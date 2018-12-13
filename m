Received: from eggs.gnu.org ([2001:4830:134:3::10]:55892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCr-0007rg-VP
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCp-0001ur-5e
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:41 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59637)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gXJCo-0001aa-5h
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:38 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 13 Dec 2018 00:04:25 -0500
Message-Id: <20181213050453.9677-46-cota@braap.org>
In-Reply-To: <20181213050453.9677-1-cota@braap.org>
References: <20181213050453.9677-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 45/73] sh4: convert to cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

Cc: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/sh4/cpu.c    | 2 +-
 target/sh4/helper.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index b9f393b7c7..58ea212f53 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -45,7 +45,7 @@ static void superh_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
 
 static bool superh_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & CPU_INTERRUPT_HARD;
+    return cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD;
 }
 
 /* CPUClass::reset() */
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 2ff0cf4060..8463da5bc8 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -83,7 +83,7 @@ void superh_cpu_do_interrupt(CPUState *cs)
 {
     SuperHCPU *cpu = SUPERH_CPU(cs);
     CPUSH4State *env = &cpu->env;
-    int do_irq = cs->interrupt_request & CPU_INTERRUPT_HARD;
+    int do_irq = cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD;
     int do_exp, irq_vector = cs->exception_index;
 
     /* prioritize exceptions over interrupts */
-- 
2.17.1
