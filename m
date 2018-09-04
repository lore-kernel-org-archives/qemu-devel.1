Received: from eggs.gnu.org ([2001:4830:134:3::10]:58132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=778d471cf=Alistair.Francis@wdc.com>)
	id 1fxKXu-0000FM-9r
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 19:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=778d471cf=Alistair.Francis@wdc.com>)
	id 1fxKXq-0002F9-Cg
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 19:15:42 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:45245)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=778d471cf=Alistair.Francis@wdc.com>)
	id 1fxKXp-0002AQ-Qh
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 19:15:38 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Tue,  4 Sep 2018 16:14:42 -0700
Message-Id: <20180904231442.18932-10-alistair.francis@wdc.com>
In-Reply-To: <20180904231442.18932-1-alistair.francis@wdc.com>
References: <20180904231442.18932-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 9/9] riscv: remove define cpu_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Alistair Francis <alistair.francis@wdc.com>

From: Igor Mammedov <imammedo@redhat.com>

cpu_init() was removed since 2.12, so drop the define that is now unused.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e0608e6d5f..d4f36295f0 100644
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
2.17.1
