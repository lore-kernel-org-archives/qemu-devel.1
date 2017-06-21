Received: from eggs.gnu.org ([2001:4830:134:3::10]:33913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNVhJ-0006UX-1t
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNVhG-0002NW-KU
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:49 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNVhG-0002NN-GH
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:46 -0400
Received: by mail-qt0-x243.google.com with SMTP id x58so25653267qtc.2
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 19:48:46 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 20 Jun 2017 19:48:22 -0700
Message-Id: <20170621024831.26019-8-rth@twiddle.net>
In-Reply-To: <20170621024831.26019-1-rth@twiddle.net>
References: <20170621024831.26019-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 07/16] tcg: Return NULL temp for
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
Cc: aurelien@aurel32.net

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 3b35344..6c357e7 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -730,7 +730,7 @@ extern bool parallel_cpus;
 
 static inline TCGTemp *arg_temp(TCGArg a)
 {
-    return &tcg_ctx.temps[a];
+    return a == TCG_CALL_DUMMY_ARG ? NULL : &tcg_ctx.temps[a];
 }
 
 static inline void tcg_set_insn_param(int op_idx, int arg, TCGArg v)
-- 
2.9.4
