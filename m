Received: from eggs.gnu.org ([2001:4830:134:3::10]:58608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFQ-0004UG-L8
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFN-0002nr-Fd
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:40 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44191)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJFM-0002ki-RA
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:37 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:05:42 -0400
Message-Id: <20181019010625.25294-14-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 13/56] lm32: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Michael Walle <michael@walle.cc>

Cc: Michael Walle <michael@walle.cc>
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
