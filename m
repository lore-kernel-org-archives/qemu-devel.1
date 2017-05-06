Received: from eggs.gnu.org ([2001:4830:134:3::10]:49010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.fonnemann@hexagon.com>) id 1d6nfO-0002zN-73
	for qemu-devel@nongnu.org; Fri, 05 May 2017 20:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.fonnemann@hexagon.com>) id 1d6nfK-0008Dw-W0
	for qemu-devel@nongnu.org; Fri, 05 May 2017 20:33:46 -0400
Received: from mail-eopbgr50132.outbound.protection.outlook.com
	([40.107.5.132]:14398
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.fonnemann@hexagon.com>)
	id 1d6nfK-0008DU-Hj
	for qemu-devel@nongnu.org; Fri, 05 May 2017 20:33:42 -0400
From: FONNEMANN Mark <mark.fonnemann@hexagon.com>
Date: Sat, 6 May 2017 00:33:40 +0000
Message-ID: <VI1PR0601MB2479934DD8D5807C7A9DB0A39CE80@VI1PR0601MB2479.eurprd06.prod.outlook.com>
References: <20170429171002.enxmz5dtuzhrxuc6@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479886B8955148FD8A2D06F9C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429191402.ebsdilnya67ispla@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479CA25619E1C66359EC3709C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429220156.bb4hdlsaf6zzqmtw@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479F31C301B954294452CA49C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170430075033.yjqj4ibssa52h4d7@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB247905FC4B3FEE03780CF1EE9C150@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170430125703.pcp4ldw7oardptmn@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB247996FB5818A956470FE8169CEB0@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170505231433.ggp34jmzx4fad6jp@var.youpi.perso.aquilenet.fr>
In-Reply-To: <20170505231433.ggp34jmzx4fad6jp@var.youpi.perso.aquilenet.fr>
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
Cc: Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

>The attached patch should be dumping the same kind of information.

Nslookup does not produce any output in curses or in logfile (-D logfile.tx=
t). I tried it using the version installed on the root system (Busybox 1.0)=
:

root@qemu:~# nslookup
                    BusyBox v1.00 (2010.04.14-20:01+0000) multi-call binary

                    Usage: nslookup [HOST] [SERVER]
root@qemu:~# nslookup www.google.com
                    *** Unknown host

                    nslookup: www.google.com: Unknown host

 as well as the newer version installed in initrd image which is version 1.=
25.1:

root@qemu:~# /initrd/bin/nslookup
                    BusyBox v1.25.1 (2017-05-01 19:00:24 EDT) multi-call bi=
nary.

                    Usage: nslookup [HOST] [SERVER]

                    Query the nameserver for the IP address of the given HO=
ST
                    optionally using a specified DNS server
root@qemu:~# /initrd/bin/nslookup www.google.com
                    Server:    10.0.2.3
                    Address 1: 10.0.2.3

                    nslookup: can't resolve 'www.google.com'

I know the patch was applied because when I ping 10.0.2.2 I get the followi=
ng:

root@qemu:~# ping 10.0.2.2
                    PING 10.0.2.2 (10.0.2.2): 56 data bytes
                    64 bytes from 10.0.2.2: icmp_seq=3D0 ttl=3D255 time=3D0=
.5 ms
                    64 bytes from 10.0.2.2: icmp_seq=3D1 ttl=3D255 time=3D0=
.1 ms
                    64 bytes from 10.0.2.2: icmp_seq=3D2 ttl=3D255 time=3D0=
.1 ms
                    64 bytes from 10.0.2.2: icmp_seq=3D3 ttl=3D255 time=3D0=
.1 ms
                    64 bytes from 10.0.2.2: icmp_seq=3D4 ttl=3D255 time=3D0=
.2 ms

                    --- 10.0.2.2 ping statistics ---
                    5 packets transmitted, 5 packets received, 0% packet lo=
ss
                    round-trip min/avg/max =3D 0.1/0.2/0.5 ms

[mfonnemann@localhost qemu]$ cat logfile
ip input a00020f -> a000202 1
ip input a00020f -> a000202 1
ip input a00020f -> a000202 1
ip input a00020f -> a000202 1
ip input a00020f -> a000202 1

mark.
