Received: from eggs.gnu.org ([2001:4830:134:3::10]:39343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ettTy-0000Wg-LO
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:13:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ettTv-0006my-Gc
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:13:10 -0500
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Thu, 8 Mar 2018 12:08:08 +0100
Message-Id: <20180308111305.C9F56745707@zero.eik.bme.hu>
Subject: [Qemu-devel] [PATCH] ppc440_pcix: Change some error_report to
 qemu_log_mask(LOG_UNIMP, ...)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>

Using log unimp is more appropriate for these messages and this also
silences them by default so they won't clobber make check output when
tests are added for this board.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/ppc440_pcix.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index ab2626a..fbffe82 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -286,8 +286,9 @@ static void ppc440_pcix_reg_write4(void *opaque, hwaddr addr,
         break;
 
     default:
-        error_report("%s: unhandled PCI internal register 0x%lx", __func__,
-                     (unsigned long)addr);
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: unhandled PCI internal register 0x%lx\n", __func__,
+                      (unsigned long)addr);
         break;
     }
 }
@@ -377,8 +378,9 @@ static uint64_t ppc440_pcix_reg_read4(void *opaque, hwaddr addr,
         break;
 
     default:
-        error_report("%s: invalid PCI internal register 0x%lx", __func__,
-                     (unsigned long)addr);
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: invalid PCI internal register 0x%lx\n", __func__,
+                      (unsigned long)addr);
         val = 0;
     }
 
-- 
2.7.6
