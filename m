Received: from eggs.gnu.org ([2001:4830:134:3::10]:50574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cFMId-000570-Tb
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 09:37:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cFMIY-0003qb-Cg
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 09:37:23 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Fri,  9 Dec 2016 15:37:03 +0100
Message-Id: <20161209143703.29457-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/intc/arm_gicv3_common: fix aff3 in typer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 hw/intc/arm_gicv3_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 0f8c4b86e023..0aa9b9ca6655 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -204,7 +204,8 @@ static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
         /* The CPU mp-affinity property is in MPIDR register format; squash
          * the affinity bytes into 32 bits as the GICR_TYPER has them.
          */
-        cpu_affid = (cpu_affid & 0xFF00000000ULL >> 8) | (cpu_affid & 0xFFFFFF);
+        cpu_affid = ((cpu_affid & 0xFF00000000ULL) >> 8) |
+                     (cpu_affid & 0xFFFFFF);
         s->cpu[i].gicr_typer = (cpu_affid << 32) |
             (1 << 24) |
             (i << 8) |
-- 
2.9.3
