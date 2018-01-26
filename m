Received: from eggs.gnu.org ([2001:4830:134:3::10]:52890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1efAQJ-0000aM-Jb
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 15:16:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1efAQF-00006z-6X
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 15:16:31 -0500
Received: from chuckie.co.uk ([82.165.15.123]:59492
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1efAQE-000057-Ug
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 15:16:27 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 26 Jan 2018 09:20:27 +0000
Message-Id: <20180126092029.20737-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180126092029.20737-1-mark.cave-ayland@ilande.co.uk>
References: <20180126092029.20737-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 1/3] grackle: convert to trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, david@gibson.dropbear.id.au

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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
2.11.0
