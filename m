Received: from eggs.gnu.org ([2001:4830:134:3::10]:55057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f0oEc-0001Zm-4J
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f0oEX-0002vW-6v
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:01:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47468 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f0oEX-0002v5-19
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:01:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2764784256
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 13:01:43 +0000 (UTC)
References: <1520857250-12935-1-git-send-email-thuth@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e7c0d2c8-6451-a598-f140-29916c99e514@redhat.com>
Date: Tue, 27 Mar 2018 21:01:30 +0800
MIME-Version: 1.0
In-Reply-To: <1520857250-12935-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] qemu-doc: Rework the network options
 chapter to make "-net" less prominent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>



On 2018=E5=B9=B403=E6=9C=8812=E6=97=A5 20:20, Thomas Huth wrote:
> "-net" is clearly a legacy option. Yet we still use it in almost all
> examples in the qemu documentation, and many other spots in the network
> chapter. We should make it less prominent that users are not lured into
> using it so often anymore. So instead of starting the network chapter w=
ith
> "-net nic" and documenting "-net <backend>" below "-netdev <backend>"
> everywhere, all the "-net" related documentation is now moved to the en=
d
> of the chapter. The new "-nic" option is moved to the beginning of the
> chapter instead, with a new example that should demonstrate how "-nic"
> can be used to shortcut "-device" with "-netdev". The examples in this
> chapter are changed to use the "-device" and "-netdev" options or
> "-nic" instead of "-net nic -net <backend>".
>
> While we're at it, also remove a legacy remark about very old Linux
> distributions. Also remove the "[...]" from the examples in this chapte=
r
> since we are not using this ellipsis in any other examples in our docu-
> mentation.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v3:
>   - Use single dash options instead of double-dash options
>
>   qemu-options.hx | 189 ++++++++++++++++++++++++++++-------------------=
---------
>   1 file changed, 94 insertions(+), 95 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 6585058..e86b3fb 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2045,41 +2045,40 @@ DEF("net", HAS_ARG, QEMU_OPTION_net,
>       "                old way to initialize a host network interface\n=
"
>       "                (use the -netdev option if possible instead)\n",=
 QEMU_ARCH_ALL)
>   STEXI
> -@item -net nic[,vlan=3D@var{n}][,netdev=3D@var{nd}][,macaddr=3D@var{ma=
c}][,model=3D@var{type}] [,name=3D@var{name}][,addr=3D@var{addr}][,vector=
s=3D@var{v}]
> -@findex -net
> -Configure or create an on-board (or machine default) Network Interface=
 Card
> -(NIC) and connect it either to VLAN @var{n} (@var{n} =3D 0 is the defa=
ult), or
> -to the netdev @var{nd}. The NIC is an e1000 by default on the PC
> -target. Optionally, the MAC address can be changed to @var{mac}, the
> -device address set to @var{addr} (PCI cards only),
> -and a @var{name} can be assigned for use in monitor commands.
> -Optionally, for PCI cards, you can specify the number @var{v} of MSI-X=
 vectors
> -that the card should have; this option currently only affects virtio c=
ards; set
> -@var{v} =3D 0 to disable MSI-X. If no @option{-net} option is specifie=
d, a single
> -NIC is created.  QEMU can emulate several different models of network =
card.
> -Valid values for @var{type} are
> -@code{virtio}, @code{i82551}, @code{i82557b}, @code{i82559er},
> -@code{ne2k_pci}, @code{ne2k_isa}, @code{pcnet}, @code{rtl8139},
> -@code{e1000}, @code{smc91c111}, @code{lance} and @code{mcf_fec}.
> -Not all devices are supported on all targets.  Use @code{-net nic,mode=
l=3Dhelp}
> -for a list of available devices for your target.
> +@item -nic [tap|bridge|user|l2tpv3|vde|netmap|vhost-user|socket][,...]=
[,mac=3Dmacaddr][,model=3Dmn]
> +@findex -nic
> +This option is a shortcut for configuring both the on-board (default) =
guest
> +NIC hardware and the host network backend in one go. The host backend =
options
> +are the same as with the corresponding @option{-netdev} options below.
> +The guest NIC model can be set with @option{model=3D@var{modelname}}.
> +Use @option{model=3Dhelp} to list the available device types.
> +The hardware MAC address can be set with @option{mac=3D@var{macaddr}}.
> +
> +The following two example do exactly the same, to show how @option{-ni=
c} can
> +be used to shorten the command line length (note that the e1000 is the=
 default
> +on i386, so the @option{model=3De1000} parameter could even be omitted=
 here, too):
