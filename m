Received: from eggs.gnu.org ([2001:4830:134:3::10]:42576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fsOWL-0000zm-UM
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:29:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fsOWJ-0003qE-IT
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:29:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34624 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fsOWI-0003kZ-UR
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:29:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E31540201C0
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 08:29:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 22 Aug 2018 10:29:24 +0200
Message-Id: <1534926564-26061-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/scsi/mptsas: Classify the device as
 "storage"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

Each device should ideally have a category, so put the mptsas1068 device
into the "storage" category.

Signed-off-by: Thomas Huth <thuth@redhat.com>
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
