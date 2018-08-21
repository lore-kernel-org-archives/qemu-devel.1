Received: from eggs.gnu.org ([2001:4830:134:3::10]:60893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA3x-0001Ar-AO
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA3n-0005ch-4i
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:20 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:50856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA3m-0005Ns-3Q
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:14 -0400
Received: by mail-wm0-x233.google.com with SMTP id s12-v6so3658426wmc.0
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:06 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:01:34 +0200
Message-Id: <1534870966-9287-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/74] scsi: mptsas: Mark as storage device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>

From: Guenter Roeck <linux@roeck-us.net>

mptsas1068 is currently listed as uncategorized device.
Mark it as storage device.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-Id: <1533076133-22745-1-git-send-email-linux@roeck-us.net>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
1.8.3.1
