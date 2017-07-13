Received: from eggs.gnu.org ([2001:4830:134:3::10]:47473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dVXVn-0008My-VV
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 02:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dVXVk-0006JC-N5
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 02:22:07 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 13 Jul 2017 16:21:28 +1000
Message-Id: <20170713062128.38954-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] ppc/pnv: Remove unused XICSState reference
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

e6f7e110ee70 "ppc/xics: remove the XICSState classes" got rid of
XICSState, this is just an leftover.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/hw/ppc/pnv_psi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
index 11d83e43f8..f6af5eae1f 100644
--- a/include/hw/ppc/pnv_psi.h
+++ b/include/hw/ppc/pnv_psi.h
@@ -28,8 +28,6 @@
 
 #define PSIHB_XSCOM_MAX         0x20
 
-typedef struct XICSState XICSState;
-
 typedef struct PnvPsi {
     SysBusDevice parent;
 
-- 
2.11.0
