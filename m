Received: from eggs.gnu.org ([209.51.188.92]:38313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8g-0000bV-55
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8d-0007bQ-Qv
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:02 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:00:52 +1100
Message-Id: <20190204090124.26191-6-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/37] ppc4xx: Rename ppc4xx_sdram_t in
 ppc440_uc.c to ppc440_sdram_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

There's already a struct with the same name in ppc4xx_devs.c. They are
not used outside their files so don't clash but they are also not
identical so rename the ppc440 specific one to distinguish them.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc440_uc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 9360f781ce..e46f59fba8 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -481,7 +481,7 @@ void ppc4xx_sdr_init(CPUPPCState *env)
=20
 /***********************************************************************=
******/
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
=20
 enum {
     SDRAM0_CFGADDR =3D 0x10,
@@ -564,7 +564,7 @@ static target_ulong sdram_size(uint32_t bcr)
     return size;
 }
=20
-static void sdram_set_bcr(ppc4xx_sdram_t *sdram,
+static void sdram_set_bcr(ppc440_sdram_t *sdram,
                           uint32_t *bcrp, uint32_t bcr, int enabled)
 {
     unsigned n =3D bcrp - sdram->bcr;
@@ -589,7 +589,7 @@ static void sdram_set_bcr(ppc4xx_sdram_t *sdram,
     }
 }
=20
-static void sdram_map_bcr(ppc4xx_sdram_t *sdram)
+static void sdram_map_bcr(ppc440_sdram_t *sdram)
 {
     int i;
=20
@@ -607,7 +607,7 @@ static void sdram_map_bcr(ppc4xx_sdram_t *sdram)
=20
 static uint32_t dcr_read_sdram(void *opaque, int dcrn)
 {
-    ppc4xx_sdram_t *sdram =3D opaque;
+    ppc440_sdram_t *sdram =3D opaque;
     uint32_t ret =3D 0;
=20
     switch (dcrn) {
@@ -658,7 +658,7 @@ static uint32_t dcr_read_sdram(void *opaque, int dcrn=
)
=20
 static void dcr_write_sdram(void *opaque, int dcrn, uint32_t val)
 {
-    ppc4xx_sdram_t *sdram =3D opaque;
+    ppc440_sdram_t *sdram =3D opaque;
=20
     switch (dcrn) {
     case SDRAM_R0BAS:
@@ -689,7 +689,7 @@ static void dcr_write_sdram(void *opaque, int dcrn, u=
int32_t val)
=20
 static void sdram_reset(void *opaque)
 {
-    ppc4xx_sdram_t *sdram =3D opaque;
+    ppc440_sdram_t *sdram =3D opaque;
=20
     sdram->addr =3D 0;
 }
@@ -699,7 +699,7 @@ void ppc440_sdram_init(CPUPPCState *env, int nbanks,
                        hwaddr *ram_bases, hwaddr *ram_sizes,
                        int do_init)
 {
-    ppc4xx_sdram_t *sdram;
+    ppc440_sdram_t *sdram;
=20
     sdram =3D g_malloc0(sizeof(*sdram));
     sdram->nbanks =3D nbanks;
--=20
2.20.1
