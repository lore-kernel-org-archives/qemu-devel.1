Received: from eggs.gnu.org ([2001:4830:134:3::10]:60215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ga3Eq-0005MD-7w
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:40:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ga3En-0001IV-0w
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:40:04 -0500
Date: Thu, 20 Dec 2018 13:39:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181220183059.20726-34-mst@redhat.com>
References: <20181220183059.20726-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220183059.20726-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v3 33/44] s390x/pci: rename hotplug handler
 callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, qemu-s390x@nongnu.org

From: David Hildenbrand <david@redhat.com>

The callbacks are also called for cold plugged devices. Drop the "hot"
to better match the actual callback names.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index f7458445c0..15759b6514 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -823,8 +823,8 @@ static bool s390_pci_alloc_idx(S390pciState *s, S390PCIBusDevice *pbdev)
     return true;
 }
 
-static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
-                                  DeviceState *dev, Error **errp)
+static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                              Error **errp)
 {
     PCIDevice *pdev = NULL;
     S390PCIBusDevice *pbdev = NULL;
@@ -932,8 +932,8 @@ static void s390_pcihost_timer_cb(void *opaque)
     qdev_unplug(DEVICE(pbdev), NULL);
 }
 
-static void s390_pcihost_hot_unplug(HotplugHandler *hotplug_dev,
-                                    DeviceState *dev, Error **errp)
+static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                                Error **errp)
 {
     PCIDevice *pci_dev = NULL;
     PCIBus *bus;
@@ -1041,8 +1041,8 @@ static void s390_pcihost_class_init(ObjectClass *klass, void *data)
 
     dc->reset = s390_pcihost_reset;
     dc->realize = s390_pcihost_realize;
-    hc->plug = s390_pcihost_hot_plug;
-    hc->unplug = s390_pcihost_hot_unplug;
+    hc->plug = s390_pcihost_plug;
+    hc->unplug = s390_pcihost_unplug;
     msi_nonbroken = true;
 }
 
-- 
MST
