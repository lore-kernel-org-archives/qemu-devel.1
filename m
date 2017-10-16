Received: from eggs.gnu.org ([2001:4830:134:3::10]:52265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e499n-0001yQ-EP
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e499k-0003Kf-9t
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:27 -0400
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:51119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e499k-0003K5-3u
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:24 -0400
Received: by mail-pg0-x230.google.com with SMTP id y7so7341944pgb.7
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:26:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Oct 2017 10:25:26 -0700
Message-Id: <20171016172609.23422-8-richard.henderson@linaro.org>
In-Reply-To: <20171016172609.23422-1-richard.henderson@linaro.org>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 07/50] tcg: Return NULL temp for
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
Cc: cota@braap.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

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
