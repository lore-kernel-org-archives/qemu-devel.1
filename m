Received: from eggs.gnu.org ([2001:4830:134:3::10]:33305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVCgM-0002vR-8s
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVCgH-0007w6-EB
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:12:10 -0400
Message-Id: <453290537c0f31507ea5e44ac824f45427b9ac1e.1529398335.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1529398335.git.balaton@eik.bme.hu>
References: <cover.1529398335.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Tue, 19 Jun 2018 10:52:15 +0200
Subject: [Qemu-devel] [PATCH v4 06/11] target/ppc: Add missing opcode for
 icbt on PPC440
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

According to PPC440 User Manual PPC440 has multiple opcodes for icbt
instruction: one for compatibility with older cores and two 440
specific opcodes one of which is defined in BookE. QEMU only
implements two of these, add the missing one.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
v4: Updated commit message, for reference see bottom of:
http://manualzilla.com/doc/6915682/ppc440-processor-user-s-manual?page=451

 target/ppc/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 5fe1ba6..3a215a1 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6707,6 +6707,8 @@ GEN_HANDLER_E(mbar, 0x1F, 0x16, 0x1a, 0x001FF801,
 GEN_HANDLER(msync_4xx, 0x1F, 0x16, 0x12, 0x03FFF801, PPC_BOOKE),
 GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x03E00001,
                PPC_BOOKE, PPC2_BOOKE206),
+GEN_HANDLER2(icbt_440, "icbt", 0x1F, 0x06, 0x08, 0x03E00001,
+               PPC_440_SPEC),
 GEN_HANDLER(lvsl, 0x1f, 0x06, 0x00, 0x00000001, PPC_ALTIVEC),
 GEN_HANDLER(lvsr, 0x1f, 0x06, 0x01, 0x00000001, PPC_ALTIVEC),
 GEN_HANDLER(mfvscr, 0x04, 0x2, 0x18, 0x001ff800, PPC_ALTIVEC),
-- 
2.7.6
