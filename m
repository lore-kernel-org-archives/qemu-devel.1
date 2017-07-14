Received: from eggs.gnu.org ([2001:4830:134:3::10]:53528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dVyCS-0004xW-82
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dVyCO-0007Fw-0c
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:51:56 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 11:51:27 +0100
Message-Id: <1500029487-14822-10-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500029487-14822-1-git-send-email-peter.maydell@linaro.org>
References: <1500029487-14822-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 9/9] MAINTAINERS: Add entries for MPS2 board
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

Add entries to the MAINTAINERS file for the new MPS2
board and devices.

Since the CMSDK devices are not specific to the MPS2 board,
extend the existing 'PrimeCell' section to cover CMSDK
devices as well; in both cases these are devices implemented
by ARM and provided as RTL that may be used in multiple
SoCs and boards.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9529c94..10f5cd6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -380,7 +380,7 @@ F: hw/*/allwinner*
 F: include/hw/*/allwinner*
 F: hw/arm/cubieboard.c
 
-ARM PrimeCell
+ARM PrimeCell and CMSDK devices
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
@@ -394,6 +394,10 @@ F: hw/intc/pl190.c
 F: hw/sd/pl181.c
 F: hw/timer/pl031.c
 F: include/hw/arm/primecell.h
+F: hw/timer/cmsdk-apb-timer.c
+F: include/hw/timer/cmsdk-apb-timer.h
+F: hw/char/cmsdk-apb-uart.c
+F: include/hw/char/cmsdk-apb-uart.h
 
 ARM cores
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -455,6 +459,14 @@ S: Maintained
 F: hw/arm/integratorcp.c
 F: hw/misc/arm_integrator_debug.c
 
+MPS2
+M: Peter Maydell <peter.maydell@linaro.org>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/mps2.c
+F: hw/misc/mps2-scc.c
+F: include/hw/misc/mps2-scc.h
+
 Musicpal
 M: Jan Kiszka <jan.kiszka@web.de>
 L: qemu-arm@nongnu.org
-- 
2.7.4
