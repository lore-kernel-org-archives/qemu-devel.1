Received: from eggs.gnu.org ([2001:4830:134:3::10]:55377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJnNl-0000Kd-Oa
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJnNk-0003ZM-P7
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:57:49 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:37216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJnNk-0003Z3-Jm
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:57:48 -0400
Received: by mail-pl0-x243.google.com with SMTP id w19-v6so5311779plq.4
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 14:57:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 18 May 2018 14:57:33 -0700
Message-Id: <20180518215734.18833-8-richard.henderson@linaro.org>
In-Reply-To: <20180518215734.18833-1-richard.henderson@linaro.org>
References: <20180518215734.18833-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 7/8] target/unicore32: Honor CPU_DUMP_FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Guan Xuetao <gxt@mprc.pku.edu.cn>

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/unicore32/translate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index abe2ea8592..3cae111955 100644
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
