Received: from eggs.gnu.org ([209.51.188.92]:33532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sourav.jb1988@gmail.com>) id 1gnhGx-0001ga-UM
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 05:02:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sourav.jb1988@gmail.com>) id 1gnhGx-0006B5-8q
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 05:02:39 -0500
From: kumar sourav <sourav.jb1988@gmail.com>
Date: Sun, 27 Jan 2019 15:32:15 +0530
Message-Id: <20190127100215.12584-1-sourav.jb1988@gmail.com>
Subject: [Qemu-devel] [PATCH] hw/input/adb.c: set device category of adb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: david@gibson.dropbear.id.au, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

Sets the category of adb as DEVICE_CATEGORY_INPUT
Devices should be assigned to one of DEVICE_CATEGORY_XXXX

Signed-off-by: kumar sourav <sourav.jb1988@gmail.com>
---
 hw/input/adb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/input/adb.c b/hw/input/adb.c
index bbb40aeef1..6ca7c5641c 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -126,6 +126,7 @@ static void adb_device_class_init(ObjectClass *oc, void *data)
     dc->realize = adb_device_realizefn;
     dc->props = adb_device_properties;
     dc->bus_type = TYPE_ADB_BUS;
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
 
 static const TypeInfo adb_device_type_info = {
-- 
2.17.1
