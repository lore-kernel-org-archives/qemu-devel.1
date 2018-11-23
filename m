Received: from eggs.gnu.org ([2001:4830:134:3::10]:44028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCis-0008Gf-3n
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCio-0003Ng-4g
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:20 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36673)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gQCin-0003Ma-OT
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:17 -0500
Received: by mail-wm1-x343.google.com with SMTP id s11so12262861wmh.1
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 06:46:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 23 Nov 2018 15:45:37 +0100
Message-Id: <20181123144558.5048-17-richard.henderson@linaro.org>
In-Reply-To: <20181123144558.5048-1-richard.henderson@linaro.org>
References: <20181123144558.5048-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 v2 16/37] tcg/arm: Add constraints for
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
Cc: Alistair.Francis@wdc.com

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
