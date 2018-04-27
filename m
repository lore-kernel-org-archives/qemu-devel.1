Received: from eggs.gnu.org ([2001:4830:134:3::10]:59363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBza3-0001dw-Hu
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBza2-00023u-Hq
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:15 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:21:01 +1000
Message-Id: <20180427092126.24812-25-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 24/49] target/ppc: Fix reserved bit mask of
 dstst instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

According to the Vector/SIMD extension documentation bit 6 that is
currently masked is valid (listed as transient bit) but bits 7 and 8
should be reserved instead. Fix the mask to match this.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3457d29f8e..b0d79a3fb9 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6561,7 +6561,7 @@ GEN_HANDLER(dcbtst, 0x1F, 0x16, 0x07, 0x00000001, PPC_CACHE),
 GEN_HANDLER_E(dcbtls, 0x1F, 0x06, 0x05, 0x02000001, PPC_BOOKE, PPC2_BOOKE206),
 GEN_HANDLER(dcbz, 0x1F, 0x16, 0x1F, 0x03C00001, PPC_CACHE_DCBZ),
 GEN_HANDLER(dst, 0x1F, 0x16, 0x0A, 0x01800001, PPC_ALTIVEC),
-GEN_HANDLER(dstst, 0x1F, 0x16, 0x0B, 0x02000001, PPC_ALTIVEC),
+GEN_HANDLER(dstst, 0x1F, 0x16, 0x0B, 0x01800001, PPC_ALTIVEC),
 GEN_HANDLER(dss, 0x1F, 0x16, 0x19, 0x019FF801, PPC_ALTIVEC),
 GEN_HANDLER(icbi, 0x1F, 0x16, 0x1E, 0x03E00001, PPC_CACHE_ICBI),
 GEN_HANDLER(dcba, 0x1F, 0x16, 0x17, 0x03E00001, PPC_CACHE_DCBA),
-- 
2.14.3
