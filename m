Received: from eggs.gnu.org ([209.51.188.92]:35064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJi8w-0006e2-BN
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJi8v-00039q-Cq
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:26:42 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:41183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJi8v-00039K-7J
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:26:41 -0400
Received: by mail-pg1-x52a.google.com with SMTP id f6so173692pgs.8
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 10:26:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 25 Apr 2019 10:26:35 -0700
Message-Id: <20190425172636.11128-2-richard.henderson@linaro.org>
In-Reply-To: <20190425172636.11128-1-richard.henderson@linaro.org>
References: <20190425172636.11128-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] fixup! target/riscv: Name the argument
 sets for all of insn32 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: palmer@sifive.com

---
 target/riscv/translate.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index d1f599a92d..009c146e8f 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -713,12 +713,19 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
  * initially declared by the 32-bit decoder, which results in duplicate
  * declaration warnings.  Suppress them.
  */
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wredundant-decls"
+#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
+# pragma GCC diagnostic push
+# pragma GCC diagnostic ignored "-Wredundant-decls"
+# ifdef __clang__
+#  pragma GCC diagnostic ignored "-Wtypedef-redefinition"
+# endif
+#endif
 
 #include "decode_insn16.inc.c"
 
-#pragma GCC diagnostic pop
+#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
+# pragma GCC diagnostic pop
+#endif
 
 static void decode_opc(DisasContext *ctx)
 {
-- 
2.17.1
