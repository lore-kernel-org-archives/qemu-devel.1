Received: from eggs.gnu.org ([2001:4830:134:3::10]:52130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gBCpZ-0003iD-Mr
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 01:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gBCpV-0005e5-JH
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 01:51:17 -0400
Received: from m12-15.163.com ([220.181.12.15]:39934)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gBCpU-0005Pi-N1
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 01:51:13 -0400
From: Li Qiang <liq3ea@163.com>
Date: Fri, 12 Oct 2018 22:51:03 -0700
Message-Id: <20181013055103.51451-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH] hw: edu: drop DO_UPCAST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/misc/edu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 0687ffd343..cdcf550dd7 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -342,7 +342,7 @@ static void *edu_fact_thread(void *opaque)
 
 static void pci_edu_realize(PCIDevice *pdev, Error **errp)
 {
-    EduState *edu = DO_UPCAST(EduState, pdev, pdev);
+    EduState *edu = EDU(pdev);
     uint8_t *pci_conf = pdev->config;
 
     pci_config_set_interrupt_pin(pci_conf, 1);
@@ -365,7 +365,7 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
 
 static void pci_edu_uninit(PCIDevice *pdev)
 {
-    EduState *edu = DO_UPCAST(EduState, pdev, pdev);
+    EduState *edu = EDU(pdev);
 
     qemu_mutex_lock(&edu->thr_mutex);
     edu->stopping = true;
-- 
2.17.1
