Received: from eggs.gnu.org ([2001:4830:134:3::10]:55581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpuV-0005Pi-B7
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpuR-0008W1-Jc
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ebpuR-0008US-EB
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:51 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 17 Jan 2018 16:43:27 +0100
Message-Id: <1516203816-19374-16-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 15/24] tricore: cpu: add
 TARGET_DEFAULT_CPU_TYPE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

it will be used for for 2 purposes, 1st is to
provide to cpu name resolving class for machine 'none'
  cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model)
and later to drop a bunch of ifdefs *-user/main.c that
set default cpu_model.

linux-user defaults to catch all 'any' which is bogus
and results into error. Pick arbitrary model "tc1796"
for TARGET_DEFAULT_CPU_TYPE to use and it would fix
missing default when *-user is switched to using types
instead of cpu_model.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index f41d2ce..835d51a 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -415,6 +415,7 @@ static inline void cpu_get_tb_cpu_state(CPUTriCoreState *env, target_ulong *pc,
 
 #define TRICORE_CPU_TYPE_SUFFIX "-" TYPE_TRICORE_CPU
 #define TRICORE_CPU_TYPE_NAME(model) model TRICORE_CPU_TYPE_SUFFIX
+#define TARGET_DEFAULT_CPU_TYPE TRICORE_CPU_TYPE_NAME("tc1796")
 
 /* helpers.c */
 int cpu_tricore_handle_mmu_fault(CPUState *cpu, target_ulong address,
-- 
2.7.4
