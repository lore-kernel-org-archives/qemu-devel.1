Received: from eggs.gnu.org ([2001:4830:134:3::10]:43368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eQRqH-0001rC-B8
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 00:50:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eQRqF-0005oj-08
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 00:50:29 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35531)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eQRqE-0005oC-OB
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 00:50:26 -0500
Received: by mail-wr0-x242.google.com with SMTP id z104so2347596wrb.2
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 21:50:26 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 17 Dec 2017 06:50:23 +0100
Message-Id: <20171217055023.29225-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] tcg: add cs_base and flags to -d exec output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/cpu-exec.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 4318441e4c..18c1a2aedb 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -146,8 +146,10 @@ static inline tcg_target_ulong cpu_tb_exec(CPUState *cpu, TranslationBlock *itb)
     uint8_t *tb_ptr = itb->tc.ptr;
 
     qemu_log_mask_and_addr(CPU_LOG_EXEC, itb->pc,
-                           "Trace %p [%d: " TARGET_FMT_lx "] %s\n",
-                           itb->tc.ptr, cpu->cpu_index, itb->pc,
+                           "Trace %d: %p ["
+                           TARGET_FMT_lx "/" TARGET_FMT_lx "/%d] %s\n",
+                           cpu->cpu_index, itb->tc.ptr,
+                           itb->cs_base, itb->pc, itb->flags,
                            lookup_symbol(itb->pc));
 
 #if defined(DEBUG_DISAS)
-- 
2.14.3
