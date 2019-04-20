Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCED2C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 14:55:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A345020883
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 14:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="Yug5j48K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A345020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42200 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHrPG-0003Cz-Pj
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 10:55:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHrNj-000254-IU
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 10:54:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHrL5-00019K-V0
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 10:51:36 -0400
Received: from m12-13.163.com ([220.181.12.13]:58198)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHrL5-00015r-AN
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 10:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=iRFD+zpf5l7TX1uoBr
	2sBdhb6Xv5dDZq2CEa09rVSBg=; b=Yug5j48Kud/PNejOT9DYHAUVTrdjhp8Tiz
	6+s+L/qNUJPFrDdUIyv0IfpcW85bWQwI+lq08XM+ALeG9dwi4c96TpFibpMi5xkt
	za2Dq6c6wyfHQZgYcgC6PT3qJ0AhyNE/qEIcHV1CeVJ86cTdscmkwci12bnORr5m
	hAnSlX6Rk=
Received: from localhost.localdomain (unknown [183.159.69.175])
	by smtp9 (Coremail) with SMTP id DcCowABXKKbvMbtc5Pi_Ag--.9861S3;
	Sat, 20 Apr 2019 22:51:29 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: jslaby@suse.cz,
	pbonzini@redhat.com
Date: Sat, 20 Apr 2019 07:51:18 -0700
Message-Id: <20190420145120.122847-2-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420145120.122847-1-liq3ea@163.com>
References: <20190420145120.122847-1-liq3ea@163.com>
X-CM-TRANSID: DcCowABXKKbvMbtc5Pi_Ag--.9861S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruFyfZF15Wr4kKr43AF18Zrb_yoW3tFX_Xw
	1xKFZ7GrW5XFyayF90q3W5uryxW3yrAF1rCrs3Gr43Ja4fGr98Z3s2qrnxXr47Gw47Kwn5
	AaykZFy5trnFgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjsqXJUUUUU==
X-Originating-IP: [183.159.69.175]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiKRGcbVXlqu9vFQAAsG
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.13
Subject: [Qemu-devel] [PATCH 1/3] edu: mmio: set 'max_access_size' to 8
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
Cc: Li Qiang <liq3ea@163.com>, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420145118.dmiOHUdqplJX2dTNJ506souy60Q1BsjxR13DbChDTdI@z>

The edu spec said, the MMIO area can be accessed by 8 bytes.
However currently the 'max_access_size' is not so the MMIO
access dispatch can only access 4 bytes one time. This patch
fixes this to respect the spec.

Notice: here the 'min_access_size' is not a must, I set this
for completement.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/misc/edu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 91af452c9e..65fc32b928 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -289,6 +289,15 @@ static const MemoryRegionOps edu_mmio_ops = {
     .read = edu_mmio_read,
     .write = edu_mmio_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+
 };
 
 /*
-- 
2.17.1



