Received: from eggs.gnu.org ([209.51.188.92]:44681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gigse-0003dt-Hq
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 09:36:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gigsd-0000SG-SW
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 09:36:52 -0500
Received: from m50-111.126.com ([123.125.50.111]:39474)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gigsc-0000Q4-Hs
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 09:36:51 -0500
From: Fei Li <lifei1214@126.com>
Date: Sun, 13 Jan 2019 22:36:41 +0800
Message-Id: <20190113143641.38936-1-lifei1214@126.com>
Subject: [Qemu-devel] [PATCH] hw/misc/edu: add msi_uninit() for
 pci_edu_uninit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, shirley17fei@gmail.com
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Fei Li <shirley17fei@gmail.com>

Let's supplement the msi_uninit() when failing to realize
the pci edu device.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Fei Li <shirley17fei@gmail.com>
---
 hw/misc/edu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index cdcf550dd7..4feb7503de 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -367,6 +367,7 @@ static void pci_edu_uninit(PCIDevice *pdev)
 {
     EduState *edu = EDU(pdev);
 
+    msi_uninit(pdev);
     qemu_mutex_lock(&edu->thr_mutex);
     edu->stopping = true;
     qemu_mutex_unlock(&edu->thr_mutex);
-- 
2.17.2 (Apple Git-113)
