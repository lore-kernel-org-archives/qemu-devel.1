Received: from eggs.gnu.org ([209.51.188.92]:45312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sourav.jb1988@gmail.com>) id 1gmhmx-0002gT-L4
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 11:23:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sourav.jb1988@gmail.com>) id 1gmhkU-0002oE-Go
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 11:21:04 -0500
From: kumar sourav <sourav.jb1988@gmail.com>
Date: Thu, 24 Jan 2019 21:50:45 +0530
Message-Id: <20190124162045.10474-1-sourav.jb1988@gmail.com>
Subject: [Qemu-devel] [PATCH] hw: sd: set category of the sd memory card
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: f4bug@amsat.org, qemu-devel@nongnu.org, thuth@redhat.com

Sets the category of the sd memory card as DEVICE_CATEGORY_STORAGE.
Devices should be assigned to one of DEVICE_CATEGORY_XXXX.

Signed-off-by: kumar sourav <sourav.jb1988@gmail.com>
---
 hw/sd/sd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d4356e9b73..aaab15f386 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2121,6 +2121,7 @@ static void sd_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &sd_vmstate;
     dc->reset = sd_reset;
     dc->bus_type = TYPE_SD_BUS;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 
     sc->set_voltage = sd_set_voltage;
     sc->get_dat_lines = sd_get_dat_lines;
-- 
2.17.1
