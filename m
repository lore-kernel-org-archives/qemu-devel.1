Received: from eggs.gnu.org ([2001:4830:134:3::10]:58865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFa-0004dR-DB
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFY-00033f-G3
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:50 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:40711)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJFY-0002mg-1Z
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:48 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:05:50 -0400
Message-Id: <20181019010625.25294-22-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 21/56] openrisc: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stafford Horne <shorne@gmail.com>

Cc: Stafford Horne <shorne@gmail.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/openrisc/sys_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index b66a45c1e0..ab4d8fb520 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -137,7 +137,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
         if (env->pmr & PMR_DME || env->pmr & PMR_SME) {
             cpu_restore_state(cs, GETPC(), true);
             env->pc += 4;
-            cs->halted = 1;
+            cpu_halted_set(cs, 1);
             raise_exception(cpu, EXCP_HALTED);
         }
         break;
-- 
2.17.1
