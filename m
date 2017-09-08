Received: from eggs.gnu.org ([2001:4830:134:3::10]:58589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe1-00025c-Lp
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGdx-0003A2-1K
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:17 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:22 +1000
Message-Id: <20170908103558.31632-5-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 04/40] spapr_pci: use
 memory_region_add_subregion() with DMA windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Passing a null priority to memory_region_add_subregion_overlap() is
strictly equivalent to calling memory_region_add_subregion().

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index d84abf1070..d258bc08d5 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1752,8 +1752,8 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
                        i, sphb->dtbusname);
             return;
         }
-        memory_region_add_subregion_overlap(&sphb->iommu_root, 0,
-                                            spapr_tce_get_iommu(tcet), 0);
+        memory_region_add_subregion(&sphb->iommu_root, 0,
+                                    spapr_tce_get_iommu(tcet));
     }
 
     sphb->msi = g_hash_table_new_full(g_int_hash, g_int_equal, g_free, g_free);
-- 
2.13.5
