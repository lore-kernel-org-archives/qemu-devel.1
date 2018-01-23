Received: from eggs.gnu.org ([2001:4830:134:3::10]:55441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtfK-0007sK-PF
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtfJ-0002CT-Dp
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:46 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 23 Jan 2018 09:08:15 +0100
Message-Id: <1516694904-64879-17-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 16/25] sh4: cpu: add CPU_RESOLVING_TYPE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

it will be used for providing to cpu name resolving class for
parsing cpu model for system and user emulation code.

Along with change add target to null-machine test, so
that when switch to CPU_RESOLVING_TYPE happens,
test would ensure that null-mchine usecase still works.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/cpu.h          | 1 +
 tests/machine-none-test.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index a2c26e0..709e0ca 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -278,6 +278,7 @@ void cpu_load_tlb(CPUSH4State * env);
 
 #define SUPERH_CPU_TYPE_SUFFIX "-" TYPE_SUPERH_CPU
 #define SUPERH_CPU_TYPE_NAME(model) model SUPERH_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_SUPERH_CPU
 
 #define cpu_signal_handler cpu_sh4_signal_handler
 #define cpu_list sh4_cpu_list
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index b3a346d..134036a 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -45,6 +45,8 @@ static struct arch2cpu cpus_map[] = {
     { "ppc64", "power8e_v2.1" },
     { "ppcemb", "440epb" },
     { "s390x", "qemu" },
+    { "sh4", "sh7750r" },
+    { "sh4eb", "sh7751r" },
 };
 
 static const char *get_cpu_model_by_arch(const char *arch)
-- 
2.7.4
