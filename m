Received: from eggs.gnu.org ([2001:4830:134:3::10]:58002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1g-00047A-LT
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:59:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1f-0007jX-Od
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:59:00 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1e0V1f-0007eF-He
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:58:59 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1e0V1X-0002r0-GZ
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 16:58:51 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  6 Oct 2017 16:59:25 +0100
Message-Id: <1507305585-20608-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/20] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Mostly my stuff with a few easy patches from others. I know I have
a few big series in my to-review queue, but I've been too jetlagged
to try to tackle those :-(

thanks
-- PMM

The following changes since commit a26a98dfb9d448d7234d931ae3720feddf6f0651:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20171006' into staging (2017-10-06 13:19:03 +0100)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20171006

for you to fetch changes up to 04829ce334bece78d4fa1d0fdbc8bc27dae9b242:

  nvic: Add missing code for writing SHCSR.HARDFAULTPENDED bit (2017-10-06 16:46:49 +0100)

----------------------------------------------------------------
target-arm:
 * v8M: more preparatory work
 * nvic: reset properly rather than leaving the nvic in a weird state
 * xlnx-zynqmp: Mark the "xlnx, zynqmp" device with user_creatable = false
 * sd: fix out-of-bounds check for multi block reads
 * arm: Fix SMC reporting to EL2 when QEMU provides PSCI

----------------------------------------------------------------
Jan Kiszka (1):
      arm: Fix SMC reporting to EL2 when QEMU provides PSCI

Michael Olbrich (1):
      hw/sd: fix out-of-bounds check for multi block reads

Peter Maydell (17):
      nvic: Clear the vector arrays and prigroup on reset
      target/arm: Don't switch to target stack early in v7M exception return
      target/arm: Prepare for CONTROL.SPSEL being nonzero in Handler mode
      target/arm: Restore security state on exception return
      target/arm: Restore SPSEL to correct CONTROL register on exception return
      target/arm: Check for xPSR mismatch usage faults earlier for v8M
      target/arm: Warn about restoring to unaligned stack
      target/arm: Don't warn about exception return with PC low bit set for v8M
      target/arm: Add new-in-v8M SFSR and SFAR
      target/arm: Update excret sanity checks for v8M
      target/arm: Add support for restoring v8M additional state context
      target/arm: Add v8M support to exception entry code
      nvic: Implement Security Attribution Unit registers
      target/arm: Implement security attribute lookups for memory accesses
      target/arm: Fix calculation of secure mm_idx values
      target/arm: Factor out "get mmuidx for specified security state"
      nvic: Add missing code for writing SHCSR.HARDFAULTPENDED bit

Thomas Huth (1):
      hw/arm/xlnx-zynqmp: Mark the "xlnx, zynqmp" device with user_creatable = false

 target/arm/cpu.h       |  60 ++++-
 target/arm/internals.h |  15 ++
 hw/arm/xlnx-zynqmp.c   |   2 +
 hw/intc/armv7m_nvic.c  | 158 ++++++++++-
 hw/sd/sd.c             |  12 +-
 target/arm/cpu.c       |  27 ++
 target/arm/helper.c    | 691 +++++++++++++++++++++++++++++++++++++++++++------
 target/arm/machine.c   |  16 ++
 target/arm/op_helper.c |  27 +-
 9 files changed, 898 insertions(+), 110 deletions(-)
