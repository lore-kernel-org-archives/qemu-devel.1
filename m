Received: from eggs.gnu.org ([2001:4830:134:3::10]:53190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1enhYA-00010G-DU
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 04:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1enhY7-00034R-Li
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 04:15:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33258 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1enhY7-00034K-Ez
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 04:15:51 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 206924023EDE
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 09:15:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 19 Feb 2018 10:15:28 +0100
Message-Id: <1519031728-9850-9-git-send-email-thuth@redhat.com>
In-Reply-To: <1519031728-9850-1-git-send-email-thuth@redhat.com>
References: <1519031728-9850-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v1 8/8] qemu-doc: Make "-net" less prominent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

"-net" is clearly a legacy option. Yet we still use it in almost all
examples in the qemu documentation, and many other spots in the network
chapter. We should make it less prominent that users are not lured into
using it so often anymore. So instead of starting the network chapter with
"-net nic" and documenting "-net <backend>" below "-netdev <backend>"
everywhere, all the "-net" related documentation is now moved to the end
of the chapter. And the examples are changed to use the "--device" and
"--netdev" options instead of "-net nic -net <backend>".

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-options.hx | 165 +++++++++++++++++++++++++++-----------------------------
 1 file changed, 80 insertions(+), 85 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 5e4c64d..914019c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2048,41 +2048,18 @@ DEF("net", HAS_ARG, QEMU_OPTION_net,
     "                old way to initialize a host network interface\n"
     "                (use the -netdev option if possible instead)\n", QEMU_ARCH_ALL)
 STEXI
-@item -net nic[,vlan=@var{n}][,netdev=@var{nd}][,macaddr=@var{mac}][,model=@var{type}] [,name=@var{name}][,addr=@var{addr}][,vectors=@var{v}]
-@findex -net
-Configure or create an on-board (or machine default) Network Interface Card
-(NIC) and connect it either to VLAN @var{n} (@var{n} = 0 is the default), or
-to the netdev @var{nd}. The NIC is an e1000 by default on the PC
-target. Optionally, the MAC address can be changed to @var{mac}, the
-device address set to @var{addr} (PCI cards only),
-and a @var{name} can be assigned for use in monitor commands.
-Optionally, for PCI cards, you can specify the number @var{v} of MSI-X vectors
-that the card should have; this option currently only affects virtio cards; set
-@var{v} = 0 to disable MSI-X. If no @option{-net} option is specified, a single
-NIC is created.  QEMU can emulate several different models of network card.
-Valid values for @var{type} are
-@code{virtio}, @code{i82551}, @code{i82557b}, @code{i82559er},
-@code{ne2k_pci}, @code{ne2k_isa}, @code{pcnet}, @code{rtl8139},
-@code{e1000}, @code{smc91c111}, @code{lance} and @code{mcf_fec}.
-Not all devices are supported on all targets.  Use @code{-net nic,model=help}
-for a list of available devices for your target.
-
-@item -netdev user,id=@var{id}[,@var{option}][,@var{option}][,...]
-@findex -netdev
-@item -net user[,@var{option}][,@var{option}][,...]
-Use the user mode network stack which requires no administrator
+@item --netdev user,id=@var{id}[,@var{option}][,@var{option}][,...]
+@findex --netdev
+Configure user mode host network backend which requires no administrator
 privilege to run. Valid options are:
 
 @table @option
-@item vlan=@var{n}
-Connect user mode stack to VLAN @var{n} (@var{n} = 0 is the default).
-
 @item id=@var{id}
-@itemx name=@var{name}
 Assign symbolic name for use in monitor commands.
 
-@option{ipv4} and @option{ipv6} specify that either IPv4 or IPv6 must
-be enabled.  If neither is specified both protocols are enabled.
+@item ipv4=on|off and ipv6=on|off
+Specify that either IPv4 or IPv6 must be enabled. If neither is specified
+both protocols are enabled.
 
 @item net=@var{addr}[/@var{mask}]
 Set IP network address the guest will see. Optionally specify the netmask,
@@ -2134,7 +2111,7 @@ can not be resolved.
 
 Example:
 @example
-qemu -net user,dnssearch=mgmt.example.org,dnssearch=example.org [...]
+qemu-system-i386 --device e1000,netdev=n1 --netdev user,id=n1,dnssearch=mgmt.example.org,dnssearch=example.org [...]
 @end example
 
 @item tftp=@var{dir}
