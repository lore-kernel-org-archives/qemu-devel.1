Received: from eggs.gnu.org ([2001:4830:134:3::10]:37349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d1uKq-0000aH-Do
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 08:40:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d1uKn-0002mt-Bn
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 08:40:20 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:33038)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d1uKn-0002mD-4h
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 08:40:17 -0400
Date: Sat, 22 Apr 2017 14:36:35 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170422123635.4kepoxqjtut6qmyd@var.youpi.perso.aquilenet.fr>
References: <VI1PR0601MB2479DE114384C023CA45C41E9C040@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170416080930.luq2l4p3e36vovkj@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479E581256475D80164322A9C070@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<cd2a810c-d717-4666-4a95-b185c02d83df@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd2a810c-d717-4666-4a95-b185c02d83df@weilnetz.de>
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
To: Stefan Weil <sw@weilnetz.de>
Cc: FONNEMANN Mark <mark.fonnemann@hexagon.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Stefan Weil, on ven. 21 avril 2017 21:58:18 +0200, wrote:
> Am 17.04.2017 um 00:10 schrieb FONNEMANN Mark:
> > I hadn't seen the original report on the list, sorry. There is too much traffic on qemu-devel for me to manage to catch these :/
> > 
> > This problem was fixed by
> > e42f869b ("slirp: Make RA build more flexible") and a2f80fdf ("slirp: Send RDNSS in RA only if host has an IPv6 DNS server") which will be included in qemu 2.9.
> > 
> > Samuel
> 
> See report on http://stackoverflow.com/questions/43308310/dns-server-not-working-in-qemu-usermode-networking.
> 
> Mark, did you also get that problem with QEMU running on a Linux host,
> or is it specific for QEMU running on Windows?

Ah, I hadn't noticed the report was about windows. The abovementioned
fix should still be fine for windows: there, get_dns6_addr just always
returns -1, and thus the RDNSS option is never added.

So I don't know what to do on my side, more investigation is needed
there.

Samuel
