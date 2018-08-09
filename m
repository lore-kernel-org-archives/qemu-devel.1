Received: from eggs.gnu.org ([2001:4830:134:3::10]:37644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fnboX-0006cc-8n
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fnboW-00037c-Au
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:41 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fnboW-000377-53
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:40 -0400
Received: by mail-pf1-x442.google.com with SMTP id l9-v6so2140248pff.9
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 20:40:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  8 Aug 2018 20:40:24 -0700
Message-Id: <20180809034033.10579-3-richard.henderson@linaro.org>
In-Reply-To: <20180809034033.10579-1-richard.henderson@linaro.org>
References: <20180809034033.10579-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 02/11] target/arm: Fix typo in do_sat_addsub_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-stable@nongnu.org

Used the wrong temporary in the computation of subtractive overflow.

Cc: qemu-stable@nongnu.org (3.0.1)
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 374051cd20..9dd4c38bab 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -1625,7 +1625,7 @@ static void do_sat_addsub_64(TCGv_i64 reg, TCGv_i64 val, bool u, bool d)
             /* Detect signed overflow for subtraction.  */
             tcg_gen_xor_i64(t0, reg, val);
             tcg_gen_sub_i64(t1, reg, val);
-            tcg_gen_xor_i64(reg, reg, t0);
+            tcg_gen_xor_i64(reg, reg, t1);
             tcg_gen_and_i64(t0, t0, reg);
 
             /* Bound the result.  */
-- 
2.17.1
