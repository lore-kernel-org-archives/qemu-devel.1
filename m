Received: from eggs.gnu.org ([2001:4830:134:3::10]:43784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fG6T2-00081U-2M
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fG6T0-0005Fc-2R
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:00 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:38801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fG6Sz-0005FJ-R9
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:31:58 -0400
Received: by mail-lf0-x244.google.com with SMTP id z142-v6so3769917lff.5
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 10:31:57 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue,  8 May 2018 19:31:17 +0200
Message-Id: <20180508173152.29327-2-edgar.iglesias@gmail.com>
In-Reply-To: <20180508173152.29327-1-edgar.iglesias@gmail.com>
References: <20180508173152.29327-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 01/36] target-microblaze: dec_load: Use bool
 instead of unsigned int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Use bool instead of unsigned int to represent flags.
No functional change.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 100883e2cc..33f21aa5b7 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -897,14 +897,15 @@ static inline TCGv *compute_ldst_addr(DisasContext *dc, TCGv *t)
 static void dec_load(DisasContext *dc)
 {
     TCGv t, v, *addr;
-    unsigned int size, rev = 0, ex = 0;
+    unsigned int size;
+    bool rev = false, ex = false;
     TCGMemOp mop;
 
     mop = dc->opcode & 3;
     size = 1 << mop;
     if (!dc->type_b) {
-        rev = (dc->ir >> 9) & 1;
-        ex = (dc->ir >> 10) & 1;
+        rev = extract32(dc->ir, 9, 1);
+        ex = extract32(dc->ir, 10, 1);
     }
     mop |= MO_TE;
     if (rev) {
-- 
2.14.1
