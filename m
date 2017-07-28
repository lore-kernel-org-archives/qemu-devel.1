Received: from eggs.gnu.org ([2001:4830:134:3::10]:47301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daxwq-0003tG-SP
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daxwp-0002ra-Uz
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:36:28 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 28 Jul 2017 02:35:25 -0300
Message-Id: <20170728053610.15770-3-f4bug@amsat.org>
In-Reply-To: <20170728053610.15770-1-f4bug@amsat.org>
References: <20170728053610.15770-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 02/47] MAINTAINERS: add missing ARM entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 972118e70b..795f89f709 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -120,6 +120,8 @@ F: include/hw/cpu/a*mpcore.h
 F: disas/arm.c
 F: disas/arm-a64.cc
 F: disas/libvixl/
+F: default-configs/arm-softmmu.mak
+F: default-configs/aarch64-softmmu.mak
 
 CRIS
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
@@ -380,6 +382,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/char/pl011.c
+F: include/hw/char/pl011.h
 F: hw/display/pl110*
 F: hw/dma/pl080.c
 F: hw/dma/pl330.c
@@ -402,14 +405,19 @@ F: hw/intc/arm*
 F: hw/intc/gic_internal.h
 F: hw/misc/a9scu.c
 F: hw/misc/arm11scu.c
+F: hw/misc/arm_sysctl.c
 F: hw/timer/a9gtimer*
 F: hw/timer/arm_*
+F: hw/timer/armv7m_systick.c
 F: include/hw/arm/arm.h
+F: include/hw/arm/armv7m*.h
 F: include/hw/intc/arm*
 F: include/hw/misc/a9scu.h
 F: include/hw/misc/arm11scu.h
 F: include/hw/timer/a9gtimer.h
 F: include/hw/timer/arm_mptimer.h
+F: include/hw/timer/armv7m_systick.h
+F: tests/test-arm-mptimer.c
 
 Exynos
 M: Igor Mitsyanko <i.mitsyanko@gmail.com>
-- 
2.13.3