> +@example
> +qemu-system-i386 -netdev user,id=3Dn1,ipv6=3Doff -device e1000,netdev=3D=
n1,mac=3D52:54:98:76:54:32
> +qemu-system-i386 -nic user,ipv6=3Doff,model=3De1000,mac=3D52:54:98:76:=
54:32
> +@end example

I'm not sure we need this since I believe we still prefer -netdev even=20
if -nic is shorter?

> +
> +@item -nic none
> +Indicate that no network devices should be configured. It is used to o=
verride
> +the default configuration (default NIC with ``user'' host network back=
end)
> +which is activated if no other networking options are provided.
>  =20
>   @item -netdev user,id=3D@var{id}[,@var{option}][,@var{option}][,...]
>   @findex -netdev
> -@item -net user[,@var{option}][,@var{option}][,...]
> -Use the user mode network stack which requires no administrator
> +Configure user mode host network backend which requires no administrat=
or
>   privilege to run. Valid options are:
>  =20
>   @table @option
> -@item vlan=3D@var{n}
> -Connect user mode stack to VLAN @var{n} (@var{n} =3D 0 is the default)=
.
> -
>   @item id=3D@var{id}
> -@itemx name=3D@var{name}
>   Assign symbolic name for use in monitor commands.
>  =20
> -@option{ipv4} and @option{ipv6} specify that either IPv4 or IPv6 must
> -be enabled.  If neither is specified both protocols are enabled.
> +@item ipv4=3Don|off and ipv6=3Don|off
> +Specify that either IPv4 or IPv6 must be enabled. If neither is specif=
ied
> +both protocols are enabled.
>  =20
>   @item net=3D@var{addr}[/@var{mask}]
>   Set IP network address the guest will see. Optionally specify the net=
mask,
> @@ -2131,7 +2130,7 @@ can not be resolved.
>  =20
>   Example:
>   @example
> -qemu -net user,dnssearch=3Dmgmt.example.org,dnssearch=3Dexample.org [.=
..]
> +qemu-system-i386 -nic user,dnssearch=3Dmgmt.example.org,dnssearch=3Dex=
ample.org
>   @end example
>  =20
>   @item tftp=3D@var{dir}
> @@ -2147,7 +2146,8 @@ a guest from a local directory.
>  =20
>   Example (using pxelinux):
>   @example
> -qemu-system-i386 -hda linux.img -boot n -net user,tftp=3D/path/to/tftp=
/files,bootfile=3D/pxelinux.0
> +qemu-system-i386 -hda linux.img -boot n -device e1000,netdev=3Dn1 \
> +    -netdev user,id=3Dn1,tftp=3D/path/to/tftp/files,bootfile=3D/pxelin=
ux.0
>   @end example
>  =20
>   @item smb=3D@var{dir}[,smbserver=3D@var{addr}]
> @@ -2166,8 +2166,6 @@ or @file{C:\WINNT\SYSTEM32\DRIVERS\ETC\LMHOSTS} (=
Windows NT/2000).
>   Then @file{@var{dir}} can be accessed in @file{\\smbserver\qemu}.
>  =20
>   Note that a SAMBA server must be installed on the host OS.
> -QEMU was tested successfully with smbd versions from Red Hat 9,
> -Fedora Core 3 and OpenSUSE 11.x.
>  =20
>   @item hostfwd=3D[tcp|udp]:[@var{hostaddr}]:@var{hostport}-[@var{guest=
addr}]:@var{guestport}
>   Redirect incoming TCP or UDP connections to the host port @var{hostpo=
rt} to
> @@ -2182,7 +2180,7 @@ screen 0, use the following:
>  =20
>   @example
>   # on the host
> -qemu-system-i386 -net user,hostfwd=3Dtcp:127.0.0.1:6001-:6000 [...]
> +qemu-system-i386 -nic user,hostfwd=3Dtcp:127.0.0.1:6001-:6000
>   # this host xterm should open in the guest X11 server
>   xterm -display :1
>   @end example
> @@ -2192,7 +2190,7 @@ the guest, use the following:
>  =20
>   @example
>   # on the host
> -qemu-system-i386 -net user,hostfwd=3Dtcp::5555-:23 [...]
> +qemu-system-i386 -nic user,hostfwd=3Dtcp::5555-:23
>   telnet localhost 5555
>   @end example
>  =20
> @@ -2211,7 +2209,7 @@ lifetime, like in the following example:
>   @example
>   # open 10.10.1.1:4321 on bootup, connect 10.0.2.100:1234 to it whenev=
er
>   # the guest accesses it
> -qemu -net user,guestfwd=3Dtcp:10.0.2.100:1234-tcp:10.10.1.1:4321 [...]
> +qemu-system-i386 -nic user,guestfwd=3Dtcp:10.0.2.100:1234-tcp:10.10.1.=
1:4321
>   @end example
>  =20
>   Or you can execute a command on every TCP connection established by t=
he guest,
> @@ -2220,7 +2218,7 @@ so that QEMU behaves similar to an inetd process =
for that virtual server:
>   @example
>   # call "netcat 10.10.1.1 4321" on every TCP connection to 10.0.2.100:=
1234
>   # and connect the TCP stream to its stdin/stdout
> -qemu -net 'user,guestfwd=3Dtcp:10.0.2.100:1234-cmd:netcat 10.10.1.1 43=
21'
> +qemu-system-i386 -nic  'user,id=3Dn1,guestfwd=3Dtcp:10.0.2.100:1234-cm=
d:netcat 10.10.1.1 4321'
>   @end example
>  =20
>   @end table
> @@ -2231,8 +2229,7 @@ syntax gives undefined results. Their use for new=
 applications is discouraged
