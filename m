Received: from eggs.gnu.org ([2001:4830:134:3::10]:53690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gJc4U-0007Xt-PE
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 05:25:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gJc0V-0000jP-HG
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 05:21:21 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon,  5 Nov 2018 11:20:37 +0100
Message-Id: <20181105102044.20547-4-david@redhat.com>
In-Reply-To: <20181105102044.20547-1-david@redhat.com>
References: <20181105102044.20547-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 03/10] s390x/pci: rename hotplug handler
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>

The callbacks are also called for cold plugged devices. Drop the "hot"
to better match the actual callback names.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index e42e1b80d6..e1b14b131b 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -813,8 +813,8 @@ static bool s390_pci_alloc_idx(S390pciState *s, S390PCIBusDevice *pbdev)
     return true;
 }
 
-static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
-                                  DeviceState *dev, Error **errp)
+static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                              Error **errp)
 {
     PCIDevice *pdev = NULL;
     S390PCIBusDevice *pbdev = NULL;
@@ -923,8 +923,8 @@ static void s390_pcihost_timer_cb(void *opaque)
     qdev_unplug(DEVICE(pbdev), NULL);
 }
 
-static void s390_pcihost_hot_unplug(HotplugHandler *hotplug_dev,
-                                    DeviceState *dev, Error **errp)
+static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                                Error **errp)
 {
     PCIDevice *pci_dev = NULL;
     PCIBus *bus;
@@ -1032,8 +1032,8 @@ static void s390_pcihost_class_init(ObjectClass *klass, void *data)
 
     dc->reset = s390_pcihost_reset;
     dc->realize = s390_pcihost_realize;
-    hc->plug = s390_pcihost_hot_plug;
-    hc->unplug = s390_pcihost_hot_unplug;
+    hc->plug = s390_pcihost_plug;
+    hc->unplug = s390_pcihost_unplug;
     msi_nonbroken = true;
 }
 
-- 
2.17.2
