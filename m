Received: from eggs.gnu.org ([2001:4830:134:3::10]:47715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eIcC2-0005QL-8s
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 10:16:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eIcC1-00056U-AG
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 10:16:34 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Sat, 25 Nov 2017 13:16:06 -0200
Message-Id: <20171125151610.20547-3-ehabkost@redhat.com>
In-Reply-To: <20171125151610.20547-1-ehabkost@redhat.com>
References: <20171125151610.20547-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/6] hw/arm/virt: Allow only supported
 dynamic sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jgross@suse.com, Thomas Huth <thuth@redhat.com>, sstabellini@kernel.org, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

Replace the TYPE_SYS_BUS_DEVICE entry in the allowed sysbus
device list with the two device types that are really supported
by the virt machine: vfio-amd-xgbe and vfio-calxeda-xgmac.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes series v1 -> v2:
* New patch added to series
---
 hw/arm/virt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index fa6dc15fcd..f267ef0ff5 100644
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
2.13.6
