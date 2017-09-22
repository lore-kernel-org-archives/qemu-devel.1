Received: from eggs.gnu.org ([2001:4830:134:3::10]:51849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQP0-0006PC-CX
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:02:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQOu-00007w-SW
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:02:06 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 13:01:06 -0300
Message-Id: <20170922160111.31885-7-f4bug@amsat.org>
In-Reply-To: <20170922154014.29350-1-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 29/34] hw/net/e1000e: use TYPE_PCI_E1000E
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/net/pci.h | 1 +
 hw/net/e1000e.c      | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/hw/net/pci.h b/include/hw/net/pci.h
index b24b5257a5..92111f86f3 100644
--- a/include/hw/net/pci.h
+++ b/include/hw/net/pci.h
@@ -14,6 +14,7 @@
 #include "hw/pci/pci_bus.h"
 
 #define TYPE_PCI_E1000      "e1000"
+#define TYPE_PCI_E1000E     "e1000e"
 
 PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
                                const char *default_model,
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 6c42b4478c..494f8cced6 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -40,6 +40,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
+#include "hw/net/pci.h"
 
 #include "hw/net/e1000_regs.h"
 
@@ -49,8 +50,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 
-#define TYPE_E1000E "e1000e"
-#define E1000E(obj) OBJECT_CHECK(E1000EState, (obj), TYPE_E1000E)
+#define E1000E(obj) OBJECT_CHECK(E1000EState, (obj), TYPE_PCI_E1000E)
 
 typedef struct E1000EState {
     PCIDevice parent_obj;
@@ -703,7 +703,7 @@ static void e1000e_instance_init(Object *obj)
 }
 
 static const TypeInfo e1000e_info = {
-    .name = TYPE_E1000E,
+    .name =   TYPE_PCI_E1000E,
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(E1000EState),
     .class_init = e1000e_class_init,
-- 
2.14.1
