Received: from eggs.gnu.org ([2001:4830:134:3::10]:41442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1czfFZ-0008AT-Gf
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 04:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1czfFW-0005PX-D5
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 04:09:37 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:39830)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1czfFW-0005P2-7K
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 04:09:34 -0400
Date: Sun, 16 Apr 2017 10:09:30 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170416080930.luq2l4p3e36vovkj@var.youpi.perso.aquilenet.fr>
References: <VI1PR0601MB2479DE114384C023CA45C41E9C040@VI1PR0601MB2479.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0601MB2479DE114384C023CA45C41E9C040@VI1PR0601MB2479.eurprd06.prod.outlook.com>
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hello,

I hadn't seen the original report on the list, sorry. There is too much
traffic on qemu-devel for me to manage to catch these :/

This problem was fixed by 
e42f869b ("slirp: Make RA build more flexible") and
a2f80fdf ("slirp: Send RDNSS in RA only if host has an IPv6 DNS server")
which will be included in qemu 2.9.

Samuel
