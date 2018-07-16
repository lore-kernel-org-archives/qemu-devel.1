Received: from eggs.gnu.org ([2001:4830:134:3::10]:50612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ff6aW-0008Sm-LK
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ff6aV-0005Yh-Pm
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:43:04 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ff6aV-0005YP-HG
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:43:03 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ff6aT-0000yY-Je
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:43:01 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jul 2018 17:42:52 +0100
Message-Id: <20180716164300.6731-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/8] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

target-arm queue: a smallish set of patches for rc1 tomorrow.
I've included the tcg patches because RTH has no others that
would merit a pullreq.

I haven't included Thomas Huth's 17-patch set to deal with
the introspection crashes, to give that a little more time
on-list for review.

thanks
-- PMM

The following changes since commit 102ad0a80f5110483efd06877c29c4236be267f9:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2018-07-16' into staging (2018-07-16 15:34:38 +0100)

are available in the Git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180716

for you to fetch changes up to 3474c98a2a2afcefa7c665f02ad2bed2a43ab0f7:

  accel/tcg: Assert that tlb fill gave us a valid TLB entry (2018-07-16 17:26:01 +0100)

----------------------------------------------------------------
target-arm queue:
 * accel/tcg: Use correct test when looking in victim TLB for code
 * bcm2835_aux: Swap RX and TX interrupt assignments
 * hw/arm/bcm2836: Mark the bcm2836 / bcm2837 devices with user_creatable = false
 * hw/intc/arm_gic: Fix handling of GICD_ITARGETSR
 * hw/intc/arm_gic: Check interrupt number in gic_deactivate_irq()
 * aspeed: Implement write-1-{set, clear} for AST2500 strapping
 * target/arm: Fix LD1W and LDFF1W (scalar plus vector)

----------------------------------------------------------------
Andrew Jeffery (1):
      aspeed: Implement write-1-{set, clear} for AST2500 strapping

Guenter Roeck (1):
      bcm2835_aux: Swap RX and TX interrupt assignments

Peter Maydell (4):
      hw/intc/arm_gic: Check interrupt number in gic_deactivate_irq()
      hw/intc/arm_gic: Fix handling of GICD_ITARGETSR
      accel/tcg: Use correct test when looking in victim TLB for code
      accel/tcg: Assert that tlb fill gave us a valid TLB entry

Richard Henderson (1):
      target/arm: Fix LD1W and LDFF1W (scalar plus vector)

Thomas Huth (1):
      hw/arm/bcm2836: Mark the bcm2836 / bcm2837 devices with user_creatable = false

 include/hw/misc/aspeed_scu.h |  2 ++
 accel/tcg/cputlb.c           |  6 +++---
 hw/arm/bcm2836.c             |  2 ++
 hw/char/bcm2835_aux.c        |  4 ++--
 hw/intc/arm_gic.c            | 22 +++++++++++++++++++---
 hw/misc/aspeed_scu.c         | 19 +++++++++++++++++--
 target/arm/sve_helper.c      |  4 ++--
 7 files changed, 47 insertions(+), 12 deletions(-)
