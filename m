Received: from eggs.gnu.org ([2001:4830:134:3::10]:45415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6J-00085i-5q
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6I-0007tv-BR
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:35:51 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:44087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I6I-0007ss-4p
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:35:50 -0400
Received: by mail-wr0-x242.google.com with SMTP id z55so17248442wrz.1
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:35:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:34:51 +0200
Message-Id: <20171025093535.10175-8-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/51] tcg: Return NULL temp for
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
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
