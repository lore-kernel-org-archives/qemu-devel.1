Received: from eggs.gnu.org ([2001:4830:134:3::10]:59325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dUsS7-0007eV-Cq
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dUsS6-0006GB-HU
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:31:35 -0400
Received: from orth.archaic.org.uk ([81.2.115.148]:48421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dUsS6-000683-9a
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:31:34 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dUsPp-0002xU-2W
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:29:13 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 11:29:08 +0100
Message-Id: <1499768952-24990-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/4] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

A surprisingly short target-arm queue, but no point in holding
onto these waiting for more code to arrive :-)

thanks
-- PMM

The following changes since commit 3d0bf8dfdfebd7f2ae41b6f220444b8047d6b1ee:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20170710a' into staging (2017-07-10 18:13:03 +0100)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170711

for you to fetch changes up to 792dac309c8660306557ba058b8b5a6a75ab3c1f:

  target-arm: v7M: ignore writes to CONTROL.SPSEL from Thread mode (2017-07-11 11:21:26 +0100)

----------------------------------------------------------------
target-arm queue:
 * v7M: ignore writes to CONTROL.SPSEL from Thread mode
 * KVM: Enable in-kernel timers with user space gic
 * aspeed: Register all watchdogs
 * hw/misc: Add Exynos4210 Pseudo Random Number Generator

----------------------------------------------------------------
Alexander Graf (1):
      ARM: KVM: Enable in-kernel timers with user space gic

Joel Stanley (1):
      aspeed: Register all watchdogs

Krzysztof Kozlowski (1):
      hw/misc: Add Exynos4210 Pseudo Random Number Generator

Peter Maydell (1):
      target-arm: v7M: ignore writes to CONTROL.SPSEL from Thread mode

 hw/misc/Makefile.objs       |   2 +-
 include/hw/arm/aspeed_soc.h |   4 +-
 include/sysemu/kvm.h        |  11 ++
 target/arm/cpu.h            |   3 +
 accel/kvm/kvm-all.c         |   5 +
 accel/stubs/kvm-stub.c      |   5 +
 hw/arm/aspeed_soc.c         |  25 ++--
 hw/arm/exynos4210.c         |   4 +
 hw/intc/arm_gic.c           |   7 ++
 hw/misc/exynos4210_rng.c    | 277 ++++++++++++++++++++++++++++++++++++++++++++
 target/arm/helper.c         |  13 ++-
 target/arm/kvm.c            |  51 ++++++++
 12 files changed, 394 insertions(+), 13 deletions(-)
 create mode 100644 hw/misc/exynos4210_rng.c
