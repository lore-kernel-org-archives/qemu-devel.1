Received: from eggs.gnu.org ([2001:4830:134:3::10]:51449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fYg2l-0005Oi-Fr
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 19:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fYg2g-0005Pp-A4
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 19:09:39 -0400
Message-Id: <cover.1530225513.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Fri, 29 Jun 2018 00:38:33 +0200
Subject: [Qemu-devel] [PATCH v6 0/5] Misc sam460ex improvements
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

These are the remaining patches for sam460ex needed to implement RTC
and get AmigaOS to boot. The sm501 patches (now a separate series) and
Sebastian's ehci patch are also needed to get AmigaOS working. I'd
appreciate if this could be merged before the imminent 3.0 freeze so
we could have at least preliminary support for all major Amiga like
OSes in QEMU 3.0.

BALATON Zoltan (5):
  ppc4xx_i2c: Rewrite to model hardware more closely
  hw/timer: Add basic M41T80 emulation
  sam460ex: Add RTC device
  ppc440_uc: Basic emulation of PPC440 DMA controller
  target/ppc: Relax reserved bitmask of indexed store instructions

 MAINTAINERS                     |   1 +
 default-configs/ppc-softmmu.mak |   1 +
 hw/i2c/ppc4xx_i2c.c             | 299 +++++++++++++++++++++-------------------
 hw/ppc/ppc440.h                 |   1 +
 hw/ppc/ppc440_uc.c              | 221 +++++++++++++++++++++++++++++
 hw/ppc/sam460ex.c               |   4 +
 hw/timer/Makefile.objs          |   1 +
 hw/timer/m41t80.c               | 117 ++++++++++++++++
 include/hw/i2c/ppc4xx_i2c.h     |   3 +-
 target/ppc/translate.c          |   2 +-
 10 files changed, 506 insertions(+), 144 deletions(-)
 create mode 100644 hw/timer/m41t80.c

-- 
2.7.6
