Received: from eggs.gnu.org ([209.51.188.92]:33681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hKuIg-0007js-4z
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 20:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hKuDu-0002s6-SY
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 20:32:47 -0400
Received: from smtpbgau1.qq.com ([54.206.16.166]:60015)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <driver1998@foxmail.com>)
	id 1hKuDu-0002qf-7N
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 20:32:46 -0400
From: driver1998 <driver1998@foxmail.com>
Date: Mon, 29 Apr 2019 00:32:23 +0000
Message-Id: <20190429003223.22856-1-driver1998@foxmail.com>
Subject: [Qemu-devel] [PATCH 2/4] qga: Fix an enum conversion warning in
 commands-win32.c, hit by clang.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, driver1998 <driver1998@foxmail.com>

Signed-off-by: driver1998 <driver1998@foxmail.com>
---
 qga/commands-win32.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index d40d61f605..4cdd2950bf 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -458,23 +458,24 @@ void qmp_guest_file_flush(int64_t handle, Error **errp)
 #ifdef CONFIG_QGA_NTDDSCSI
 
 static STORAGE_BUS_TYPE win2qemu[] = {
-    [BusTypeUnknown] = GUEST_DISK_BUS_TYPE_UNKNOWN,
-    [BusTypeScsi] = GUEST_DISK_BUS_TYPE_SCSI,
-    [BusTypeAtapi] = GUEST_DISK_BUS_TYPE_IDE,
-    [BusTypeAta] = GUEST_DISK_BUS_TYPE_IDE,
-    [BusType1394] = GUEST_DISK_BUS_TYPE_IEEE1394,
-    [BusTypeSsa] = GUEST_DISK_BUS_TYPE_SSA,
-    [BusTypeFibre] = GUEST_DISK_BUS_TYPE_SSA,
-    [BusTypeUsb] = GUEST_DISK_BUS_TYPE_USB,
-    [BusTypeRAID] = GUEST_DISK_BUS_TYPE_RAID,
-    [BusTypeiScsi] = GUEST_DISK_BUS_TYPE_ISCSI,
-    [BusTypeSas] = GUEST_DISK_BUS_TYPE_SAS,
-    [BusTypeSata] = GUEST_DISK_BUS_TYPE_SATA,
-    [BusTypeSd] =  GUEST_DISK_BUS_TYPE_SD,
-    [BusTypeMmc] = GUEST_DISK_BUS_TYPE_MMC,
+    [BusTypeUnknown] = (STORAGE_BUS_TYPE)GUEST_DISK_BUS_TYPE_UNKNOWN,
+    [BusTypeScsi] = (STORAGE_BUS_TYPE)GUEST_DISK_BUS_TYPE_SCSI,
+    [BusTypeAtapi] = (STORAGE_BUS_TYPE)GUEST_DISK_BUS_TYPE_IDE,
+    [BusTypeAta] = (STORAGE_BUS_TYPE)GUEST_DISK_BUS_TYPE_IDE,
+    [BusType1394] = (STORAGE_BUS_TYPE)GUEST_DISK_BUS_TYPE_IEEE1394,
+    [BusTypeSsa] = (STORAGE_BUS_TYPE)GUEST_DISK_BUS_TYPE_SSA,
+    [BusTypeFibre] = (STORAGE_BUS_TYPE)GUEST_DISK_BUS_TYPE_SSA,
+    [BusTypeUsb] = (STORAGE_BUS_TYPE)GUEST_DISK_BUS_TYPE_USB,
+    [BusTypeRAID] = (STORAGE_BUS_TYPE)GUEST_DISK_BUS_TYPE_RAID,
+    [BusTypeiScsi] = (STORAGE_BUS_TYPE)GUEST_DISK_BUS_TYPE_ISCSI,
+    [BusTypeSas] = (STORAGE_BUS_TYPE)GUEST_DISK_BUS_TYPE_SAS,
+    [BusTypeSata] = (STORAGE_BUS_TYPE)GUEST_DISK_BUS_TYPE_SATA,
+    [BusTypeSd] =  (STORAGE_BUS_TYPE)GUEST_DISK_BUS_TYPE_SD,
+    [BusTypeMmc] = (STORAGE_BUS_TYPE)GUEST_DISK_BUS_TYPE_MMC,
 #if (_WIN32_WINNT >= 0x0601)
-    [BusTypeVirtual] = GUEST_DISK_BUS_TYPE_VIRTUAL,
-    [BusTypeFileBackedVirtual] = GUEST_DISK_BUS_TYPE_FILE_BACKED_VIRTUAL,
+    [BusTypeVirtual] = (STORAGE_BUS_TYPE)GUEST_DISK_BUS_TYPE_VIRTUAL,
+    [BusTypeFileBackedVirtual] =
+        (STORAGE_BUS_TYPE)GUEST_DISK_BUS_TYPE_FILE_BACKED_VIRTUAL,
 #endif
 };
 
@@ -483,7 +484,7 @@ static GuestDiskBusType find_bus_type(STORAGE_BUS_TYPE bus)
     if (bus >= ARRAY_SIZE(win2qemu) || (int)bus < 0) {
         return GUEST_DISK_BUS_TYPE_UNKNOWN;
     }
-    return win2qemu[(int)bus];
+    return (GuestDiskBusType)win2qemu[(int)bus];
 }
 
 DEFINE_GUID(GUID_DEVINTERFACE_DISK,
-- 
2.17.1
