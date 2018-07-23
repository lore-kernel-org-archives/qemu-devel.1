Received: from eggs.gnu.org ([2001:4830:134:3::10]:43710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fhc28-0007Wp-Rl
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:41:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fhc27-000824-Uh
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:41:56 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fhc27-00081L-NM
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:41:55 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fhc25-0007hM-JX
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 15:41:53 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jul 2018 15:41:47 +0100
Message-Id: <20180723144152.13885-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/5] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

target-arm queue for 3.0:

Thomas' fixes for instrospection issues with a handful of
devices (including one microblaze one that I include in this
pullreq for convenience's sake), plus my bugfix for a
corner case of small MPU region support.

thanks
-- PMM

The following changes since commit 55b1f14cefcb19ce6d5e28c4c83404230888aa7e:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.0-pull-request' into staging (2018-07-23 14:03:14 +0100)

are available in the Git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180723

for you to fetch changes up to 1ddc9b98c3cb89fe23a55ba924000fd645253e87:

  hw/intc/exynos4210_gic: Turn instance_init into realize function (2018-07-23 15:21:27 +0100)

----------------------------------------------------------------
target-arm queue:
 * spitz, exynos: fix bugs when introspecting some devices
 * hw/microblaze/xlnx-zynqmp-pmu: Fix introspection problem in 'xlnx, zynqmp-pmu-soc'
 * target/arm: Correctly handle overlapping small MPU regions
 * hw/sd/bcm2835_sdhost: Fix PIO mode writes

----------------------------------------------------------------
Guenter Roeck (1):
      hw/sd/bcm2835_sdhost: Fix PIO mode writes

Peter Maydell (1):
      target/arm: Correctly handle overlapping small MPU regions

Thomas Huth (3):
      hw/microblaze/xlnx-zynqmp-pmu: Fix introspection problem in 'xlnx, zynqmp-pmu-soc'
      hw/arm/spitz: Move problematic nand_init() code to realize function
      hw/intc/exynos4210_gic: Turn instance_init into realize function

 hw/arm/spitz.c                  | 15 ++++++++++----
 hw/intc/exynos4210_gic.c        |  6 +++---
 hw/microblaze/xlnx-zynqmp-pmu.c | 10 ++++-----
 hw/sd/bcm2835_sdhost.c          | 20 ++++++++++++++----
 target/arm/helper.c             | 46 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 80 insertions(+), 17 deletions(-)
