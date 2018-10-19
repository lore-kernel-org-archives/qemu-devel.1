Received: from eggs.gnu.org ([2001:4830:134:3::10]:39072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDNwa-0004FN-7F
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDNwP-0002Fx-Vt
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:07:29 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:37374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gDNwD-00021n-U2
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:07:11 -0400
Received: by mail-pf1-x433.google.com with SMTP id j23-v6so16001238pfi.4
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 23:07:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 18 Oct 2018 23:06:42 -0700
Message-Id: <20181019060656.7968-8-richard.henderson@linaro.org>
In-Reply-To: <20181019060656.7968-1-richard.henderson@linaro.org>
References: <20181019060656.7968-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 07/21] target/unicore32: remove tlb_flush
 from uc32_init_fn
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
