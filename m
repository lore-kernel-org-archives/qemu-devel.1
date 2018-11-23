Received: from eggs.gnu.org ([2001:4830:134:3::10]:44134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCj1-0000EA-LF
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCiw-0003Xa-4u
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:30 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gQCiu-0003T4-29
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:25 -0500
Received: by mail-wr1-x443.google.com with SMTP id x10so12591707wrs.8
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 06:46:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 23 Nov 2018 15:45:43 +0100
Message-Id: <20181123144558.5048-23-richard.henderson@linaro.org>
In-Reply-To: <20181123144558.5048-1-richard.henderson@linaro.org>
References: <20181123144558.5048-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 v2 22/37] tcg/ppc: Add constraints for
 R7-R8
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
 tcg/ppc/tcg-target.inc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 6377e3a829..484d90ead2 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -236,10 +236,11 @@ static inline void tcg_out_bc_noaddr(TCGContext *s, int insn)
 static const char *target_parse_constraint(TCGArgConstraint *ct,
                                            const char *ct_str, TCGType type)
 {
-    switch (*ct_str++) {
-    case 'A': case 'B': case 'C': case 'D':
+    char c = *ct_str++;
+    switch (c) {
+    case 'A': case 'B': case 'C': case 'D': case 'E': case 'F':
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set_reg(ct->u.regs, 3 + ct_str[0] - 'A');
+        tcg_regset_set_reg(ct->u.regs, 3 + c - 'A');
         break;
     case 'r':
         ct->ct |= TCG_CT_REG;
-- 
2.17.2
