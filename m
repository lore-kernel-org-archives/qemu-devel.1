Received: from eggs.gnu.org ([2001:4830:134:3::10]:37799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dro02-0001dG-47
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dro00-0006yL-GF
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:22 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:35937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dro00-0006xy-AX
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:20 -0400
Received: by mail-pg0-x232.google.com with SMTP id i130so14869212pgc.3
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 09:25:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 12 Sep 2017 09:24:59 -0700
Message-Id: <20170912162513.21694-3-richard.henderson@linaro.org>
In-Reply-To: <20170912162513.21694-1-richard.henderson@linaro.org>
References: <20170912162513.21694-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 02/16] tcg: Add types for host vectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, f4bug@amsat.org

Nothing uses or enables them yet.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h | 5 +++++
 tcg/tcg.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index ac94133870..f56ddac31d 100644
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
index fd8a3dfe93..bc65d01618 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -116,7 +116,7 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 static bool tcg_out_ldst_finalize(TCGContext *s);
 #endif
 
-static TCGRegSet tcg_target_available_regs[2];
+static TCGRegSet tcg_target_available_regs[TCG_TYPE_COUNT];
 static TCGRegSet tcg_target_call_clobber_regs;
 
 #if TCG_TARGET_INSN_UNIT_SIZE == 1
-- 
2.13.5
