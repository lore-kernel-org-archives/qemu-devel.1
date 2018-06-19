Received: from eggs.gnu.org ([2001:4830:134:3::10]:34450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVCkM-0005wG-SY
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:16:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVCkI-0000L5-VD
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:16:18 -0400
Message-Id: <cover.1529398335.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Tue, 19 Jun 2018 10:52:15 +0200
Subject: [Qemu-devel] [PATCH v4 00/11] Misc sam460ex improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Sebastian Bauer <mail@sebastianbauer.info>


Next spin of sam460ex pathces with changes according to review and
some new patches.

BALATON Zoltan (8):
  ppc4xx_i2c: Remove unimplemented sdata and intr registers
  ppc4xx_i2c: Implement directcntl register
  ppc4xx_i2c: Rewrite to model hardware more closely
  hw/timer: Add basic M41T80 emulation
  sam460ex: Add RTC device
  target/ppc: Add missing opcode for icbt on PPC440
  sm501: Implement i2c part for reading monitor EDID
  sm501: Set updated region dirty after 2D operation
  sm501: Fix support for non-zero frame buffer start address

Sebastian Bauer (3):
  sm501: Perform a full update after palette change
  sm501: Use values from the pitch register for 2d operations.

 MAINTAINERS                        |   1 +
 default-configs/ppc-softmmu.mak    |   3 +
 default-configs/ppcemb-softmmu.mak |   2 +
 default-configs/sh4-softmmu.mak    |   1 +
 default-configs/sh4eb-softmmu.mak  |   1 +
 hw/display/sm501.c                 | 166 ++++++++++++++++++++++--
 hw/i2c/ppc4xx_i2c.c                | 252 ++++++++++++++++++-------------------
 hw/ppc/sam460ex.c                  |   1 +
 hw/timer/Makefile.objs             |   1 +
 hw/timer/m41t80.c                  | 117 +++++++++++++++++
 include/hw/i2c/ppc4xx_i2c.h        |  11 +-
 target/ppc/translate.c             |   2 +
 12 files changed, 415 insertions(+), 143 deletions(-)
 create mode 100644 hw/timer/m41t80.c

-- 
2.7.6
