Received: from eggs.gnu.org ([2001:4830:134:3::10]:52796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1f0FmW-0000Sh-67
	for qemu-devel@nongnu.org; Sun, 25 Mar 2018 20:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1f0FmS-0003OA-4c
	for qemu-devel@nongnu.org; Sun, 25 Mar 2018 20:14:36 -0400
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Mon, 26 Mar 2018 01:54:28 +0200
Message-Id: <20180326001421.0E0937456D7@zero.eik.bme.hu>
Subject: [Qemu-devel] [PATCH] target/ppc: Fix reserved bit mask of dstst
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

According to the Vector/SIMD extension documentation bit 6 that is
currently masked is valid (listed as transient bit) but bits 7 and 8
should be reserved instead. Fix the mask to match this.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3457d29..b0d79a3 100644
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
2.7.6
