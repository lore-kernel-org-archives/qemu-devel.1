Received: from eggs.gnu.org ([2001:4830:134:3::10]:34353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cbJ7j-0007Y1-9i
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 22:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cbJ7g-0000Q2-6U
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 22:40:51 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cbJ7g-0000Pu-0L
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 22:40:48 -0500
Received: by mail-pg0-x241.google.com with SMTP id 194so13852973pgd.0
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 19:40:47 -0800 (PST)
Message-ID: <589a933e.54c0620a.e6952.a4c6@mx.google.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue,  7 Feb 2017 19:40:32 -0800
Subject: [Qemu-devel] [PATCH] misc: edu: free dma timer in device unit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jslaby@suse.cz, qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: Li Qiang <liqiang6-s@360.cn>

From: Li Qiang <liqiang6-s@360.cn>

This can avoid a memory leak when hotplug and unplug.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
---
 hw/misc/edu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 401039c..7565552 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -375,6 +375,7 @@ static void pci_edu_uninit(PCIDevice *pdev)
     qemu_mutex_destroy(&edu->thr_mutex);
 
     timer_del(&edu->dma_timer);
+    timer_free(&edu->dma_timer);
 }
 
 static void edu_obj_uint64(Object *obj, Visitor *v, const char *name,
-- 
1.8.3.1
