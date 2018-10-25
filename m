Received: from eggs.gnu.org ([2001:4830:134:3::10]:59897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFh5P-0003jm-J2
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFgv6-00086y-Ie
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:34 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58389)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFgv6-0007tg-BM
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:32 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 10:46:01 -0400
Message-Id: <20181025144644.15464-28-cota@braap.org>
In-Reply-To: <20181025144644.15464-1-cota@braap.org>
References: <20181025144644.15464-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v4 28/71] openrisc: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Stafford Horne <shorne@gmail.com>

Cc: Stafford Horne <shorne@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
