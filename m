Received: from eggs.gnu.org ([2001:4830:134:3::10]:46048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dlwlo-0007TS-88
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 08:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dlwlj-0005lT-89
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 08:34:28 -0400
Date: Sun, 27 Aug 2017 14:34:14 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <cover.1503249785.git.balaton@eik.bme.hu>
Message-ID: <alpine.BSF.2.21.1708271402040.1289@zero.eik.bme.hu>
References: <cover.1503249785.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 00/15] Sam460ex emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Francois Revol <revol@free.fr>, David Gibson <david@gibson.dropbear.id.au>

Hello,

Just to confirm where we are with this series, let me summarise what I got 
from the replies and what's my plan for this based on that. Here's the 
list of patches for reference:

[PATCH 01/15] ppc4xx: Move MAL from ppc405_uc to ppc4xx_devs
[PATCH 02/15] ppc4xx: Make MAL emulation more generic
[PATCH 03/15] ohci: Allow sysbus version to be used as a companion
[PATCH 04/15] ehci: Add ppc4xx-ehci for the USB 2.0 controller in embedded PPC SoCs
[PATCH 05/15] ppc4xx: Split off 4xx I2C emulation from ppc405_uc to its own file
[PATCH 06/15] ppc4xx_i2c: QOMify
[PATCH 07/15] ppc4xx_i2c: Move to hw/i2c
[PATCH 08/15] ppc4xx_i2c: Implement basic I2C functions
[PATCH 09/15] hw/ide: Emulate SiI3112 SATA controller
[PATCH 10/15] ppc440: Add emulation of plb-pcix controller found in some 440 SoCs
[PATCH 11/15] ppc: Add 460EX embedded CPU
[PATCH 12/15] ppc4xx: Export ECB and PLB emulation
[PATCH 13/15] ppc4xx: Add more PLB registers
[PATCH 14/15] ppc4xx: Add device models found in PPC440 core SoCs
[PATCH 15/15] ppc: Add aCube Sam460ex board

- I think 1-7 is either already queued for 2.11 or could be applied as is 
having got reviews without need to change so I don't need to resend them. 
So are 11-13 if I got that right. That leaves 8-10 and 14-15 that I'll 
resend.

- I'm not sure if 8 was reviewed or do I need to make any modifications to 
it.

- I know I should change 9-10 and 14-15 based on review comments and 
resend.

Since I'll likely also need to change those patches to fix the bugs we 
know about currently, I thought I should probably resend after those bugs 
are fixed to avoid subsequent fixup patches. Since this will not be before 
next week (because I don't have time for it before that) I hope 
development should be open again and those patches that are already OK 
could be merged by then so I can rebase on that and only resend the 
missing ones as described above. Is that OK or did I miss something?

David, in case you want to stage all of this in your for-2.11 branch 
before all patches are ready and send them together, then where is this 
branch I should rebase to?

Regards,
BALATON Zoltan
