Received: from eggs.gnu.org ([2001:4830:134:3::10]:33561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehoZ-0003B9-Pn
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehoY-00033f-PJ
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:39 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eehoY-00030M-Gm
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:38 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eehoQ-0006pE-Df
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 13:43:30 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 13:43:08 +0000
Message-Id: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/21] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org


Arm queue built up to a point where it seems worth sending:
various bug fixes, plus RTH's refactoring in preparation for SVE.

thanks
-- PMM
 
 
The following changes since commit 0f79bfe38a2cf0f43c7ea4959da7f8ebd7858f3d:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-2.12-pull-request' into staging (2018-01-25 09:53:53 +0000)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180125

for you to fetch changes up to 24da047af0e99a83fcc0d50b86c0f2627f7418b3:

  pl110: Implement vertical compare/next base interrupts (2018-01-25 11:45:30 +0000)

----------------------------------------------------------------
target-arm queue:
 * target/arm: Fix address truncation in 64-bit pagetable walks
 * i.MX: Fix FEC/ENET receive functions
 * target/arm: preparatory refactoring for SVE emulation
 * hw/intc/arm_gic: Prevent the GIC from signaling an IRQ when it's "active and pending"
 * hw/intc/arm_gic: Fix C_RPR value on idle priority
 * hw/intc/arm_gic: Fix group priority computation for group 1 IRQs
 * hw/intc/arm_gic: Fix the NS view of C_BPR when C_CTRL.CBPR is 1
 * hw/arm/virt: Check that the CPU realize method succeeded
 * sdhci: fix a NULL pointer dereference due to uninitialized AddressSpace object
 * xilinx_spips: Correct usage of an uninitialized local variable
 * pl110: Implement vertical compare/next base interrupts

----------------------------------------------------------------
Ard Biesheuvel (1):
      target/arm: Fix 32-bit address truncation

Francisco Iglesias (1):
      xilinx_spips: Correct usage of an uninitialized local variable

Jean-Christophe Dubois (1):
      i.MX: Fix FEC/ENET receive funtions

Linus Walleij (1):
      pl110: Implement vertical compare/next base interrupts

Luc MICHEL (4):
      hw/intc/arm_gic: Prevent the GIC from signaling an IRQ when it's "active and pending"
      hw/intc/arm_gic: Fix C_RPR value on idle priority
      hw/intc/arm_gic: Fix group priority computation for group 1 IRQs
      hw/intc/arm_gic: Fix the NS view of C_BPR when C_CTRL.CBPR is 1

Peter Maydell (1):
      hw/arm/virt: Check that the CPU realize method succeeded

Philippe Mathieu-Daudé (1):
      sdhci: fix a NULL pointer dereference due to uninitialized AddresSpace object

Richard Henderson (11):
      target/arm: Mark disas_set_insn_syndrome inline
      target/arm: Use pointers in crypto helpers
      target/arm: Use pointers in neon zip/uzp helpers
      target/arm: Use pointers in neon tbl helper
      target/arm: Change the type of vfp.regs
      target/arm: Add aa{32, 64}_vfp_{dreg, qreg} helpers
      vmstate: Add VMSTATE_UINT64_SUB_ARRAY
      target/arm: Add ARM_FEATURE_SVE
      target/arm: Move cpu_get_tb_cpu_state out of line
      target/arm: Hoist store to flags output in cpu_get_tb_cpu_state
      target/arm: Simplify fp_exception_el for user-only

 include/hw/sd/sdhci.h       |   1 +
 include/migration/vmstate.h |   9 ++-
 target/arm/cpu.h            | 157 ++++++++-----------------------------
 target/arm/helper.h         |  46 +++++------
 target/arm/translate.h      |   2 +-
 hw/arm/virt.c               |   2 +-
 hw/display/pl110.c          |  30 +++++++-
 hw/intc/arm_gic.c           |  25 +++++-
 hw/net/imx_fec.c            |   8 +-
 hw/sd/sdhci.c               |   1 +
 hw/ssi/xilinx_spips.c       |  18 ++++-
 linux-user/signal.c         |  22 +++---
 target/arm/arch_dump.c      |   8 +-
 target/arm/crypto_helper.c  | 184 +++++++++++++++++---------------------------
 target/arm/helper-a64.c     |   5 +-
 target/arm/helper.c         | 164 +++++++++++++++++++++++++++++++++++----
 target/arm/kvm32.c          |   4 +-
 target/arm/kvm64.c          |  31 +++-----
 target/arm/machine.c        |   2 +-
 target/arm/neon_helper.c    | 162 ++++++++++++++++++++------------------
 target/arm/op_helper.c      |  17 ++--
 target/arm/translate-a64.c  | 100 ++++++++++++------------
 target/arm/translate.c      | 134 +++++++++++++++++---------------
 23 files changed, 607 insertions(+), 525 deletions(-)
