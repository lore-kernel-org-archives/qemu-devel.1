Received: from eggs.gnu.org ([2001:4830:134:3::10]:34225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun5-0007mi-2w
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun4-0007a2-CM
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:27 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYun4-0007UV-5C
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:26 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun2-0004mz-Rn
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:54:24 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:53:35 +0100
Message-Id: <20180629145347.652-44-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 43/55] i.mx7d: Remove unused header files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Jean-Christophe Dubois <jcd@tribudubois.net>

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/mcimx7d-sabre.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 95fb409d9c5..9c5f0e70c3e 100644
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
