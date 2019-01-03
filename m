Received: from eggs.gnu.org ([208.118.235.92]:56586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gf3Xq-0003oy-ON
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:00:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gf3Xk-0003YA-S5
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:00:22 -0500
Message-Id: <cover.1546522545.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Thu, 3 Jan 2019 14:35:45 +0100
Date: Thu, 03 Jan 2019 14:35:45 +0100
Subject: [Qemu-devel] [PATCH v2 0/6] Misc sam460ex related patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>

The last code patch in this series fixes memory size larger than 1GB
for sam460ex, other patches are just clean ups I've made along the way.

The first patch is intended to be generic and may be useful for other
boards which currently have their own SPD EEPROM data or don't yet
generate any SPD data just have TODO comments instead. These are MIPS
malta and fulong2e, ARM integratorcp and maybe aspeed, and the PIIX
and Q35 pc machines. I did not try to change these as I have no way to
test them throughly. Patch 2 converts sam460ex to use this function.
Other patches are misc cleanups.

Regards,
BALATON Zoltan

v2: Address review comments, omitting patches already merged

BALATON Zoltan (6):
  smbus: Add a helper to generate SPD EEPROM data
  sam460ex: Clean up SPD EEPROM creation
  ppc4xx: Use ram_addr_t in ppc4xx_sdram_adjust()
  ppc4xx: Rename ppc4xx_sdram_t in ppc440_uc.c to ppc440_sdram_t
  ppc4xx: Pass array index to function instead of pointer into the array
  sam460ex: Fix support for memory larger than 1GB

 hw/i2c/smbus_eeprom.c   | 130 ++++++++++++++++++++++++++++++++++
 hw/ppc/ppc440_bamboo.c  |   2 +-
 hw/ppc/ppc440_uc.c      |  70 +++++++++----------
 hw/ppc/ppc4xx_devs.c    |   4 +-
 hw/ppc/sam460ex.c       | 181 +++++++-----------------------------------------
 include/hw/i2c/smbus.h  |   3 +
 include/hw/ppc/ppc4xx.h |   2 +-
 7 files changed, 196 insertions(+), 196 deletions(-)

-- 
2.13.7
