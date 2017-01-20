Received: from eggs.gnu.org ([2001:4830:134:3::10]:57454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUXUK-00063M-5F
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 06:36:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUXUI-0006Q9-Nb
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 06:36:12 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUXUI-0006Oi-Fo
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 06:36:10 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUXUF-0003vX-KA
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:36:07 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jan 2017 11:36:06 +0000
Message-Id: <1484912166-19271-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 00/36] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Changes from v1: just squashed in
http://patchwork.ozlabs.org/patch/717312/
which deletes a now-unused function.

thanks
-- PMM

The following changes since commit 0f6bcf68a99efdc531b209551f2b760b0bdcc554:

  Merge remote-tracking branch 'remotes/artyom/tags/pull-sun4v-20170118' into staging (2017-01-19 18:34:13 +0000)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170120

for you to fetch changes up to f29cacfb5fc0a6e93efc3f6d2900d82d625f143e:

  hw/arm/virt: Add board property to enable EL2 (2017-01-20 11:15:11 +0000)

----------------------------------------------------------------
target-arm queue:
 * support virtualization in GICv3
 * enable EL2 in AArch64 CPU models
 * allow EL2 to be enabled on 'virt' board via -machine virtualization=on
 * aspeed: SMC improvements
 * m25p80: support die erase command
 * m25p80: Add Quad Page Program 4byte
 * m25p80: Improve 1GiB Micron flash definition
 * arm: Uniquely name imx25 I2C buses

----------------------------------------------------------------
Alastair D'Silva (1):
      arm: Uniquely name imx25 I2C buses.

Andrew Jones (1):
      hw/arm/virt-acpi-build: use SMC if booting in EL2

Ard Biesheuvel (1):
      hw/arm/virt-acpi - reserve ECAM space as PNP0C02 device

Cédric Le Goater (10):
      aspeed/smc: remove call to reset in realize function
      aspeed/smc: remove call to aspeed_smc_update_cs() in reset function
      aspeed/smc: rework the prototype of the AspeedSMCFlash helper routines
      aspeed/smc: autostrap CE0/1 configuration
      aspeed/smc: unfold the AspeedSMCController array
      aspeed/smc: adjust the size of the register region
      aspeed/smc: handle SPI flash Command mode
      aspeed/smc: reset flash after each test
      aspeed/smc: extend tests for Command mode
      aspeed: use first FMC flash as a boot ROM

Marcin Krzeminski (3):
      block: m25p80: Add Quad Page Program 4byte
      block: m25p80: Introduce die erase command
      block: m25p80: Improve 1GiB Micron flash definition

Peter Maydell (19):
      target/arm: Handle VIRQ and VFIQ in arm_cpu_do_interrupt_aarch32()
      target/arm: Implement DBGVCR32_EL2 system register
      hw/intc/arm_gicv3: Add external IRQ lines for VIRQ and VFIQ
      hw/intc/arm_gic: Add external IRQ lines for VIRQ and VFIQ
      target-arm: Expose output GPIO line for VCPU maintenance interrupt
      hw/arm/virt: Wire VIRQ, VFIQ, maintenance irq lines from GIC to CPU
      target-arm: Add ARMCPU fields for GIC CPU i/f config
      hw/intc/gicv3: Add defines for ICH system register fields
      hw/intc/gicv3: Add data fields for virtualization support
      hw/intc/arm_gicv3: Add accessors for ICH_ system registers
      hw/intc/arm_gicv3: Implement ICV_ registers which are just accessors
      hw/intc/arm_gicv3: Implement ICV_ HPPIR, DIR and RPR registers
      hw/intc/arm_gicv3: Implement ICV_ registers EOIR and IAR
      hw/intc/arm_gicv3: Implement gicv3_cpuif_virt_update()
      hw/intc/arm_gicv3: Implement EL2 traps for CPU i/f regs
      hw/arm/virt: Support using SMC for PSCI
      target/arm/psci.c: If EL2 implemented, start CPUs in EL2
      target-arm: Enable EL2 feature bit on A53 and A57
      hw/arm/virt: Add board property to enable EL2

Shannon Zhao (1):
      arm: virt: Fix segmentation fault when specifying an unsupported CPU

 hw/intc/gicv3_internal.h           |   79 +++
 include/hw/arm/virt.h              |    5 +-
 include/hw/intc/arm_gic_common.h   |    2 +
 include/hw/intc/arm_gicv3_common.h |   21 +
 include/hw/ssi/aspeed_smc.h        |    4 +-
 target/arm/cpu.h                   |    9 +
 hw/arm/aspeed.c                    |   41 ++
 hw/arm/imx25_pdk.c                 |    2 +-
 hw/arm/virt-acpi-build.c           |   36 +-
 hw/arm/virt.c                      |   88 ++-
 hw/arm/xlnx-zynqmp.c               |    2 +
 hw/block/m25p80.c                  |   51 +-
 hw/i2c/imx_i2c.c                   |    2 +-
 hw/intc/arm_gic_common.c           |    6 +
 hw/intc/arm_gicv3_common.c         |   31 +
 hw/intc/arm_gicv3_cpuif.c          | 1351 +++++++++++++++++++++++++++++++++++-
 hw/ssi/aspeed_smc.c                |  325 +++++++--
 target/arm/cpu.c                   |   15 +
 target/arm/cpu64.c                 |    8 +
 target/arm/helper.c                |   21 +
 target/arm/psci.c                  |   25 +-
 tests/m25p80-test.c                |  133 ++++
 hw/intc/trace-events               |   33 +
 23 files changed, 2149 insertions(+), 141 deletions(-)
