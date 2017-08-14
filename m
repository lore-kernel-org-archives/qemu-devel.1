Received: from eggs.gnu.org ([2001:4830:134:3::10]:43176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhNOV-0002Xv-IM
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhNOS-0002wt-QD
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:59:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dhNOS-0002wW-HO
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:59:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6A8BB81DF6
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 21:59:27 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 14 Aug 2017 18:57:46 -0300
Message-Id: <20170814215748.5158-12-ehabkost@redhat.com>
In-Reply-To: <20170814215748.5158-1-ehabkost@redhat.com>
References: <20170814215748.5158-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v4 11/13] pci: enumerate_slots implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>

Enumerate each PCI function as a separate slots, because that's
how QEMU treats multi-function PCI devices.

Example output using "-machine q35" is below.

  {
    "available": true,
    "count": 224,
    "device-types": [ "pci-device" ],
    "hotpluggable": false,
    "opts": [
      { "option": "function", "values": [ [ 0, 7 ] ] },
      { "option": "device-number", "values": [ [ 3, 30 ] ] },
      { "option": "bus", "values": "pcie.0" }
    ],
    "opts-complete": true
  }
  {
    "available": false,
    "count": 1,
    "device": "/machine/unattached/device[30]",
    "device-types": [ "pci-device" ],
    "hotpluggable": false,
    "opts": [
      { "option": "function", "values": 0 },
      { "option": "device-number", "values": 2 },
      { "option": "bus", "values": "pcie.0" }
    ],
    "opts-complete": true
  }
  {
    "available": false,
    "count": 1,
    "device": "/machine/q35/mch",
    "device-types": [ "pci-device" ],
    "hotpluggable": false,
    "opts": [
      { "option": "function", "values": 0 },
      { "option": "device-number", "values": 0 },
      { "option": "bus", "values": "pcie.0" }
    ],
    "opts-complete": true
  }
  {
    "available": false,
    "count": 1,
    "device": "/machine/unattached/device[29]",
    "device-types": [ "pci-device" ],
    "hotpluggable": false,
    "opts": [
      { "option": "function", "values": 0 },
      { "option": "device-number", "values": 1 },
      { "option": "bus", "values": "pcie.0" }
    ],
    "opts-complete": true
  }
  {
    "available": false,
    "count": 1,
    "device": "/machine/unattached/device[3]",
    "device-types": [ "pci-device" ],
    "hotpluggable": false,
    "opts": [
      { "option": "function", "values": 0 },
      { "option": "device-number", "values": 31 },
      { "option": "bus", "values": "pcie.0" }
    ],
    "opts-complete": true
  }
  {
    "available": false,
    "count": 1,
    "device": "/machine/unattached/device[18]",
    "device-types": [ "pci-device" ],
    "hotpluggable": false,
    "opts": [
      { "option": "function", "values": 2 },
      { "option": "device-number", "values": 31 },
      { "option": "bus", "values": "pcie.0" }
    ],
    "opts-complete": true
  }
  {
    "available": false,
    "count": 1,
    "device": "/machine/unattached/device[20]",
    "device-types": [ "pci-device" ],
    "hotpluggable": false,
    "opts": [
      { "option": "function", "values": 3 },
      { "option": "device-number", "values": 31 },
      { "option": "bus", "values": "pcie.0" }
    ],
    "opts-complete": true
  }
  {
    "available": false,
    "count": 21,
    "device-types": [ "pci-device" ],
    "hotpluggable": false,
    "opts": [
      { "option": "function", "values": [ [ 1, 7 ] ] },
      { "option": "device-number", "values": [ [ 0, 2 ] ] },
      { "option": "bus", "values": "pcie.0" }
    ],
    "opts-complete": true
  }
  {
    "available": false,
    "count": 5,
    "device-types": [ "pci-device" ],
    "hotpluggable": false,
    "opts": [
      { "option": "function", "values": [ 1, [ 4, 7 ] ] },
      { "option": "device-number", "values": 31 },
      { "option": "bus", "values": "pcie.0" }
    ],
    "opts-complete": true
  }

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/pci/pci.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 5753af3..ae268a9 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -27,6 +27,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
+#include "hw/qdev-slotinfo.h"
 #include "monitor/monitor.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
@@ -144,6 +145,54 @@ static uint16_t pcibus_numa_node(PCIBus *bus)
     return NUMA_NODE_UNASSIGNED;
 }
 
+
+static bool pci_bus_has_pcie_upstream_port(PCIBus *bus);
+
+static DeviceSlotInfoList *pci_bus_enumerate_slots(BusState *bus)
+{
+    PCIBus *pb = PCI_BUS(bus);
+    int devnr, devnrs;
+    DeviceSlotInfoList *r = NULL;
+
+    if (pci_bus_has_pcie_upstream_port(pb)) {
+        devnrs = 1;
+    } else {
+        devnrs = PCI_SLOT_MAX;
+    }
+
+    /* Each PCI devfn (device number + function) is a separate slot,
+     * because we implement multi-function PCI devices as separate
+     * device objects.
+     */
+    for(devnr = PCI_SLOT(pb->devfn_min); devnr < devnrs; devnr++) {
+        PCIDevice *dev0 = pb->devices[PCI_DEVFN(devnr, 0)];
+        int func;
+
+        for (func = 0; func < PCI_FUNC_MAX; func++) {
+            /*TODO: add info about accepting only bridges on extra PCI root buses */
+            PCIDevice *dev = pb->devices[PCI_DEVFN(devnr, func)];
+            DeviceSlotInfo *s = make_slot(bus);
+            slot_add_opt_int(s, "device-number", devnr);
+            slot_add_opt_int(s, "function", func);
+            s->opts_complete = true;
+            s->has_count = true;
+            s->count = 1;
+            /* Conditions that make a devnr unavailable:
+             * - function already occupied
+             * - function 0 already occupied by a device
+             */
+            s->available &= !dev0 && !dev;
+            if (dev) {
+                s->has_device = true;
+                s->device = object_get_canonical_path(OBJECT(dev));
+            }
+            slot_list_add_slot(&r, s);
+        }
+    }
+
+    return r;
+}
+
 static void pci_bus_class_init(ObjectClass *klass, void *data)
 {
     BusClass *k = BUS_CLASS(klass);
@@ -156,6 +205,7 @@ static void pci_bus_class_init(ObjectClass *klass, void *data)
     k->unrealize = pci_bus_unrealize;
     k->reset = pcibus_reset;
     k->device_type = TYPE_PCI_DEVICE;
+    k->enumerate_slots = pci_bus_enumerate_slots;
 
     pbc->is_root = pcibus_is_root;
     pbc->bus_num = pcibus_num;
-- 
2.9.4
