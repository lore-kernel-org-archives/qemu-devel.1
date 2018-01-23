Received: from eggs.gnu.org ([2001:4830:134:3::10]:55379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtfJ-0007qM-8l
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtfF-0002AD-7K
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:45 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 23 Jan 2018 09:08:12 +0100
Message-Id: <1516694904-64879-14-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 13/25] openrisc: cpu: add CPU_RESOLVING_TYPE
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
Cc: Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>

it will be used for providing to cpu name resolving class for
parsing cpu model for system and user emulation code.

Along with change add target to null-machine test, so
that when switch to CPU_RESOLVING_TYPE happens,
test would ensure that null-mchine usecase still works.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/cpu.h     | 1 +
 tests/machine-none-test.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index cc22dc8..9b32ea4 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -394,6 +394,7 @@ int cpu_openrisc_get_phys_data(OpenRISCCPU *cpu,
 
 #define OPENRISC_CPU_TYPE_SUFFIX "-" TYPE_OPENRISC_CPU
 #define OPENRISC_CPU_TYPE_NAME(model) model OPENRISC_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_OPENRISC_CPU
 
 #include "exec/cpu-all.h"
 
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index c6ad495..160aa13 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -40,6 +40,7 @@ static struct arch2cpu cpus_map[] = {
     { "mips64el", "20Kc" },
     { "moxie", "MoxieLite" },
     { "nios2", "FIXME" },
+    { "or1k", "or1200" },
 };
 
 static const char *get_cpu_model_by_arch(const char *arch)
-- 
2.7.4
