Received: from eggs.gnu.org ([2001:4830:134:3::10]:52168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkqHj-0005mK-1v
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 08:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkqHi-0004Sx-9J
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 08:31:23 -0400
Received: from mail-ua0-x241.google.com ([2607:f8b0:400c:c08::241]:38611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkqHi-0004SE-1L
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 08:31:22 -0400
Received: by mail-ua0-x241.google.com with SMTP id o11-v6so12543567uak.5
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 05:31:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  1 Aug 2018 08:31:09 -0400
Message-Id: <20180801123111.3595-3-richard.henderson@linaro.org>
In-Reply-To: <20180801123111.3595-1-richard.henderson@linaro.org>
References: <20180801123111.3595-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/4] target/arm: Fix typo in do_sat_addsub_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, laurent.desnogues@gmail.com

Used the wrong temporary in the computation of subtractive overflow.

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
