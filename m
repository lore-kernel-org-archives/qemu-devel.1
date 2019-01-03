Received: from eggs.gnu.org ([208.118.235.92]:58448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gf65B-0000jF-5l
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 11:42:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gf656-0007hh-En
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 11:42:57 -0500
Message-Id: <e77cddedf4ff8fbb1d5caf5d742b059ce93a99ee.1546532844.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1546532844.git.balaton@eik.bme.hu>
References: <cover.1546532844.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Thu, 03 Jan 2019 17:27:24 +0100
Subject: [Qemu-devel] [PATCH v3 4/6] ppc4xx: Rename ppc4xx_sdram_t in
 ppc440_uc.c to ppc440_sdram_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>

There's already a struct with the same name in ppc4xx_devs.c. They are
not used outside their files so don't clash but they are also not
identical so rename the ppc440 specific one to distinguish them.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc440_uc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 9360f781ce..e46f59fba8 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -481,7 +481,7 @@ void ppc4xx_sdr_init(CPUPPCState *env)
 
 /*****************************************************************************/
 /* SDRAM controller */
-typedef struct ppc4xx_sdram_t {
+typedef struct ppc440_sdram_t {
     uint32_t addr;
     int nbanks;
     MemoryRegion containers[4]; /* used for clipping */
@@ -489,7 +489,7 @@ typedef struct ppc4xx_sdram_t {
     hwaddr ram_bases[4];
     hwaddr ram_sizes[4];
     uint32_t bcr[4];
-} ppc4xx_sdram_t;
+} ppc440_sdram_t;
 
 enum {
     SDRAM0_CFGADDR = 0x10,
@@ -564,7 +564,7 @@ static target_ulong sdram_size(uint32_t bcr)
     return size;
 }
 
-static void sdram_set_bcr(ppc4xx_sdram_t *sdram,
+static void sdram_set_bcr(ppc440_sdram_t *sdram,
                           uint32_t *bcrp, uint32_t bcr, int enabled)
 {
     unsigned n = bcrp - sdram->bcr;
@@ -589,7 +589,7 @@ static void sdram_set_bcr(ppc4xx_sdram_t *sdram,
     }
 }
 
-static void sdram_map_bcr(ppc4xx_sdram_t *sdram)
+static void sdram_map_bcr(ppc440_sdram_t *sdram)
 {
     int i;
 
@@ -607,7 +607,7 @@ static void sdram_map_bcr(ppc4xx_sdram_t *sdram)
 
 static uint32_t dcr_read_sdram(void *opaque, int dcrn)
 {
-    ppc4xx_sdram_t *sdram = opaque;
+    ppc440_sdram_t *sdram = opaque;
     uint32_t ret = 0;
 
     switch (dcrn) {
@@ -658,7 +658,7 @@ static uint32_t dcr_read_sdram(void *opaque, int dcrn)
 
 static void dcr_write_sdram(void *opaque, int dcrn, uint32_t val)
 {
-    ppc4xx_sdram_t *sdram = opaque;
+    ppc440_sdram_t *sdram = opaque;
 
     switch (dcrn) {
     case SDRAM_R0BAS:
@@ -689,7 +689,7 @@ static void dcr_write_sdram(void *opaque, int dcrn, uint32_t val)
 
 static void sdram_reset(void *opaque)
 {
-    ppc4xx_sdram_t *sdram = opaque;
+    ppc440_sdram_t *sdram = opaque;
 
     sdram->addr = 0;
 }
@@ -699,7 +699,7 @@ void ppc440_sdram_init(CPUPPCState *env, int nbanks,
                        hwaddr *ram_bases, hwaddr *ram_sizes,
                        int do_init)
 {
-    ppc4xx_sdram_t *sdram;
+    ppc440_sdram_t *sdram;
 
     sdram = g_malloc0(sizeof(*sdram));
     sdram->nbanks = nbanks;
-- 
2.13.7
