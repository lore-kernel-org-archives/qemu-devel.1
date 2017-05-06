Received: from eggs.gnu.org ([2001:4830:134:3::10]:53187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.fonnemann@hexagon.com>) id 1d6oBE-0001km-01
	for qemu-devel@nongnu.org; Fri, 05 May 2017 21:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.fonnemann@hexagon.com>) id 1d6oB9-00054n-3V
	for qemu-devel@nongnu.org; Fri, 05 May 2017 21:06:40 -0400
Received: from mail-eopbgr50099.outbound.protection.outlook.com
	([40.107.5.99]:64058
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.fonnemann@hexagon.com>)
	id 1d6oB8-00054W-LD
	for qemu-devel@nongnu.org; Fri, 05 May 2017 21:06:35 -0400
From: FONNEMANN Mark <mark.fonnemann@hexagon.com>
Date: Sat, 6 May 2017 01:06:31 +0000
Message-ID: <VI1PR0601MB2479B8C2F3EA375823AD6B6E9CE80@VI1PR0601MB2479.eurprd06.prod.outlook.com>
References: <20170429191402.ebsdilnya67ispla@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479CA25619E1C66359EC3709C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429220156.bb4hdlsaf6zzqmtw@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479F31C301B954294452CA49C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170430075033.yjqj4ibssa52h4d7@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB247905FC4B3FEE03780CF1EE9C150@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170430125703.pcp4ldw7oardptmn@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB247996FB5818A956470FE8169CEB0@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170505231433.ggp34jmzx4fad6jp@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479934DD8D5807C7A9DB0A39CE80@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170506005600.6utgnirnrlm2g56i@var.youpi.perso.aquilenet.fr>
In-Reply-To: <20170506005600.6utgnirnrlm2g56i@var.youpi.perso.aquilenet.fr>
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

>So it's supposed to be using 10.0.2.3 I guess. Just to make sure, you coul=
d try
>/initrd/bin/nslookup www.google.com 10.0.2.3

root@qemu:~# /initrd/bin/nslookup www.google.com 10.0.2.3
                    Server:    10.0.2.3
                    Address 1: 10.0.2.3

                    nslookup: can't resolve 'www.google.com'

>Do you get output when pinging 10.0.2.3?
>(you won't get ping answers, but that's fine, qemu should still be able to=
 see the requests coming in)

root@qemu:~# ping 10.0.2.3
                    PING 10.0.2.3 (10.0.2.3): 56 data bytes

                    --- 10.0.2.3 ping statistics ---
                    9 packets transmitted, 0 packets received, 100% packet =
loss

[mfonnemann@localhost qemu]$ cat logfile
ip input a00020f -> a000203 1
ip input a00020f -> a000203 1
ip input a00020f -> a000203 1
ip input a00020f -> a000203 1
ip input a00020f -> a000203 1
ip input a00020f -> a000203 1
ip input a00020f -> a000203 1
ip input a00020f -> a000203 1
ip input a00020f -> a000203 1

>Also, just to make sure: you don't have firewalling rules, do you?

How can I verify this? (iptables is not installed on this guest Linux)=20
