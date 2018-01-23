Received: from eggs.gnu.org ([2001:4830:134:3::10]:55026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtf4-0007Uw-O8
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtf2-00020U-Cu
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:30 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 23 Jan 2018 09:08:07 +0100
Message-Id: <1516694904-64879-9-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 08/25] m68k: cpu: add CPU_RESOLVING_TYPE
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
Cc: Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org

it will be used for providing to cpu name resolving class for
parsing cpu model for system and user emulation code.

Along with change add target to null-machine test, so
that when switch to CPU_RESOLVING_TYPE happens,
test would ensure that null-mchine usecase still works.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/cpu.h         | 1 +
 tests/machine-none-test.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 2985b03..8a4299a 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -405,6 +405,7 @@ void register_m68k_insns (CPUM68KState *env);
 
 #define M68K_CPU_TYPE_SUFFIX "-" TYPE_M68K_CPU
 #define M68K_CPU_TYPE_NAME(model) model M68K_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_M68K_CPU
 
 #define cpu_signal_handler cpu_m68k_signal_handler
 #define cpu_list m68k_cpu_list
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index 1159290..c9445b6 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -31,6 +31,7 @@ static struct arch2cpu cpus_map[] = {
     { "alpha", "ev67" },
     { "cris", "crisv32" },
     { "lm32", "lm32-full" },
+    { "m68k", "m5206" },
 };
 
 static const char *get_cpu_model_by_arch(const char *arch)
-- 
2.7.4
