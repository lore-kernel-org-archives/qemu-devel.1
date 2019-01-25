Received: from eggs.gnu.org ([209.51.188.92]:37661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sourav.jb1988@gmail.com>) id 1gn3CP-0008UD-FS
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:15:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sourav.jb1988@gmail.com>) id 1gn3CO-0007Pg-QY
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:15:17 -0500
From: kumar sourav <sourav.jb1988@gmail.com>
Date: Fri, 25 Jan 2019 20:44:40 +0530
Message-Id: <20190125151440.13794-1-sourav.jb1988@gmail.com>
Subject: [Qemu-devel] [PATCH] hw: input: set category of the i8042 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, thuth@redhat.com

Sets the category of i8042 device as DEVICE_CATEGORY_INPUT
Devices should be assigned to one of DEVICE_CATEGORY_XXXX.

Signed-off-by: kumar sourav <sourav.jb1988@gmail.com>
---
 hw/input/pckbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index 3e66713b47..72e7d5f6cc 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -574,6 +574,7 @@ static void i8042_class_initfn(ObjectClass *klass, void *data)
 
     dc->realize = i8042_realizefn;
     dc->vmsd = &vmstate_kbd_isa;
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
 
 static const TypeInfo i8042_info = {
-- 
2.17.1
