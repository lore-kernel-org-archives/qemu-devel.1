Received: from eggs.gnu.org ([209.51.188.92]:35321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3b-0008Gc-6V
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3a-00010K-74
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:47 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39885)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe3a-0000ob-2W
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:46 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:19 -0500
Message-Id: <20190130004811.27372-22-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 21/73] lm32: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Michael Walle <michael@walle.cc>

Cc: Michael Walle <michael@walle.cc>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/lm32/op_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/lm32/op_helper.c b/target/lm32/op_helper.c
index 234d55e056..392634441b 100644
--- a/target/lm32/op_helper.c
+++ b/target/lm32/op_helper.c
@@ -31,7 +31,7 @@ void HELPER(hlt)(CPULM32State *env)
 {
     CPUState *cs = CPU(lm32_env_get_cpu(env));
 
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     cs->exception_index = EXCP_HLT;
     cpu_loop_exit(cs);
 }
@@ -44,7 +44,7 @@ void HELPER(ill)(CPULM32State *env)
             "Connect a debugger or switch to the monitor console "
             "to find out more.\n");
     vm_stop(RUN_STATE_PAUSED);
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     raise_exception(env, EXCP_HALTED);
 #endif
 }
-- 
2.17.1
