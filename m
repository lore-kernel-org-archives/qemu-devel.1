Received: from eggs.gnu.org ([2001:4830:134:3::10]:55202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtfB-0007ew-OS
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtfA-00026Q-Iu
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:37 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 23 Jan 2018 09:08:11 +0100
Message-Id: <1516694904-64879-13-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 12/25] nios2: cpu: add CPU_RESOLVING_TYPE
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
Cc: Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>

it will be used for providing to cpu name resolving class for
parsing cpu model for system and user emulation code.

Along with change add target to null-machine test, so
that when switch to CPU_RESOLVING_TYPE happens,
test would ensure that null-mchine usecase still works.

TODO:
 make nios2_cpu_class_by_name() to do name check instead of
 accepting anything

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Chris Wulff <crwulff@gmail.com>
CC: Marek Vasut <marex@denx.de>
---
 target/nios2/cpu.h        | 1 +
 tests/machine-none-test.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 88823a6..2234bff 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -232,6 +232,7 @@ void nios2_check_interrupts(CPUNios2State *env);
 #endif
 
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_NIOS2_CPU, cpu_model)
+#define CPU_RESOLVING_TYPE TYPE_NIOS2_CPU
 
 #define cpu_gen_code cpu_nios2_gen_code
 #define cpu_signal_handler cpu_nios2_signal_handler
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index c15a857..c6ad495 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -39,6 +39,7 @@ static struct arch2cpu cpus_map[] = {
     { "mips64", "20Kc" },
     { "mips64el", "20Kc" },
     { "moxie", "MoxieLite" },
+    { "nios2", "FIXME" },
 };
 
 static const char *get_cpu_model_by_arch(const char *arch)
-- 
2.7.4
