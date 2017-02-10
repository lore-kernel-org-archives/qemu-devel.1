Received: from eggs.gnu.org ([2001:4830:134:3::10]:49546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFc6-00021T-T8
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFc5-0003uI-VF
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:06 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ccFc5-0003sU-OL
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:05 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFc4-0007aa-36
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 18:08:04 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 18:07:50 +0000
Message-Id: <1486750082-12324-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/12] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

ARM queue: nothing particularly exciting here, but no
reason to sit on them for another week.

thanks
-- PMM

The following changes since commit 61eedf7aec0e2395aabd628cc055096909a3ea15:

  tests/prom-env: Ease time-out problems on slow hosts (2017-02-10 15:44:53 +0000)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170210

for you to fetch changes up to b4cc583f0285a2e1e78621dfba142f00ca47414a:

  aspeed/smc: use a modulo to check segment limits (2017-02-10 17:40:30 +0000)

----------------------------------------------------------------
target-arm queue:
 * aspeed: minor fixes
 * virt: declare fwcfg and virtio-mmio as DMA coherent in DT & ACPI
 * arm: enable basic TCG emulation of PMU for AArch64

----------------------------------------------------------------
Alexander Graf (4):
      target-arm: Declare virtio-mmio as dma-coherent in dt
      hw/arm/virt: Declare virtio-mmio as dma cache coherent in ACPI
      hw/arm/virt: Declare fwcfg as dma cache coherent in ACPI
      hw/arm/virt: Declare fwcfg as dma cache coherent in dt

Cédric Le Goater (4):
      aspeed: check for negative values returned by blk_getlength()
      aspeed: remove useless comment on controller segment size
      aspeed/smc: handle dummies only in fast read mode
      aspeed/smc: use a modulo to check segment limits

Wei Huang (4):
      target-arm: Add support for PMU register PMSELR_EL0
      target-arm: Add support for AArch64 PMU register PMXEVTYPER_EL0
      target-arm: Add support for PMU register PMINTENSET_EL1
      target-arm: Enable vPMU support under TCG mode

 target/arm/cpu.h         |  4 +--
 hw/arm/aspeed.c          | 22 +++++++++-----
 hw/arm/vexpress.c        |  1 +
 hw/arm/virt-acpi-build.c |  2 ++
 hw/arm/virt.c            |  4 ++-
 hw/ssi/aspeed_smc.c      | 13 +++++----
 target/arm/cpu.c         |  2 +-
 target/arm/helper.c      | 74 ++++++++++++++++++++++++++++++++++++------------
 8 files changed, 88 insertions(+), 34 deletions(-)
