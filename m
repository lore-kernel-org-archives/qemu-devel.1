Received: from eggs.gnu.org ([209.51.188.92]:57788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guab6-0002HJ-F1
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:19:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guab5-0000lh-GO
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:19:56 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:35323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guab3-0000cK-IK
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:19:55 -0500
Received: by mail-wr1-x429.google.com with SMTP id t18so9770998wrx.2
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 02:19:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n2sm8399570wrq.58.2019.02.15.02.19.49
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 15 Feb 2019 02:19:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Feb 2019 10:19:48 +0000
Message-Id: <20190215101948.13893-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 00/25] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

v2: drop a couple of RTH's patches that he wants to rework.

The following changes since commit 0266c739abbed804deabb4ccde2aa449466ac3b4:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-feb-14-2019' into staging (2019-02-14 18:33:00 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190215

for you to fetch changes up to 0f8b09b22234460cb5b8766a25066cf6b5f06842:

  gdbstub: Send a reply to the vKill packet. (2019-02-15 09:56:41 +0000)

----------------------------------------------------------------
target-arm queue:
 * gdbstub: Send a reply to the vKill packet
 * Improve codegen for neon min/max and saturating arithmetic
 * Fix a bug in clearing FPSCR exception status bits
 * hw/arm/armsse: Fix miswiring of expansion IRQs
 * hw/intc/armv7m_nvic: Allow byte accesses to SHPR1
 * MAINTAINERS: Remove Peter Crosthwaite from various entries
 * arm: Allow system registers for KVM guests to be changed by QEMU code
 * linux-user: support HWCAP_CPUID which exposes ID registers to user code
 * Fix bug in 128-bit cmpxchg for BE Arm guests
 * Implement (no-op) HACR_EL2
 * Fix CRn to be 14 for PMEVTYPER/PMEVCNTR

----------------------------------------------------------------
Aaron Lindsay OS (1):
      target/arm: Fix CRn to be 14 for PMEVTYPER/PMEVCNTR

Alex Bennée (5):
      target/arm: relax permission checks for HWCAP_CPUID registers
      target/arm: expose CPUID registers to userspace
      target/arm: expose MPIDR_EL1 to userspace
      target/arm: expose remaining CPUID registers as RAZ
      linux-user/elfload: enable HWCAP_CPUID for AArch64

Catherine Ho (1):
      target/arm: Fix int128_make128 lo, hi order in paired_cmpxchg64_be

Peter Maydell (5):
      target/arm: Implement HACR_EL2
      arm: Allow system registers for KVM guests to be changed by QEMU code
      MAINTAINERS: Remove Peter Crosthwaite from various entries
      hw/intc/armv7m_nvic: Allow byte accesses to SHPR1
      hw/arm/armsse: Fix miswiring of expansion IRQs

Richard Henderson (12):
      target/arm: Rely on optimization within tcg_gen_gvec_or
      target/arm: Use vector minmax expanders for aarch64
      target/arm: Use vector minmax expanders for aarch32
      target/arm: Use tcg integer min/max primitives for neon
      target/arm: Remove neon min/max helpers
      target/arm: Fix vfp_gdb_get/set_reg vs FPSCR
      target/arm: Fix arm_cpu_dump_state vs FPSCR
      target/arm: Split out flags setting from vfp compares
      target/arm: Fix set of bits kept in xregs[ARM_VFP_FPSCR]
      target/arm: Split out FPSCR.QC to a vector field
      target/arm: Use vector operations for saturation
      target/arm: Add missing clear_tail calls

Sandra Loosemore (1):
      gdbstub: Send a reply to the vKill packet.

 target/arm/cpu.h           |  50 +++++++++-
 target/arm/helper.h        |  45 ++++++---
 target/arm/translate.h     |   4 +
 gdbstub.c                  |   1 +
 hw/arm/armsse.c            |   2 +-
 hw/intc/armv7m_nvic.c      |   4 +-
 linux-user/elfload.c       |   1 +
 target/arm/helper-a64.c    |   4 +-
 target/arm/helper.c        | 228 ++++++++++++++++++++++++++++++++++++---------
 target/arm/kvm32.c         |  20 +---
 target/arm/kvm64.c         |   2 +
 target/arm/machine.c       |   2 +-
 target/arm/neon_helper.c   |  14 +--
 target/arm/translate-a64.c |  77 ++++++---------
 target/arm/translate-sve.c |   6 +-
 target/arm/translate.c     | 219 ++++++++++++++++++++++++++++++++++---------
 target/arm/vec_helper.c    | 134 +++++++++++++++++++++++++-
 MAINTAINERS                |   4 -
 18 files changed, 622 insertions(+), 195 deletions(-)
