Received: from eggs.gnu.org ([2001:4830:134:3::10]:54904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtf0-0007Qc-TL
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtez-0001z6-Nh
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:26 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 23 Jan 2018 09:08:06 +0100
Message-Id: <1516694904-64879-8-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 07/25] lm32: cpu: add CPU_RESOLVING_TYPE
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
Cc: Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Michael Walle <michael@walle.cc>

it will be used for providing to cpu name resolving class for
parsing cpu model for system and user emulation code.

Along with change add target to null-machine test, so
that when switch to CPU_RESOLVING_TYPE happens,
test would ensure that null-mchine usecase still works.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Michael Walle <michael@walle.cc>
---
 target/lm32/cpu.h         | 1 +
 tests/machine-none-test.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index 2279594..0656052 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -259,6 +259,7 @@ bool lm32_cpu_do_semihosting(CPUState *cs);
 
 #define LM32_CPU_TYPE_SUFFIX "-" TYPE_LM32_CPU
 #define LM32_CPU_TYPE_NAME(model) model LM32_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_LM32_CPU
 
 #define cpu_list lm32_cpu_list
 #define cpu_signal_handler cpu_lm32_signal_handler
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index 68f7a30..1159290 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -30,6 +30,7 @@ static struct arch2cpu cpus_map[] = {
     { "i386", "qemu32,apic-id=0" },
     { "alpha", "ev67" },
     { "cris", "crisv32" },
+    { "lm32", "lm32-full" },
 };
 
 static const char *get_cpu_model_by_arch(const char *arch)
-- 
2.7.4
