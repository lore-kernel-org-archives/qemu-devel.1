Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27107C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 00:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD86B2087F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 00:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="hxgmaeBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD86B2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60285 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMM53-0005eC-7d
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 20:29:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hMM4I-0005Jm-0L
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hMM4H-0005ZH-6G
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:28:49 -0400
Received: from smtpbg302.qq.com ([184.105.206.27]:39751)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <driver1998@foxmail.com>)
	id 1hMM4G-0005Yl-VS
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1556843322;
	bh=rNrdiz1Sy8K1ZYQLRYYtYLz7q52e7xr8Xcc2h9May4E=;
	h=From:To:Subject:Date:Message-Id;
	b=hxgmaeBypi0P6+raQxUaOc16fDxaGRWjPfZ6H/am/U9eWg6VQd9subTkDYmHh9YlP
	UmXtjOWfKz5HnQ8YYSWbk27tqZwDFvjQRiVPRZv9gHUsjeiJa0Tfk3iRG5Y4T3y1lF
	SUSIxkwWhfD1oJqUSLaLxYLmOLDjKmfZOHpZJFfM=
X-QQ-mid: esmtp7t1556843318tno2w30ci
Received: from localhost (unknown [183.63.119.3])
	by esmtp4.qq.com (ESMTP) with 
	id ; Fri, 03 May 2019 08:28:38 +0800 (CST)
X-QQ-SSF: B100000000000030F7F00F00000000O
X-QQ-FEAT: EUGmOqWjSYI2rkdK+363Ofz3Pv1nPGWXHH9S5VhbHOPFX9225ctzB+oZj7J0l
	00lPS4O8SmKu2KuZy8FRAcAMByi4/HFqcuMBGNFaSUM2ympgczWDj488ephQRSEoaTYk2pH
	VwznKCFt3w6pBZTeNzGShhZihiuhT2WM0R//QK1CYFzCxUPyTBEwK5oAKd6VKNx6y7xjbRf
	dqngNB6vI0jrS4mmXTix9E89Ex9yGH/ezWBCu/KD9ozK96WnRR2mc/bZGmvWhlVs1NsDK8N
	G+QUjDw/iS29DHTA1ORG5poeU+tCISfTeVkA==
X-QQ-GoodBg: 0
From: Cao Jiaxi <driver1998@foxmail.com>
To: mdroth@linux.vnet.ibm.com
Date: Fri,  3 May 2019 08:25:56 +0800
Message-Id: <20190503002556.9941-1-driver1998@foxmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503002258.9799-1-driver1998@foxmail.com>
References: <20190503002258.9799-1-driver1998@foxmail.com>
X-QQ-SENDSIZE: 520
X-QQ-FName: 427BBF23CFDD4292848D96C87D1DD7A9
X-QQ-LocalIP: 10.198.131.167
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.4.x
X-Received-From: 184.105.206.27
Subject: [Qemu-devel] [PATCH v3 2/4] qga: Fix mingw compilation warnings on
 enum conversion
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
Message-ID: <20190503002556.Nyjw5Kiuef7pBwkTYVuoyDio1RwkyK7KWY5YV6p4LQw@z>

The win2qemu[] is supposed to be the conversion table to convert between
STORAGE_BUS_TYPE in Windows SDK and GuestDiskBusType in qga.

But it was incorrectly written that it forces to set a GuestDiskBusType
value to STORAGE_BUS_TYPE, which generates an enum conversion warning in clang.

Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
---
 qga/commands-win32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index d40d61f605..6b67f16faf 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -457,7 +457,7 @@ void qmp_guest_file_flush(int64_t handle, Error **errp)
 
 #ifdef CONFIG_QGA_NTDDSCSI
 
-static STORAGE_BUS_TYPE win2qemu[] = {
+static GuestDiskBusType win2qemu[] = {
     [BusTypeUnknown] = GUEST_DISK_BUS_TYPE_UNKNOWN,
     [BusTypeScsi] = GUEST_DISK_BUS_TYPE_SCSI,
     [BusTypeAtapi] = GUEST_DISK_BUS_TYPE_IDE,
-- 
2.17.1


