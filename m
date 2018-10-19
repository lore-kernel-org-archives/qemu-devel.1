Received: from eggs.gnu.org ([2001:4830:134:3::10]:59163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFk-0004pL-UA
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFj-0003K2-68
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:00 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56257)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJFi-00032p-NV
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:58 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:06:07 -0400
Message-Id: <20181019010625.25294-39-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 38/56] nios: convert to cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>

Cc: Chris Wulff <crwulff@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/nios2/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index fbfaa2ce26..49a75414d3 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -36,7 +36,7 @@ static void nios2_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool nios2_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
+    return cpu_interrupt_request(cs) & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
 
 /* CPUClass::reset() */
-- 
2.17.1