@@ -2150,7 +2127,8 @@ a guest from a local directory.
 
 Example (using pxelinux):
 @example
-qemu-system-i386 -hda linux.img -boot n -net user,tftp=/path/to/tftp/files,bootfile=/pxelinux.0
+qemu-system-i386 --hda linux.img --boot n --device e1000,netdev=n1 \
+    --netdev user,id=n1,tftp=/path/to/tftp/files,bootfile=/pxelinux.0
 @end example
 
 @item smb=@var{dir}[,smbserver=@var{addr}]
@@ -2185,7 +2163,7 @@ screen 0, use the following:
 
 @example
 # on the host
-qemu-system-i386 -net user,hostfwd=tcp:127.0.0.1:6001-:6000 [...]
+qemu-system-i386 --device virtio-net-pci,netdev=n1 --netdev user,id=n1,hostfwd=tcp:127.0.0.1:6001-:6000 [...]
 # this host xterm should open in the guest X11 server
 xterm -display :1
 @end example
@@ -2195,7 +2173,7 @@ the guest, use the following:
 
 @example
 # on the host
-qemu-system-i386 -net user,hostfwd=tcp::5555-:23 [...]
+qemu-system-i386 --device e1000,netdev=n1 --netdev user,id=n1,hostfwd=tcp::5555-:23 [...]
 telnet localhost 5555
 @end example
 
@@ -2214,7 +2192,7 @@ lifetime, like in the following example:
 @example
 # open 10.10.1.1:4321 on bootup, connect 10.0.2.100:1234 to it whenever
 # the guest accesses it
-qemu -net user,guestfwd=tcp:10.0.2.100:1234-tcp:10.10.1.1:4321 [...]
+qemu-system-i386 --device e1000,netdev=n1 --netdev user,id=n1,guestfwd=tcp:10.0.2.100:1234-tcp:10.10.1.1:4321 [...]
 @end example
 
 Or you can execute a command on every TCP connection established by the guest,
@@ -2223,7 +2201,7 @@ so that QEMU behaves similar to an inetd process for that virtual server:
 @example
 # call "netcat 10.10.1.1 4321" on every TCP connection to 10.0.2.100:1234
 # and connect the TCP stream to its stdin/stdout
-qemu -net 'user,guestfwd=tcp:10.0.2.100:1234-cmd:netcat 10.10.1.1 4321'
+qemu-system-i386 --device e1000,netdev=n1 --netdev 'user,id=n1,guestfwd=tcp:10.0.2.100:1234-cmd:netcat 10.10.1.1 4321'
 @end example
 
 @end table
@@ -2233,9 +2211,8 @@ processed and applied to -net user. Mixing them with the new configuration
 syntax gives undefined results. Their use for new applications is discouraged
 as they will be removed from future versions.
 
-@item -netdev tap,id=@var{id}[,fd=@var{h}][,ifname=@var{name}][,script=@var{file}][,downscript=@var{dfile}][,br=@var{bridge}][,helper=@var{helper}]
-@itemx -net tap[,vlan=@var{n}][,name=@var{name}][,fd=@var{h}][,ifname=@var{name}][,script=@var{file}][,downscript=@var{dfile}][,br=@var{bridge}][,helper=@var{helper}]
-Connect the host TAP network interface @var{name} to VLAN @var{n}.
+@item --netdev tap,id=@var{id}[,fd=@var{h}][,ifname=@var{name}][,script=@var{file}][,downscript=@var{dfile}][,br=@var{bridge}][,helper=@var{helper}]
+Configure a host TAP network backend with ID @var{id}.
 
 Use the network script @var{file} to configure it and the network script
 @var{dfile} to deconfigure it. If @var{name} is not provided, the OS
@@ -2256,7 +2233,7 @@ Examples:
 
 @example
 #launch a QEMU instance with the default network script
-qemu-system-i386 linux.img -net nic -net tap
+qemu-system-i386 linux.img --netdev tap,id=n1 --device virtio-net-pci,netdev=n1
 @end example
 
 @example
@@ -2270,12 +2247,11 @@ qemu-system-i386 linux.img \
 @example
 #launch a QEMU instance with the default network helper to
 #connect a TAP device to bridge br0
-qemu-system-i386 linux.img \
-                 -net nic -net tap,"helper=/path/to/qemu-bridge-helper"
+qemu-system-i386 linux.img --device e1000,netdev=n1 \
+        --netdev tap,id=n1,"helper=/path/to/qemu-bridge-helper"
 @end example
 
