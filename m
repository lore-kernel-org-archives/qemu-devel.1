Received: from eggs.gnu.org ([2001:4830:134:3::10]:52498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9w5c-00035y-22
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9w5X-0005nm-9K
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:46:35 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:43247)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g9w5W-0005hF-Vz
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:46:31 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue,  9 Oct 2018 13:45:53 -0400
Message-Id: <20181009174557.16125-3-cota@braap.org>
In-Reply-To: <20181009174557.16125-1-cota@braap.org>
References: <20181009174557.16125-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v5 2/6] target/unicore32: remove tlb_flush from
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
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>

As far as I can tell tlb_flush does not need to be called
this early. tlb_flush is eventually called after the CPU
has been realized.

This change paves the way to the introduction of tlb_init,
which will be called from cpu_exec_realizefn.

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Signed-off-by: Emilio G. Cota <cota@braap.org>
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
2.17.1
