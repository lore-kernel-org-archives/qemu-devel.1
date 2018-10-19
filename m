Received: from eggs.gnu.org ([2001:4830:134:3::10]:58558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFO-0004U8-VX
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFN-0002n8-26
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:38 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38249)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJFM-0002jn-CY
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:36 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:05:40 -0400
Message-Id: <20181019010625.25294-12-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 11/56] sh4: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Cc: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/sh4/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 4f825bae5a..57cc363ccc 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -105,7 +105,7 @@ void helper_sleep(CPUSH4State *env)
 {
     CPUState *cs = CPU(sh_env_get_cpu(env));
 
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     env->in_sleep = 1;
     raise_exception(env, EXCP_HLT, 0);
 }
-- 
2.17.1
