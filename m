Received: from eggs.gnu.org ([2001:4830:134:3::10]:33298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTl-0005Q5-J6
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTc-0006iM-9c
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:33 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dKmTc-0006cz-2E
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:24 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTQ-000136-Ox
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 15:07:12 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jun 2017 15:06:56 +0100
Message-Id: <1497362826-21125-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1497362826-21125-1-git-send-email-peter.maydell@linaro.org>
References: <1497362826-21125-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/17] hw/arm/exynos: Use type define instead of
 hard-coded a9mpcore_priv string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Krzysztof Kozlowski <krzk@kernel.org>

Use a define for a9mpcore_priv device type name instead of hard-coded
string.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/exynos4210.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 27a7bf2..0050626 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -26,6 +26,7 @@
 #include "qemu-common.h"
 #include "qemu/log.h"
 #include "cpu.h"
+#include "hw/cpu/a9mpcore.h"
 #include "hw/boards.h"
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
@@ -211,7 +212,7 @@ Exynos4210State *exynos4210_init(MemoryRegion *system_mem)
     }
 
     /* Private memory region and Internal GIC */
-    dev = qdev_create(NULL, "a9mpcore_priv");
+    dev = qdev_create(NULL, TYPE_A9MPCORE_PRIV);
     qdev_prop_set_uint32(dev, "num-cpu", EXYNOS4210_NCPUS);
     qdev_init_nofail(dev);
     busdev = SYS_BUS_DEVICE(dev);
-- 
2.7.4
