Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E5BC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 18:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C185D20854
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 18:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Q5P6ReeJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C185D20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51421 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLXH8-00026w-0a
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 14:14:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hLXFZ-0001F2-Q3
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hLXFY-0006xw-Od
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:13:05 -0400
Received: from smtpproxy19.qq.com ([184.105.206.84]:57185)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <driver1998@foxmail.com>)
	id 1hLXFY-0006wk-GV
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1556647980;
	bh=nitcZo7Ica6bxaPIrVW3UM/lQlmnfjXu6RBr0DAnV5Q=;
	h=From:To:Subject:Date:Message-Id;
	b=Q5P6ReeJmhWgp/FYHnmVrDvKbgS/kIeh86wHZyDYoIPOi7BFPyJYPGyvlrI5EJRIj
	GV6l33xqM1rMopJXhVzt/WlVmUW6jpIYjyRKK0R+MsmqYgmIT1M2UrQW5vHwKB7ZCP
	H4Hi1l7yGv+se5xNJPlMych9ovDRGZ2tltB34JuE=
X-QQ-mid: esmtp6t1556647979tsgmfeir4
Received: from localhost (unknown [183.63.119.27])
	by esmtp4.qq.com (ESMTP) with 
	id ; Wed, 01 May 2019 02:12:59 +0800 (CST)
X-QQ-SSF: B100000000000030F7F00F00000000O
X-QQ-FEAT: uLC2yWZT8bFf07dEYANqfu6Y4Id3QR3XmDOvTc7nv/ZBQ3xGeuDtVzSTQdaQg
	N+RuhCP+2PYsoSldiOESHQaHq2jVn4AHuoUPrmd7qjFV3K5UKF8J5IiRW4z2rt/xzhRA3kp
	wNxVuH2fJFpWGHVHkKOCbiNldsnQJV2rf0S1o7cbqKBJf+wcfs0Z6Z9ORBgGdsSXvdQ0xuf
	Sk3KpOLGESsW407zWRvNaci8ad50CM628TKREQOjdkWxsl61ubdqSRFXV1IVU1tjYHu86bz
	zBc6/Sb8EBOt5zBL5f4eSkHzY495vCHUfQOQ==
X-QQ-GoodBg: 0
From: Cao Jiaxi <driver1998@foxmail.com>
To: mdroth@linux.vnet.ibm.com
Date: Wed,  1 May 2019 02:12:57 +0800
Message-Id: <20190430181257.1265-1-driver1998@foxmail.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgforeign:bgforeign2
X-QQ-Bgrelay: 1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.4.x
X-Received-From: 184.105.206.84
Subject: [Qemu-devel] [PATCH v2 2/4] qga: Fix an enum conversion warning in
 commands-win32.c, hit by clang.
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Cao Jiaxi <driver1998@foxmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190430181257.-NLKpxbmuO1WTTAekOVS6xhK1e65rRhmvHDeo335x_8@z>

Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
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




