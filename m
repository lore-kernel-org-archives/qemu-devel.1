Received: from eggs.gnu.org ([2001:4830:134:3::10]:55041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fVGtQ-0002qQ-V9
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fVGtM-00049i-TE
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:41:56 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue, 19 Jun 2018 15:41:31 +0200
Message-Id: <20180619134141.29478-3-david@redhat.com>
In-Reply-To: <20180619134141.29478-1-david@redhat.com>
References: <20180619134141.29478-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v5 02/12] pc: rename pc_dimm_(plug|unplug|...)*
 into pc_memory_(plug|unplug|...)*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

Use a similar naming scheme as spapr. This way, we can go ahead and
rename e.g. pc_dimm_memory_plug to pc_dimm_plug, which avoids
confusion.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/pc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 622e49d6bc..f9250ffae7 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1674,8 +1674,8 @@ void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name)
     }
 }
 
-static void pc_dimm_plug(HotplugHandler *hotplug_dev,
-                         DeviceState *dev, Error **errp)
+static void pc_memory_plug(HotplugHandler *hotplug_dev,
+                           DeviceState *dev, Error **errp)
 {
     HotplugHandlerClass *hhc;
     Error *local_err = NULL;
@@ -1728,8 +1728,8 @@ out:
     error_propagate(errp, local_err);
 }
 
-static void pc_dimm_unplug_request(HotplugHandler *hotplug_dev,
-                                   DeviceState *dev, Error **errp)
+static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
+                                     DeviceState *dev, Error **errp)
 {
     HotplugHandlerClass *hhc;
     Error *local_err = NULL;
@@ -1759,8 +1759,8 @@ out:
     error_propagate(errp, local_err);
 }
 
-static void pc_dimm_unplug(HotplugHandler *hotplug_dev,
-                           DeviceState *dev, Error **errp)
+static void pc_memory_unplug(HotplugHandler *hotplug_dev,
+                             DeviceState *dev, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
     HotplugHandlerClass *hhc;
@@ -2015,7 +2015,7 @@ static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                                       DeviceState *dev, Error **errp)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
-        pc_dimm_plug(hotplug_dev, dev, errp);
+        pc_memory_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         pc_cpu_plug(hotplug_dev, dev, errp);
     }
@@ -2025,7 +2025,7 @@ static void pc_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
                                                 DeviceState *dev, Error **errp)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
-        pc_dimm_unplug_request(hotplug_dev, dev, errp);
+        pc_memory_unplug_request(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         pc_cpu_unplug_request_cb(hotplug_dev, dev, errp);
     } else {
@@ -2038,7 +2038,7 @@ static void pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
-        pc_dimm_unplug(hotplug_dev, dev, errp);
+        pc_memory_unplug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         pc_cpu_unplug_cb(hotplug_dev, dev, errp);
     } else {
-- 
2.17.1
