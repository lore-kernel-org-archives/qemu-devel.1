Received: from eggs.gnu.org ([2001:4830:134:3::10]:59061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5Oc-0007r2-Kd
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5Ob-0002Df-Dz
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:06 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dX5Ob-0002Ci-7G
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:05 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5OZ-0003Xh-U6
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:45:03 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 13:44:54 +0100
Message-Id: <1500295494-8991-19-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500295494-8991-1-git-send-email-peter.maydell@linaro.org>
References: <1500295494-8991-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/18] MAINTAINERS: Add entries for MPS2 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add entries to the MAINTAINERS file for the new MPS2
board and devices.

Since the CMSDK devices are not specific to the MPS2 board,
extend the existing 'PrimeCell' section to cover CMSDK
devices as well; in both cases these are devices implemented
by ARM and provided as RTL that may be used in multiple
SoCs and boards.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1500029487-14822-10-git-send-email-peter.maydell@linaro.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b9aa878..5ea273f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -375,7 +375,7 @@ F: hw/*/allwinner*
 F: include/hw/*/allwinner*
 F: hw/arm/cubieboard.c
 
-ARM PrimeCell
+ARM PrimeCell and CMSDK devices
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
@@ -389,6 +389,10 @@ F: hw/intc/pl190.c
 F: hw/sd/pl181.c
 F: hw/timer/pl031.c
 F: include/hw/arm/primecell.h
+F: hw/timer/cmsdk-apb-timer.c
+F: include/hw/timer/cmsdk-apb-timer.h
+F: hw/char/cmsdk-apb-uart.c
+F: include/hw/char/cmsdk-apb-uart.h
 
 ARM cores
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -450,6 +454,14 @@ S: Maintained
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