>   as they will be removed from future versions.
>  =20
>   @item -netdev tap,id=3D@var{id}[,fd=3D@var{h}][,ifname=3D@var{name}][=
,script=3D@var{file}][,downscript=3D@var{dfile}][,br=3D@var{bridge}][,hel=
per=3D@var{helper}]
> -@itemx -net tap[,vlan=3D@var{n}][,name=3D@var{name}][,fd=3D@var{h}][,i=
fname=3D@var{name}][,script=3D@var{file}][,downscript=3D@var{dfile}][,br=3D=
@var{bridge}][,helper=3D@var{helper}]
> -Connect the host TAP network interface @var{name} to VLAN @var{n}.
> +Configure a host TAP network backend with ID @var{id}.
>  =20
>   Use the network script @var{file} to configure it and the network scr=
ipt
>   @var{dfile} to deconfigure it. If @var{name} is not provided, the OS
> @@ -2253,7 +2250,7 @@ Examples:
>  =20
>   @example
>   #launch a QEMU instance with the default network script
> -qemu-system-i386 linux.img -net nic -net tap
> +qemu-system-i386 linux.img -nic tap
>   @end example
>  =20
>   @example
> @@ -2267,12 +2264,11 @@ qemu-system-i386 linux.img \
>   @example
>   #launch a QEMU instance with the default network helper to
>   #connect a TAP device to bridge br0
> -qemu-system-i386 linux.img \
> -                 -net nic -net tap,"helper=3D/path/to/qemu-bridge-help=
er"
> +qemu-system-i386 linux.img -device virtio-net-pci,netdev=3Dn1 \
> +        -netdev tap,id=3Dn1,"helper=3D/path/to/qemu-bridge-helper"
>   @end example
>  =20
>   @item -netdev bridge,id=3D@var{id}[,br=3D@var{bridge}][,helper=3D@var=
{helper}]
> -@itemx -net bridge[,vlan=3D@var{n}][,name=3D@var{name}][,br=3D@var{bri=
dge}][,helper=3D@var{helper}]
>   Connect a host TAP network interface to a host bridge device.
>  =20
>   Use the network helper @var{helper} to configure the TAP interface an=
d
> @@ -2285,21 +2281,20 @@ Examples:
>   @example
>   #launch a QEMU instance with the default network helper to
>   #connect a TAP device to bridge br0
> -qemu-system-i386 linux.img -net bridge -net nic,model=3Dvirtio
> +qemu-system-i386 linux.img -netdev bridge,id=3Dn1 -device virtio-net,n=
etdev=3Dn1
>   @end example
>  =20
>   @example
>   #launch a QEMU instance with the default network helper to
>   #connect a TAP device to bridge qemubr0
> -qemu-system-i386 linux.img -net bridge,br=3Dqemubr0 -net nic,model=3Dv=
irtio
> +qemu-system-i386 linux.img -netdev bridge,br=3Dqemubr0,id=3Dn1 -device=
 virtio-net,netdev=3Dn1
