Received: from eggs.gnu.org ([2001:4830:134:3::10]:52491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9w5c-00035u-07
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9w5X-0005nf-7P
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:46:35 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:41747)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g9w5W-0005ge-UL
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:46:31 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue,  9 Oct 2018 13:45:52 -0400
Message-Id: <20181009174557.16125-2-cota@braap.org>
In-Reply-To: <20181009174557.16125-1-cota@braap.org>
References: <20181009174557.16125-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v5 1/6] target/alpha: remove tlb_flush from
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
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

As far as I can tell tlb_flush does not need to be called
this early. tlb_flush is eventually called after the CPU
has been realized.

This change paves the way to the introduction of tlb_init,
which will be called from cpu_exec_realizefn.

Signed-off-by: Emilio G. Cota <cota@braap.org>
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
2.17.1
