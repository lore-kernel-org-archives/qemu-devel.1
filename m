Received: from eggs.gnu.org ([2001:4830:134:3::10]:55563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtfN-0007xh-T3
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtfM-0002F4-R8
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:49 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 23 Jan 2018 09:08:18 +0100
Message-Id: <1516694904-64879-20-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 19/25] unicore32: cpu: add
 CPU_RESOLVING_TYPE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Guan Xuetao <gxt@mprc.pku.edu.cn>

it will be used for providing to cpu name resolving class for
parsing cpu model for system and user emulation code.

Along with change add target to null-machine test, so
that when switch to CPU_RESOLVING_TYPE happens,
test would ensure that null-mchine usecase still works.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Laurent Vivier <laurent@vivier.eu>
CC: Guan Xuetao <gxt@mprc.pku.edu.cn>
---
 target/unicore32/cpu.h    | 1 +
 tests/machine-none-test.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index 3dc6fbc..9644b07 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -169,6 +169,7 @@ static inline int cpu_mmu_index(CPUUniCore32State *env, bool ifetch)
 
 #define UNICORE32_CPU_TYPE_SUFFIX "-" TYPE_UNICORE32_CPU
 #define UNICORE32_CPU_TYPE_NAME(model) model UNICORE32_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_UNICORE32_CPU
 
 static inline void cpu_get_tb_cpu_state(CPUUniCore32State *env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index 0430b06..a8a499e 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -50,6 +50,7 @@ static struct arch2cpu cpus_map[] = {
     { "sparc", "LEON2" },
     { "sparc64", "Fujitsu Sparc64" },
     { "tricore", "tc1796" },
+    { "unicore32", "UniCore-II" },
 };
 
 static const char *get_cpu_model_by_arch(const char *arch)
-- 
2.7.4
