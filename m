Received: from eggs.gnu.org ([2001:4830:134:3::10]:43910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCij-00080W-RF
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCih-0003Du-Qz
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:13 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gQCih-0003CZ-Iw
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:11 -0500
Received: by mail-wm1-x344.google.com with SMTP id y185so7737542wmd.1
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 06:46:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 23 Nov 2018 15:45:31 +0100
Message-Id: <20181123144558.5048-11-richard.henderson@linaro.org>
In-Reply-To: <20181123144558.5048-1-richard.henderson@linaro.org>
References: <20181123144558.5048-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 v2 10/37] tcg/aarch64: Add constraints
 for x0, x1, x2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com

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
