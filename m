Received: from eggs.gnu.org ([209.51.188.92]:59512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMnO-0005pm-70
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMnN-000567-9k
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:14:46 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 19 Apr 2019 03:14:26 -0300
Message-Id: <20190419061429.17695-5-ehabkost@redhat.com>
In-Reply-To: <20190419061429.17695-1-ehabkost@redhat.com>
References: <20190419061429.17695-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 4/7] arm: Remove special case for "any" CPU
 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org

We already have an entry for "any" at arm_cpus[], which makes a
"any-arm-cpu" QOM type be registered.  This means the regular QOM
type name lookup code already works and there's no need for a
special case.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
---
 target/arm/cpu.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6848d9c94d..dcc65093d9 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1213,14 +1213,6 @@ static ObjectClass *arm_cpu_class_by_name(const char *cpu_model)
     ObjectClass *oc;
     char *typename;
 
-#ifdef CONFIG_USER_ONLY
-    /* For backwards compatibility usermode emulation allows "-cpu any",
-     * which has the same semantics as "-cpu max".
-     */
-    if (!strcmp(cpu_model, "any")) {
-        cpu_model = "max";
-    }
-#endif
     typename = g_strdup_printf(ARM_CPU_TYPE_NAME("%s"), cpu_model);
     oc = object_class_by_name(typename);
     g_free(typename);
-- 
2.18.0.rc1.1.g3f1ff2140
