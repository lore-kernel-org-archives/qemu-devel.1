Received: from eggs.gnu.org ([2001:4830:134:3::10]:59079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1foD8M-0002RG-8u
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1foD8L-0005bx-AS
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:31:38 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:35608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1foD8L-0005bK-4b
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:31:37 -0400
Received: by mail-pg1-x52d.google.com with SMTP id w10-v6so4850986pgv.2
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 12:31:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 10 Aug 2018 12:31:26 -0700
Message-Id: <20180810193129.1556-4-richard.henderson@linaro.org>
In-Reply-To: <20180810193129.1556-1-richard.henderson@linaro.org>
References: <20180810193129.1556-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/6] target/arm: Use fp_status_fp16 for
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-stable@nongnu.org

This makes float16_muladd correctly use FZ16 not FZ.

Fixes: 6ceabaad110
Cc: qemu-stable@nongnu.org (3.0.1)
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 5bae600d17..f8434e68f2 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3398,7 +3398,7 @@ static void do_fmla_zpzzz_h(CPUARMState *env, void *vg, uint32_t desc,
                 e1 = *(uint16_t *)(vn + H1_2(i)) ^ neg1;
                 e2 = *(uint16_t *)(vm + H1_2(i));
                 e3 = *(uint16_t *)(va + H1_2(i)) ^ neg3;
-                r = float16_muladd(e1, e2, e3, 0, &env->vfp.fp_status);
+                r = float16_muladd(e1, e2, e3, 0, &env->vfp.fp_status_f16);
                 *(uint16_t *)(vd + H1_2(i)) = r;
             }
         } while (i & 63);
-- 
2.17.1