-@item -netdev bridge,id=@var{id}[,br=@var{bridge}][,helper=@var{helper}]
-@itemx -net bridge[,vlan=@var{n}][,name=@var{name}][,br=@var{bridge}][,helper=@var{helper}]
+@item --netdev bridge,id=@var{id}[,br=@var{bridge}][,helper=@var{helper}]
 Connect a host TAP network interface to a host bridge device.
 
 Use the network helper @var{helper} to configure the TAP interface and
@@ -2288,21 +2264,20 @@ Examples:
 @example
 #launch a QEMU instance with the default network helper to
 #connect a TAP device to bridge br0
-qemu-system-i386 linux.img -net bridge -net nic,model=virtio
+qemu-system-i386 linux.img --netdev bridge,id=n1 --device virtio-net,netdev=n1
 @end example
 
 @example
 #launch a QEMU instance with the default network helper to
 #connect a TAP device to bridge qemubr0
-qemu-system-i386 linux.img -net bridge,br=qemubr0 -net nic,model=virtio
+qemu-system-i386 linux.img --netdev bridge,br=qemubr0,id=n1 --device virtio-net,netdev=n1
 @end example
 
-@item -netdev socket,id=@var{id}[,fd=@var{h}][,listen=[@var{host}]:@var{port}][,connect=@var{host}:@var{port}]
-@itemx -net socket[,vlan=@var{n}][,name=@var{name}][,fd=@var{h}] [,listen=[@var{host}]:@var{port}][,connect=@var{host}:@var{port}]
+@item --netdev socket,id=@var{id}[,fd=@var{h}][,listen=[@var{host}]:@var{port}][,connect=@var{host}:@var{port}]
 
-Connect the VLAN @var{n} to a remote VLAN in another QEMU virtual
-machine using a TCP socket connection. If @option{listen} is
-specified, QEMU waits for incoming connections on @var{port}
+This host network backend can be used to connect the guest's network to
+another QEMU virtual machine using a TCP socket connection. If @option{listen}
+is specified, QEMU waits for incoming connections on @var{port}
 (@var{host} is optional). @option{connect} is used to connect to
 another QEMU instance using the @option{listen} option. @option{fd}=@var{h}
 specifies an already opened TCP socket.
@@ -2311,21 +2286,19 @@ Example:
 @example
 # launch a first QEMU instance
 qemu-system-i386 linux.img \
-                 -net nic,macaddr=52:54:00:12:34:56 \
-                 -net socket,listen=:1234
-# connect the VLAN 0 of this instance to the VLAN 0
-# of the first instance
+                 --device e1000,netdev=n1,mac=52:54:00:12:34:56 \
+                 --netdev socket,id=n1,listen=:1234
+# connect the network of this instance to the network of the first instance
 qemu-system-i386 linux.img \
-                 -net nic,macaddr=52:54:00:12:34:57 \
-                 -net socket,connect=127.0.0.1:1234
+                 --device e1000,netdev=n2,mac=52:54:00:12:34:57 \
+                 --netdev socket,id=n2,connect=127.0.0.1:1234
 @end example
 
-@item -netdev socket,id=@var{id}[,fd=@var{h}][,mcast=@var{maddr}:@var{port}[,localaddr=@var{addr}]]
-@itemx -net socket[,vlan=@var{n}][,name=@var{name}][,fd=@var{h}][,mcast=@var{maddr}:@var{port}[,localaddr=@var{addr}]]
+@item --netdev socket,id=@var{id}[,fd=@var{h}][,mcast=@var{maddr}:@var{port}[,localaddr=@var{addr}]]
 
-Create a VLAN @var{n} shared with another QEMU virtual
-machines using a UDP multicast socket, effectively making a bus for
-every QEMU with same multicast address @var{maddr} and @var{port}.
+Configure a socket host network backend to shared the guest's network traffic
+with another QEMU virtual machines using a UDP multicast socket, effectively
+making a bus for every QEMU with same multicast address @var{maddr} and @var{port}.
 NOTES:
 @enumerate
 @item
@@ -2342,25 +2315,24 @@ Example:
 @example
 # launch one QEMU instance
 qemu-system-i386 linux.img \
