Received: from eggs.gnu.org ([209.51.188.92]:42784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVb1-0002QE-G1
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVb0-000759-C6
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:11 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:40049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVaz-00073s-Uw
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:10 -0500
Received: by mail-wr1-x42f.google.com with SMTP id p4so15415920wrt.7
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.06 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:16 +0000
Message-Id: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/49] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

A largish pull request: the big things are Richard's PAuth work
and Aaron's PMU emulation improvements.

thanks
-- PMM


The following changes since commit 681d61362d3f766a00806b89d6581869041f73cb:

  Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-01-17 12:48:42 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190118

for you to fetch changes up to 2a0ed2804e2c77a1c4e255f05ab739618e05c85d:

  tests/libqtest: Introduce qtest_init_with_serial() (2019-01-18 14:17:38 +0000)

----------------------------------------------------------------
target-arm queue:
 * hw/char/stm32f2xx_usart: Do not update data register when device is disabled
 * hw/arm/virt-acpi-build: Set COHACC override flag in IORT SMMUv3 node
 * target/arm: Allow Aarch32 exception return to switch from Mon->Hyp
 * ftgmac100: implement the new MDIO interface on Aspeed SoC
 * implement the ARMv8.3-PAuth extension
 * improve emulation of the ARM PMU

----------------------------------------------------------------
Aaron Lindsay (13):
      migration: Add post_save function to VMStateDescription
      target/arm: Reorganize PMCCNTR accesses
      target/arm: Swap PMU values before/after migrations
      target/arm: Filter cycle counter based on PMCCFILTR_EL0
      target/arm: Allow AArch32 access for PMCCFILTR
      target/arm: Implement PMOVSSET
      target/arm: Define FIELDs for ID_DFR0
      target/arm: Make PMCEID[01]_EL0 64 bit registers, add PMCEID[23]
      target/arm: Add array for supported PMU events, generate PMCEID[01]_EL0
      target/arm: Finish implementation of PM[X]EVCNTR and PM[X]EVTYPER
      target/arm: PMU: Add instruction and cycle events
      target/arm: PMU: Set PMCR.N to 4
      target/arm: Implement PMSWINC

Alexander Graf (1):
      target/arm: Allow Aarch32 exception return to switch from Mon->Hyp

Cédric Le Goater (1):
      ftgmac100: implement the new MDIO interface on Aspeed SoC

Eric Auger (1):
      hw/arm/virt-acpi-build: Set COHACC override flag in IORT SMMUv3 node

Julia Suvorova (1):
      tests/libqtest: Introduce qtest_init_with_serial()

Philippe Mathieu-Daudé (1):
      hw/char/stm32f2xx_usart: Do not update data register when device is disabled

Richard Henderson (31):
      target/arm: Add state for the ARMv8.3-PAuth extension
      target/arm: Add SCTLR bits through ARMv8.5
      target/arm: Add PAuth active bit to tbflags
      target/arm: Introduce raise_exception_ra
      target/arm: Add PAuth helpers
      target/arm: Decode PAuth within system hint space
      target/arm: Rearrange decode in disas_data_proc_1src
      target/arm: Decode PAuth within disas_data_proc_1src
      target/arm: Decode PAuth within disas_data_proc_2src
      target/arm: Move helper_exception_return to helper-a64.c
      target/arm: Add new_pc argument to helper_exception_return
      target/arm: Rearrange decode in disas_uncond_b_reg
      target/arm: Decode PAuth within disas_uncond_b_reg
      target/arm: Decode Load/store register (pac)
      target/arm: Move cpu_mmu_index out of line
      target/arm: Introduce arm_mmu_idx
      target/arm: Introduce arm_stage1_mmu_idx
      target/arm: Create ARMVAParameters and helpers
      target/arm: Merge TBFLAG_AA_TB{0, 1} to TBII
      target/arm: Export aa64_va_parameters to internals.h
      target/arm: Add aa64_va_parameters_both
      target/arm: Decode TBID from TCR
      target/arm: Reuse aa64_va_parameters for setting tbflags
      target/arm: Implement pauth_strip
      target/arm: Implement pauth_auth
      target/arm: Implement pauth_addpac
      target/arm: Implement pauth_computepac
      target/arm: Add PAuth system registers
      target/arm: Enable PAuth for -cpu max
      target/arm: Enable PAuth for user-only
      target/arm: Tidy TBI handling in gen_a64_set_pc

 target/arm/Makefile.objs    |    1 +
 include/hw/acpi/acpi-defs.h |    2 +
 include/migration/vmstate.h |    1 +
 target/arm/cpu.h            |  244 +++++----
 target/arm/helper-a64.h     |   14 +
 target/arm/helper.h         |    1 -
 target/arm/internals.h      |   77 +++
 target/arm/translate.h      |    5 +-
 tests/libqtest.h            |   11 +
 hw/arm/virt-acpi-build.c    |    1 +
 hw/char/stm32f2xx_usart.c   |    3 +-
 hw/net/ftgmac100.c          |   80 ++-
 migration/vmstate.c         |   13 +-
 target/arm/cpu.c            |   19 +-
 target/arm/cpu64.c          |   68 ++-
 target/arm/helper-a64.c     |  155 ++++++
 target/arm/helper.c         | 1222 +++++++++++++++++++++++++++++++++----------
 target/arm/machine.c        |   24 +
 target/arm/op_helper.c      |  174 +-----
 target/arm/pauth_helper.c   |  497 ++++++++++++++++++
 target/arm/translate-a64.c  |  537 ++++++++++++++++---
 tests/libqtest.c            |   26 +
 docs/devel/migration.rst    |    9 +-
 23 files changed, 2552 insertions(+), 632 deletions(-)
 create mode 100644 target/arm/pauth_helper.c
