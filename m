Received: from eggs.gnu.org ([2001:4830:134:3::10]:54873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtez-0007Q7-LF
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtey-0001xh-CF
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:25 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 23 Jan 2018 09:08:04 +0100
Message-Id: <1516694904-64879-6-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 05/25] alpha: cpu: add CPU_RESOLVING_TYPE
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
Cc: Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Richard Henderson <rth@twiddle.net>

it will be used for providing to cpu name resolving class for
parsing cpu model for system and user emulation code.

Along with change add target to null-machine test, so
that when switch to CPU_RESOLVING_TYPE happens,
test would ensure that null-mchine usecase still works.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Richard Henderson <rth@twiddle.net>
---
 target/alpha/cpu.h        | 1 +
 tests/machine-none-test.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 0a9ad35..21ed5d6 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -472,6 +472,7 @@ void alpha_translate_init(void);
 
 #define ALPHA_CPU_TYPE_SUFFIX "-" TYPE_ALPHA_CPU
 #define ALPHA_CPU_TYPE_NAME(model) model ALPHA_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_ALPHA_CPU
 
 void alpha_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 /* you can call this signal handler from your SIGBUS and SIGSEGV
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index 4b704fb..5d23ade 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -28,6 +28,7 @@ static struct arch2cpu cpus_map[] = {
     { "aarch64", "cortex-a15" },
     { "x86_64", "qemu64,apic-id=0" },
     { "i386", "qemu32,apic-id=0" },
+    { "alpha", "ev67" },
 };
 
 static const char *get_cpu_model_by_arch(const char *arch)
-- 
2.7.4
