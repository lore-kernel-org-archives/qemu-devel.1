Received: from eggs.gnu.org ([2001:4830:134:3::10]:52320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGz73-00055j-1o
	for qemu-devel@nongnu.org; Thu, 10 May 2018 23:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGz71-0006BS-7C
	for qemu-devel@nongnu.org; Thu, 10 May 2018 23:52:57 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:38274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGz71-0006BG-28
	for qemu-devel@nongnu.org; Thu, 10 May 2018 23:52:55 -0400
Received: by mail-pg0-x244.google.com with SMTP id n9-v6so1857848pgq.5
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 20:52:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 May 2018 20:52:39 -0700
Message-Id: <20180511035240.4016-9-richard.henderson@linaro.org>
In-Reply-To: <20180511035240.4016-1-richard.henderson@linaro.org>
References: <20180511035240.4016-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 8/9] target/unicore32: Honor CPU_DUMP_FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/unicore32/translate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 5b51f2166d..63619e7d2c 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -2101,7 +2101,9 @@ void uc32_cpu_dump_state(CPUState *cs, FILE *f,
                 psr & (1 << 28) ? 'V' : '-',
                 cpu_mode_names[psr & 0xf]);
 
-    cpu_dump_state_ucf64(env, f, cpu_fprintf, flags);
+    if (flags & CPU_DUMP_FPU) {
+        cpu_dump_state_ucf64(env, f, cpu_fprintf, flags);
+    }
 }
 
 void restore_state_to_opc(CPUUniCore32State *env, TranslationBlock *tb,
-- 
2.17.0
