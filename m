Received: from eggs.gnu.org ([2001:4830:134:3::10]:54973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtf3-0007TU-LW
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtf2-00020t-Dk
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:29 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 23 Jan 2018 09:08:08 +0100
Message-Id: <1516694904-64879-10-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 09/25] microblaze: cpu: add
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
Cc: Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

it will be used for providing to cpu name resolving class for
parsing cpu model for system and user emulation code.

PC:
 target cpu can't be instantiated with -M none -cpu
 Add FIXME note in test, so microblaze maintainers
 could fix it in future and add proper error checking
 in cpu_model resolver which accepts any junk now.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
---
 target/microblaze/cpu.h   | 1 +
 tests/machine-none-test.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 52b6b6a..492f9f7 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -344,6 +344,7 @@ int cpu_mb_signal_handler(int host_signum, void *pinfo,
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_MICROBLAZE_CPU, cpu_model)
+#define CPU_RESOLVING_TYPE TYPE_MICROBLAZE_CPU
 
 #define cpu_signal_handler cpu_mb_signal_handler
 
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index c9445b6..984def6 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -32,6 +32,8 @@ static struct arch2cpu cpus_map[] = {
     { "cris", "crisv32" },
     { "lm32", "lm32-full" },
     { "m68k", "m5206" },
+    /* FIXME: { "microblaze", "any" }, doesn't work with -M none -cpu any */
+    /* FIXME: { "microblazeel", "any" }, doesn't work with -M none -cpu any */
 };
 
 static const char *get_cpu_model_by_arch(const char *arch)
-- 
2.7.4
