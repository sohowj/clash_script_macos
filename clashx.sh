#!/usr/bin/env bash

# CONFIGURATION
INTERFACE=Wi-Fi

SOCKS_PROXY_HOST=127.0.0.1
SOCKS_PROXY_PORT=7890

HTTP_PROXY_HOST=127.0.0.1
HTTP_PROXY_PORT=7890

BYPASS_DOMAINS="192.168.0.0/16 10.0.0.0/8 172.16.0.0/12 127.0.0.1 localhost *.local timestamp.apple.com sequoia.apple.com seed-sequoia.siri.apple.com"

# END CONFIGURATION

if [[ "$1" = "on" ]]; then
  networksetup -setsocksfirewallproxy $INTERFACE $SOCKS_PROXY_HOST $SOCKS_PROXY_PORT
  networksetup -setsocksfirewallproxystate $INTERFACE on

  networksetup -setwebproxy $INTERFACE $HTTP_PROXY_HOST $HTTP_PROXY_PORT
  networksetup -setwebproxystate $INTERFACE on

  networksetup -setsecurewebproxy $INTERFACE $HTTP_PROXY_HOST $HTTP_PROXY_PORT
  networksetup -setsecurewebproxystate $INTERFACE on

  networksetup -setproxybypassdomains $INTERFACE $BYPASS_DOMAINS
  exit
fi

if [[ "$1" = "off" ]]; then
  networksetup -setsocksfirewallproxystate $INTERFACE off
  networksetup -setwebproxystate $INTERFACE off
  networksetup -setsecurewebproxystate $INTERFACE off
  exit
fi

echo ""
echo "SOCKS Proxy:"
networksetup -getsocksfirewallproxy $INTERFACE
echo ""
echo "HTTP Proxy:"
networksetup -getwebproxy $INTERFACE
echo ""
echo "HTTPS Proxy:"
networksetup -getsecurewebproxy $INTERFACE
echo ""
echo "Bypass:"
networksetup -getproxybypassdomains $INTERFACE
echo