>   @end example
>  =20
>   @item -netdev socket,id=3D@var{id}[,fd=3D@var{h}][,listen=3D[@var{hos=
t}]:@var{port}][,connect=3D@var{host}:@var{port}]
> -@itemx -net socket[,vlan=3D@var{n}][,name=3D@var{name}][,fd=3D@var{h}]=
 [,listen=3D[@var{host}]:@var{port}][,connect=3D@var{host}:@var{port}]
>  =20
> -Connect the VLAN @var{n} to a remote VLAN in another QEMU virtual
> -machine using a TCP socket connection. If @option{listen} is
> -specified, QEMU waits for incoming connections on @var{port}
> +This host network backend can be used to connect the guest's network t=
o
> +another QEMU virtual machine using a TCP socket connection. If @option=
{listen}
> +is specified, QEMU waits for incoming connections on @var{port}
>   (@var{host} is optional). @option{connect} is used to connect to
>   another QEMU instance using the @option{listen} option. @option{fd}=3D=
@var{h}
>   specifies an already opened TCP socket.
> @@ -2308,21 +2303,19 @@ Example:
>   @example
>   # launch a first QEMU instance
>   qemu-system-i386 linux.img \
> -                 -net nic,macaddr=3D52:54:00:12:34:56 \
> -                 -net socket,listen=3D:1234
> -# connect the VLAN 0 of this instance to the VLAN 0
> -# of the first instance
> +                 -device e1000,netdev=3Dn1,mac=3D52:54:00:12:34:56 \
> +                 -netdev socket,id=3Dn1,listen=3D:1234
> +# connect the network of this instance to the network of the first ins=
tance
>   qemu-system-i386 linux.img \
> -                 -net nic,macaddr=3D52:54:00:12:34:57 \
> -                 -net socket,connect=3D127.0.0.1:1234
> +                 -device e1000,netdev=3Dn2,mac=3D52:54:00:12:34:57 \
> +                 -netdev socket,id=3Dn2,connect=3D127.0.0.1:1234
>   @end example
>  =20
>   @item -netdev socket,id=3D@var{id}[,fd=3D@var{h}][,mcast=3D@var{maddr=
}:@var{port}[,localaddr=3D@var{addr}]]
> -@itemx -net socket[,vlan=3D@var{n}][,name=3D@var{name}][,fd=3D@var{h}]=
[,mcast=3D@var{maddr}:@var{port}[,localaddr=3D@var{addr}]]
>  =20
> -Create a VLAN @var{n} shared with another QEMU virtual
> -machines using a UDP multicast socket, effectively making a bus for
> -every QEMU with same multicast address @var{maddr} and @var{port}.
> +Configure a socket host network backend to share the guest's network t=
raffic
> +with another QEMU virtual machines using a UDP multicast socket, effec=
tively
> +making a bus for every QEMU with same multicast address @var{maddr} an=
d @var{port}.
>   NOTES:
>   @enumerate
>   @item
> @@ -2339,25 +2332,24 @@ Example:
>   @example
>   # launch one QEMU instance
>   qemu-system-i386 linux.img \
> -                 -net nic,macaddr=3D52:54:00:12:34:56 \
> -                 -net socket,mcast=3D230.0.0.1:1234
> +                 -device e1000,netdev=3Dn1,mac=3D52:54:00:12:34:56 \
> +                 -netdev socket,id=3Dn1,mcast=3D230.0.0.1:1234
>   # launch another QEMU instance on same "bus"
>   qemu-system-i386 linux.img \
> -                 -net nic,macaddr=3D52:54:00:12:34:57 \
> -                 -net socket,mcast=3D230.0.0.1:1234
> +                 -device e1000,netdev=3Dn2,mac=3D52:54:00:12:34:57 \
> +                 -netdev socket,id=3Dn2,mcast=3D230.0.0.1:1234
>   # launch yet another QEMU instance on same "bus"
>   qemu-system-i386 linux.img \
> -                 -net nic,macaddr=3D52:54:00:12:34:58 \
> -                 -net socket,mcast=3D230.0.0.1:1234
> +                 -device e1000,netdev=3Dn3,macaddr=3D52:54:00:12:34:58=
 \
