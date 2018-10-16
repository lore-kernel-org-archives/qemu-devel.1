Received: from eggs.gnu.org ([2001:4830:134:3::10]:59695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCTTP-00046T-65
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCTTL-00010F-0O
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:38 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:39641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCTTK-0000je-Jw
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:34 -0400
Received: by mail-pl1-x62f.google.com with SMTP id e67-v6so2385444plb.6
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 10:49:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Oct 2018 10:48:56 -0700
Message-Id: <20181016174911.9052-7-richard.henderson@linaro.org>
In-Reply-To: <20181016174911.9052-1-richard.henderson@linaro.org>
References: <20181016174911.9052-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/21] target/alpha: remove tlb_flush from
 alpha_cpu_initfn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

As far as I can tell tlb_flush does not need to be called
this early. tlb_flush is eventually called after the CPU
has been realized.

This change paves the way to the introduction of tlb_init,
which will be called from cpu_exec_realizefn.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <20181009174557.16125-2-cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index b08078e7fc..a953897fcc 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -201,7 +201,6 @@ static void alpha_cpu_initfn(Object *obj)
     CPUAlphaState *env = &cpu->env;
 
     cs->env_ptr = env;
-    tlb_flush(cs);
 
     env->lock_addr = -1;
 #if defined(CONFIG_USER_ONLY)
-- 
2.17.2
