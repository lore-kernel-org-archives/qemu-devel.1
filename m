Received: from eggs.gnu.org ([2001:4830:134:3::10]:56177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fZMZX-0000lo-Qi
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 16:34:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fZMZU-0005lc-MZ
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 16:34:19 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:35045)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1fZMZU-0005ig-C6
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 16:34:16 -0400
Date: Sat, 30 Jun 2018 22:34:13 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <cover.1530047900.git.balaton@eik.bme.hu>
Message-ID: <alpine.BSF.2.21.1806302231400.45338@zero.eik.bme.hu>
References: <cover.1530047900.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v2 0/7] Misc sm501 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Sebastian Bauer <mail@sebastianbauer.info>, Magnus Damm <magnus.damm@gmail.com>, Philippe Mathieu-Daude <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>

On Tue, 26 Jun 2018, BALATON Zoltan wrote:
> Version 2 of the sm501 changes with fixes that are needed to get
> AmigaOS 4.1FE to boot and able to produce graphics.
>
> The strange blue-white colors that first appear are actually correct
> and because of AmigaOS selecting a low resolution PAL mode by default
> instead of a board specific mode. To work around this one can select
> the last option to boot the live CD and then select a better board
> specific mode from ScreenMode Prefs. It takes a while for the
> ScreenMode window to appear and graphics operations are slow which
> could use some improvement but at least it seems to work correctly now
> apart from some unimplemented drawing modes for compositing.
>
> If this could be merged before the freeze with the sam460ex patches
> and Sebastian's ehci patch then QEMU 3.0 could be the first version
> that can boot AmigaOS.

Ping? Sorry to push it but it would be great if this could get in for 3.0. 
Peter, this may need your attention like last time as it's not clear whose 
tree it should go through and David did not seem to be confident taking it 
via the ppc tree.

Thank you,
BALATON Zoltan

> BALATON Zoltan (3):
>  sm501: Implement i2c part for reading monitor EDID
>  sm501: Fix support for non-zero frame buffer start address
>  sm501: Set updated region dirty after 2D operation
>
> Sebastian Bauer (4):
>  sm501: Perform a full update after palette change
>  sm501: Use values from the pitch register for 2D operations
>  sm501: Implement negated destination raster operation mode
>  sm501: Log unimplemented raster operation modes
>
> default-configs/ppc-softmmu.mak    |   1 +
> default-configs/ppcemb-softmmu.mak |   1 +
> default-configs/sh4-softmmu.mak    |   2 +
> default-configs/sh4eb-softmmu.mak  |   2 +
> hw/display/sm501.c                 | 229 +++++++++++++++++++++++++++++++++++--
> 5 files changed, 223 insertions(+), 12 deletions(-)
>
>
