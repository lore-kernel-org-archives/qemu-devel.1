Received: from eggs.gnu.org ([2001:4830:134:3::10]:51707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d6o0y-000788-JY
	for qemu-devel@nongnu.org; Fri, 05 May 2017 20:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d6o0x-0008OU-Ul
	for qemu-devel@nongnu.org; Fri, 05 May 2017 20:56:04 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:42371)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d6o0x-0008OI-NW
	for qemu-devel@nongnu.org; Fri, 05 May 2017 20:56:03 -0400
Date: Sat, 6 May 2017 02:56:00 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170506005600.6utgnirnrlm2g56i@var.youpi.perso.aquilenet.fr>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0601MB2479934DD8D5807C7A9DB0A39CE80@VI1PR0601MB2479.eurprd06.prod.outlook.com>
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
To: FONNEMANN Mark <mark.fonnemann@hexagon.com>
Cc: Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

FONNEMANN Mark, on sam. 06 mai 2017 00:33:40 +0000, wrote:
> >The attached patch should be dumping the same kind of information.
> 
> Nslookup does not produce any output in curses or in logfile (-D logfile.txt).

Uh.  So qemu can't be the culprit since it doesn't receive anything :)

> root@qemu:~# /initrd/bin/nslookup www.google.com
>                     Server:    10.0.2.3
>                     Address 1: 10.0.2.3
> 
>                     nslookup: can't resolve 'www.google.com'

So it's supposed to be using 10.0.2.3 I guess. Just to make sure, you
could try

/initrd/bin/nslookup www.google.com 10.0.2.3

> I know the patch was applied because when I ping 10.0.2.2 I get the following:
> 
> root@qemu:~# ping 10.0.2.2
>                     PING 10.0.2.2 (10.0.2.2): 56 data bytes
>                     64 bytes from 10.0.2.2: icmp_seq=0 ttl=255 time=0.5 ms
> [mfonnemann@localhost qemu]$ cat logfile
> ip input a00020f -> a000202 1
> ip input a00020f -> a000202 1

Do you get output when pinging 10.0.2.3?
(you won't get ping answers, but that's fine, qemu should still be able
to see the requests coming in)

Also, just to make sure: you don't have firewalling rules, do you?

Samuel
