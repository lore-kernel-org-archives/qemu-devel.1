Received: from eggs.gnu.org ([2001:4830:134:3::10]:57948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cludwig@genua.de>) id 1dMwyp-0003Vl-Ta
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cludwig@genua.de>) id 1dMwym-00046d-TE
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:44:36 -0400
Received: from gg-0.genua.de ([80.154.94.10]:32295 helo=gg.genua.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cludwig@genua.de>) id 1dMwym-000424-LV
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:44:32 -0400
Received: from gg.genua.de (localhost [127.0.0.1])
	by gg.genua.de (Postfix) with ESMTP id 2464F859DAB
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 15:44:29 +0200 (CEST)
From: Christian Ludwig <cludwig@genua.de>
Date: Mon, 19 Jun 2017 15:44:08 +0200
Message-Id: <1497879848-7612-1-git-send-email-cludwig@genua.de>
Subject: [Qemu-devel] [PATCH] AcpiDeviceIf: More readable bitmask definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Christian Ludwig <cludwig@genua.de>

AcpiEventStatusBits defines bits in a bitmask. Having it in decimal
notation is rather uncommon. Make it more clear which bits are meant
there.

No functional change.

Signed-off-by: Christian Ludwig <cludwig@genua.de>
---
 include/hw/acpi/acpi_dev_interface.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index 3c2e4e9..f526a6c 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -7,11 +7,11 @@
 
 /* These values are part of guest ABI, and can not be changed */
 typedef enum {
-    ACPI_PCI_HOTPLUG_STATUS = 2,
-    ACPI_CPU_HOTPLUG_STATUS = 4,
-    ACPI_MEMORY_HOTPLUG_STATUS = 8,
-    ACPI_NVDIMM_HOTPLUG_STATUS = 16,
-    ACPI_VMGENID_CHANGE_STATUS = 32,
+    ACPI_PCI_HOTPLUG_STATUS =		(1 << 1),
+    ACPI_CPU_HOTPLUG_STATUS =		(1 << 2),
+    ACPI_MEMORY_HOTPLUG_STATUS =	(1 << 3),
+    ACPI_NVDIMM_HOTPLUG_STATUS =	(1 << 4),
+    ACPI_VMGENID_CHANGE_STATUS =	(1 << 5),
 } AcpiEventStatusBits;
 
 #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
-- 
2.1.4
