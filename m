Received: from eggs.gnu.org ([2001:4830:134:3::10]:43797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCig-0007yX-E0
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCif-00039z-Is
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:10 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gQCid-00037I-J7
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:09 -0500
Received: by mail-wm1-x342.google.com with SMTP id y139so12074450wmc.5
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 06:46:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 23 Nov 2018 15:45:26 +0100
Message-Id: <20181123144558.5048-6-richard.henderson@linaro.org>
In-Reply-To: <20181123144558.5048-1-richard.henderson@linaro.org>
References: <20181123144558.5048-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 v2 05/37] tcg/i386: Add constraints for
 r8 and r9
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

These are function call arguments for x86_64 we will need soon.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 4f66a0c5ae..8aef66e430 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -233,6 +233,14 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
         ct->ct |= TCG_CT_REG;
         tcg_regset_set_reg(ct->u.regs, TCG_REG_EDI);
         break;
+    case 'E': /* "Eight", r8 */
+        ct->ct |= TCG_CT_REG;
+        tcg_regset_set_reg(ct->u.regs, TCG_REG_R8);
+        break;
+    case 'N': /* "Nine", r9 */
+        ct->ct |= TCG_CT_REG;
+        tcg_regset_set_reg(ct->u.regs, TCG_REG_R9);
+        break;
     case 'q':
         /* A register that can be used as a byte operand.  */
         ct->ct |= TCG_CT_REG;
-- 
2.17.2
