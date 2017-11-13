Received: from eggs.gnu.org ([2001:4830:134:3::10]:56380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eENNe-00022O-3u
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 17:39:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eENNd-0006qy-0c
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 17:39:02 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 13 Nov 2017 14:34:45 -0800
Message-ID: <e5b06e7b283106c82aee47044d4d0475718d8a78.1510612380.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1510612380.git.alistair.francis@xilinx.com>
References: <cover.1510612380.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 03/29] Fixes after renaming __FUNCTION__ to
 __func__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, Eric Blake <eblake@redhat.com>

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: Eric Blake <eblake@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
V3:
 - Squash onto single lines
 - Don't fix indentation of case in omap_prcm_apll_update()

 hw/arm/omap1.c     | 8 +++-----
 hw/block/onenand.c | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 1388200191..92e58f09c8 100644
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
index e243182394..ed77f859e9 100644
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
2.14.1
