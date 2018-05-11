Received: from eggs.gnu.org ([2001:4830:134:3::10]:52321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGz73-00055l-2L
	for qemu-devel@nongnu.org; Thu, 10 May 2018 23:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGz72-0006Bt-F2
	for qemu-devel@nongnu.org; Thu, 10 May 2018 23:52:57 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:36492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGz72-0006Be-9F
	for qemu-devel@nongnu.org; Thu, 10 May 2018 23:52:56 -0400
Received: by mail-pl0-x242.google.com with SMTP id v24-v6so2509859plo.3
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 20:52:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 May 2018 20:52:40 -0700
Message-Id: <20180511035240.4016-10-richard.henderson@linaro.org>
In-Reply-To: <20180511035240.4016-1-richard.henderson@linaro.org>
References: <20180511035240.4016-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 9/9] target/xtensa: Honor CPU_DUMP_FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Cc: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 4f6d03059f..2afe395ecf 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1244,7 +1244,8 @@ void xtensa_cpu_dump_state(CPUState *cs, FILE *f,
         }
     }
 
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_FP_COPROCESSOR)) {
+    if ((flags & CPU_DUMP_FPU) &&
+        xtensa_option_enabled(env->config, XTENSA_OPTION_FP_COPROCESSOR)) {
         cpu_fprintf(f, "\n");
 
         for (i = 0; i < 16; ++i) {
-- 
2.17.0
