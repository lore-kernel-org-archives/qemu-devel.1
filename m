Received: from eggs.gnu.org ([2001:4830:134:3::10]:59161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3t-0002ri-Oq
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3s-00021t-GB
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:49 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 12 Jun 2018 16:44:58 +1000
Message-Id: <20180612064503.14282-29-david@gibson.dropbear.id.au>
In-Reply-To: <20180612064503.14282-1-david@gibson.dropbear.id.au>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 28/33] spapr: introduce machine unplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: David Hildenbrand <david@redhat.com>

We'll be handling unplug of e.g. CPUs and PCDIMMs  via the general
hotplug handler soon, so let's add that handler function.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9b8b4068b1..c45f8bc75b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3584,6 +3584,11 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
     }
 }
 
+static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
+                                        DeviceState *dev, Error **errp)
+{
+}
+
 static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
                                                 DeviceState *dev, Error **errp)
 {
@@ -3978,6 +3983,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->get_default_cpu_node_id = spapr_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = spapr_possible_cpu_arch_ids;
     hc->unplug_request = spapr_machine_device_unplug_request;
+    hc->unplug = spapr_machine_device_unplug;
 
     smc->dr_lmb_enabled = true;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power8_v2.0");
-- 
2.17.1
