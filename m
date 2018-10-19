Received: from eggs.gnu.org ([2001:4830:134:3::10]:59191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFl-0004qM-Sz
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFj-0003LA-Pm
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:01 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45691)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJFj-00033x-7M
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:59 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:06:10 -0400
Message-Id: <20181019010625.25294-42-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 41/56] moxie: convert to cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Anthony Green <green@moxielogic.com>

Cc: Anthony Green <green@moxielogic.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/moxie/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index 8d67eb6727..bad92cfc61 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -33,7 +33,7 @@ static void moxie_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool moxie_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & CPU_INTERRUPT_HARD;
+    return cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD;
 }
 
 static void moxie_cpu_reset(CPUState *s)
-- 
2.17.1
