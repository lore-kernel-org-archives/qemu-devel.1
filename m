Received: from eggs.gnu.org ([209.51.188.92]:44941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sBC-0000T7-O3
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:19:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sBA-00025U-FC
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:19:10 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:55515)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1h0sB9-0001M0-WF
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:19:08 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  4 Mar 2019 13:18:00 -0500
Message-Id: <20190304181813.8075-61-cota@braap.org>
In-Reply-To: <20190304181813.8075-1-cota@braap.org>
References: <20190304181813.8075-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 60/73] cpu: convert to interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This finishes the conversion to interrupt_request.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 qom/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qom/cpu.c b/qom/cpu.c
index 00add81a7f..f2695be9b2 100644
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
@@ -412,7 +412,7 @@ static vaddr cpu_adjust_watchpoint_address(CPUState *cpu, vaddr addr, int len)
 
 static void generic_handle_interrupt(CPUState *cpu, int mask)
 {
-    cpu->interrupt_request |= mask;
+    cpu_interrupt_request_or(cpu, mask);
 
     if (!qemu_cpu_is_self(cpu)) {
         qemu_cpu_kick(cpu);
-- 
2.17.1
