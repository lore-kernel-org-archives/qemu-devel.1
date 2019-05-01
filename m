Received: from eggs.gnu.org ([209.51.188.92]:38523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRm-0006lZ-7f
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRj-00035Y-6M
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:22 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRj-00034Q-1K
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:19 -0400
Received: by mail-pf1-x442.google.com with SMTP id z26so4260388pfg.6
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:06:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 30 Apr 2019 22:05:34 -0700
Message-Id: <20190501050536.15580-28-richard.henderson@linaro.org>
In-Reply-To: <20190501050536.15580-1-richard.henderson@linaro.org>
References: <20190501050536.15580-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 27/29] target/s390x: Use tcg_gen_abs_i64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>

Cc: David Hildenbrand <david@redhat.com>
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
