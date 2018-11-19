Received: from eggs.gnu.org ([2001:4830:134:3::10]:45261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gOlvi-0001w9-1K
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:57:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gOlvh-0006tO-7X
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:57:41 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gOlvh-0006rE-0C
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:57:41 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gOlvZ-000640-OB
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 15:57:33 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Nov 2018 15:57:20 +0000
Message-Id: <20181119155730.11758-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/10] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Some Arm bugfixes for rc2...

thanks
-- PMM

The following changes since commit e6ebbd46b6e539f3613136111977721d212c2812:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2018-11-19 14:31:48 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20181119

for you to fetch changes up to a00d7f2048c2a1a6a4487ac195c804c78adcf60e:

  MAINTAINERS: list myself as maintainer for various Arm boards (2018-11-19 15:55:11 +0000)

----------------------------------------------------------------
target-arm queue:
 * various MAINTAINERS file updates
 * hw/block/onenand: use qemu_log_mask() for reporting
 * hw/block/onenand: Fix off-by-one error allowing out-of-bounds read
   on the n800 and n810 machine models
 * target/arm: fix smc incorrectly trapping to EL3 when secure is off
 * hw/arm/stm32f205: Fix the UART and Timer region size
 * target/arm: read ID registers for KVM guests so they can be
   used to gate "is feature X present" checks

----------------------------------------------------------------
Luc Michel (1):
      target/arm: fix smc incorrectly trapping to EL3 when secure is off

Peter Maydell (3):
      hw/block/onenand: Fix off-by-one error allowing out-of-bounds read
      hw/block/onenand: use qemu_log_mask() for reporting
      MAINTAINERS: list myself as maintainer for various Arm boards

Richard Henderson (4):
      target/arm: Install ARMISARegisters from kvm host
      target/arm: Fill in ARMISARegisters for kvm64
      target/arm: Introduce read_sys_reg32 for kvm32
      target/arm: Fill in ARMISARegisters for kvm32

Seth Kintigh (1):
      hw/arm/stm32f205: Fix the UART and Timer region size

Thomas Huth (1):
      MAINTAINERS: Add entries for missing ARM boards

 target/arm/kvm_arm.h       |   1 +
 hw/block/onenand.c         |  24 +++++-----
 hw/char/stm32f2xx_usart.c  |   2 +-
 hw/timer/stm32f2xx_timer.c |   2 +-
 target/arm/kvm.c           |   1 +
 target/arm/kvm32.c         |  77 ++++++++++++++++++++------------
 target/arm/kvm64.c         |  90 +++++++++++++++++++++++++++++++++++++-
 target/arm/op_helper.c     |  54 +++++++++++++++++++----
 MAINTAINERS                | 106 +++++++++++++++++++++++++++++++++++++++------
 9 files changed, 293 insertions(+), 64 deletions(-)
