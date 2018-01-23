Received: from eggs.gnu.org ([2001:4830:134:3::10]:55495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtfL-0007uM-TZ
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtfK-0002DK-Hv
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:47 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 23 Jan 2018 09:08:17 +0100
Message-Id: <1516694904-64879-19-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 18/25] tricore: cpu: add CPU_RESOLVING_TYPE
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

it will be used for providing to cpu name resolving class for
parsing cpu model for system and user emulation code.

Along with change add target to null-machine test, so
that when switch to CPU_RESOLVING_TYPE happens,
test would ensure that null-mchine usecase still works.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/cpu.h      | 1 +
 tests/machine-none-test.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index f41d2ce..a2ef632 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -415,6 +415,7 @@ static inline void cpu_get_tb_cpu_state(CPUTriCoreState *env, target_ulong *pc,
 
 #define TRICORE_CPU_TYPE_SUFFIX "-" TYPE_TRICORE_CPU
 #define TRICORE_CPU_TYPE_NAME(model) model TRICORE_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_TRICORE_CPU
 
 /* helpers.c */
 int cpu_tricore_handle_mmu_fault(CPUState *cpu, target_ulong address,
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index 0f80d7b..0430b06 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -49,6 +49,7 @@ static struct arch2cpu cpus_map[] = {
     { "sh4eb", "sh7751r" },
     { "sparc", "LEON2" },
     { "sparc64", "Fujitsu Sparc64" },
+    { "tricore", "tc1796" },
 };
 
 static const char *get_cpu_model_by_arch(const char *arch)
-- 
2.7.4
