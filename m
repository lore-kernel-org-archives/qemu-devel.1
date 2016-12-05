Received: from eggs.gnu.org ([2001:4830:134:3::10]:57271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cE2ka-0002qg-VA
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 18:32:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cE2kW-00061e-Uv
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 18:32:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cE2kW-00061Q-MX
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 18:32:44 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D72EA61B96
	for <qemu-devel@nongnu.org>; Mon,  5 Dec 2016 23:32:43 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue,  6 Dec 2016 00:32:27 +0100
Message-Id: <1480980749-182204-9-git-send-email-imammedo@redhat.com>
In-Reply-To: <1480980749-182204-1-git-send-email-imammedo@redhat.com>
References: <1480980749-182204-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 08/10] memhp: move memory hotplug only
 defines to memory_hotplug.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Move defines used locally only by memory_hotplug.c into it
from header files.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/acpi/memory_hotplug.h |  3 ---
 include/hw/acpi/pc-hotplug.h     | 22 ----------------------
 hw/acpi/memory_hotplug.c         | 24 ++++++++++++++++++++++++
 3 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/include/hw/acpi/memory_hotplug.h b/include/hw/acpi/memory_hotplug.h
index 37e2706..91d4045 100644
--- a/include/hw/acpi/memory_hotplug.h
+++ b/include/hw/acpi/memory_hotplug.h
@@ -47,9 +47,6 @@ extern const VMStateDescription vmstate_memory_hotplug;
 
 void acpi_memory_ospm_status(MemHotplugState *mem_st, ACPIOSTInfoList ***list);
 
-#define MEMORY_HOTPLUG_DEVICE        "MHPD"
-#define MEMORY_SLOT_SCAN_METHOD      "MSCN"
-
 void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
                               uint16_t io_base, uint16_t io_len,
                               const char *res_root,
diff --git a/include/hw/acpi/pc-hotplug.h b/include/hw/acpi/pc-hotplug.h
index 6a8d268..a4f513d 100644
--- a/include/hw/acpi/pc-hotplug.h
+++ b/include/hw/acpi/pc-hotplug.h
@@ -32,26 +32,4 @@
 #define ACPI_MEMORY_HOTPLUG_IO_LEN 24
 #define ACPI_MEMORY_HOTPLUG_BASE 0x0a00
 
-#define MEMORY_SLOTS_NUMBER          "MDNR"
-#define MEMORY_HOTPLUG_IO_REGION     "HPMR"
-#define MEMORY_SLOT_ADDR_LOW         "MRBL"
-#define MEMORY_SLOT_ADDR_HIGH        "MRBH"
-#define MEMORY_SLOT_SIZE_LOW         "MRLL"
-#define MEMORY_SLOT_SIZE_HIGH        "MRLH"
-#define MEMORY_SLOT_PROXIMITY        "MPX"
-#define MEMORY_SLOT_ENABLED          "MES"
-#define MEMORY_SLOT_INSERT_EVENT     "MINS"
-#define MEMORY_SLOT_REMOVE_EVENT     "MRMV"
-#define MEMORY_SLOT_EJECT            "MEJ"
-#define MEMORY_SLOT_SLECTOR          "MSEL"
-#define MEMORY_SLOT_OST_EVENT        "MOEV"
-#define MEMORY_SLOT_OST_STATUS       "MOSC"
-#define MEMORY_SLOT_LOCK             "MLCK"
-#define MEMORY_SLOT_STATUS_METHOD    "MRST"
-#define MEMORY_SLOT_CRS_METHOD       "MCRS"
-#define MEMORY_SLOT_OST_METHOD       "MOST"
-#define MEMORY_SLOT_PROXIMITY_METHOD "MPXM"
-#define MEMORY_SLOT_EJECT_METHOD     "MEJ0"
-#define MEMORY_SLOT_NOTIFY_METHOD    "MTFY"
-
 #endif
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 49e856f..da29332 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -7,6 +7,30 @@
 #include "trace.h"
 #include "qapi-event.h"
 
+#define MEMORY_SLOTS_NUMBER          "MDNR"
+#define MEMORY_HOTPLUG_IO_REGION     "HPMR"
+#define MEMORY_SLOT_ADDR_LOW         "MRBL"
+#define MEMORY_SLOT_ADDR_HIGH        "MRBH"
+#define MEMORY_SLOT_SIZE_LOW         "MRLL"
+#define MEMORY_SLOT_SIZE_HIGH        "MRLH"
+#define MEMORY_SLOT_PROXIMITY        "MPX"
+#define MEMORY_SLOT_ENABLED          "MES"
+#define MEMORY_SLOT_INSERT_EVENT     "MINS"
+#define MEMORY_SLOT_REMOVE_EVENT     "MRMV"
+#define MEMORY_SLOT_EJECT            "MEJ"
+#define MEMORY_SLOT_SLECTOR          "MSEL"
+#define MEMORY_SLOT_OST_EVENT        "MOEV"
+#define MEMORY_SLOT_OST_STATUS       "MOSC"
+#define MEMORY_SLOT_LOCK             "MLCK"
+#define MEMORY_SLOT_STATUS_METHOD    "MRST"
+#define MEMORY_SLOT_CRS_METHOD       "MCRS"
+#define MEMORY_SLOT_OST_METHOD       "MOST"
+#define MEMORY_SLOT_PROXIMITY_METHOD "MPXM"
+#define MEMORY_SLOT_EJECT_METHOD     "MEJ0"
+#define MEMORY_SLOT_NOTIFY_METHOD    "MTFY"
+#define MEMORY_SLOT_SCAN_METHOD      "MSCN"
+#define MEMORY_HOTPLUG_DEVICE        "MHPD"
+
 static ACPIOSTInfo *acpi_memory_device_status(int slot, MemStatus *mdev)
 {
     ACPIOSTInfo *info = g_new0(ACPIOSTInfo, 1);
-- 
2.7.4
