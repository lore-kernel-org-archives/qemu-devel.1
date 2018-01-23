Received: from eggs.gnu.org ([2001:4830:134:3::10]:55280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtfD-0007iR-Mu
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtfC-00028H-QH
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:39 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 23 Jan 2018 09:08:13 +0100
Message-Id: <1516694904-64879-15-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 14/25] ppc: cpu: add CPU_RESOLVING_TYPE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

it will be used for providing to cpu name resolving class for
parsing cpu model for system and user emulation code.

Along with change add target to null-machine test, so
that when switch to CPU_RESOLVING_TYPE happens,
test would ensure that null-mchine usecase still works.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Laurent Vivier <laurent@vivier.eu>
CC: David Gibson <david@gibson.dropbear.id.au>
CC: Alexander Graf <agraf@suse.de>
CC: qemu-ppc@nongnu.org
---
 target/ppc/cpu.h          | 1 +
 tests/machine-none-test.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 603a38c..d5f2f3d 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1380,6 +1380,7 @@ int ppc_dcr_write (ppc_dcr_t *dcr_env, int dcrn, uint32_t val);
 
 #define POWERPC_CPU_TYPE_SUFFIX "-" TYPE_POWERPC_CPU
 #define POWERPC_CPU_TYPE_NAME(model) model POWERPC_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_POWERPC_CPU
 
 #define cpu_signal_handler cpu_ppc_signal_handler
 #define cpu_list ppc_cpu_list
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index 160aa13..052b8c0 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -41,6 +41,9 @@ static struct arch2cpu cpus_map[] = {
     { "moxie", "MoxieLite" },
     { "nios2", "FIXME" },
     { "or1k", "or1200" },
+    { "ppc", "604" },
+    { "ppc64", "power8e_v2.1" },
+    { "ppcemb", "440epb" },
 };
 
 static const char *get_cpu_model_by_arch(const char *arch)
-- 
2.7.4
