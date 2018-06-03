Received: from eggs.gnu.org ([2001:4830:134:3::10]:41669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fPdGq-0004bW-0a
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 20:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fPdGm-0008G5-Sy
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 20:22:48 -0400
Message-Id: <cover.1528069840.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Mon, 4 Jun 2018 01:50:40 +0200
Subject: [Qemu-devel] [PATCH 0/4] Misc sam460ex improvements
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

BALATON Zoltan (4):
  ppc4xx_i2c: Rewrite PPC4xx I2C emulation
  hw/timer: Add basic M41T80 emulation
  sam460ex: Add RTC device
  sm501: Do not clear read only bits when writing register

 MAINTAINERS                     |   1 +
 default-configs/ppc-softmmu.mak |   2 +
 hw/display/sm501.c              |   6 +-
 hw/i2c/ppc4xx_i2c.c             | 366 +++++++++++++++++++++-------------------
 hw/ppc/sam460ex.c               |   1 +
 hw/timer/Makefile.objs          |   1 +
 hw/timer/m41t80.c               | 117 +++++++++++++
 include/hw/i2c/ppc4xx_i2c.h     |  19 +--
 8 files changed, 321 insertions(+), 192 deletions(-)
 create mode 100644 hw/timer/m41t80.c

-- 
2.7.6
