Received: from eggs.gnu.org ([2001:4830:134:3::10]:54750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtet-0007Ji-Du
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtes-0001v9-Il
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:19 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 23 Jan 2018 09:08:03 +0100
Message-Id: <1516694904-64879-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 04/25] x86: cpu: add CPU_RESOLVING_TYPE macro
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
CC: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h         | 1 +
 tests/machine-none-test.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 30cc562..82c7381 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1568,6 +1568,7 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 
 #define X86_CPU_TYPE_SUFFIX "-" TYPE_X86_CPU
 #define X86_CPU_TYPE_NAME(name) (name X86_CPU_TYPE_SUFFIX)
+#define CPU_RESOLVING_TYPE TYPE_X86_CPU
 
 #ifdef TARGET_X86_64
 #define TARGET_DEFAULT_CPU_TYPE X86_CPU_TYPE_NAME("qemu64")
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index 1b213ff..4b704fb 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -26,6 +26,8 @@ static struct arch2cpu cpus_map[] = {
     /* tested targets list */
     { "arm", "cortex-a15" },
     { "aarch64", "cortex-a15" },
+    { "x86_64", "qemu64,apic-id=0" },
+    { "i386", "qemu32,apic-id=0" },
 };
 
 static const char *get_cpu_model_by_arch(const char *arch)
-- 
2.7.4
