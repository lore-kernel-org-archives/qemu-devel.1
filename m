Received: from eggs.gnu.org ([2001:4830:134:3::10]:44895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1fXw0h-00045z-9N
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1fXw0c-0002lR-NW
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:00:27 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:53083)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1fXw0c-0002kJ-Hk
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:00:22 -0400
From: Jean-Christophe Dubois <jcd@tribudubois.net>
Date: Wed, 27 Jun 2018 00:00:14 +0200
Message-Id: <20180626220014.18986-1-jcd@tribudubois.net>
Subject: [Qemu-devel] [PATCH 1/3] i.mx7d: Remove unused header files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, peter.chubb@nicta.com.au, andrew.smirnov@gmail.com
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
---
 hw/arm/mcimx7d-sabre.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 95fb409d9c..9c5f0e70c3 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -18,10 +18,8 @@
 #include "hw/arm/fsl-imx7.h"
 #include "hw/boards.h"
 #include "sysemu/sysemu.h"
-#include "sysemu/device_tree.h"
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
-#include "net/net.h"
 
 typedef struct {
     FslIMX7State soc;
-- 
2.17.1
