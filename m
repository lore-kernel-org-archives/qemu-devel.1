Received: from eggs.gnu.org ([2001:4830:134:3::10]:40214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fTGBF-0006O5-J6
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 20:32:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fTGBC-00037Z-Bx
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 20:32:01 -0400
Message-Id: <cover.1528935420.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Thu, 14 Jun 2018 02:17:00 +0200
Date: Thu, 14 Jun 2018 02:17:00 +0200
Subject: [Qemu-devel] [PATCH v3 0/9] Misc sam460ex improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Sebastian Bauer <mail@sebastianbauer.info>

This is v3 of sam460ex improvements addressing review comments and
adding two additional patches that allow AmigaOS to progress further
(does not boot fully yet).

BALATON Zoltan (8):
  ppc4xx_i2c: Remove unimplemented sdata and intr registers
  ppc4xx_i2c: Implement directcntl register
  ppc4xx_i2c: Rewrite to model hardware more closely
  hw/timer: Add basic M41T80 emulation
  sam460ex: Add RTC device
  sm501: Do not clear read only bits when writing registers
  sm501: Implement i2c part for reading monitor EDID
  target/ppc: Add missing opcode for icbt on PPC440

Sebastian Bauer (1):
  sm501: Perform a full update after palette change

 MAINTAINERS                        |   1 +
 default-configs/ppc-softmmu.mak    |   3 +
 default-configs/ppcemb-softmmu.mak |   2 +
 default-configs/sh4-softmmu.mak    |   1 +
 default-configs/sh4eb-softmmu.mak  |   1 +
 hw/display/sm501.c                 | 159 +++++++++++++++++++++--
 hw/i2c/ppc4xx_i2c.c                | 251 ++++++++++++++++++-------------------
 hw/ppc/sam460ex.c                  |   1 +
 hw/timer/Makefile.objs             |   1 +
 hw/timer/m41t80.c                  | 117 +++++++++++++++++
 include/hw/i2c/ppc4xx_i2c.h        |  11 +-
 target/ppc/translate.c             |   2 +
 12 files changed, 406 insertions(+), 144 deletions(-)
 create mode 100644 hw/timer/m41t80.c

-- 
2.7.6
