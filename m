Received: from eggs.gnu.org ([209.51.188.92]:35337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gj20n-0006fC-UJ
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:10:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gj20m-0007sF-O4
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:10:41 -0500
Received: from m50-111.126.com ([123.125.50.111]:51086)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gj20j-0007jC-F6
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:10:40 -0500
From: Fei Li <lifei1214@126.com>
Date: Mon, 14 Jan 2019 21:10:15 +0800
Message-Id: <20190114131015.52967-1-lifei1214@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] hw/misc/edu: add msi_uninit() for
 pci_edu_uninit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jiri Slaby <jslaby@suse.cz>, shirley17fei@gmail.com

From: Fei Li <shirley17fei@gmail.com>

Let's supplement the msi_uninit() when failing to realize
the pci edu device.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Fei Li <shirley17fei@gmail.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 hw/misc/edu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index cdcf550dd7..ceaf688bfb 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -377,6 +377,7 @@ static void pci_edu_uninit(PCIDevice *pdev)
     qemu_mutex_destroy(&edu->thr_mutex);
 
     timer_del(&edu->dma_timer);
+    msi_uninit(pdev);
 }
 
 static void edu_obj_uint64(Object *obj, Visitor *v, const char *name,
-- 
2.17.2 (Apple Git-113)
