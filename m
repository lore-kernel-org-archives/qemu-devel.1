Received: from eggs.gnu.org ([2001:4830:134:3::10]:44514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diTn3-0004vg-RA
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diTn0-0000qQ-Ag
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:01:25 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:36958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1diTn0-0000px-5Y
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:01:22 -0400
Received: by mail-pg0-x22a.google.com with SMTP id y129so51924905pgy.4
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 16:01:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 17 Aug 2017 16:01:09 -0700
Message-Id: <20170817230114.3655-4-richard.henderson@linaro.org>
In-Reply-To: <20170817230114.3655-1-richard.henderson@linaro.org>
References: <20170817230114.3655-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/8] tcg: Add types for host vectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org

Nothing uses or enables them yet.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h | 5 +++++
 tcg/tcg.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index dd97095af5..1277caed3d 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -256,6 +256,11 @@ typedef struct TCGPool {
 typedef enum TCGType {
     TCG_TYPE_I32,
     TCG_TYPE_I64,
+
+    TCG_TYPE_V64,
+    TCG_TYPE_V128,
+    TCG_TYPE_V256,
+
     TCG_TYPE_COUNT, /* number of different types */
 
     /* An alias for the size of the host register.  */
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 787c8ba0f7..ea78d47fad 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -118,7 +118,7 @@ static TCGReg tcg_reg_alloc_new(TCGContext *s, TCGType t)
 static bool tcg_out_ldst_finalize(TCGContext *s);
 #endif
 
-static TCGRegSet tcg_target_available_regs[2];
+static TCGRegSet tcg_target_available_regs[TCG_TYPE_COUNT];
 static TCGRegSet tcg_target_call_clobber_regs;
 
 #if TCG_TARGET_INSN_UNIT_SIZE == 1
-- 
2.13.5
