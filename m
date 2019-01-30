Received: from eggs.gnu.org ([209.51.188.92]:35746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe40-0000CK-Tt
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe40-0001U5-1g
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:12 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60547)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe3y-00017b-Rn
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:10 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:51 -0500
Message-Id: <20190130004811.27372-54-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 53/73] alpha: convert to
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
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/alpha/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 1fd95d6c0f..cebd459251 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -42,10 +42,10 @@ static bool alpha_cpu_has_work(CPUState *cs)
        assume that if a CPU really wants to stay asleep, it will mask
        interrupts at the chipset level, which will prevent these bits
        from being set in the first place.  */
-    return cs->interrupt_request & (CPU_INTERRUPT_HARD
-                                    | CPU_INTERRUPT_TIMER
-                                    | CPU_INTERRUPT_SMP
-                                    | CPU_INTERRUPT_MCHK);
+    return cpu_interrupt_request(cs) & (CPU_INTERRUPT_HARD
+                                        | CPU_INTERRUPT_TIMER
+                                        | CPU_INTERRUPT_SMP
+                                        | CPU_INTERRUPT_MCHK);
 }
 
 static void alpha_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
-- 
2.17.1
