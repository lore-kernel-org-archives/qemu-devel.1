Received: from eggs.gnu.org ([209.51.188.92]:46215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sourav.jb1988@gmail.com>) id 1gn3qb-0007qy-1G
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:56:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sourav.jb1988@gmail.com>) id 1gn3qa-0007h8-CM
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:56:48 -0500
From: kumar sourav <sourav.jb1988@gmail.com>
Date: Fri, 25 Jan 2019 21:26:30 +0530
Message-Id: <20190125155630.17430-1-sourav.jb1988@gmail.com>
Subject: [Qemu-devel] [PATCH] hw/arm/nrf51_soc: set object owner in
 memory_region_init_ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: joel@jms.id.au, peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org

set object owner in memory_region_init_ram() instead
of NULL.

Signed-off-by: kumar sourav <sourav.jb1988@gmail.com>
---
 hw/arm/nrf51_soc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 1630c27594..3a1c7e200c 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -89,7 +89,8 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     }
     memory_region_add_subregion(&s->container, NRF51_FLASH_BASE, &s->flash);
 
-    memory_region_init_ram(&s->sram, NULL, "nrf51.sram", s->sram_size, &err);
+    memory_region_init_ram(&s->sram, OBJECT(s), "nrf51.sram", s->sram_size,
+                           &err);
     if (err) {
         error_propagate(errp, err);
         return;
-- 
2.17.1
