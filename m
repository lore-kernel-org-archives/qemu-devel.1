Received: from eggs.gnu.org ([2001:4830:134:3::10]:53635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dVyCY-00054E-Ec
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dVyCU-0007PJ-7h
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:52:02 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 11:51:23 +0100
Message-Id: <1500029487-14822-6-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500029487-14822-1-git-send-email-peter.maydell@linaro.org>
References: <1500029487-14822-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 5/9] hw/arm/mps2: Add timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Alistair Francis <alistair.francis@xilinx.com>

Add the CMSDK APB timers to the MPS2 board.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/mps2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 180c5d2..0de0ffcb 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -33,6 +33,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/misc/unimp.h"
 #include "hw/char/cmsdk-apb-uart.h"
+#include "hw/timer/cmsdk-apb-timer.h"
 
 typedef enum MPS2FPGAType {
     FPGA_AN385,
@@ -292,6 +293,9 @@ static void mps2_common_init(MachineState *machine)
         g_assert_not_reached();
     }
 
+    cmsdk_apb_timer_create(0x40000000, qdev_get_gpio_in(armv7m, 8), SYSCLK_FRQ);
+    cmsdk_apb_timer_create(0x40001000, qdev_get_gpio_in(armv7m, 9), SYSCLK_FRQ);
+
     system_clock_scale = NANOSECONDS_PER_SECOND / SYSCLK_FRQ;
 
     armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
-- 
2.7.4
