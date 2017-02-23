Received: from eggs.gnu.org ([2001:4830:134:3::10]:58476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cgxEe-00079H-4W
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 12:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cgxEZ-0005nq-Ub
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 12:31:20 -0500
Date: Thu, 23 Feb 2017 18:31:04 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <cover.1487522123.git.balaton@eik.bme.hu>
Message-ID: <alpine.BSF.2.20.1702231822570.1863@zero.eik.bme.hu>
References: <cover.1487522123.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH 00/10] Improvements for sm501 display
 controller emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Magnus Damm <magnus.damm@gmail.com>

On Sun, 19 Feb 2017, BALATON Zoltan wrote:
> This series improves the sm501 display controller emulation fixing
> endianness problems that caused mixed up colors in LE hosts, fix hardware
> cursor and adding panel layer support and some missing registers. The
> first few patches update the code style and QOMify the device before
> changes are made to it in subsequent patches.
>
> Including qemu-trivial list as well, both because some of the patches
> are trivial and also I'm not sure how actively maintained this part is
> so that also may need attention from the trivial list to get this merged.
>
> The changes were tested with sh4 image at
> https://people.debian.org/~aurel32/qemu/sh4/
> which accepts video= kernel parameter to excercise different screen modes.
>
> BALATON Zoltan (10):
>  sm501: Fixed code style and a few typos in comments
>  sm501: Use defines instead of constants where available
>  sm501: QOMify
>  sm501: Add emulation of chip connected via PCI
>  sm501: Add missing arbitration control register
>  sm501: Fix device endianness
>  sm501: Fix hardware cursor
>  sm501: Add support for panel layer
>  sm501: Add some more missing registers
>  ppc: Add SM501 device in config for ppc and ppcemb targets
>
> default-configs/ppc-softmmu.mak    |    1 +
> default-configs/ppcemb-softmmu.mak |    1 +
> hw/display/sm501.c                 | 1546 ++++++++++++++++++++----------------
> hw/display/sm501_template.h        |   92 +--
> hw/sh4/r2d.c                       |   11 +-
> include/hw/devices.h               |    5 -
> 6 files changed, 920 insertions(+), 736 deletions(-)

Ping? Is there anyone who could take a look and merge this? It could get 
tested more during the freeze and could be reverted any time if found to 
cause any problems but if it's not merged now it may get delayed for 
months until the next opportunity.
Patchwork links:

http://patchwork.ozlabs.org/patch/729575/
http://patchwork.ozlabs.org/patch/729570/
http://patchwork.ozlabs.org/patch/729571/
http://patchwork.ozlabs.org/patch/729574/
http://patchwork.ozlabs.org/patch/729576/
http://patchwork.ozlabs.org/patch/729577/
http://patchwork.ozlabs.org/patch/729572/
http://patchwork.ozlabs.org/patch/729573/
http://patchwork.ozlabs.org/patch/729569/
http://patchwork.ozlabs.org/patch/729568/
