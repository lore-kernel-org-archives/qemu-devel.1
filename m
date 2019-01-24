Received: from eggs.gnu.org ([209.51.188.92]:44324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gmeSJ-00018P-A5
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:50:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gmeSG-00013k-Vd
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:50:02 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 24 Jan 2019 13:49:06 +0100
Message-Id: <20190124124906.16653-6-laurent@vivier.eu>
In-Reply-To: <20190124124906.16653-1-laurent@vivier.eu>
References: <20190124124906.16653-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 5/5] hw/i386/pc.c: fix one typo in function name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Wei Yang <richardw.yang@linux.intel.com>, Stefano Garzarella <sgarzare@redhat.com>

From: Wei Yang <richardw.yang@linux.intel.com>

Rename pc_get_hotpug_handler to pc_get_hotplug_handler.

No functional change.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20190124073626.20534-1-richardw.yang@linux.intel.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/i386/pc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 73d688f842..747548b7aa 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2285,7 +2285,7 @@ static void pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
     }
 }
 
-static HotplugHandler *pc_get_hotpug_handler(MachineState *machine,
+static HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
                                              DeviceState *dev)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
@@ -2615,7 +2615,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->save_tsc_khz = true;
     pcmc->linuxboot_dma_enabled = true;
     assert(!mc->get_hotplug_handler);
-    mc->get_hotplug_handler = pc_get_hotpug_handler;
+    mc->get_hotplug_handler = pc_get_hotplug_handler;
     mc->cpu_index_to_instance_props = pc_cpu_index_to_props;
     mc->get_default_cpu_node_id = pc_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = pc_possible_cpu_arch_ids;
-- 
2.20.1
