Received: from eggs.gnu.org ([2001:4830:134:3::10]:59081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFj-0004mm-1P
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFh-0003Hq-Tc
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:58 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44747)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJFh-00030n-GA
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:57 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:05:57 -0400
Message-Id: <20181019010625.25294-29-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC v3 28/56] openrisc: use cpu_reset_interrupt
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

From: Paolo Bonzini <pbonzini@redhat.com>

Cc: Stafford Horne <shorne@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
