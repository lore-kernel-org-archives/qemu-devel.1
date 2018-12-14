Received: from eggs.gnu.org ([2001:4830:134:3::10]:58997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe1D-0006Hx-D9
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe1C-0007jO-CO
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:03 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:41317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe1C-0007VL-16
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:02 -0500
Received: by mail-ot1-x334.google.com with SMTP id u16so4105691otk.8
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:19:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:19:18 -0600
Message-Id: <20181214031923.29527-29-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 27/32] tcg/mips: Improve the add2/sub2 command
 to use TCG_TARGET_REG_BITS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair.francis@wdc.com>

From: Alistair Francis <Alistair.Francis@wdc.com>

Instead of hard coding 31 for the shift right use TCG_TARGET_REG_BITS - 1.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <7dfbddf7014a595150aa79011ddb342c3cc17ec3.1544648105.git.alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index a06ff257fa..be0bc92e8e 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -792,7 +792,7 @@ static void tcg_out_addsub2(TCGContext *s, TCGReg rl, TCGReg rh, TCGReg al,
             tcg_out_opc_imm(s, OPC_ADDIU, rl, al, bl);
             tcg_out_opc_imm(s, OPC_SLTIU, TCG_TMP0, rl, bl);
         } else if (rl == al && rl == bl) {
-            tcg_out_opc_sa(s, OPC_SRL, TCG_TMP0, al, 31);
+            tcg_out_opc_sa(s, OPC_SRL, TCG_TMP0, al, TCG_TARGET_REG_BITS - 1);
             tcg_out_opc_reg(s, OPC_ADDU, rl, al, bl);
         } else {
             tcg_out_opc_reg(s, OPC_ADDU, rl, al, bl);
-- 
2.17.2
