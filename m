Received: from eggs.gnu.org ([208.118.235.92]:35859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1geWgT-0004Op-SB
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 21:55:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1geWgR-0005RU-M9
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 21:55:05 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:60314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1geWgR-0005Qq-7N
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 21:55:03 -0500
Message-Id: <cover.1546394798.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Wed, 2 Jan 2019 03:06:38 +0100
Subject: [Qemu-devel] [PATCH 0/8] Misc sam460ex related patches
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

Other patches are misc cleanups. The very last patch is administrative
and adds some more files to sam460ex section in MAINTAINERS as was
discussed before.

Regards,
BALATON Zoltan

BALATON Zoltan (8):
  smbus: Add a helper to generate SPD EEPROM data
  sam460ex: Clean up SPD EEPROM creation
  ppc4xx: Disable debug logging by default
  ppc4xx: Use ram_addr_t in ppc4xx_sdram_adjust()
  ppc4xx: Rename ppc4xx_sdram_t in ppc440_uc.c to ppc440_sdram_t
  ppc4xx: Pass array index to function instead of pointer into the array
  sam460ex: Fix support for memory larger than 1GB
  MAINTAINERS: Add more files to sam460ex

 MAINTAINERS             |   6 ++
 hw/i2c/smbus_eeprom.c   | 128 ++++++++++++++++++++++++++++++++++
 hw/ppc/ppc440_bamboo.c  |   2 +-
 hw/ppc/ppc440_uc.c      |  70 ++++++++++---------
 hw/ppc/ppc4xx_devs.c    |   7 +-
 hw/ppc/sam460ex.c       | 177 ++++++------------------------------------------
 include/hw/i2c/smbus.h  |   3 +
 include/hw/ppc/ppc4xx.h |   2 +-
 8 files changed, 197 insertions(+), 198 deletions(-)

-- 
2.13.7
