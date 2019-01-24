Received: from eggs.gnu.org ([209.51.188.92]:35133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gmZZW-0001aY-Ub
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 02:37:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gmZZV-0000Yq-15
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 02:37:10 -0500
Received: from mga04.intel.com ([192.55.52.120]:50604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1gmZZU-0000CF-8m
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 02:37:08 -0500
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Thu, 24 Jan 2019 15:36:26 +0800
Message-Id: <20190124073626.20534-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/i386/pc.c: fix one typo in function name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, Wei Yang <richardw.yang@linux.intel.com>

Rename pc_get_hotpug_handler to pc_get_hotplug_handler.

No functional change.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 hw/i386/pc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 115bc2825c..5317e08f60 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2059,7 +2059,7 @@ static void pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
     }
 }
 
-static HotplugHandler *pc_get_hotpug_handler(MachineState *machine,
+static HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
                                              DeviceState *dev)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
@@ -2389,7 +2389,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->save_tsc_khz = true;
     pcmc->linuxboot_dma_enabled = true;
     assert(!mc->get_hotplug_handler);
-    mc->get_hotplug_handler = pc_get_hotpug_handler;
+    mc->get_hotplug_handler = pc_get_hotplug_handler;
     mc->cpu_index_to_instance_props = pc_cpu_index_to_props;
     mc->get_default_cpu_node_id = pc_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = pc_possible_cpu_arch_ids;
-- 
2.19.1
