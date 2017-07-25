Received: from eggs.gnu.org ([2001:4830:134:3::10]:51558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZser-0000Yu-3O
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 01:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZseo-0006FX-1K
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 01:45:25 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 25 Jul 2017 15:45:07 +1000
Message-Id: <20170725054510.15177-2-david@gibson.dropbear.id.au>
In-Reply-To: <20170725054510.15177-1-david@gibson.dropbear.id.au>
References: <20170725054510.15177-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 1/4] spapr_pci: Fix obsolete comment about MSIX
 encoding in addr/data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, lvivier@redhat.com, groug@kaod.org, bharata@linux.vnet.ibm.com, thuth@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

f1c2dc7c866a "spapr-pci: rework MSI/MSIX" (07/2013) changed MSIX encoding
but forgot to change the comment so this changes it.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 6ecdf29d28..d84abf1070 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -723,9 +723,7 @@ static PCIINTxRoute spapr_route_intx_pin_to_irq(void *opaque, int pin)
 /*
  * MSI/MSIX memory region implementation.
  * The handler handles both MSI and MSIX.
- * For MSI-X, the vector number is encoded as a part of the address,
- * data is set to 0.
- * For MSI, the vector number is encoded in least bits in data.
+ * The vector number is encoded in least bits in data.
  */
 static void spapr_msi_write(void *opaque, hwaddr addr,
                             uint64_t data, unsigned size)
-- 
2.13.3
