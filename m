Received: from eggs.gnu.org ([2001:4830:134:3::10]:33229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTf-0005Kz-8l
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTe-0006ku-D9
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:27 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dKmTe-0006fN-5n
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:26 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTL-000112-Tc
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 15:07:07 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jun 2017 15:06:49 +0100
Message-Id: <1497362826-21125-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/17] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Target-arm queue...

thanks
-- PMM

The following changes since commit 735286a4f88255e1463d42ce28d8d14181fd32d4:

  Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20170613' into staging (2017-06-13 13:51:29 +0100)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170613

for you to fetch changes up to 252a7a6a968c279a4636a86b0559ba3a930a90b5:

  hw/intc/arm_gicv3_its: Allow save/restore (2017-06-13 14:57:01 +0100)

----------------------------------------------------------------
target-arm queue:
 * vITS: Support save/restore
 * timer/aspeed: Fix timer enablement when reload is not set
 * aspped: add temperature sensor device
 * timer.h: Provide better monotonic time on ARM hosts
 * exynos4210: various cleanups
 * exynos4210: support system poweroff

----------------------------------------------------------------
Cédric Le Goater (3):
      hw/misc: add a TMP42{1, 2, 3} device model
      aspeed: add a temp sensor device on I2C bus 3
      timer/aspeed: fix timer enablement when a reload is not set

Eric Auger (4):
      kvm-all: Pass an error object to kvm_device_access
      hw/intc/arm_gicv3_its: Implement state save/restore
      hw/intc/arm_gicv3_kvm: Implement pending table save
      hw/intc/arm_gicv3_its: Allow save/restore

Krzysztof Kozlowski (9):
      hw/intc/exynos4210_gic: Use more meaningful name for local variable
      hw/timer/exynos4210_mct: Fix checkpatch style errors
      hw/timer/exynos4210_mct: Cleanup indentation and empty new lines
      hw/timer/exynos4210_mct: Remove unused defines
      hw/arm/exynos: Move DRAM initialization next boards
      hw/arm/exynos: Declare local variables in some order
      hw/arm/exynos: Use type define instead of hard-coded a9mpcore_priv string
      hw/intc/exynos4210_gic: Constify array of combiner interrupts
      hw/misc/exynos4210_pmu: Add support for system poweroff

Pranith Kumar (1):
      timer.h: Provide better monotonic time

 hw/misc/Makefile.objs                  |   1 +
 include/hw/arm/exynos4210.h            |   5 +-
 include/hw/intc/arm_gicv3_its_common.h |   8 +
 include/migration/vmstate.h            |   2 +
 include/qemu/timer.h                   |   5 +-
 include/sysemu/kvm.h                   |  11 +-
 hw/arm/aspeed.c                        |   9 +
 hw/arm/exynos4210.c                    |  27 +--
 hw/arm/exynos4_boards.c                |  50 +++-
 hw/intc/arm_gic_kvm.c                  |   9 +-
 hw/intc/arm_gicv3_common.c             |   1 +
 hw/intc/arm_gicv3_its_common.c         |  12 +-
 hw/intc/arm_gicv3_its_kvm.c            | 131 +++++++++--
 hw/intc/arm_gicv3_kvm.c                |  48 +++-
 hw/intc/exynos4210_gic.c               |  14 +-
 hw/misc/exynos4210_pmu.c               |  20 +-
 hw/misc/tmp421.c                       | 402 +++++++++++++++++++++++++++++++++
 hw/timer/aspeed_timer.c                |  37 ++-
 hw/timer/exynos4210_mct.c              |  50 ++--
 kvm-all.c                              |  14 +-
 default-configs/arm-softmmu.mak        |   1 +
 21 files changed, 741 insertions(+), 116 deletions(-)
 create mode 100644 hw/misc/tmp421.c
