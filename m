Received: from eggs.gnu.org ([209.51.188.92]:42089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMncA-000890-CP
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnc9-0004cg-ER
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:38 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnc9-0004ag-73
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:37 -0400
Received: by mail-pg1-x543.google.com with SMTP id z16so3752708pgv.11
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  3 May 2019 22:52:57 -0700
Message-Id: <20190504055300.18426-29-richard.henderson@linaro.org>
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 28/31] target/s390x: Use tcg_gen_abs_i64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, david@redhat.com

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/translate.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index d4951836ad..e8e8a79b7d 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1407,13 +1407,7 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
 
 static DisasJumpType op_abs(DisasContext *s, DisasOps *o)
 {
-    TCGv_i64 z, n;
-    z = tcg_const_i64(0);
-    n = tcg_temp_new_i64();
-    tcg_gen_neg_i64(n, o->in2);
-    tcg_gen_movcond_i64(TCG_COND_LT, o->out, o->in2, z, n, o->in2);
-    tcg_temp_free_i64(n);
-    tcg_temp_free_i64(z);
+    tcg_gen_abs_i64(o->out, o->in2);
     return DISAS_NEXT;
 }
 
-- 
2.17.1
