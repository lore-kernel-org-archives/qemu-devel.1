Received: from eggs.gnu.org ([2001:4830:134:3::10]:54158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK3E-0003ZX-L2
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK3B-0004z6-1y
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:19 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gMK3A-0004yW-Rj
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:16 -0500
Received: by mail-wr1-x442.google.com with SMTP id u5-v6so5737988wrn.9
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 13:47:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 12 Nov 2018 22:44:54 +0100
Message-Id: <20181112214503.22941-9-richard.henderson@linaro.org>
In-Reply-To: <20181112214503.22941-1-richard.henderson@linaro.org>
References: <20181112214503.22941-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 08/17] tcg/aarch64: Add constraints for
 x0, x1, x2
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
 tcg/aarch64/tcg-target.inc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 30091f6a69..148de0b7f2 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -125,6 +125,18 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
                                            const char *ct_str, TCGType type)
 {
     switch (*ct_str++) {
+    case 'a': /* x0 */
+        ct->ct |= TCG_CT_REG;
+        tcg_regset_set_reg(ct->u.regs, TCG_REG_X0);
+        break;
+    case 'b': /* x1 */
+        ct->ct |= TCG_CT_REG;
+        tcg_regset_set_reg(ct->u.regs, TCG_REG_X1);
+        break;
+    case 'c': /* x2 */
+        ct->ct |= TCG_CT_REG;
+        tcg_regset_set_reg(ct->u.regs, TCG_REG_X2);
+        break;
     case 'r': /* general registers */
         ct->ct |= TCG_CT_REG;
         ct->u.regs |= 0xffffffffu;
-- 
2.17.2
