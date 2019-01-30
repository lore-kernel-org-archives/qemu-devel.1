Received: from eggs.gnu.org ([209.51.188.92]:35686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3y-00007y-PX
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3w-0001Im-MX
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:10 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33837)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe3s-000109-TX
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:06 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:35 -0500
Message-Id: <20190130004811.27372-38-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 37/73] openrisc: use cpu_reset_interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stafford Horne <shorne@gmail.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Cc: Stafford Horne <shorne@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/openrisc/sys_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index ab4d8fb520..c645cc896d 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -170,7 +170,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
                 env->ttmr = (rb & ~TTMR_IP) | ip;
             } else {    /* Clear IP bit.  */
                 env->ttmr = rb & ~TTMR_IP;
-                cs->interrupt_request &= ~CPU_INTERRUPT_TIMER;
+                cpu_reset_interrupt(cs, CPU_INTERRUPT_TIMER);
             }
 
             cpu_openrisc_timer_update(cpu);
-- 
2.17.1
