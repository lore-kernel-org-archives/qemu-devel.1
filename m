Received: from eggs.gnu.org ([209.51.188.92]:42499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsJU1-0006vV-QY
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:39:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsJTx-0000Xb-Te
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:39:11 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gsJTs-0000V9-Cy
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:39:05 -0500
Received: by mail-pf1-x441.google.com with SMTP id f132so2577963pfa.6
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 19:39:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  8 Feb 2019 19:38:42 -0800
Message-Id: <20190209033847.9014-8-richard.henderson@linaro.org>
In-Reply-To: <20190209033847.9014-1-richard.henderson@linaro.org>
References: <20190209033847.9014-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 07/12] target/arm: Fix arm_cpu_dump_state vs
 FPSCR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index f0101d2788..9b426f4271 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -13641,7 +13641,7 @@ void arm_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                         i * 2 + 1, (uint32_t)(v >> 32),
                         i, v);
         }
-        cpu_fprintf(f, "FPSCR: %08x\n", (int)env->vfp.xregs[ARM_VFP_FPSCR]);
+        cpu_fprintf(f, "FPSCR: %08x\n", vfp_get_fpscr(env));
     }
 }
 
-- 
2.17.2
