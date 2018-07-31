Received: from eggs.gnu.org ([2001:4830:134:3::10]:44027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1fkd8a-00033C-Cc
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 18:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1fkd8V-00052M-Er
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 18:29:04 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:46516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1fkd8V-000520-80
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 18:28:59 -0400
Received: by mail-pl0-x241.google.com with SMTP id t17-v6so7778200ply.13
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 15:28:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 31 Jul 2018 15:28:53 -0700
Message-Id: <1533076133-22745-1-git-send-email-linux@roeck-us.net>
Subject: [Qemu-devel] [PATCH] scsi: mptsas: Mark as storage device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>

mptsas1068 is currently listed as uncategorized device.
Mark it as storage device.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/scsi/mptsas.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 4176e87..929404f 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -1431,6 +1431,7 @@ static void mptsas1068_class_init(ObjectClass *oc, void *data)
     dc->reset = mptsas_reset;
     dc->vmsd = &vmstate_mptsas;
     dc->desc = "LSI SAS 1068";
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
 
 static const TypeInfo mptsas_info = {
-- 
2.7.4
