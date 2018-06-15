Received: from eggs.gnu.org ([2001:4830:134:3::10]:60640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfQ-0001Xm-67
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfO-0006Af-OL
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:32 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfO-00065w-E6
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:30 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfG-0003a4-P0
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:22 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:24:38 +0100
Message-Id: <20180615142521.19143-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/43] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

target-arm queue; this one has a fair scattering of more
miscellaneous things in it which I've sent out this week.
I've shoved those in as well as it seemed the least-effort
way of getting them into master; a few of them are dependencies
on arm-related patches I have brewing.

thanks
-- PMM


The following changes since commit 2702c2d3eb74e3908c0c5dbf3a71c8987595a86e:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-updates-140618-1' into staging (2018-06-15 12:49:36 +0100)

are available in the Git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180615

for you to fetch changes up to 14120108f87b3f9e1beacdf0a6096e464e62bb65:

  target/arm: Allow ARMv6-M Thumb2 instructions (2018-06-15 15:23:34 +0100)

----------------------------------------------------------------
target-arm and miscellaneous queue:
 * fix KVM state save/restore for GICv3 priority registers for high IRQ numbers
 * hw/arm/mps2-tz: Put ethernet controller behind PPC
 * hw/sh/sh7750: Convert away from old_mmio
 * hw/m68k/mcf5206: Convert away from old_mmio
 * hw/block/pflash_cfi02: Convert away from old_mmio
 * hw/watchdog/wdt_i6300esb: Convert away from old_mmio
 * hw/input/pckbd: Convert away from old_mmio
 * hw/char/parallel: Convert away from old_mmio
 * armv7m: refactor to get rid of armv7m_init() function
 * arm: Don't crash if user tries to use a Cortex-M CPU without an NVIC
 * hw/core/or-irq: Support more than 16 inputs to an OR gate
 * cpu-defs.h: Document CPUIOTLBEntry 'addr' field
 * cputlb: Pass cpu_transaction_failed() the correct physaddr
 * CODING_STYLE: Define our preferred form for multiline comments
 * Add and use new stn_*_p() and ldn_*_p() memory access functions
 * target/arm: More parts of the upcoming SVE support
 * aspeed_scu: Implement RNG register
 * m25p80: add support for two bytes WRSR for Macronix chips
 * exec.c: Handle IOMMUs being in the path of TCG CPU memory accesses
 * target/arm: Allow ARMv6-M Thumb2 instructions

----------------------------------------------------------------
Cédric Le Goater (1):
      m25p80: add support for two bytes WRSR for Macronix chips

Joel Stanley (1):
      aspeed_scu: Implement RNG register

Julia Suvorova (1):
      target/arm: Allow ARMv6-M Thumb2 instructions

Peter Maydell (21):
      hw/arm/mps2-tz: Put ethernet controller behind PPC
      hw/sh/sh7750: Convert away from old_mmio
      hw/m68k/mcf5206: Convert away from old_mmio
      hw/block/pflash_cfi02: Convert away from old_mmio
      hw/watchdog/wdt_i6300esb: Convert away from old_mmio
      hw/input/pckbd: Convert away from old_mmio
      hw/char/parallel: Convert away from old_mmio
      stellaris: Stop using armv7m_init()
      hw/arm/armv7m: Remove unused armv7m_init() function
      arm: Don't crash if user tries to use a Cortex-M CPU without an NVIC
      hw/core/or-irq: Support more than 16 inputs to an OR gate
      cpu-defs.h: Document CPUIOTLBEntry 'addr' field
      cputlb: Pass cpu_transaction_failed() the correct physaddr
      CODING_STYLE: Define our preferred form for multiline comments
      bswap: Add new stn_*_p() and ldn_*_p() memory access functions
      exec.c: Don't accidentally sign-extend 4-byte loads in subpage_read()
      exec.c: Use stn_p() and ldn_p() instead of explicit switches
      iommu: Add IOMMU index concept to IOMMU API
      iommu: Add IOMMU index argument to notifier APIs
      iommu: Add IOMMU index argument to translate method
      exec.c: Handle IOMMUs in address_space_translate_for_iotlb()

