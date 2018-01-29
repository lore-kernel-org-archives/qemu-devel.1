Received: from eggs.gnu.org ([2001:4830:134:3::10]:34814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eg07Z-0004Sh-70
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 22:28:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eg07Y-0001dM-4X
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 22:28:37 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 29 Jan 2018 14:28:17 +1100
Message-Id: <20180129032826.16876-4-david@gibson.dropbear.id.au>
In-Reply-To: <20180129032826.16876-1-david@gibson.dropbear.id.au>
References: <20180129032826.16876-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 03/12] grackle: convert to trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, surajjs@au1.ibm.com, groug@kaod.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci-host/grackle.c    | 13 ++-----------
 hw/pci-host/trace-events |  3 +++
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index 3caf1ccb37..033588b7d2 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -27,16 +27,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/ppc/mac.h"
 #include "hw/pci/pci.h"
-
-/* debug Grackle */
-//#define DEBUG_GRACKLE
-
-#ifdef DEBUG_GRACKLE
-#define GRACKLE_DPRINTF(fmt, ...)                               \
-    do { printf("GRACKLE: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define GRACKLE_DPRINTF(fmt, ...)
-#endif
+#include "trace.h"
 
 #define GRACKLE_PCI_HOST_BRIDGE(obj) \
     OBJECT_CHECK(GrackleState, (obj), TYPE_GRACKLE_PCI_HOST_BRIDGE)
@@ -58,7 +49,7 @@ static void pci_grackle_set_irq(void *opaque, int irq_num, int level)
 {
     qemu_irq *pic = opaque;
 
-    GRACKLE_DPRINTF("set_irq num %d level %d\n", irq_num, level);
+    trace_grackle_set_irq(irq_num, level);
     qemu_set_irq(pic[irq_num + 0x15], level);
 }
 
diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
index 32dfc84692..5b8fcc228b 100644
--- a/hw/pci-host/trace-events
+++ b/hw/pci-host/trace-events
@@ -1,5 +1,8 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
+# hw/pci-host/grackle.c
+grackle_set_irq(int irq_num, int level) "set_irq num %d level %d"
+
 # hw/pci-host/sabre.c
 sabre_set_request(int irq_num) "request irq %d"
 sabre_clear_request(int irq_num) "clear request irq %d"
-- 
2.14.3
