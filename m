Received: from eggs.gnu.org ([2001:4830:134:3::10]:37360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eGcha-0001ha-K0
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:24:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eGchZ-0006V3-O7
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:24:54 -0500
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sun, 19 Nov 2017 21:24:13 -0600
Message-Id: <20171120032420.9134-6-mdavidsaver@gmail.com>
In-Reply-To: <20171120032420.9134-1-mdavidsaver@gmail.com>
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 05/12] e500: name openpic and pci host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 hw/ppc/e500.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 057be1751b..6f77844303 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -685,6 +685,8 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500Params *params,
     int i, j, k;
 
     dev = qdev_create(NULL, TYPE_OPENPIC);
+    object_property_add_child(qdev_get_machine(), "pic", OBJECT(dev),
+                              &error_fatal);
     qdev_prop_set_uint32(dev, "model", params->mpic_version);
     qdev_prop_set_uint32(dev, "nb_cpus", smp_cpus);
 
@@ -876,6 +878,8 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
 
     /* PCI */
     dev = qdev_create(NULL, "e500-pcihost");
+    object_property_add_child(qdev_get_machine(), "pci-host", OBJECT(dev),
+                              &error_abort);
     qdev_prop_set_uint32(dev, "first_slot", params->pci_first_slot);
     qdev_prop_set_uint32(dev, "first_pin_irq", pci_irq_nrs[0]);
     qdev_init_nofail(dev);
-- 
2.11.0
