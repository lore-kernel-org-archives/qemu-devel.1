Received: from eggs.gnu.org ([2001:4830:134:3::10]:44970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fIXx2-0004bs-OY
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fIXwy-0004WK-Or
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:17:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60626 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fIXwy-0004W5-KF
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:17:00 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 15 May 2018 13:16:13 +0200
Message-Id: <1526382973-49342-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH] riscv: remove define cpu_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mjc@sifive.com, palmer@sifive.com

cpu_init() was removed since 2.12, so drop define that now isn't used
nad point to nowhere.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 target/riscv/cpu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 34abc38..0562a02 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -251,7 +251,6 @@ int riscv_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
 char *riscv_isa_string(RISCVCPU *cpu);
 void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_RISCV_CPU, cpu_model)
 #define cpu_signal_handler cpu_riscv_signal_handler
 #define cpu_list riscv_cpu_list
 #define cpu_mmu_index riscv_cpu_mmu_index
-- 
2.7.4
