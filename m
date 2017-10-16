Received: from eggs.gnu.org ([2001:4830:134:3::10]:52434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49A8-0002MU-Gd
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49A7-0003ci-Pb
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:48 -0400
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:54267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e49A7-0003cF-JK
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:47 -0400
Received: by mail-pf0-x22b.google.com with SMTP id t188so13793979pfd.10
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:26:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Oct 2017 10:25:42 -0700
Message-Id: <20171016172609.23422-24-richard.henderson@linaro.org>
In-Reply-To: <20171016172609.23422-1-richard.henderson@linaro.org>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 23/50] hack dump tb->flags and tb->cflags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

---
 accel/tcg/cpu-exec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 39ec9508d1..99f1d519c5 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -146,9 +146,9 @@ static inline tcg_target_ulong cpu_tb_exec(CPUState *cpu, TranslationBlock *itb)
     uint8_t *tb_ptr = itb->tc.ptr;
 
     qemu_log_mask_and_addr(CPU_LOG_EXEC, itb->pc,
-                           "Trace %p [%d: " TARGET_FMT_lx "] %s\n",
+                           "Trace %p [%d: " TARGET_FMT_lx ", %x, %x] %s\n",
                            itb->tc.ptr, cpu->cpu_index, itb->pc,
-                           lookup_symbol(itb->pc));
+                           itb->flags, itb->cflags, lookup_symbol(itb->pc));
 
 #if defined(DEBUG_DISAS)
     if (qemu_loglevel_mask(CPU_LOG_TB_CPU)
-- 
2.13.6
