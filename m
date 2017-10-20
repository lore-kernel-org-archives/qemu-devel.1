Received: from eggs.gnu.org ([2001:4830:134:3::10]:44301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5gan-0005rO-3W
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5gak-0007Yz-FI
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:20:41 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:45629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e5gak-0007Ya-8V
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:20:38 -0400
Received: by mail-pf0-x243.google.com with SMTP id d28so13076772pfe.2
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 16:20:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 20 Oct 2017 16:19:38 -0700
Message-Id: <20171020232023.15010-8-richard.henderson@linaro.org>
In-Reply-To: <20171020232023.15010-1-richard.henderson@linaro.org>
References: <20171020232023.15010-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v7 07/52] tcg: Return NULL temp for
 TCG_CALL_DUMMY_ARG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, f4bug@amsat.org, pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index fc4d1ed58b..5fcdec1fc5 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -731,7 +731,7 @@ extern bool parallel_cpus;
 
 static inline TCGTemp *arg_temp(TCGArg a)
 {
-    return &tcg_ctx.temps[a];
+    return a == TCG_CALL_DUMMY_ARG ? NULL : &tcg_ctx.temps[a];
 }
 
 static inline void tcg_set_insn_param(int op_idx, int arg, TCGArg v)
-- 
2.13.6
