Received: from eggs.gnu.org ([2001:4830:134:3::10]:55320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJnNf-0000FV-Tr
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJnNd-0003XJ-PW
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:57:43 -0400
Received: from mail-pl0-x236.google.com ([2607:f8b0:400e:c01::236]:34848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJnNd-0003XA-JX
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:57:41 -0400
Received: by mail-pl0-x236.google.com with SMTP id i5-v6so5318997plt.2
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 14:57:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 18 May 2018 14:57:28 -0700
Message-Id: <20180518215734.18833-3-richard.henderson@linaro.org>
In-Reply-To: <20180518215734.18833-1-richard.henderson@linaro.org>
References: <20180518215734.18833-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/8] target/mips: Honor CPU_DUMP_FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@mips.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index f1c1fdd35c..e88f983ae7 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20446,8 +20446,9 @@ void mips_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                 env->CP0_Config2, env->CP0_Config3);
     cpu_fprintf(f, "    Config4 0x%08x Config5 0x%08x\n",
                 env->CP0_Config4, env->CP0_Config5);
-    if (env->hflags & MIPS_HFLAG_FPU)
+    if ((flags & CPU_DUMP_FPU) && (env->hflags & MIPS_HFLAG_FPU)) {
         fpu_dump_state(env, f, cpu_fprintf, flags);
+    }
 }
 
 void mips_tcg_init(void)
-- 
2.17.0
