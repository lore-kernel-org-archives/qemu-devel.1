Received: from eggs.gnu.org ([2001:4830:134:3::10]:59281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpGAa-0000O6-NJ
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:53:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpGAW-0004Im-9f
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:53:44 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Sep 2017 16:53:31 +0100
Message-Id: <1504626814-23124-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 0/3] Add do_transaction_failed hook for ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>

I sent these patches earlier, but only realized when I
put them in the target-arm pull request that they broke
the user-mode emulators.

Only change in these 3 patches from v1 is that patch 1
now checks that what it gets from qdev_get_machine()
is really an instance of TYPE_MACHINE before using it
(which only happens for the user-mode emulators, where
we don't need to set ignore_memory_transaction_failures).

thanks
-- PMM

Peter Maydell (3):
  boards.h: Define new flag ignore_memory_transaction_failures
  hw/arm: Set ignore_memory_transaction_failures for most ARM boards
  target/arm: Implement new do_transaction_failed hook

 include/hw/boards.h     | 11 +++++++++++
 include/qom/cpu.h       |  7 ++++++-
 target/arm/internals.h  | 10 ++++++++++
 hw/arm/aspeed.c         |  3 +++
 hw/arm/collie.c         |  1 +
 hw/arm/cubieboard.c     |  1 +
 hw/arm/digic_boards.c   |  1 +
 hw/arm/exynos4_boards.c |  2 ++
 hw/arm/gumstix.c        |  2 ++
 hw/arm/highbank.c       |  2 ++
 hw/arm/imx25_pdk.c      |  1 +
 hw/arm/integratorcp.c   |  1 +
 hw/arm/kzm.c            |  1 +
 hw/arm/mainstone.c      |  1 +
 hw/arm/musicpal.c       |  1 +
 hw/arm/netduino2.c      |  1 +
 hw/arm/nseries.c        |  2 ++
 hw/arm/omap_sx1.c       |  2 ++
 hw/arm/palm.c           |  1 +
 hw/arm/raspi.c          |  1 +
 hw/arm/realview.c       |  4 ++++
 hw/arm/sabrelite.c      |  1 +
 hw/arm/spitz.c          |  4 ++++
 hw/arm/stellaris.c      |  2 ++
 hw/arm/tosa.c           |  1 +
 hw/arm/versatilepb.c    |  2 ++
 hw/arm/vexpress.c       |  1 +
 hw/arm/xilinx_zynq.c    |  1 +
 hw/arm/xlnx-ep108.c     |  2 ++
 hw/arm/z2.c             |  1 +
 qom/cpu.c               | 16 ++++++++++++++++
 target/arm/cpu.c        |  1 +
 target/arm/op_helper.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
 33 files changed, 130 insertions(+), 1 deletion(-)

-- 
2.7.4
