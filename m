Received: from eggs.gnu.org ([2001:4830:134:3::10]:56207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1exim7-0006Z0-0r
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 20:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1exim5-0000Mm-RA
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 20:35:43 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 19 Mar 2018 11:35:23 +1100
Message-Id: <20180319003524.28143-8-david@gibson.dropbear.id.au>
In-Reply-To: <20180319003524.28143-1-david@gibson.dropbear.id.au>
References: <20180319003524.28143-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 7/8] ppc440_pcix: Change some error_report to
 qemu_log_mask(LOG_UNIMP, ...)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, lvivier@redhat.com, surajjs@au1.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

Using log unimp is more appropriate for these messages and this also
silences them by default so they won't clobber make check output when
tests are added for this board.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc440_pcix.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index ab2626a9de..b1307e6477 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -21,6 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/log.h"
 #include "hw/hw.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
@@ -286,8 +287,9 @@ static void ppc440_pcix_reg_write4(void *opaque, hwaddr addr,
         break;
 
     default:
-        error_report("%s: unhandled PCI internal register 0x%lx", __func__,
-                     (unsigned long)addr);
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: unhandled PCI internal register 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
         break;
     }
 }
@@ -377,8 +379,9 @@ static uint64_t ppc440_pcix_reg_read4(void *opaque, hwaddr addr,
         break;
 
     default:
-        error_report("%s: invalid PCI internal register 0x%lx", __func__,
-                     (unsigned long)addr);
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: invalid PCI internal register 0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
         val = 0;
     }
 
-- 
2.14.3
