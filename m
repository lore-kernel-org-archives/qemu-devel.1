Received: from eggs.gnu.org ([2001:4830:134:3::10]:56181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCy-0007yl-8W
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCw-00028H-HX
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:47 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46771)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gXJCw-0001oW-5E
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:46 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 13 Dec 2018 00:04:40 -0500
Message-Id: <20181213050453.9677-61-cota@braap.org>
In-Reply-To: <20181213050453.9677-1-cota@braap.org>
References: <20181213050453.9677-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v5 60/73] cpu: convert to interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This finishes the conversion to interrupt_request.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 qom/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qom/cpu.c b/qom/cpu.c
index 44b78f1892..7452109833 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -275,7 +275,7 @@ static void cpu_common_reset(CPUState *cpu)
         log_cpu_state(cpu, cc->reset_dump_flags);
     }
 
-    cpu->interrupt_request = 0;
+    cpu_interrupt_request_set(cpu, 0);
     cpu_halted_set(cpu, 0);
     cpu->mem_io_pc = 0;
     cpu->mem_io_vaddr = 0;
@@ -410,7 +410,7 @@ static vaddr cpu_adjust_watchpoint_address(CPUState *cpu, vaddr addr, int len)
 
 static void generic_handle_interrupt(CPUState *cpu, int mask)
 {
-    cpu->interrupt_request |= mask;
+    cpu_interrupt_request_or(cpu, mask);
 
     if (!qemu_cpu_is_self(cpu)) {
         qemu_cpu_kick(cpu);
-- 
2.17.1
