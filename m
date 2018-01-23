Received: from eggs.gnu.org ([2001:4830:134:3::10]:55106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtf9-0007bn-Fr
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtf4-00022J-MN
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:35 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 23 Jan 2018 09:08:09 +0100
Message-Id: <1516694904-64879-11-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 10/25] mips: cpu: add CPU_RESOLVING_TYPE
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
Cc: Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

it will be used for providing to cpu name resolving class for
parsing cpu model for system and user emulation code.

Along with change add target to null-machine test, so
that when switch to CPU_RESOLVING_TYPE happens,
test would ensure that null-mchine usecase still works.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Aurelien Jarno <aurelien@aurel32.net>
CC: Yongbok Kim <yongbok.kim@mips.com>
---
 target/mips/cpu.h         | 1 +
 tests/machine-none-test.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 7f8ba5f..0fcbfb3 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -743,6 +743,7 @@ int cpu_mips_signal_handler(int host_signum, void *pinfo, void *puc);
 
 #define MIPS_CPU_TYPE_SUFFIX "-" TYPE_MIPS_CPU
 #define MIPS_CPU_TYPE_NAME(model) model MIPS_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_MIPS_CPU
 
 bool cpu_supports_cps_smp(const char *cpu_type);
 bool cpu_supports_isa(const char *cpu_type, unsigned int isa);
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index 984def6..9bc6a06 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -34,6 +34,10 @@ static struct arch2cpu cpus_map[] = {
     { "m68k", "m5206" },
     /* FIXME: { "microblaze", "any" }, doesn't work with -M none -cpu any */
     /* FIXME: { "microblazeel", "any" }, doesn't work with -M none -cpu any */
+    { "mips", "4Kc" },
+    { "mipsel", "4Kc" },
+    { "mips64", "20Kc" },
+    { "mips64el", "20Kc" },
 };
 
 static const char *get_cpu_model_by_arch(const char *arch)
-- 
2.7.4
