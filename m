Received: from eggs.gnu.org ([2001:4830:134:3::10]:47403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY5l-0001Jx-Nz
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY5k-0001mR-BT
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:57:41 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDY5k-0001jg-2m
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:57:40 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY5h-0006f6-Pl
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 17:57:37 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:56:50 +0100
Message-Id: <20181019165735.22511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/45] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

As promised, another pullreq... This one's mostly RTH's patches.

thanks
-- PMM

The following changes since commit 784c2e4f232adf5ef47a84a262ec72a07d068d6a:

  Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2018-10-19 15:30:40 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20181019

for you to fetch changes up to 88c9add25e7120e8622796c81ad3f3fb7f8d40e7:

  target/arm: Only flush tlb if ASID changes (2018-10-19 17:38:48 +0100)

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

Richard Henderson (30):
      target/arm: Move some system registers into a substructure
      target/arm: V8M should not imply V7VE
      target/arm: Convert v8 extensions from feature bits to isar tests
      target/arm: Convert division from feature bits to isar0 tests
      target/arm: Convert jazelle from feature bit to isar1 test
      target/arm: Convert t32ee from feature bit to isar3 test
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

 target/arm/cpu.h            |  227 ++++++-
 target/arm/internals.h      |   45 +-
 target/arm/kvm_arm.h        |   24 +
 target/arm/translate.h      |   21 +
 hw/arm/boot.c               |   18 +
 hw/intc/armv7m_nvic.c       |   12 +-
 hw/net/cadence_gem.c        |    9 +-
 hw/sd/ssi-sd.c              |    2 +
 linux-user/aarch64/signal.c |    4 +-
 linux-user/elfload.c        |   60 +-
 linux-user/syscall.c        |   10 +-
 target/arm/cpu.c            |  242 ++++----
 target/arm/cpu64.c          |  148 +++--
 target/arm/helper.c         |  397 ++++++++----
 target/arm/kvm.c            |   60 ++
 target/arm/kvm32.c          |   13 +
 target/arm/kvm64.c          |   15 +-
 target/arm/machine.c        |   28 +-
 target/arm/op_helper.c      |    2 +-
 target/arm/translate-a64.c  |  715 ++++-----------------
 target/arm/translate.c      | 1451 ++++++++++++++++++++++++++++---------------
 21 files changed, 2021 insertions(+), 1482 deletions(-)
