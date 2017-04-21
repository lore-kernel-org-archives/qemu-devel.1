Received: from eggs.gnu.org ([2001:4830:134:3::10]:60422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1d1ehL-0005UD-RV
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 15:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1d1ehH-000762-VU
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 15:58:31 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:47448
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1d1ehH-00075p-Nm
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 15:58:27 -0400
From: Stefan Weil <sw@weilnetz.de>
References: <VI1PR0601MB2479DE114384C023CA45C41E9C040@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170416080930.luq2l4p3e36vovkj@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479E581256475D80164322A9C070@VI1PR0601MB2479.eurprd06.prod.outlook.com>
Message-ID: <cd2a810c-d717-4666-4a95-b185c02d83df@weilnetz.de>
Date: Fri, 21 Apr 2017 21:58:18 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR0601MB2479E581256475D80164322A9C070@VI1PR0601MB2479.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
To: FONNEMANN Mark <mark.fonnemann@hexagon.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@gnu.org>

Am 17.04.2017 um 00:10 schrieb FONNEMANN Mark:
> This issue still exists for me in 2.9 rc4.
>
> -----Original Message-----
> From: Samuel Thibault [mailto:samuel.thibault@gnu.org]
> Sent: Sunday, April 16, 2017 04:10
> To: FONNEMANN Mark <mark.fonnemann@hexagon.com>
> Cc: qemu-devel@nongnu.org
> Subject: Re: [Qemu-devel] dns server not working in QEMU using usermode networking (SLIRP)
>
> Hello,
>
> I hadn't seen the original report on the list, sorry. There is too much traffic on qemu-devel for me to manage to catch these :/
>
> This problem was fixed by
> e42f869b ("slirp: Make RA build more flexible") and a2f80fdf ("slirp: Send RDNSS in RA only if host has an IPv6 DNS server") which will be included in qemu 2.9.
>
> Samuel

See report on 
http://stackoverflow.com/questions/43308310/dns-server-not-working-in-qemu-usermode-networking.

Mark, did you also get that problem with QEMU running on a Linux host,
or is it specific for QEMU running on Windows?

Regards,
Stefan
