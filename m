Received: from eggs.gnu.org ([2001:4830:134:3::10]:54122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdIA-0001qE-8U
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 22:46:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdI9-0005Xc-Da
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 22:46:42 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdI9-0005X7-6Z
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 22:46:41 -0500
Received: by mail-pg0-x241.google.com with SMTP id b1so2444556pgc.1
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 19:46:41 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 19:46:37 -0800
Message-Id: <20161224034637.12207-3-rth@twiddle.net>
In-Reply-To: <20161224034637.12207-1-rth@twiddle.net>
References: <20161224034637.12207-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 2/2] tcg/s390: Remove 'R' constraint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Since R0 is reserved, we don't need a special case constraint.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/s390/tcg-target.inc.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 23115b5..8d5d2bd 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -378,11 +378,6 @@ static int target_parse_constraint(TCGArgConstraint *ct, const char **pct_str)
         ct->ct |= TCG_CT_REG;
         tcg_regset_set32(ct->u.regs, 0, 0xffff);
         break;
-    case 'R':                  /* not R0 */
-        ct->ct |= TCG_CT_REG;
-        tcg_regset_set32(ct->u.regs, 0, 0xffff);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R0);
-        break;
     case 'L':                  /* qemu_ld/st constraint */
         ct->ct |= TCG_CT_REG;
         tcg_regset_set32(ct->u.regs, 0, 0xffff);
@@ -2226,12 +2221,12 @@ static const TCGTargetOpDef s390_op_defs[] = {
 
     { INDEX_op_neg_i32, { "r", "r" } },
 
-    { INDEX_op_shl_i32, { "r", "0", "Ri" } },
-    { INDEX_op_shr_i32, { "r", "0", "Ri" } },
-    { INDEX_op_sar_i32, { "r", "0", "Ri" } },
+    { INDEX_op_shl_i32, { "r", "0", "ri" } },
+    { INDEX_op_shr_i32, { "r", "0", "ri" } },
+    { INDEX_op_sar_i32, { "r", "0", "ri" } },
 
-    { INDEX_op_rotl_i32, { "r", "r", "Ri" } },
-    { INDEX_op_rotr_i32, { "r", "r", "Ri" } },
+    { INDEX_op_rotl_i32, { "r", "r", "ri" } },
+    { INDEX_op_rotr_i32, { "r", "r", "ri" } },
 
     { INDEX_op_ext8s_i32, { "r", "r" } },
     { INDEX_op_ext8u_i32, { "r", "r" } },
@@ -2281,12 +2276,12 @@ static const TCGTargetOpDef s390_op_defs[] = {
 
     { INDEX_op_neg_i64, { "r", "r" } },
 
-    { INDEX_op_shl_i64, { "r", "r", "Ri" } },
-    { INDEX_op_shr_i64, { "r", "r", "Ri" } },
-    { INDEX_op_sar_i64, { "r", "r", "Ri" } },
+    { INDEX_op_shl_i64, { "r", "r", "ri" } },
+    { INDEX_op_shr_i64, { "r", "r", "ri" } },
+    { INDEX_op_sar_i64, { "r", "r", "ri" } },
 
-    { INDEX_op_rotl_i64, { "r", "r", "Ri" } },
-    { INDEX_op_rotr_i64, { "r", "r", "Ri" } },
+    { INDEX_op_rotl_i64, { "r", "r", "ri" } },
+    { INDEX_op_rotr_i64, { "r", "r", "ri" } },
 
     { INDEX_op_ext8s_i64, { "r", "r" } },
     { INDEX_op_ext8u_i64, { "r", "r" } },
-- 
2.9.3
