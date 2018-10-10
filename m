Received: from eggs.gnu.org ([2001:4830:134:3::10]:54693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gAH4O-0004t4-LW
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 12:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gAH4J-0007bZ-KN
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 12:10:44 -0400
From: Li Qiang <liq3ea@163.com>
Date: Wed, 10 Oct 2018 09:10:25 -0700
Message-Id: <20181010161025.34796-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH] machine: fix a typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Li Qiang <liq3ea@163.com>

Cc: qemu-trivial@nongnu.org
Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/core/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1987557833..da50ad6de7 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -636,7 +636,7 @@ static void machine_class_init(ObjectClass *oc, void *data)
         machine_get_memory_encryption, machine_set_memory_encryption,
         &error_abort);
     object_class_property_set_description(oc, "memory-encryption",
-        "Set memory encyption object to use", &error_abort);
+        "Set memory encryption object to use", &error_abort);
 }
 
 static void machine_class_base_init(ObjectClass *oc, void *data)
-- 
2.17.1