-                 -net nic,macaddr=52:54:00:12:34:56 \
-                 -net socket,mcast=230.0.0.1:1234
+                 --device e1000,netdev=n1,mac=52:54:00:12:34:56 \
+                 --netdev socket,id=n1,mcast=230.0.0.1:1234
 # launch another QEMU instance on same "bus"
 qemu-system-i386 linux.img \
-                 -net nic,macaddr=52:54:00:12:34:57 \
-                 -net socket,mcast=230.0.0.1:1234
+                 --device e1000,netdev=n2,mac=52:54:00:12:34:57 \
+                 --netdev socket,id=n2,mcast=230.0.0.1:1234
 # launch yet another QEMU instance on same "bus"
 qemu-system-i386 linux.img \
-                 -net nic,macaddr=52:54:00:12:34:58 \
-                 -net socket,mcast=230.0.0.1:1234
+                 --device e1000,netdev=n3,macaddr=52:54:00:12:34:58 \
+                 --netdev socket,id=n3,mcast=230.0.0.1:1234
 @end example
 
 Example (User Mode Linux compat.):
 @example
-# launch QEMU instance (note mcast address selected
-# is UML's default)
+# launch QEMU instance (note mcast address selected is UML's default)
 qemu-system-i386 linux.img \
-                 -net nic,macaddr=52:54:00:12:34:56 \
-                 -net socket,mcast=239.192.168.1:1102
+                 --device e1000,netdev=n1,mac=52:54:00:12:34:56 \
+                 --netdev socket,id=n1,mcast=239.192.168.1:1102
 # launch UML
 /path/to/linux ubd0=/path/to/root_fs eth0=mcast
 @end example
