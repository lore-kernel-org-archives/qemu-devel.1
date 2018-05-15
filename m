Received: from eggs.gnu.org ([2001:4830:134:3::10]:47489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fIcNk-0007Q0-96
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fIcNa-0007dt-Nw
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:00:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51304 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fIcNa-0007dm-Jp
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:00:46 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 15 May 2018 18:00:00 +0200
Message-Id: <1526400000-66561-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <1526382973-49342-1-git-send-email-imammedo@redhat.com>
References: <1526382973-49342-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] riscv: remove define cpu_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, mjc@sifive.com, palmer@sifive.com, f4bug@amsat.org

cpu_init() was removed since 2.12, so drop the define that is now unused.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
v2:
  * refine commit message (Eric Blake <eblake@redhat.com>)
---
 target/riscv/cpu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 34abc38..0562a02 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -251,7 +251,6 @@ int riscv_cpu_handle_mmu_fault(CPUState *cpu, vaddr a=
ddress, int size,
 char *riscv_isa_string(RISCVCPU *cpu);
 void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf);
=20
-#define cpu_init(cpu_model) cpu_generic_init(TYPE_RISCV_CPU, cpu_model)
 #define cpu_signal_handler cpu_riscv_signal_handler
 #define cpu_list riscv_cpu_list
 #define cpu_mmu_index riscv_cpu_mmu_index
--=20
2.7.4
