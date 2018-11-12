Received: from eggs.gnu.org ([2001:4830:134:3::10]:54334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK3W-0004bP-UZ
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK3M-00056B-C9
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:30 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gMK3K-000523-FY
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:26 -0500
Received: by mail-wr1-x441.google.com with SMTP id 74-v6so10991509wrb.13
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 13:47:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 12 Nov 2018 22:45:00 +0100
Message-Id: <20181112214503.22941-15-richard.henderson@linaro.org>
In-Reply-To: <20181112214503.22941-1-richard.henderson@linaro.org>
References: <20181112214503.22941-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 14/17] tcg/arm: Add constraints for
 R0-R5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

These are function call arguments that we will need soon.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.inc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 414c91c9ea..4339c472e8 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -246,7 +246,12 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
 static const char *target_parse_constraint(TCGArgConstraint *ct,
                                            const char *ct_str, TCGType type)
 {
-    switch (*ct_str++) {
+    char c = *ct_str++;
+    switch (c) {
+    case 'a' ... 'f': /* r0 - r5 */
+        ct->ct |= TCG_CT_REG;
+        tcg_regset_set_reg(ct->u.regs, TCG_REG_R0 + (c - 'a'));
+        break;
     case 'I':
         ct->ct |= TCG_CT_CONST_ARM;
         break;
-- 
2.17.2
