Received: from eggs.gnu.org ([2001:4830:134:3::10]:41448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gFFlJ-00012r-VQ
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gFFlI-0000Jb-SY
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:47:37 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gFFlI-00005P-JP
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:47:36 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gFFl2-0002QN-85
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 10:47:20 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 Oct 2018 10:47:17 +0100
Message-Id: <20181024094717.21139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 00/44] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

v1->v2 changes: drop the "convert FEATURE_THUMB2EE" patch as
it broke compilation on arm hosts (conversion of KVM related
code had been forgotten)

thanks
-- PMM

The following changes since commit 13399aad4fa87b2878c49d02a5d3bafa6c966ba3:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-10-22' into staging (2018-10-23 17:20:23 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20181024

for you to fetch changes up to 93f379b0c43617b1361f742f261479eaed4959cb:

  target/arm: Only flush tlb if ASID changes (2018-10-24 07:51:37 +0100)

----------------------------------------------------------------
target-arm queue:
 * ssi-sd: Make devices picking up backends unavailable with -device
 * Add support for VCPU event states
 * Move towards making ID registers the source of truth for
   whether a guest CPU implements a feature, rather than having
   parallel ID registers and feature bit flags
 * Implement various HCR hypervisor trap/config bits
 * Get IL bit correct for v7 syndrome values
 * Report correct syndrome for FP/SIMD traps to Hyp mode
 * hw/arm/boot: Increase compliance with kernel arm64 boot protocol
 * Refactor A32 Neon to use generic vector infrastructure
 * Fix a bug in A32 VLD2 "(multiple 2-element structures)" insn
 * net: cadence_gem: Report features correctly in ID register
 * Avoid some unnecessary TLB flushes on TTBR register writes

----------------------------------------------------------------
Dongjiu Geng (1):
      target/arm: Add support for VCPU event states

Edgar E. Iglesias (2):
      net: cadence_gem: Announce availability of priority queues
      net: cadence_gem: Announce 64bit addressing support

Markus Armbruster (1):
      ssi-sd: Make devices picking up backends unavailable with -device

Peter Maydell (10):
      target/arm: Improve debug logging of AArch32 exception return
      target/arm: Make switch_mode() file-local
      target/arm: Implement HCR.FB
      target/arm: Implement HCR.DC
      target/arm: ISR_EL1 bits track virtual interrupts if IMO/FMO set
      target/arm: Implement HCR.VI and VF
      target/arm: Implement HCR.PTW
      target/arm: New utility function to extract EC from syndrome
      target/arm: Get IL bit correct for v7 syndrome values
      target/arm: Report correct syndrome for FP/SIMD traps to Hyp mode

Richard Henderson (29):
      target/arm: Move some system registers into a substructure
      target/arm: V8M should not imply V7VE
      target/arm: Convert v8 extensions from feature bits to isar tests
      target/arm: Convert division from feature bits to isar0 tests
      target/arm: Convert jazelle from feature bit to isar1 test
      target/arm: Convert sve from feature bit to aa64pfr0 test
      target/arm: Convert v8.2-fp16 from feature bit to aa64pfr0 test
      target/arm: Hoist address increment for vector memory ops
      target/arm: Don't call tcg_clear_temp_count
      target/arm: Use tcg_gen_gvec_dup_i64 for LD[1-4]R
      target/arm: Promote consecutive memory ops for aa64
      target/arm: Mark some arrays const
      target/arm: Use gvec for NEON VDUP
      target/arm: Use gvec for NEON VMOV, VMVN, VBIC & VORR (immediate)
      target/arm: Use gvec for NEON_3R_LOGIC insns
      target/arm: Use gvec for NEON_3R_VADD_VSUB insns
      target/arm: Use gvec for NEON_2RM_VMN, NEON_2RM_VNEG
      target/arm: Use gvec for NEON_3R_VMUL
      target/arm: Use gvec for VSHR, VSHL
      target/arm: Use gvec for VSRA
      target/arm: Use gvec for VSRI, VSLI
      target/arm: Use gvec for NEON_3R_VML
      target/arm: Use gvec for NEON_3R_VTST_VCEQ, NEON_3R_VCGT, NEON_3R_VCGE
      target/arm: Use gvec for NEON VLD all lanes
      target/arm: Reorg NEON VLD/VST all elements
      target/arm: Promote consecutive memory ops for aa32
      target/arm: Reorg NEON VLD/VST single element to one lane
      target/arm: Remove writefn from TTBR0_EL3
      target/arm: Only flush tlb if ASID changes

Stewart Hildebrand (1):
      hw/arm/boot: Increase compliance with kernel arm64 boot protocol

 target/arm/cpu.h            |  221 ++++++-
 target/arm/internals.h      |   45 +-
 target/arm/kvm_arm.h        |   24 +
 target/arm/translate.h      |   21 +
 hw/arm/boot.c               |   18 +
 hw/intc/armv7m_nvic.c       |   12 +-
 hw/net/cadence_gem.c        |    9 +-
 hw/sd/ssi-sd.c              |    2 +
 linux-user/aarch64/signal.c |    4 +-
 linux-user/elfload.c        |   58 +-
 linux-user/syscall.c        |   10 +-
 target/arm/cpu.c            |  238 +++----
 target/arm/cpu64.c          |  148 +++--
 target/arm/helper.c         |  395 ++++++++----
 target/arm/kvm.c            |   60 ++
 target/arm/kvm32.c          |   13 +
 target/arm/kvm64.c          |   15 +-
 target/arm/machine.c        |   25 +-
 target/arm/op_helper.c      |    2 +-
 target/arm/translate-a64.c  |  715 ++++-----------------
 target/arm/translate.c      | 1451 ++++++++++++++++++++++++++++---------------
 21 files changed, 2013 insertions(+), 1473 deletions(-)
