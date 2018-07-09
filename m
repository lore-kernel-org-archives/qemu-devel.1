Received: from eggs.gnu.org ([2001:4830:134:3::10]:48088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWch-0007ay-Bs
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWcg-0004zw-JV
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:39 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fcWcg-0004zS-BP
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:38 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWce-0000g8-BB
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:54:36 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jul 2018 14:54:24 +0100
Message-Id: <20180709135435.836-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/11] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi; this target-arm pull request has a collection of generally
fairly minor bugs to sneak in before 3.0 rc0 tomorrow...

thanks
-- PMM

The following changes since commit a98ff0ec2ba3538dd766b349518ee18d03942ed8:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-3.0-20180709' into staging (2018-07-09 11:00:45 +0100)

are available in the Git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180709

for you to fetch changes up to 8fad0a65582c0a6e324580f45516461e9b6aa439:

  hw/net/dp8393x: don't make prom region 'nomigrate' (2018-07-09 14:51:35 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/net/dp8393x: don't make prom region 'nomigrate'
 * boards.h: Remove doc comment reference to nonexistent function
 * hw/sd/omap_mmc: Split 'pseudo-reset' from 'power-on-reset'
 * target/arm: Fix do_predset for large VL
 * tcg: Restrict check_size_impl to multiples of the line size
 * target/arm: Suppress Coverity warning for PRF
 * hw/timer/cmsdk-apb-timer: fix minor corner-case bugs and
   suppress spurious warnings when running Linux's timer driver
 * hw/arm/smmu-common: Fix devfn computation in smmu_iommu_mr

----------------------------------------------------------------
Eric Auger (1):
      hw/arm/smmu-common: Fix devfn computation in smmu_iommu_mr

Guenter Roeck (1):
      hw/timer/cmsdk-apb-timer: Correctly identify and set one-shot mode

Peter Maydell (5):
      ptimer: Add TRIGGER_ONLY_ON_DECREMENT policy option
      hw/timer/cmsdk-apb-timer: Correct ptimer policy settings
      hw/timer/cmsdk-apb-timer: run or stop timer on writes to RELOAD and VALUE
      boards.h: Remove doc comment reference to nonexistent function
      hw/net/dp8393x: don't make prom region 'nomigrate'

Philippe Mathieu-Daudé (1):
      hw/sd/omap_mmc: Split 'pseudo-reset' from 'power-on-reset'

Richard Henderson (3):
      target/arm: Suppress Coverity warning for PRF
      tcg: Restrict check_size_impl to multiples of the line size
      target/arm: Fix do_predset for large VL

 include/hw/arm/smmu-common.h |  1 +
 include/hw/boards.h          |  3 +--
 include/hw/ptimer.h          |  9 +++++++++
 hw/arm/smmu-common.c         |  2 +-
 hw/core/ptimer.c             | 22 +++++++++++++++++++++-
 hw/net/dp8393x.c             |  2 +-
 hw/sd/omap_mmc.c             | 14 +++++++++++---
 hw/timer/cmsdk-apb-timer.c   | 20 ++++++++++++++++++--
 target/arm/translate-sve.c   | 14 ++++----------
 tcg/tcg-op-gvec.c            |  7 +++++--
 tests/ptimer-test.c          | 25 +++++++++++++++++++------
 11 files changed, 91 insertions(+), 28 deletions(-)
