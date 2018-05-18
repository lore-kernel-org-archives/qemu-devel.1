Received: from eggs.gnu.org ([2001:4830:134:3::10]:55388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJnNq-0000Pu-Nw
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJnNm-0003Zg-85
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:57:54 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:38600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJnNm-0003ZV-2J
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:57:50 -0400
Received: by mail-pg0-x232.google.com with SMTP id n9-v6so3849402pgq.5
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 14:57:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 18 May 2018 14:57:34 -0700
Message-Id: <20180518215734.18833-9-richard.henderson@linaro.org>
In-Reply-To: <20180518215734.18833-1-richard.henderson@linaro.org>
References: <20180518215734.18833-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 8/8] target/xtensa: Honor CPU_DUMP_FPU
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

Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index ae0feb0254..53f6f5db8f 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1243,7 +1243,8 @@ void xtensa_cpu_dump_state(CPUState *cs, FILE *f,
         }
     }
 
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_FP_COPROCESSOR)) {
+    if ((flags & CPU_DUMP_FPU) &&
+        xtensa_option_enabled(env->config, XTENSA_OPTION_FP_COPROCESSOR)) {
         cpu_fprintf(f, "\n");
 
         for (i = 0; i < 16; ++i) {
-- 
2.17.0
