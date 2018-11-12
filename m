Received: from eggs.gnu.org ([2001:4830:134:3::10]:54055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK35-0003U9-4K
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK32-0004to-Gs
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:11 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gMK32-0004tP-A5
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:08 -0500
Received: by mail-wm1-x344.google.com with SMTP id u13-v6so9546679wmc.4
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 13:47:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 12 Nov 2018 22:44:47 +0100
Message-Id: <20181112214503.22941-2-richard.henderson@linaro.org>
In-Reply-To: <20181112214503.22941-1-richard.henderson@linaro.org>
References: <20181112214503.22941-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 01/17] tcg/i386: Add constraints for r8
 and r9
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

These are function call arguments for x86_64 we will need soon.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 436195894b..e4d9be57ff 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -230,6 +230,14 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
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