Richard Henderson (18):
      target/arm: Extend vec_reg_offset to larger sizes
      target/arm: Implement SVE Permute - Unpredicated Group
      target/arm: Implement SVE Permute - Predicates Group
      target/arm: Implement SVE Permute - Interleaving Group
      target/arm: Implement SVE compress active elements
      target/arm: Implement SVE conditionally broadcast/extract element
      target/arm: Implement SVE copy to vector (predicated)
      target/arm: Implement SVE reverse within elements
      target/arm: Implement SVE vector splice (predicated)
      target/arm: Implement SVE Select Vectors Group
      target/arm: Implement SVE Integer Compare - Vectors Group
      target/arm: Implement SVE Integer Compare - Immediate Group
      target/arm: Implement SVE Partition Break Group
      target/arm: Implement SVE Predicate Count Group
      target/arm: Implement SVE Integer Compare - Scalars Group
      target/arm: Implement FDUP/DUP
      target/arm: Implement SVE Integer Wide Immediate - Unpredicated Group
      target/arm: Implement SVE Floating Point Arithmetic - Unpredicated Group

Shannon Zhao (1):
      arm_gicv3_kvm: kvm_dist_get/put_priority: skip the registers banked by GICR_IPRIORITYR

 include/exec/cpu-all.h      |    4 +
 include/exec/cpu-defs.h     |    9 +
 include/exec/exec-all.h     |   16 +-
 include/exec/memory.h       |   65 +-
 include/hw/arm/arm.h        |    8 +-
 include/hw/or-irq.h         |    5 +-
 include/qemu/bswap.h        |   52 ++
 include/qom/cpu.h           |    3 +
 target/arm/helper-sve.h     |  294 +++++++++
 target/arm/helper.h         |   19 +
 target/arm/translate-a64.h  |   26 +-
 accel/tcg/cputlb.c          |   59 +-
 exec.c                      |  263 ++++----
 hw/alpha/typhoon.c          |    3 +-
 hw/arm/armv7m.c             |   28 +-
 hw/arm/mps2-tz.c            |   32 +-
 hw/arm/smmuv3.c             |    2 +-
 hw/arm/stellaris.c          |   12 +-
 hw/block/m25p80.c           |    1 +
 hw/block/pflash_cfi02.c     |   97 +--
 hw/char/parallel.c          |   50 +-
 hw/core/or-irq.c            |   39 +-
 hw/dma/rc4030.c             |    2 +-
 hw/i386/amd_iommu.c         |    2 +-
 hw/i386/intel_iommu.c       |    8 +-
 hw/input/pckbd.c            |   14 +-
 hw/intc/arm_gicv3_kvm.c     |   18 +-
 hw/intc/armv7m_nvic.c       |    6 +-
 hw/m68k/mcf5206.c           |   48 +-
 hw/misc/aspeed_scu.c        |   20 +
 hw/ppc/spapr_iommu.c        |    5 +-
 hw/s390x/s390-pci-bus.c     |    2 +-
 hw/s390x/s390-pci-inst.c    |    4 +-
 hw/sh4/sh7750.c             |   44 +-
 hw/sparc/sun4m_iommu.c      |    3 +-
 hw/sparc64/sun4u_iommu.c    |    2 +-
 hw/vfio/common.c            |    6 +-
 hw/virtio/vhost.c           |    7 +-
 hw/watchdog/wdt_i6300esb.c  |   48 +-
 memory.c                    |   33 +-
 target/arm/cpu.c            |   18 +
 target/arm/sve_helper.c     | 1250 +++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c  | 1458 +++++++++++++++++++++++++++++++++++++++++++
 target/arm/translate.c      |   43 +-
 target/arm/vec_helper.c     |   69 ++
 CODING_STYLE                |   17 +
 docs/devel/loads-stores.rst |   15 +
 target/arm/sve.decode       |  248 ++++++++
 48 files changed, 4114 insertions(+), 363 deletions(-)
