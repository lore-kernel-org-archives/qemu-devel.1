Received: from eggs.gnu.org ([2001:4830:134:3::10]:56183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gHVlE-0005lZ-KG
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:16:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gHVlB-0007vu-8i
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:16:52 -0400
From: Li Qiang <liq3ea@163.com>
Date: Tue, 30 Oct 2018 08:16:37 -0700
Message-Id: <20181030151637.37207-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH] hw: qdev: fix error in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: f4bug@amsat.org, armbru@redhat.com, laurent@vivier.eu
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Li Qiang <liq3ea@163.com>

Cc: qemu-trivial@nongnu.org

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 include/hw/qdev-core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index a24d0dd566..92851e55df 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -197,7 +197,7 @@ typedef struct BusChild {
 
 /**
  * BusState:
- * @hotplug_device: link to a hotplug device associated with bus.
+ * @hotplug_handler: link to a hotplug handler associated with bus.
  */
 struct BusState {
     Object obj;
-- 
2.17.1
