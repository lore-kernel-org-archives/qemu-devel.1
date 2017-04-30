Received: from eggs.gnu.org ([2001:4830:134:3::10]:58749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.fonnemann@hexagon.com>) id 1d4oBh-0001ks-Sj
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 08:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.fonnemann@hexagon.com>) id 1d4oBZ-00027B-IJ
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 08:42:49 -0400
Received: from mail-db5eur01on0110.outbound.protection.outlook.com
	([104.47.2.110]:28706
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.fonnemann@hexagon.com>)
	id 1d4oBZ-00026I-78
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 08:42:45 -0400
From: FONNEMANN Mark <mark.fonnemann@hexagon.com>
Date: Sun, 30 Apr 2017 12:42:41 +0000
Message-ID: <VI1PR0601MB247905FC4B3FEE03780CF1EE9C150@VI1PR0601MB2479.eurprd06.prod.outlook.com>
References: <VI1PR0601MB2479950F84BBE26A46F549FA9C110@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<VI1PR0601MB2479D2A56A202E3FD18C6DDF9C1F0@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429124421.2qcthvlsiwvtqov2@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479CBDA85F323A82C0CFBD99C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429171002.enxmz5dtuzhrxuc6@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479886B8955148FD8A2D06F9C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429191402.ebsdilnya67ispla@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479CA25619E1C66359EC3709C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429220156.bb4hdlsaf6zzqmtw@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479F31C301B954294452CA49C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170430075033.yjqj4ibssa52h4d7@var.youpi.perso.aquilenet.fr>
In-Reply-To: <20170430075033.yjqj4ibssa52h4d7@var.youpi.perso.aquilenet.fr>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] dns server not working in QEMU using usermode
 networking (SLIRP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, MCDONALD Margaret <margaret.mcdonald@hexagon.com>

>Could you show us your NG.cfg, your guest /sbin/ifconfig and /sbin/route o=
utput and /etc/resolv.conf >content for that host?

[mfonnemann@desktopPC qemu]$ cat NG.cfg
[drive]
  format =3D "raw"
  file =3D "qemu_rootfs_512.img"

[drive]
  format =3D "raw"
  file =3D "placeholder2.vhdx"

[drive]
  format =3D "raw"
  file =3D "swap_512m.img"

[drive]
  format =3D "vhdx"
  file =3D "placeholder.vhdx"

[machine]
  usb =3D "on"
  initrd =3D "initrd-2.6.11.12.img.gz"
  kernel =3D "vmlinuz-2.6.11.12-vanilla.bz"
  append =3D "root=3D/dev/hda"

[memory]
  size =3D "2G"

[smp-opts]
  cpus =3D "2"

root@qemu:~# ifconfig
                   eth0      Link encap:Ethernet  HWaddr 52:54:00:12:34:56
                             inet addr:10.0.2.15  Bcast:10.255.255.255  Mas=
k:255.255.255.0
                             UP BROADCAST RUNNING MULTICAST  MTU:1500  Metr=
ic:1
                             RX packets:0 errors:0 dropped:0 overruns:0 fra=
me:0
                             TX packets:0 errors:0 dropped:0 overruns:0 car=
rier:0
                             collisions:0 txqueuelen:1000
                             RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
                             Base address:0xc000 Memory:febc0000-febe0000

                   lo        Link encap:Local Loopback
                             inet addr:127.0.0.1  Mask:255.0.0.0
                             UP LOOPBACK RUNNING  MTU:16436  Metric:1
                             RX packets:0 errors:0 dropped:0 overruns:0 fra=
me:0
                             TX packets:0 errors:0 dropped:0 overruns:0 car=
rier:0
                             collisions:0 txqueuelen:0

                  root@qemu:~# route
UDP packet for DNS server
                                                              translating 3=
02000a against ffffff 302000a
                                                                           =
                             it's an alias
                                                                           =
                                          it's DNS
      dns_addr is cached: 1020204
                                 got resolv.conf entry '4.2.2.1'
                   Kernel IP routing table                     =20
parsed 7fe2
                   Destination     Gateway         Genmask         Flags Me=
tric Ref   =20
Use Iface '4.2.2.2'
                   10.0.2.0        *               255.255.255.0   U     0 =
     0        0 eth0
                   default         10.0.2.2        0.0.0.0         UG    0 =
     0        0 eth0

root@qemu:~# cat /etc/resolv.conf
                   nameserver 10.0.2.3

root@qemu:~# nslookup www.google.com
                   *** Unknown host

                   nslookup: www.google.com: Unknown host

HTH

It appears using the "route" command causes your DNS debug statements to pr=
int out but still nslookup does not work correctly.

mark.
