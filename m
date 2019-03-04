Received: from eggs.gnu.org ([209.51.188.92]:46056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0mIa-0008JK-1r
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:02:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0mIS-00083H-Br
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:02:23 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  4 Mar 2019 13:01:43 +0100
Message-Id: <20190304120210.31500-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 00/27] s390x updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

The following changes since commit 20b084c4b1401b7f8fbc385649d48c67b6f43d44:

  Merge remote-tracking branch 'remotes/cminyard/tags/i2c-for-release-20190228' into staging (2019-03-01 11:20:49 +0000)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20190304

for you to fetch changes up to df192fbc517a0954dda644282e52ba943e22ec18:

  s390x: Add floating-point extension facility to "qemu" cpu model (2019-03-04 11:49:31 +0100)

----------------------------------------------------------------
s390x updates:
- tcg: support the floating-point extension facility
- vfio-ap: support hot(un)plug of vfio-ap device
- fixes + cleanups

----------------------------------------------------------------

David Hildenbrand (25):
  s390x: Use cpu_to_be64 in SIGP STORE ADDITIONAL STATUS
  s390x: use a QEMU-style typedef + name for SIGP save area struct
  s390x/tcg: Save vregs to extended mchk save area
  s390x/tcg: RXE has an optional M3 field
  s390x/tcg: Simplify disassembler operands initialization
  s390x/tcg: Clarify terminology in vec_reg_offset()
  s390x/tcg: Factor out vec_full_reg_offset()
  s390x/tcg: Factor out gen_addi_and_wrap_i64() from get_address()
  s390x/tcg: Implement LOAD LENGTHENED short HFP to long HFP
  s390x/tcg: Implement LOAD COUNT TO BLOCK BOUNDARY
  s390x/tcg: Fix TEST DATA CLASS instructions
  s390x/tcg: Fix rounding from float128 to uint64_t/uint32_t
  s390x/tcg: Factor out conversion of softfloat exceptions
  s390x/tcg: Fix parts of IEEE exception handling
  s390x/tcg: Hide IEEE underflows in some scenarios
  s390x/tcg: Refactor SET FPC AND SIGNAL handling
  s390x/tcg: Fix simulated-IEEE exceptions
  s390x/tcg: Handle SET FPC AND LOAD FPC 3-bit BFP rounding modes
  s390x/tcg: Check for exceptions in SET BFP ROUNDING MODE
  s390x/tcg: Refactor saving/restoring the bfp rounding mode
  s390x/tcg: Prepare for IEEE-inexact-exception control (XxC)
  s390x/tcg: Implement XxC and checks for most FP instructions
  s390x/tcg: Implement rounding mode and XxC for LOAD ROUNDED
  s390x/tcg: Handle all rounding modes overwritten by BFP instructions
  s390x: Add floating-point extension facility to "qemu" cpu model

Tony Krowiak (2):
  s390x/vfio-ap: Implement hot plug/unplug of vfio-ap device
  s390x/vfio-ap: document hot plug/unplug of vfio-ap device

 docs/vfio-ap.txt             |  61 +++-
 hw/s390x/ap-bridge.c         |  12 +-
 hw/vfio/ap.c                 |   2 +-
 target/s390x/cc_helper.c     |   8 +
 target/s390x/excp_helper.c   |  46 ++-
 target/s390x/fpu_helper.c    | 541 +++++++++++++++++++++--------------
 target/s390x/gen-features.c  |   5 +
 target/s390x/helper.c        |  40 ++-
 target/s390x/helper.h        |   9 +-
 target/s390x/insn-data.def   |  16 +-
 target/s390x/insn-format.def |   2 +-
 target/s390x/internal.h      |  14 +-
 target/s390x/translate.c     | 409 ++++++++++++++++++--------
 13 files changed, 792 insertions(+), 373 deletions(-)

-- 
2.17.2