@@ -2368,14 +2340,13 @@ qemu-system-i386 linux.img \
 Example (send packets from host's 1.2.3.4):
 @example
 qemu-system-i386 linux.img \
-                 -net nic,macaddr=52:54:00:12:34:56 \
-                 -net socket,mcast=239.192.168.1:1102,localaddr=1.2.3.4
+                 --device e1000,netdev=n1,mac=52:54:00:12:34:56 \
+                 --netdev socket,id=n1,mcast=239.192.168.1:1102,localaddr=1.2.3.4
 @end example
 
-@item -netdev l2tpv3,id=@var{id},src=@var{srcaddr},dst=@var{dstaddr}[,srcport=@var{srcport}][,dstport=@var{dstport}],txsession=@var{txsession}[,rxsession=@var{rxsession}][,ipv6][,udp][,cookie64][,counter][,pincounter][,txcookie=@var{txcookie}][,rxcookie=@var{rxcookie}][,offset=@var{offset}]
-@itemx -net l2tpv3[,vlan=@var{n}][,name=@var{name}],src=@var{srcaddr},dst=@var{dstaddr}[,srcport=@var{srcport}][,dstport=@var{dstport}],txsession=@var{txsession}[,rxsession=@var{rxsession}][,ipv6][,udp][,cookie64][,counter][,pincounter][,txcookie=@var{txcookie}][,rxcookie=@var{rxcookie}][,offset=@var{offset}]
-Connect VLAN @var{n} to L2TPv3 pseudowire. L2TPv3 (RFC3391) is a popular
-protocol to transport Ethernet (and other Layer 2) data frames between
+@item --netdev l2tpv3,id=@var{id},src=@var{srcaddr},dst=@var{dstaddr}[,srcport=@var{srcport}][,dstport=@var{dstport}],txsession=@var{txsession}[,rxsession=@var{rxsession}][,ipv6][,udp][,cookie64][,counter][,pincounter][,txcookie=@var{txcookie}][,rxcookie=@var{rxcookie}][,offset=@var{offset}]
+Configure a L2TPv3 pseudowire host network backend. L2TPv3 (RFC3391) is a
+popular protocol to transport Ethernet (and other Layer 2) data frames between
 two systems. It is present in routers, firewalls and the Linux kernel
 (from version 3.3 onwards).
 
@@ -2428,14 +2399,13 @@ brctl addif br-lan vmtunnel0
 # on 4.3.2.1
 # launch QEMU instance - if your network has reorder or is very lossy add ,pincounter
 
-qemu-system-i386 linux.img -net nic -net l2tpv3,src=4.2.3.1,dst=1.2.3.4,udp,srcport=16384,dstport=16384,rxsession=0xffffffff,txsession=0xffffffff,counter
-
+qemu-system-i386 linux.img --device e1000,netdev=n1 \
+    --netdev l2tpv3,id=n1,src=4.2.3.1,dst=1.2.3.4,udp,srcport=16384,dstport=16384,rxsession=0xffffffff,txsession=0xffffffff,counter
 
 @end example
 
-@item -netdev vde,id=@var{id}[,sock=@var{socketpath}][,port=@var{n}][,group=@var{groupname}][,mode=@var{octalmode}]
-@itemx -net vde[,vlan=@var{n}][,name=@var{name}][,sock=@var{socketpath}] [,port=@var{n}][,group=@var{groupname}][,mode=@var{octalmode}]
-Connect VLAN @var{n} to PORT @var{n} of a vde switch running on host and
+@item --netdev vde,id=@var{id}[,sock=@var{socketpath}][,port=@var{n}][,group=@var{groupname}][,mode=@var{octalmode}]
+Configure VDE backend to connect to PORT @var{n} of a vde switch running on host and
 listening for incoming connections on @var{socketpath}. Use GROUP @var{groupname}
 and MODE @var{octalmode} to change default ownership and permissions for
 communication port. This option is only available if QEMU has been compiled
@@ -2446,10 +2416,10 @@ Example:
 # launch vde switch
 vde_switch -F -sock /tmp/myswitch
 # launch QEMU instance
-qemu-system-i386 linux.img -net nic -net vde,sock=/tmp/myswitch
+qemu-system-i386 linux.img --device e1000,netdev=n1 --netdev vde,id=n1,sock=/tmp/myswitch
 @end example
 
-@item -netdev hubport,id=@var{id},hubid=@var{hubid}[,netdev=@var{nd}]
+@item --netdev hubport,id=@var{id},hubid=@var{hubid}[,netdev=@var{nd}]
 
 Create a hub port on QEMU "vlan" @var{hubid}.
 
@@ -2459,7 +2429,7 @@ required hub automatically. Alternatively, you can also connect the hubport
 to another netdev with ID @var{nd} by using the @option{netdev=@var{nd}}
 option.
 
-@item -netdev vhost-user,chardev=@var{id}[,vhostforce=on|off][,queues=n]
+@item --netdev vhost-user,chardev=@var{id}[,vhostforce=on|off][,queues=n]
 
 Establish a vhost-user netdev, backed by a chardev @var{id}. The chardev should
 be a unix domain socket backed one. The vhost-user uses a specifically defined
@@ -2488,6 +2458,31 @@ hardware MAC address can be set with @option{mac=@var{macaddr}}.
 Indicate that no network devices should be configured. It is used to override
 the default configuration (default NIC with @option{--net user} backend) which
 is activated if no other networking options are provided.
+
+@item -net nic[,vlan=@var{n}][,netdev=@var{nd}][,macaddr=@var{mac}][,model=@var{type}] [,name=@var{name}][,addr=@var{addr}][,vectors=@var{v}]
+@findex -net
+Legacy option to configure or create an on-board (or machine default) Network
+Interface Card(NIC) and connect it either to the emulated hub port ("vlan")
+with number @var{n} (@var{n} = 0 is the default), or to the netdev @var{nd}.
+The NIC is an e1000 by default on the PC target. Optionally, the MAC address
+can be changed to @var{mac}, the device address set to @var{addr} (PCI cards
+only), and a @var{name} can be assigned for use in monitor commands.
+Optionally, for PCI cards, you can specify the number @var{v} of MSI-X vectors
+that the card should have; this option currently only affects virtio cards; set
+@var{v} = 0 to disable MSI-X. If no @option{-net} option is specified, a single
+NIC is created.  QEMU can emulate several different models of network card.
+Valid values for @var{type} are
+@code{virtio}, @code{i82551}, @code{i82557b}, @code{i82559er},
+@code{ne2k_pci}, @code{ne2k_isa}, @code{pcnet}, @code{rtl8139},
+@code{e1000}, @code{smc91c111}, @code{lance} and @code{mcf_fec}.
+Not all devices are supported on all targets.  Use @code{-net nic,model=help}
+for a list of available devices for your target.
+
+@item -net user|tap|bridge|socket|l2tpv3|vde[,...][,vlan=@var{n}][,name=@var{name}]
+Configure a host network backend (with the options corresponding to the same
+@option{--netdev} option) and connect it to the emulated hub ("vlan") with the
+number @var{n} (default is number 0). Use @var{name} to specify the name of the
+hub port.
 ETEXI
 
 STEXI
-- 
1.8.3.1
