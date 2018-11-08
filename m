Received: from eggs.gnu.org ([2001:4830:134:3::10]:39020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gKkZ9-0006ea-Kt
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:41:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gKkZ8-0007On-9t
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:41:47 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gKkZ8-0007JN-01
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:41:46 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  8 Nov 2018 13:41:39 +0000
Message-Id: <20181108134139.31666-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] MAINTAINERS: list myself as maintainer for
 various Arm boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Markus Armbruster <armbru@redhat.com>, patches@linaro.org, Beniamino Galvani <b.galvani@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>, Antony Pavlov <antonynpavlov@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, Andrzej Zaborowski <balrogg@gmail.com>

In practice for most of the more-or-less orphan Arm board models,
I will review patches and put them in via the target-arm tree.
So list myself as an "Odd Fixes" status maintainer for them.

This commit downgrades these boards to "Odd Fixes":
 * Allwinner-A10
 * Exynos
 * Calxeda Highbank
 * Canon DIGIC
 * Musicpal
 * nSeries
 * Palm
 * PXA2xx

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Thomas Huth sent a patch which only addressed collie, but
let's be consistent.

The set of downgrades to odd-fixes is based mostly on my
subjective impression of whether anybody has made any changes
to the board models over the last year or so, so it's quite
possible I've forgotten that one of them is in better shape
maintainer-activity-wise. If the maintainers for those boards
disagree (cc'd) I'm happy to re-upgrade them to Maintained.

Arguably it would be nice to have a letter prefix for "this
is the person who will deal with getting the patch into the
tree, but somebody else will be the primary maintainer for
patch review" -- that's the situation for the maintained/
active boards like ASpeed.
---
 MAINTAINERS | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d68e4bc5eb..4443105686d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -436,8 +436,9 @@ ARM Machines
 ------------
 Allwinner-a10
 M: Beniamino Galvani <b.galvani@gmail.com>
+M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/*/allwinner*
 F: include/hw/*/allwinner*
 F: hw/arm/cubieboard.c
@@ -496,27 +497,31 @@ F: tests/test-arm-mptimer.c
 
 Exynos
 M: Igor Mitsyanko <i.mitsyanko@gmail.com>
+M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/*/exynos*
 F: include/hw/arm/exynos4210.h
 
 Calxeda Highbank
 M: Rob Herring <robh@kernel.org>
+M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/arm/highbank.c
 F: hw/net/xgmac.c
 
 Canon DIGIC
 M: Antony Pavlov <antonynpavlov@gmail.com>
+M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: include/hw/arm/digic.h
 F: hw/*/digic*
 
 Gumstix
 M: Philippe Mathieu-Daudé <f4bug@amsat.org>
+M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-devel@nongnu.org
 L: qemu-arm@nongnu.org
 S: Odd Fixes
@@ -524,8 +529,9 @@ F: hw/arm/gumstix.c
 
 i.MX31
 M: Peter Chubb <peter.chubb@nicta.com.au>
+M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Odd fixes
+S: Odd Fixes
 F: hw/*/imx*
 F: include/hw/*/imx*
 F: hw/arm/kzm.c
@@ -555,20 +561,23 @@ F: include/hw/misc/iotkit-sysinfo.h
 
 Musicpal
 M: Jan Kiszka <jan.kiszka@web.de>
+M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/arm/musicpal.c
 
 nSeries
 M: Andrzej Zaborowski <balrogg@gmail.com>
+M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/arm/nseries.c
 
 Palm
 M: Andrzej Zaborowski <balrogg@gmail.com>
+M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/arm/palm.c
 
 Real View
@@ -582,8 +591,9 @@ F: include/hw/intc/realview_gic.h
 
 PXA2XX
 M: Andrzej Zaborowski <balrogg@gmail.com>
+M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/arm/mainstone.c
 F: hw/arm/spitz.c
 F: hw/arm/tosa.c
@@ -608,6 +618,7 @@ F: hw/misc/arm_sysctl.c
 Xilinx Zynq
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 M: Alistair Francis <alistair@alistair23.me>
+M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/*/xilinx_*
@@ -619,6 +630,7 @@ X: hw/ssi/xilinx_*
 Xilinx ZynqMP
 M: Alistair Francis <alistair@alistair23.me>
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
+M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/*/xlnx*.c
@@ -632,6 +644,7 @@ F: hw/arm/virt-acpi-build.c
 
 STM32F205
 M: Alistair Francis <alistair@alistair23.me>
+M: Peter Maydell <peter.maydell@linaro.org>
 S: Maintained
 F: hw/arm/stm32f205_soc.c
 F: hw/misc/stm32f2xx_syscfg.c
@@ -643,11 +656,13 @@ F: include/hw/*/stm32*.h
 
 Netduino 2
 M: Alistair Francis <alistair@alistair23.me>
+M: Peter Maydell <peter.maydell@linaro.org>
 S: Maintained
 F: hw/arm/netduino2.c
 
 SmartFusion2
 M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
+M: Peter Maydell <peter.maydell@linaro.org>
 S: Maintained
 F: hw/arm/msf2-soc.c
 F: hw/misc/msf2-sysreg.c
@@ -660,11 +675,13 @@ F: include/hw/ssi/mss-spi.h
 
 Emcraft M2S-FG484
 M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
+M: Peter Maydell <peter.maydell@linaro.org>
 S: Maintained
 F: hw/arm/msf2-som.c
 
 ASPEED BMCs
 M: Cédric Le Goater <clg@kaod.org>
+M: Peter Maydell <peter.maydell@linaro.org>
 R: Andrew Jeffery <andrew@aj.id.au>
 R: Joel Stanley <joel@jms.id.au>
 L: qemu-arm@nongnu.org
@@ -676,6 +693,7 @@ F: include/hw/net/ftgmac100.h
 
 NRF51
 M: Joel Stanley <joel@jms.id.au>
+M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/nrf51_soc.c
-- 
2.19.1
