Received: from eggs.gnu.org ([2001:4830:134:3::10]:51761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHB-00021X-AC
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHA-0007Bq-6Y
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:09 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fXrH9-00079F-UP
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:08 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrH2-0008SJ-5V
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 17:57:00 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 17:56:26 +0100
Message-Id: <20180626165658.31394-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/32] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

target-arm queue: mostly smallish stuff. I expect to send
out another pullreq at the end of this week, but since this
is up to 32 patches already I'd rather send it out now
than accumulate a monster sized patchset.

thanks
-- PMM


The following changes since commit 0ab4c574a55448a37b9f616259b82950742c9427:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180626-pull-request' into staging (2018-06-26 16:44:57 +0100)

are available in the Git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180626

for you to fetch changes up to 9b945a9ee36a34eaeca412ef9ef35fbfe33c2c85:

  aspeed/timer: use the APB frequency from the SCU (2018-06-26 17:50:42 +0100)

----------------------------------------------------------------
target-arm queue:
 * aspeed: set APB clocks correctly (fixes slowdown on palmetto)
 * smmuv3: cache config data and TLB entries
 * v7m/v8m: support read/write from MPU regions smaller than 1K
 * various: clean up logging/debug messages
 * xilinx_spips: Make dma transactions as per dma_burst_size

----------------------------------------------------------------
Cédric Le Goater (6):
      aspeed/smc: fix dummy cycles count when in dual IO mode
      aspeed/smc: fix HW strapping
      aspeed/smc: rename aspeed_smc_flash_send_addr() to aspeed_smc_flash_setup()
      aspeed/scu: introduce clock frequencies
      aspeed: initialize the SCU controller first
      aspeed/timer: use the APB frequency from the SCU

Eric Auger (3):
      hw/arm/smmuv3: Cache/invalidate config data
      hw/arm/smmuv3: IOTLB emulation
      hw/arm/smmuv3: Add notifications on invalidation

Jia He (1):
      hw/arm/smmuv3: Fix translate error handling

Joel Stanley (1):
      MAINTAINERS: Add ASPEED BMCs

Peter Maydell (3):
      tcg: Support MMU protection regions smaller than TARGET_PAGE_SIZE
      target/arm: Set page (region) size in get_phys_addr_pmsav7()
      target/arm: Handle small regions in get_phys_addr_pmsav8()

Philippe Mathieu-Daudé (17):
      MAINTAINERS: Adopt the Gumstix computers-on-module machines
      hw/input/pckbd: Use qemu_log_mask(GUEST_ERROR) instead of fprintf
      hw/input/tsc2005: Use qemu_log_mask(GUEST_ERROR) instead of fprintf
      hw/dma/omap_dma: Use qemu_log_mask(UNIMP) instead of printf
      hw/dma/omap_dma: Use qemu_log_mask(GUEST_ERROR) instead of fprintf
      hw/ssi/omap_spi: Use qemu_log_mask(GUEST_ERROR) instead of fprintf
      hw/sd/omap_mmc: Use qemu_log_mask(UNIMP) instead of printf
      hw/i2c/omap_i2c: Use qemu_log_mask(UNIMP) instead of fprintf
      hw/arm/omap1: Use qemu_log_mask(GUEST_ERROR) instead of fprintf
      hw/arm/omap: Use qemu_log_mask(GUEST_ERROR) instead of fprintf
      hw/arm/stellaris: Use qemu_log_mask(UNIMP) instead of fprintf
      hw/net/stellaris_enet: Fix a typo
      hw/net/stellaris_enet: Use qemu_log_mask(GUEST_ERROR) instead of hw_error
      hw/net/smc91c111: Use qemu_log_mask(GUEST_ERROR) instead of hw_error
      hw/net/smc91c111: Use qemu_log_mask(UNIMP) instead of fprintf
      hw/arm/stellaris: Fix gptm_write() error message
      hw/arm/stellaris: Use HWADDR_PRIx to display register address

Sai Pavan Boddu (1):
      xilinx_spips: Make dma transactions as per dma_burst_size

 accel/tcg/softmmu_template.h    |  24 ++-
 hw/arm/smmuv3-internal.h        |  12 +-
 include/exec/cpu-all.h          |   5 +-
 include/hw/arm/omap.h           |  30 +--
 include/hw/arm/smmu-common.h    |  24 +++
 include/hw/arm/smmuv3.h         |   1 +
 include/hw/misc/aspeed_scu.h    |  70 ++++++-
 include/hw/ssi/xilinx_spips.h   |   5 +-
 include/hw/timer/aspeed_timer.h |   4 +
 accel/tcg/cputlb.c              | 131 +++++++++++--
 hw/arm/aspeed_soc.c             |  42 ++--
 hw/arm/omap1.c                  |  18 +-
 hw/arm/smmu-common.c            | 118 ++++++++++-
 hw/arm/smmuv3.c                 | 420 ++++++++++++++++++++++++++++++++++++----
 hw/arm/stellaris.c              |   8 +-
 hw/dma/omap_dma.c               |  70 ++++---
 hw/i2c/omap_i2c.c               |  20 +-
 hw/input/pckbd.c                |   4 +-
 hw/input/tsc2005.c              |  13 +-
 hw/misc/aspeed_scu.c            | 106 ++++++++++
 hw/net/smc91c111.c              |  21 +-
 hw/net/stellaris_enet.c         |  11 +-
 hw/sd/omap_mmc.c                |  13 +-
 hw/ssi/aspeed_smc.c             |  48 ++---
 hw/ssi/omap_spi.c               |  15 +-
 hw/ssi/xilinx_spips.c           |  23 ++-
 hw/timer/aspeed_timer.c         |  19 +-
 target/arm/helper.c             | 115 +++++++----
 MAINTAINERS                     |  14 +-
 hw/arm/trace-events             |  27 ++-
 30 files changed, 1176 insertions(+), 255 deletions(-)
