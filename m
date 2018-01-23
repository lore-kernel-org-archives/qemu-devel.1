Received: from eggs.gnu.org ([2001:4830:134:3::10]:55148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtfA-0007d1-EC
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtf9-00024k-6d
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:36 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 23 Jan 2018 09:08:10 +0100
Message-Id: <1516694904-64879-12-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 11/25] moxie: cpu: add CPU_RESOLVING_TYPE
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
Cc: Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Anthony Green <green@moxielogic.com>

it will be used for providing to cpu name resolving class for
parsing cpu model for system and user emulation code.

Along with change add target to null-machine test, so
that when switch to CPU_RESOLVING_TYPE happens,
test would ensure that null-mchine usecase still works.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Anthony Green <green@moxielogic.com>
---
 target/moxie/cpu.h        | 1 +
 tests/machine-none-test.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index d37e6a5..3f94a5a 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -124,6 +124,7 @@ int cpu_moxie_signal_handler(int host_signum, void *pinfo,
 
 #define MOXIE_CPU_TYPE_SUFFIX "-" TYPE_MOXIE_CPU
 #define MOXIE_CPU_TYPE_NAME(model) model MOXIE_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_MOXIE_CPU
 
 #define cpu_signal_handler cpu_moxie_signal_handler
 
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index 9bc6a06..c15a857 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -38,6 +38,7 @@ static struct arch2cpu cpus_map[] = {
     { "mipsel", "4Kc" },
     { "mips64", "20Kc" },
     { "mips64el", "20Kc" },
+    { "moxie", "MoxieLite" },
 };
 
 static const char *get_cpu_model_by_arch(const char *arch)
-- 
2.7.4
