Received: from eggs.gnu.org ([2001:4830:134:3::10]:42590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1edaFz-0002o3-O9
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:27:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1edaFy-0007IS-TK
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:27:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1edaFy-0007IA-No
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:27:18 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 22 Jan 2018 12:27:03 +0100
Message-Id: <1516620426-18530-7-git-send-email-thuth@redhat.com>
In-Reply-To: <1516620426-18530-1-git-send-email-thuth@redhat.com>
References: <1516620426-18530-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 6/9] Fixes after renaming __FUNCTION__ to
 __func__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>

From: Alistair Francis <alistair.francis@xilinx.com>

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: Eric Blake <eblake@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/omap1.c     | 8 +++-----
 hw/block/onenand.c | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 1388200..92e58f0 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -1717,7 +1717,7 @@ static void omap_clkm_write(void *opaque, hwaddr addr,
         if ((s->clkm.clocking_scheme ^ (value >> 11)) & 7) {
             s->clkm.clocking_scheme = (value >> 11) & 7;
             printf("%s: clocking scheme set to %s\n", __func__,
-                            clkschemename[s->clkm.clocking_scheme]);
+                   clkschemename[s->clkm.clocking_scheme]);
         }
         s->clkm.cold_start &= value & 0x3f;
         return;
@@ -3329,14 +3329,12 @@ static void omap_mcbsp_writeh(void *opaque, hwaddr addr,
     case 0x18:	/* MCR2 */
         s->mcr[1] = value & 0x03e3;
         if (value & 3)					/* XMCM */
-            printf("%s: Tx channel selection mode enable attempt\n",
-                            __func__);
+            printf("%s: Tx channel selection mode enable attempt\n", __func__);
         return;
     case 0x1a:	/* MCR1 */
         s->mcr[0] = value & 0x03e1;
         if (value & 1)					/* RMCM */
-            printf("%s: Rx channel selection mode enable attempt\n",
-                            __func__);
+            printf("%s: Rx channel selection mode enable attempt\n", __func__);
         return;
     case 0x1c:	/* RCERA */
         s->rcer[0] = value & 0xffff;
diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index e243182..ed77f85 100644
--- a/hw/block/onenand.c
+++ b/hw/block/onenand.c
@@ -659,7 +659,7 @@ static uint64_t onenand_read(void *opaque, hwaddr addr,
     case 0xff02:	/* ECC Result of spare area data */
     case 0xff03:	/* ECC Result of main area data */
     case 0xff04:	/* ECC Result of spare area data */
-        hw_error("%s: imeplement ECC\n", __func__);
+        hw_error("%s: implement ECC\n", __func__);
         return 0x0000;
     }
 
-- 
1.8.3.1
