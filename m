Received: from eggs.gnu.org ([2001:4830:134:3::10]:59267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFn-0004sK-Fw
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFj-0003LO-Tb
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:03 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35727)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJFj-00032Y-DV
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:59 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:06:04 -0400
Message-Id: <20181019010625.25294-36-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 35/56] lm32: convert to cpu_interrupt_request
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
 target/lm32/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index b7499cb627..1508bb6199 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -101,7 +101,7 @@ static void lm32_cpu_init_cfg_reg(LM32CPU *cpu)
 
 static bool lm32_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & CPU_INTERRUPT_HARD;
+    return cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD;
 }
 
 /* CPUClass::reset() */
-- 
2.17.1
