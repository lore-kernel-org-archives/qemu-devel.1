Received: from eggs.gnu.org ([2001:4830:134:3::10]:33479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eWabd-0001Da-6V
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 23:24:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eWabb-0001zz-5d
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 23:24:45 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  3 Jan 2018 15:24:17 +1100
Message-Id: <20180103042419.14520-14-david@gibson.dropbear.id.au>
In-Reply-To: <20180103042419.14520-1-david@gibson.dropbear.id.au>
References: <20180103042419.14520-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 13/15] spapr_pci: use warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

These two are definitely warnings. Let's use the appropriate API.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c      | 6 +++---
 hw/ppc/spapr_pci_vfio.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 88797b3d36..695c820911 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1696,9 +1696,9 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     /* DMA setup */
     if (((sphb->page_size_mask & qemu_getrampagesize()) == 0)
         && kvm_enabled()) {
-        error_report("System page size 0x%lx is not enabled in page_size_mask "
-                     "(0x%"PRIx64"). Performance may be slow",
-                     qemu_getrampagesize(), sphb->page_size_mask);
+        warn_report("System page size 0x%lx is not enabled in page_size_mask "
+                    "(0x%"PRIx64"). Performance may be slow",
+                    qemu_getrampagesize(), sphb->page_size_mask);
     }
 
     for (i = 0; i < windows_supported; ++i) {
diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index 8448e0b024..1f775ea93d 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -50,7 +50,7 @@ static Property spapr_phb_vfio_properties[] = {
 static void spapr_phb_vfio_instance_init(Object *obj)
 {
     if (!qtest_enabled()) {
-        error_report("spapr-pci-vfio-host-bridge is deprecated");
+        warn_report("spapr-pci-vfio-host-bridge is deprecated");
     }
 }
 
-- 
2.14.3
