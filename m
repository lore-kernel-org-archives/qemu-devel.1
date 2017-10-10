Received: from eggs.gnu.org ([2001:4830:134:3::10]:58796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e20EK-0000Xv-13
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:30:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e20EJ-00051a-AG
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:30:16 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:49908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e20EJ-000503-2x
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:30:15 -0400
Received: by mail-pf0-x22e.google.com with SMTP id l188so18271676pfc.6
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 12:30:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 10 Oct 2017 12:29:49 -0700
Message-Id: <20171010193003.28857-7-richard.henderson@linaro.org>
In-Reply-To: <20171010193003.28857-1-richard.henderson@linaro.org>
References: <20171010193003.28857-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 06/20] tcg/i386: constify
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
 tcg/i386/tcg-target.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 69e49c9f58..63d27f10e7 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -2499,7 +2499,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     return NULL;
 }
 
-static int tcg_target_callee_save_regs[] = {
+static const int tcg_target_callee_save_regs[] = {
 #if TCG_TARGET_REG_BITS == 64
     TCG_REG_RBP,
     TCG_REG_RBX,
-- 
2.13.6
