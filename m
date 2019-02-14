Received: from eggs.gnu.org ([209.51.188.92]:53723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMKm-0007h3-Vu
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMKl-0004bl-Rq
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:08 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:54366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guMKl-0004b4-IF
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:07 -0500
Received: by mail-wm1-x333.google.com with SMTP id a62so7505928wmh.4
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 11:06:07 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	n184sm7798471wmf.5.2019.02.14.11.06.04 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 14 Feb 2019 11:06:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 19:05:36 +0000
Message-Id: <20190214190603.25030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/27] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 0d3e41d5efd638a0c5682f6813b26448c3c51624:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-request' into staging (2019-02-14 17:42:25 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190214

for you to fetch changes up to 497bc12b1b374ecd62903bf062229bd93f8924af:

  gdbstub: Send a reply to the vKill packet. (2019-02-14 18:45:49 +0000)

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

Richard Henderson (14):
      target/arm: Force result size into dp after operation
      target/arm: Restructure disas_fp_int_conv
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

 target/arm/cpu.h           |  50 ++++++++-
 target/arm/helper.h        |  45 +++++---
 target/arm/translate.h     |   4 +
 gdbstub.c                  |   1 +
 hw/arm/armsse.c            |   2 +-
 hw/intc/armv7m_nvic.c      |   4 +-
 linux-user/elfload.c       |   1 +
 target/arm/helper-a64.c    |   4 +-
 target/arm/helper.c        | 228 ++++++++++++++++++++++++++++++++--------
 target/arm/kvm32.c         |  20 +---
 target/arm/kvm64.c         |   2 +
 target/arm/machine.c       |   2 +-
 target/arm/neon_helper.c   |  14 +--
 target/arm/translate-a64.c | 171 +++++++++++++++---------------
 target/arm/translate-sve.c |   6 +-
 target/arm/translate.c     | 251 ++++++++++++++++++++++++++++++++++-----------
 target/arm/vec_helper.c    | 134 +++++++++++++++++++++++-
 MAINTAINERS                |   4 -
 18 files changed, 687 insertions(+), 256 deletions(-)
