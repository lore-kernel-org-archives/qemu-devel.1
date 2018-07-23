Received: from eggs.gnu.org ([2001:4830:134:3::10]:60515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fheYI-0005it-Pm
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fheYH-00061k-LW
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:23:18 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:35046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fheYH-00061K-Ft
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:23:17 -0400
Received: by mail-pl0-x241.google.com with SMTP id w3-v6so507151plq.2
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 10:23:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 23 Jul 2018 10:23:11 -0700
Message-Id: <20180723172311.11316-2-richard.henderson@linaro.org>
In-Reply-To: <20180723172311.11316-1-richard.henderson@linaro.org>
References: <20180723172311.11316-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL for-3.0 1/1] tcg/i386: Mark xmm registers
 call-clobbered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-stable@nongnu.org

When host vector registers and operations were introduced, I failed
to mark the registers call clobbered as required by the ABI.

Fixes: 770c2fc7bb7
Cc: qemu-stable@nongnu.org
Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index e87b0d445e..a91e4f1313 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -3532,7 +3532,7 @@ static void tcg_target_init(TCGContext *s)
         tcg_target_available_regs[TCG_TYPE_V256] = ALL_VECTOR_REGS;
     }
 
-    tcg_target_call_clobber_regs = 0;
+    tcg_target_call_clobber_regs = ALL_VECTOR_REGS;
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_EAX);
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_EDX);
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_ECX);
-- 
2.17.1
