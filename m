Received: from eggs.gnu.org ([2001:4830:134:3::10]:44158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dBGVE-0003SN-Al
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dBGVD-00028Z-J7
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:09:44 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 18 May 2017 10:09:31 +0200
Message-Id: <1495094971-177754-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1495094971-177754-1-git-send-email-imammedo@redhat.com>
References: <1495094971-177754-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] numa: silence incomplete mapping warning
 under qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>, Markus Armbruster <armbru@redhat.com>

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Markus Armbruster <armbru@redhat.com>

---
 hw/core/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 2e91aa9..21ebef8 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -21,6 +21,7 @@
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
 #include "sysemu/numa.h"
+#include "sysemu/qtest.h"
 
 static char *machine_get_accel(Object *obj, Error **errp)
 {
@@ -732,7 +733,7 @@ static void machine_numa_finish_init(MachineState *machine)
             }
         }
     }
-    if (s->len) {
+    if (s->len && !qtest_enabled()) {
         error_report("warning: CPU(s) not present in any NUMA nodes: %s",
                      s->str);
         error_report("warning: All CPU(s) up to maxcpus should be described "
-- 
2.7.4
