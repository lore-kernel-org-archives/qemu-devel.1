Received: from eggs.gnu.org ([2001:4830:134:3::10]:53199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixM-0003dI-Ez
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixJ-0004cN-C6
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:48 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Dec 2017 16:54:16 +1100
Message-Id: <20171215055435.24204-6-david@gibson.dropbear.id.au>
In-Reply-To: <20171215055435.24204-1-david@gibson.dropbear.id.au>
References: <20171215055435.24204-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 05/24] e500: name openpic and pci host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mdroth@linux.vnet.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Michael Davidsaver <mdavidsaver@gmail.com>

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/e500.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 5cf0dabef3..c4fe06ea2a 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -685,6 +685,8 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500Params *params,
     int i, j, k;
 
     dev = qdev_create(NULL, TYPE_OPENPIC);
+    object_property_add_child(qdev_get_machine(), "pic", OBJECT(dev),
+                              &error_fatal);
     qdev_prop_set_uint32(dev, "model", params->mpic_version);
     qdev_prop_set_uint32(dev, "nb_cpus", smp_cpus);
 
@@ -884,6 +886,8 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
 
     /* PCI */
     dev = qdev_create(NULL, "e500-pcihost");
+    object_property_add_child(qdev_get_machine(), "pci-host", OBJECT(dev),
+                              &error_abort);
     qdev_prop_set_uint32(dev, "first_slot", params->pci_first_slot);
     qdev_prop_set_uint32(dev, "first_pin_irq", pci_irq_nrs[0]);
     qdev_init_nofail(dev);
-- 
2.14.3
