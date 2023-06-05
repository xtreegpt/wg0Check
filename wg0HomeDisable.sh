#!/bin/bash

#Stop wiregaurd tunnel when home

#Set variables for current gateway and wg0 state

GATEWAY=$( netstat -r |grep default |awk '{print $2}' )
WG0STATE=$( systemctl status wg-quick@wg0.service |sed '2d' |grep active |awk '{print $2}' )

# Check conditions: If home and wg0 is active. If true turn off wg0

if ( [ $GATEWAY == "crawford" ] && [ $WG0STATE == active ] );
        then
                echo "wg0 is up, and device is at home, stopping wg0"
                systemctl stop wg-quick@wg0.service
        else
                echo "wg0 is down"
fi
