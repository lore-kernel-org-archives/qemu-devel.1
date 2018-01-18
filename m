Received: from eggs.gnu.org ([2001:4830:134:3::10]:47015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ecE6b-0004Un-Dg
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:36:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ecE6a-000826-Hk
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:36:01 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 18 Jan 2018 18:34:02 +0100
Message-Id: <1516296842-136976-6-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516296842-136976-1-git-send-email-imammedo@redhat.com>
References: <1516296842-136976-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC v2 5/5] x86: cpu: add CPU_RESOLVING_TYPE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org

it will be used for providing to cpu name resolving class for
  cpu_parse_cpu_model(CPU_RESOLVING_TYPE, ...)
in null-machine.c and in linux-user/main.c

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 target/i386/cpu.h    | 3 +++
 tests/machine-none.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f64e5ed..a1712fc 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1568,6 +1568,9 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 #define TARGET_DEFAULT_CPU_TYPE X86_CPU_TYPE_NAME("qemu32")
 #endif
 
+/* used to get target's callback in cpu_parse_cpu_model() */
+#define CPU_RESOLVING_TYPE TYPE_X86_CPU
+
 #define cpu_signal_handler cpu_x86_signal_handler
 #define cpu_list x86_cpu_list
 
diff --git a/tests/machine-none.c b/tests/machine-none.c
index 7f64532..8a306ba 100644
--- a/tests/machine-none.c
+++ b/tests/machine-none.c
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
