Received: from eggs.gnu.org ([2001:4830:134:3::10]:55873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQy9N-0002tX-Cc
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 12:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQy9L-0001zN-Lj
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 12:52:37 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Jun 2018 18:52:15 +0200
Message-Id: <20180607165218.9558-6-david@redhat.com>
In-Reply-To: <20180607165218.9558-1-david@redhat.com>
References: <20180607165218.9558-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 5/8] spapr: introduce machine unplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, david@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Greg Kurz <groug@kaod.org>

We'll be handling unplug of e.g. CPUs and PCDIMMs  via the general
hotplug handler soon, so let's add that handler function.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/ppc/spapr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4447cb197f..bcb72d9fa7 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3586,6 +3586,11 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
     error_propagate(errp, local_err);
 }
 
+static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
+                                        DeviceState *dev, Error **errp)
+{
+}
+
 static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
                                                 DeviceState *dev, Error **errp)
 {
@@ -3988,6 +3993,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->get_default_cpu_node_id = spapr_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = spapr_possible_cpu_arch_ids;
     hc->unplug_request = spapr_machine_device_unplug_request;
+    hc->unplug = spapr_machine_device_unplug;
 
     smc->dr_lmb_enabled = true;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power8_v2.0");
-- 
2.17.0
