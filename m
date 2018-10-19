Received: from eggs.gnu.org ([2001:4830:134:3::10]:59171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFl-0004pT-23
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFj-0003KS-D8
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:00 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35349)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJFi-00032F-VL
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:59 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:06:03 -0400
Message-Id: <20181019010625.25294-35-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 34/56] hppa: convert to cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Cc: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/hppa/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 00bf444620..1ab4e62850 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -60,7 +60,7 @@ static void hppa_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
 
 static bool hppa_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & CPU_INTERRUPT_HARD;
+    return cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD;
 }
 
 static void hppa_cpu_disas_set_info(CPUState *cs, disassemble_info *info)
-- 
2.17.1
