Received: from eggs.gnu.org ([2001:4830:134:3::10]:43593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dXHp3-0007kh-7c
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 22:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dXHp0-0001ip-7d
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 22:01:13 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 18 Jul 2017 12:00:33 +1000
Message-Id: <20170718020033.8819-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] spapr_pci: Fix obsolete comment about
 MSIX encoding in addr/data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

f1c2dc7c866a "spapr-pci: rework MSI/MSIX" (07/2013) changed MSIX encoding
but forgot to change the comment so this changes it.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/ppc/spapr_pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index a52dcf8ec0..4b895c5a2a 100644
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
2.11.0
