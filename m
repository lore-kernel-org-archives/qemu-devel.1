Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20879C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 00:50:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC7020656
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 00:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="OAr3Lks0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC7020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50169 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKuV3-0007lU-3v
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 20:50:29 -0400
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1556497956;
	bh=gerxQDe02AMpDBIHhMgCswR4djHrmypAHaU/w5+GbGc=;
	h=From:To:Subject:Date:Message-Id;
	b=OAr3Lks0NwAd7taLLL3ZNiXCJyrsdwpVOEdE3X6L6Z9IIUFywNyq8w2CSwfnWAzY4
	yyxg2WR9awFNbXxIUc9mNkcsRaSPQq1kORe5ol4cSmLJza7YN3qXrw6+YJXkU+jh3T
	7askQ0heK/7wiqLYOzPsapIahOoy40GIPVFiDJNI=
X-QQ-mid: esmtp5t1556497955tpz6kda8i
Received: from localhost (unknown [183.63.119.27])
	by esmtp4.qq.com (ESMTP) with 
	id ; Mon, 29 Apr 2019 08:32:34 +0800 (CST)
X-QQ-SSF: B100000000000030F7F00F00000000O
X-QQ-FEAT: 6ugjij1k5i+U+MtU1Gig6Z/DKHduD8fjPl7gcoOWmCmUcIse7eLArPs2XM3wB
	QS7xxcEWrxf2j9+s40N2P68zs1u1sY9+IiGHZLP/aAj4c64RVyq16iN7RG/fHu8bAfALdo7
	+paxam6vKJl/GsCxXRhXl8m9xicMNcGC/zH+D2m6h2P4wZuIv1HkKfAzxuFnZM9mTHFM7I5
	0//U932Ihh6d0x6fBtlYrwLsPSVbKs84p4bFLEvhAvUy2o8d1A+Pt/67iIs6JPx9hmdEkun
	zrI++UTjH0DdEgwd6FqTBjrKaxIR5lmMplXg==
X-QQ-GoodBg: 0
From: driver1998 <driver1998@foxmail.com>
To: mdroth@linux.vnet.ibm.com
Date: Mon, 29 Apr 2019 00:32:23 +0000
Message-Id: <20190429003223.22856-1-driver1998@foxmail.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgforeign:bgforeign4
X-QQ-Bgrelay: 1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 54.206.16.166
X-Mailman-Approved-At: Sun, 28 Apr 2019 20:49:03 -0400
Subject: [Qemu-devel] [PATCH 2/4] qga: Fix an enum conversion warning in
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
Cc: driver1998 <driver1998@foxmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190429003223.uwM-RuZWLwxb0AzHcmlBc_wBin0d6kDfu_DMCxIZGk0@z>

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




