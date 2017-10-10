Received: from eggs.gnu.org ([2001:4830:134:3::10]:60470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1iqG-0002Gj-H0
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1iqD-0004Oq-TC
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:16 -0400
Received: from mail-pf0-x232.google.com ([2607:f8b0:400e:c00::232]:46678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e1iqD-0004OG-O1
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:13 -0400
Received: by mail-pf0-x232.google.com with SMTP id p87so6426375pfj.3
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 17:56:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  9 Oct 2017 17:55:44 -0700
Message-Id: <20171010005600.28735-8-richard.henderson@linaro.org>
In-Reply-To: <20171010005600.28735-1-richard.henderson@linaro.org>
References: <20171010005600.28735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/23] tcg/mips: constify
 tcg_target_callee_save_regs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index ce4030602f..e993138930 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -2341,7 +2341,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     }
 }
 
-static int tcg_target_callee_save_regs[] = {
+static const int tcg_target_callee_save_regs[] = {
     TCG_REG_S0,       /* used for the global env (TCG_AREG0) */
     TCG_REG_S1,
     TCG_REG_S2,
-- 
2.13.6
