Received: from eggs.gnu.org ([2001:4830:134:3::10]:56788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.fonnemann@hexagon.com>) id 1d4Xar-0004TB-Ef
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 14:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.fonnemann@hexagon.com>) id 1d4Xao-0003TA-DP
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 14:59:45 -0400
Received: from mail-db5eur01on0090.outbound.protection.outlook.com
	([104.47.2.90]:28458
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.fonnemann@hexagon.com>)
	id 1d4Xao-0003T1-4P
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 14:59:42 -0400
From: FONNEMANN Mark <mark.fonnemann@hexagon.com>
Date: Sat, 29 Apr 2017 18:25:26 +0000
Message-ID: <VI1PR0601MB2479886B8955148FD8A2D06F9C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
References: <VI1PR0601MB247952CA06D05D5041AA450D9C130@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<VI1PR0601MB247995F01C0EC808ADEA07C49C180@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<VI1PR0601MB2479950F84BBE26A46F549FA9C110@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<VI1PR0601MB2479D2A56A202E3FD18C6DDF9C1F0@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429124421.2qcthvlsiwvtqov2@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479CBDA85F323A82C0CFBD99C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429171002.enxmz5dtuzhrxuc6@var.youpi.perso.aquilenet.fr>
In-Reply-To: <20170429171002.enxmz5dtuzhrxuc6@var.youpi.perso.aquilenet.fr>
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
Cc: Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>, MCDONALD Margaret <margaret.mcdonald@hexagon.com>

Hello-

>And I guess these do work fine on the host.

Yes:

[mfonnemann@localhost ~]$ nslookup www.google.com
Server:         4.2.2.1
Address:        4.2.2.1#53

Non-authoritative answer:
Name:   www.google.com
Address: 172.217.11.4

>Perhaps you should make sure that qemu does emit the DNS lookup request to=
 these thanks to
>tcpdump -i any host 4.2.2.1 or host 4.2.2.2
>while you run nslookup from the guest.

1. Issue command as requested on linux host:

 [mfonnemann@localhost qemu]$ sudo tcpdump -i any host 4.2.2.1 or host 4.2.=
2.2
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on any, link-type LINUX_SLL (Linux cooked), capture size 65535 by=
tes

2. Start qemu on linux host:

[mfonnemann@localhost qemu]$ /usr/local/bin/qemu-system-i386 -display curse=
s -readconfig qemu.cfg

3. Do nslookup on linux guest:

root@qemu:~# nslookup www.google.com

                    *** Unknown host

                    nslookup: www.google.com: Unknown host

root@qemu:~# nslookup www.google.com 10.0.2.3
                    *** Unknown host

                    nslookup: www.google.com: Unknown host

4. Exit tcpdump via ctrl-c:

^C
0 packets captured
0 packets received by filter
0 packets dropped by kernel

Thanks for your continued assistance!

Mark.
