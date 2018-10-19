Received: from eggs.gnu.org ([2001:4830:134:3::10]:59210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFm-0004qp-D3
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFk-0003M8-9Y
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:02 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:53791)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJFj-00034w-Jg
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:59 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:06:14 -0400
Message-Id: <20181019010625.25294-46-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 45/56] microblaze: convert to
 cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/microblaze/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 9b546a2c18..206fdd8651 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -84,7 +84,7 @@ static void mb_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool mb_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
+    return cpu_interrupt_request(cs) & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.17.1
