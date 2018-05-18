Received: from eggs.gnu.org ([2001:4830:134:3::10]:36971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJhMY-0003lv-UL
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJhMY-0005m7-3Z
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:32:10 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 16:31:57 +0100
Message-Id: <20180518153157.14899-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Add entries for newer MPS2 boards
 and devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Add entries to MAINTAINERS to cover the newer MPS2 boards and
the new devices they use.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Oops, forgot these when we added the mps2-an505...

 MAINTAINERS | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e187b1f18f..1823f900b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -447,6 +447,8 @@ F: hw/timer/cmsdk-apb-timer.c
 F: include/hw/timer/cmsdk-apb-timer.h
 F: hw/char/cmsdk-apb-uart.c
 F: include/hw/char/cmsdk-apb-uart.h
+F: hw/misc/tz-ppc.c
+F: include/hw/misc/tz-ppc.h
 
 ARM cores
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -515,8 +517,11 @@ M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/mps2.c
-F: hw/misc/mps2-scc.c
-F: include/hw/misc/mps2-scc.h
+F: hw/arm/mps2-tz.c
+F: hw/misc/mps2-*.c
+F: include/hw/misc/mps2-*.h
+F: hw/arm/iotkit.c
+F: include/hw/arm/iotkit.h
 
 Musicpal
 M: Jan Kiszka <jan.kiszka@web.de>
-- 
2.17.0
