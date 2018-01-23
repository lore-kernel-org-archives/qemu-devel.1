Received: from eggs.gnu.org ([2001:4830:134:3::10]:55594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtfO-0007ys-KQ
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtfN-0002Fi-Qn
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:50 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 23 Jan 2018 09:08:19 +0100
Message-Id: <1516694904-64879-21-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 20/25] xtensa: cpu: add CPU_RESOLVING_TYPE
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
Cc: Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>

it will be used for providing to cpu name resolving class for
parsing cpu model for system and user emulation code.

Along with change add target to null-machine test, so
that when switch to CPU_RESOLVING_TYPE happens,
test would ensure that null-mchine usecase still works.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h       | 1 +
 tests/machine-none-test.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index d9404aa..23dbd45 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -500,6 +500,7 @@ void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
 
 #define XTENSA_CPU_TYPE_SUFFIX "-" TYPE_XTENSA_CPU
 #define XTENSA_CPU_TYPE_NAME(model) model XTENSA_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_XTENSA_CPU
 
 #ifdef TARGET_WORDS_BIGENDIAN
 #define XTENSA_DEFAULT_CPU_MODEL "fsf"
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index a8a499e..a1e9980 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -51,6 +51,8 @@ static struct arch2cpu cpus_map[] = {
     { "sparc64", "Fujitsu Sparc64" },
     { "tricore", "tc1796" },
     { "unicore32", "UniCore-II" },
+    { "xtensa", "dc233c" },
+    { "xtensaeb", "fsf" },
 };
 
 static const char *get_cpu_model_by_arch(const char *arch)
-- 
2.7.4
