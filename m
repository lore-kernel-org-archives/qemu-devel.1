Received: from eggs.gnu.org ([2001:4830:134:3::10]:40499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhI1-0001HW-Sd
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhHx-00021p-Uh
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:18:41 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:48 -0500
Message-Id: <20180723201748.25573-100-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 99/99] tcg/i386: Mark xmm registers
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
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

When host vector registers and operations were introduced, I failed
to mark the registers call clobbered as required by the ABI.

Fixes: 770c2fc7bb7
Cc: qemu-stable@nongnu.org
Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 672189cd586ea38a2c1d8ab91eb1f9dcff5ceb05)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tcg/i386/tcg-target.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index ccde8801a5..5727999bb3 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -3529,7 +3529,7 @@ static void tcg_target_init(TCGContext *s)
         tcg_target_available_regs[TCG_TYPE_V256] = ALL_VECTOR_REGS;
     }
 
-    tcg_target_call_clobber_regs = 0;
+    tcg_target_call_clobber_regs = ALL_VECTOR_REGS;
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_EAX);
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_EDX);
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_ECX);
-- 
2.17.1
