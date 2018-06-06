Received: from eggs.gnu.org ([2001:4830:134:3::10]:40173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fQYwW-0008Q5-13
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fQYwS-0000VI-VO
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:57:40 -0400
Message-Id: <cover.1528291908.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Wed, 06 Jun 2018 15:31:48 +0200
Subject: [Qemu-devel] [PATCH v2 0/8] Misc sam460ex improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

Some more improvements to sam460ex emulation:
- Implemented RTC (which also needed fixing I2C to work)
- Fix a problem in sm501 which led to AmigaOS slow down

v2:
- split patch 1 (i2c rewrite) into smaller pieces
- Added another sm501 patch

BALATON Zoltan (8):
  ppc4xx_i2c: Clean up and improve error logging
  ppc4xx_i2c: Move register state to private struct and remove    
    unimplemented sdata and intr registers
  ppc4xx_i2c: Implement directcntl register
  ppc4xx_i2c: Rewrite to model hardware more closely
  hw/timer: Add basic M41T80 emulation
  sam460ex: Add RTC device
  sm501: Do not clear read only bits when writing register
  sm501: Implement i2c part for reading monitor EDID

 MAINTAINERS                        |   1 +
 default-configs/ppc-softmmu.mak    |   3 +
 default-configs/ppcemb-softmmu.mak |   2 +
 default-configs/sh4-softmmu.mak    |   1 +
 default-configs/sh4eb-softmmu.mak  |   1 +
 hw/display/sm501.c                 | 142 ++++++++++++++-
 hw/i2c/ppc4xx_i2c.c                | 364 ++++++++++++++++++++-----------------
 hw/ppc/sam460ex.c                  |   1 +
 hw/timer/Makefile.objs             |   1 +
 hw/timer/m41t80.c                  | 117 ++++++++++++
 include/hw/i2c/ppc4xx_i2c.h        |  19 +-
 11 files changed, 457 insertions(+), 195 deletions(-)
 create mode 100644 hw/timer/m41t80.c

-- 
2.7.6
