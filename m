Received: from eggs.gnu.org ([209.51.188.92]:54019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMLJ-00082l-Tg
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMLH-0004sM-R4
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:41 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:35020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guMLF-0004oy-UB
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:38 -0500
Received: by mail-wr1-x432.google.com with SMTP id t18so7747334wrx.2
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 11:06:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	n184sm7798471wmf.5.2019.02.14.11.06.29 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 14 Feb 2019 11:06:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 19:05:57 +0000
Message-Id: <20190214190603.25030-22-peter.maydell@linaro.org>
In-Reply-To: <20190214190603.25030-1-peter.maydell@linaro.org>
References: <20190214190603.25030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/27] target/arm: Fix arm_cpu_dump_state vs
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190209033847.9014-8-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 103b4f1821a..b871a11ba69 100644
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
2.20.1