> +                 -netdev socket,id=3Dn3,mcast=3D230.0.0.1:1234
>   @end example
>  =20
>   Example (User Mode Linux compat.):
>   @example
> -# launch QEMU instance (note mcast address selected
> -# is UML's default)
> +# launch QEMU instance (note mcast address selected is UML's default)
>   qemu-system-i386 linux.img \
> -                 -net nic,macaddr=3D52:54:00:12:34:56 \
> -                 -net socket,mcast=3D239.192.168.1:1102
> +                 -device e1000,netdev=3Dn1,mac=3D52:54:00:12:34:56 \
> +                 -netdev socket,id=3Dn1,mcast=3D239.192.168.1:1102
>   # launch UML
>   /path/to/linux ubd0=3D/path/to/root_fs eth0=3Dmcast
>   @end example
> @@ -2365,14 +2357,13 @@ qemu-system-i386 linux.img \
>   Example (send packets from host's 1.2.3.4):
>   @example
>   qemu-system-i386 linux.img \
> -                 -net nic,macaddr=3D52:54:00:12:34:56 \
> -                 -net socket,mcast=3D239.192.168.1:1102,localaddr=3D1.=
2.3.4
> +                 -device e1000,netdev=3Dn1,mac=3D52:54:00:12:34:56 \
> +                 -netdev socket,id=3Dn1,mcast=3D239.192.168.1:1102,loc=
aladdr=3D1.2.3.4
>   @end example
>  =20
>   @item -netdev l2tpv3,id=3D@var{id},src=3D@var{srcaddr},dst=3D@var{dst=
addr}[,srcport=3D@var{srcport}][,dstport=3D@var{dstport}],txsession=3D@va=
r{txsession}[,rxsession=3D@var{rxsession}][,ipv6][,udp][,cookie64][,count=
er][,pincounter][,txcookie=3D@var{txcookie}][,rxcookie=3D@var{rxcookie}][=
,offset=3D@var{offset}]
> -@itemx -net l2tpv3[,vlan=3D@var{n}][,name=3D@var{name}],src=3D@var{src=
addr},dst=3D@var{dstaddr}[,srcport=3D@var{srcport}][,dstport=3D@var{dstpo=
rt}],txsession=3D@var{txsession}[,rxsession=3D@var{rxsession}][,ipv6][,ud=
p][,cookie64][,counter][,pincounter][,txcookie=3D@var{txcookie}][,rxcooki=
e=3D@var{rxcookie}][,offset=3D@var{offset}]
> -Connect VLAN @var{n} to L2TPv3 pseudowire. L2TPv3 (RFC3391) is a popul=
ar
> -protocol to transport Ethernet (and other Layer 2) data frames between
> +Configure a L2TPv3 pseudowire host network backend. L2TPv3 (RFC3391) i=
s a
> +popular protocol to transport Ethernet (and other Layer 2) data frames=
 between
>   two systems. It is present in routers, firewalls and the Linux kernel
>   (from version 3.3 onwards).
>  =20
> @@ -2425,14 +2416,13 @@ brctl addif br-lan vmtunnel0
>   # on 4.3.2.1
>   # launch QEMU instance - if your network has reorder or is very lossy=
 add ,pincounter
>  =20
> -qemu-system-i386 linux.img -net nic -net l2tpv3,src=3D4.2.3.1,dst=3D1.=
2.3.4,udp,srcport=3D16384,dstport=3D16384,rxsession=3D0xffffffff,txsessio=
n=3D0xffffffff,counter
> -
> +qemu-system-i386 linux.img -device e1000,netdev=3Dn1 \
> +    -netdev l2tpv3,id=3Dn1,src=3D4.2.3.1,dst=3D1.2.3.4,udp,srcport=3D1=
6384,dstport=3D16384,rxsession=3D0xffffffff,txsession=3D0xffffffff,counte=
r
>  =20
>   @end example
>  =20
>   @item -netdev vde,id=3D@var{id}[,sock=3D@var{socketpath}][,port=3D@va=
r{n}][,group=3D@var{groupname}][,mode=3D@var{octalmode}]
> -@itemx -net vde[,vlan=3D@var{n}][,name=3D@var{name}][,sock=3D@var{sock=
etpath}] [,port=3D@var{n}][,group=3D@var{groupname}][,mode=3D@var{octalmo=
de}]
> -Connect VLAN @var{n} to PORT @var{n} of a vde switch running on host a=
nd
> +Configure VDE backend to connect to PORT @var{n} of a vde switch runni=
ng on host and
>   listening for incoming connections on @var{socketpath}. Use GROUP @va=
r{groupname}
>   and MODE @var{octalmode} to change default ownership and permissions =
for
>   communication port. This option is only available if QEMU has been co=
mpiled
> @@ -2443,19 +2433,9 @@ Example:
>   # launch vde switch
>   vde_switch -F -sock /tmp/myswitch
>   # launch QEMU instance
> -qemu-system-i386 linux.img -net nic -net vde,sock=3D/tmp/myswitch
> +qemu-system-i386 linux.img -nic vde,sock=3D/tmp/myswitch

I think we should use -netdev here?

Thanks

>   @end example
>  =20
> -@item -netdev hubport,id=3D@var{id},hubid=3D@var{hubid}[,netdev=3D@var=
{nd}]
> -
> -Create a hub port on QEMU "vlan" @var{hubid}.
> -
> -The hubport netdev lets you connect a NIC to a QEMU "vlan" instead of =
a single
> -netdev.  @code{-net} and @code{-device} with parameter @option{vlan} c=
reate the
> -required hub automatically. Alternatively, you can also connect the hu=
bport
> -to another netdev with ID @var{nd} by using the @option{netdev=3D@var{=
nd}}
> -option.
> -
>   @item -netdev vhost-user,chardev=3D@var{id}[,vhostforce=3Don|off][,qu=
eues=3Dn]
>  =20
>   Establish a vhost-user netdev, backed by a chardev @var{id}. The char=
dev should
> @@ -2474,17 +2454,36 @@ qemu -m 512 -object memory-backend-file,id=3Dme=
m,size=3D512M,mem-path=3D/hugetlbfs,sha
>        -device virtio-net-pci,netdev=3Dnet0
>   @end example
>  =20
> -@item --nic [tap|bridge|user|l2tpv3|vde|netmap|vhost-user|socket][,...=
][,mac=3Dmacaddr]
> +@item -netdev hubport,id=3D@var{id},hubid=3D@var{hubid}[,netdev=3D@var=
{nd}]
>  =20
> -This option is a shortcut for setting both, the on-board (default) gue=
st NIC
> -hardware and the host network backend in one go. The host backend opti=
ons are
> -the same as with the corresponding @option{--netdev} option. The guest=
 NIC
> -hardware MAC address can be set with @option{mac=3D@var{macaddr}}.
> +Create a hub port on the emulated hub with ID @var{hubid}.
>  =20
> -@item --nic none
> -Indicate that no network devices should be configured. It is used to o=
verride
> -the default configuration (default NIC with @option{--net user} backen=
d) which
> -is activated if no other networking options are provided.
> +The hubport netdev lets you connect a NIC to a QEMU emulated hub inste=
ad of a
> +single netdev. @code{-net} and @code{-device} with the parameter @opti=
on{vlan}
> +(deprecated), or @code{-nic hubport} can also be used to connect a
> +network device or a NIC to a hub. Alternatively, you can also connect =
the
> +hubport to another netdev with ID @var{nd} by using the @option{netdev=
=3D@var{nd}}
> +option.
> +
> +@item -net nic[,vlan=3D@var{n}][,netdev=3D@var{nd}][,macaddr=3D@var{ma=
c}][,model=3D@var{type}] [,name=3D@var{name}][,addr=3D@var{addr}][,vector=
s=3D@var{v}]
> +@findex -net
> +Legacy option to configure or create an on-board (or machine default) =
Network
> +Interface Card(NIC) and connect it either to the emulated hub port ("v=
lan")
> +with number @var{n} (@var{n} =3D 0 is the default), or to the netdev @=
var{nd}.
> +The NIC is an e1000 by default on the PC target. Optionally, the MAC a=
ddress
> +can be changed to @var{mac}, the device address set to @var{addr} (PCI=
 cards
> +only), and a @var{name} can be assigned for use in monitor commands.
> +Optionally, for PCI cards, you can specify the number @var{v} of MSI-X=
 vectors
> +that the card should have; this option currently only affects virtio c=
ards; set
> +@var{v} =3D 0 to disable MSI-X. If no @option{-net} option is specifie=
d, a single
> +NIC is created.  QEMU can emulate several different models of network =
card.
> +Use @code{-net nic,model=3Dhelp} for a list of available devices for y=
our target.
> +
> +@item -net user|tap|bridge|socket|l2tpv3|vde[,...][,vlan=3D@var{n}][,n=
ame=3D@var{name}]
> +Configure a host network backend (with the options corresponding to th=
e same
> +@option{-netdev} option) and connect it to the emulated hub ("vlan") w=
ith the
> +number @var{n} (default is number 0). Use @var{name} to specify the na=
me of the
> +hub port.
>   ETEXI
>  =20
>   STEXI
