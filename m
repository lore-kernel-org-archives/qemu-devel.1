Received: from eggs.gnu.org ([2001:4830:134:3::10]:59171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQm-0000rJ-SZ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQk-00029K-Os
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:16 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fqIQi-00021R-Ub
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:13 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQg-0000Aq-BO
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:35:10 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 14:34:34 +0100
Message-Id: <20180816133438.17061-27-peter.maydell@linaro.org>
In-Reply-To: <20180816133438.17061-1-peter.maydell@linaro.org>
References: <20180816133438.17061-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 26/30] target/arm: Use fp_status_fp16 for
 do_fmpa_zpzzz_h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

This makes float16_muladd correctly use FZ16 not FZ.

Fixes: 6ceabaad110
Cc: qemu-stable@nongnu.org (3.0.1)
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20180810193129.1556-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/sve_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index e03f954a264..0f980972535 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3358,7 +3358,7 @@ static void do_fmla_zpzzz_h(CPUARMState *env, void *vg, uint32_t desc,
                 e1 = *(uint16_t *)(vn + H1_2(i)) ^ neg1;
                 e2 = *(uint16_t *)(vm + H1_2(i));
                 e3 = *(uint16_t *)(va + H1_2(i)) ^ neg3;
-                r = float16_muladd(e1, e2, e3, 0, &env->vfp.fp_status);
+                r = float16_muladd(e1, e2, e3, 0, &env->vfp.fp_status_f16);
                 *(uint16_t *)(vd + H1_2(i)) = r;
             }
         } while (i & 63);
-- 
2.18.0
