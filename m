Received: from eggs.gnu.org ([2001:4830:134:3::10]:33998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpBA-00005R-I8
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:41:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpB8-0005zi-St
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:41:04 -0500
Received: from mail.kernel.org ([198.145.29.136]:48658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpB8-0005zZ-Hk
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:41:02 -0500
Date: Tue, 10 Jan 2017 07:40:58 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-39-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 38/41] memhp: move memory hotplug only defines
 to memory_hotplug.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Move defines used locally only by memory_hotplug.c into it
from header files.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
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
MST
