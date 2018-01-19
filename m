Received: from eggs.gnu.org ([2001:4830:134:3::10]:45592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecZd0-0005xj-JQ
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:34:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecZcz-0006oA-RQ
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:34:54 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 19 Jan 2018 14:33:33 -0200
Message-Id: <20180119163345.10649-8-ehabkost@redhat.com>
In-Reply-To: <20180119163345.10649-1-ehabkost@redhat.com>
References: <20180119163345.10649-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL v2 07/19] hw/arm/virt: Allow only supported
 dynamic sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, qemu-arm@nongnu.org

Replace the TYPE_SYS_BUS_DEVICE entry in the allowed sysbus
device list with the two device types that are really supported
by the virt machine: vfio-amd-xgbe and vfio-calxeda-xgmac.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20171125151610.20547-3-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/arm/virt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7549895fd2..4a6fdcc4f5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -34,6 +34,8 @@
 #include "hw/arm/arm.h"
 #include "hw/arm/primecell.h"
 #include "hw/arm/virt.h"
+#include "hw/vfio/vfio-calxeda-xgmac.h"
+#include "hw/vfio/vfio-amd-xgbe.h"
 #include "hw/devices.h"
 #include "net/net.h"
 #include "sysemu/block-backend.h"
@@ -1591,8 +1593,8 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
      * configuration of the particular instance.
      */
     mc->max_cpus = 255;
-    /*TODO: allow only sysbus devices that really work with this machine */
-    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SYS_BUS_DEVICE);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_CALXEDA_XGMAC);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_AMD_XGBE);
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
     mc->pci_allow_0_address = true;
-- 
2.14.3
