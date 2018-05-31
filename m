Received: from eggs.gnu.org ([2001:4830:134:3::10]:41660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUv-0000t3-JF
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUu-0006Xl-BP
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:13 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fOOUu-0006Oj-2J
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:12 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUi-0002oW-E8
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:24:00 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 15:23:34 +0100
Message-Id: <20180531142357.904-3-peter.maydell@linaro.org>
In-Reply-To: <20180531142357.904-1-peter.maydell@linaro.org>
References: <20180531142357.904-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 02/25] MAINTAINERS: Add entries for newer MPS2
 boards and devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add entries to MAINTAINERS to cover the newer MPS2 boards and
the new devices they use.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180518153157.14899-1-peter.maydell@linaro.org
---
 MAINTAINERS | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf482fd4e9..41cd3736a9 100644
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
2.17.1
