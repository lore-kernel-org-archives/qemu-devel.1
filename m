Received: from eggs.gnu.org ([2001:4830:134:3::10]:59668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCTTO-00045V-6u
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCTTJ-0000y7-Rr
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:37 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:38062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCTTI-0000lD-HZ
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:33 -0400
Received: by mail-pg1-x52d.google.com with SMTP id f8-v6so11197723pgq.5
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 10:49:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Oct 2018 10:48:57 -0700
Message-Id: <20181016174911.9052-8-richard.henderson@linaro.org>
In-Reply-To: <20181016174911.9052-1-richard.henderson@linaro.org>
References: <20181016174911.9052-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/21] target/unicore32: remove tlb_flush from
 uc32_init_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>

From: "Emilio G. Cota" <cota@braap.org>

As far as I can tell tlb_flush does not need to be called
this early. tlb_flush is eventually called after the CPU
has been realized.

This change paves the way to the introduction of tlb_init,
which will be called from cpu_exec_realizefn.

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <20181009174557.16125-3-cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/unicore32/cpu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index 68f978d80b..2b49d1ca40 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -116,8 +116,6 @@ static void uc32_cpu_initfn(Object *obj)
     env->uncached_asr = ASR_MODE_PRIV;
     env->regs[31] = 0x03000000;
 #endif
-
-    tlb_flush(cs);
 }
 
 static const VMStateDescription vmstate_uc32_cpu = {
-- 
2.17.2
