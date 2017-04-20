Received: from eggs.gnu.org ([2001:4830:134:3::10]:43597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F8z-0008Oe-2a
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F8x-000847-HD
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:21 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:36885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1d1F8x-0007wI-Ak
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:19 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F8p-0006s6-9t
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 17:41:11 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 17:40:46 +0100
Message-Id: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/24] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

First ARM pullreq of the 2.10 cycle...

thanks
-- PMM

The following changes since commit 64c8ed97cceabac4fafe17fca8d88ef08183f439:

  Open 2.10 development tree (2017-04-20 15:42:31 +0100)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170420

for you to fetch changes up to f4e8e4edda875cab9df91dc4ae9767f7cb1f50aa:

  arm: Remove workarounds for old M-profile exception return implementation (2017-04-20 17:39:17 +0100)

----------------------------------------------------------------
target-arm queue:
 * implement M profile exception return properly
 * cadence GEM: fix multiqueue handling bugs
 * pxa2xx.c: QOMify a device
 * arm/kvm: Remove trailing newlines from error_report()
 * stellaris: Don't hw_error() on bad register accesses
 * Add assertion about FSC format for syndrome registers
 * Move excnames[] array into arm_log_exceptions()
 * exynos: minor code cleanups
 * hw/arm/boot: take Linux/arm64 TEXT_OFFSET header field into account
 * Fix APSR writes via M profile MSR

----------------------------------------------------------------
Alistair Francis (5):
      cadence_gem: Read the correct queue descriptor
      cadence_gem: Correct the multi-queue can rx logic
      cadence_gem: Correct the interupt logic
      cadence_gem: Make the revision a property
      xlnx-zynqmp: Set the Cadence GEM revision

Ard Biesheuvel (1):
      hw/arm/boot: take Linux/arm64 TEXT_OFFSET header field into account

Ishani Chugh (1):
      arm/kvm: Remove trailing newlines from error_report()

Krzysztof Kozlowski (3):
      hw/arm/exynos: Convert fprintf to qemu_log_mask/error_report
      hw/char/exynos4210_uart: Constify static array and few arguments
      hw/misc/exynos4210_pmu: Reorder local variables for readability

Peter Maydell (13):
      target/arm: Add missing entries to excnames[] for log strings
      arm: Move excnames[] array into arm_log_exceptions()
      target/arm: Add assertion about FSC format for syndrome registers
      stellaris: Don't hw_error() on bad register accesses
      arm: Don't implement BXJ on M-profile CPUs
      arm: Thumb shift operations should not permit interworking branches
      arm: Factor out "generate right kind of step exception"
      arm: Move gen_set_condexec() and gen_set_pc_im() up in the file
      arm: Move condition-failed codepath generation out of if()
      arm: Abstract out "are we singlestepping" test to utility function
      arm: Track M profile handler mode state in TB flags
      arm: Implement M profile exception return properly
      arm: Remove workarounds for old M-profile exception return implementation

Suramya Shah (1):
      hw/arm: Qomify pxa2xx.c

 include/hw/net/cadence_gem.h |   1 +
 target/arm/cpu.h             |  10 +++
 target/arm/internals.h       |  21 -----
 target/arm/translate.h       |   5 ++
 hw/arm/boot.c                |  64 ++++++++++++---
 hw/arm/exynos4_boards.c      |   7 +-
 hw/arm/pxa2xx.c              |  14 ++--
 hw/arm/stellaris.c           |  60 ++++++++------
 hw/arm/xlnx-zynqmp.c         |   6 +-
 hw/char/exynos4210_uart.c    |   8 +-
 hw/misc/exynos4210_pmu.c     |   4 +-
 hw/net/cadence_gem.c         |  45 +++++++----
 hw/timer/exynos4210_mct.c    |   6 +-
 hw/timer/exynos4210_pwm.c    |  13 ++--
 hw/timer/exynos4210_rtc.c    |  19 ++---
 target/arm/cpu.c             |  43 +---------
 target/arm/helper.c          |  19 +++++
 target/arm/kvm64.c           |   4 +-
 target/arm/op_helper.c       |  23 ++++--
 target/arm/translate.c       | 181 +++++++++++++++++++++++++++++--------------
 20 files changed, 341 insertions(+), 212 deletions(-)
