Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CF8C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 18:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4AF2207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 18:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4AF2207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igux8-0006ew-Ry
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 13:18:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <a13xp0p0v88@gmail.com>) id 1iguvj-0005LK-ID
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 13:17:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <a13xp0p0v88@gmail.com>) id 1iguvi-0007K5-BQ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 13:17:15 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39802)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <a13xp0p0v88@gmail.com>)
 id 1iguve-0007Dt-RF; Mon, 16 Dec 2019 13:17:11 -0500
Received: by mail-lf1-f68.google.com with SMTP id y1so4959330lfb.6;
 Mon, 16 Dec 2019 10:17:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H2lU9B555iOtaYRPgG6csTMWCgU0FVXS1nicw21vqDo=;
 b=dF9ppZXolMTqkgis8WYnZ7P6AxSFnf+V84ef9scrM5k41RKDEsd58dEjPYQ8AGvPIl
 jkd/9WZWIKrzjEEmOEKFRD4pKXZDJc1NZyWXrbkueSxf327UHtuxLjf0zoE0h858AwLM
 29MSF2IKUzYcuaQVMJNNK5iCpO8fS5zmfbqu2onbgvponBb4P6jGcuaErLmASspgMAhs
 pDqbmviOn3uQY81SMRpm/2oIw5ZdK7jBCSC6aeqNw+Xp8obAgF00BgaOs+1bgskR3bPc
 dRuXe0LhIVvc4l5vPqLQFMBvy6mdd9FlTmClBlcT44ujBDspkz05XD8wLeh23yPqUAjd
 eAkQ==
X-Gm-Message-State: APjAAAUDBFRKpM22QhxqC51+nnyE1vAzGID6irK3cRGLpFaHAlz93pse
 2BAuzGbZmFXJ1DPEwtyweak=
X-Google-Smtp-Source: APXvYqyX8mla1n2+MWjLezEUjLsODqLHVUQ1cGtQ8kzJWPc/QztdI4cgP7OAYqN2glG/IcToKExZdQ==
X-Received: by 2002:a19:84d:: with SMTP id 74mr228504lfi.122.1576520229385;
 Mon, 16 Dec 2019 10:17:09 -0800 (PST)
Received: from localhost.localdomain ([213.87.130.66])
 by smtp.gmail.com with ESMTPSA id j10sm10961857ljc.76.2019.12.16.10.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 10:17:08 -0800 (PST)
From: Alexander Popov <alex.popov@linux.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 pmatouse@redhat.com, sstabellini@kernel.org, mdroth@linux.vnet.ibm.com,
 pjp@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Kashyap Chamarthy <kashyap.cv@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Alexander Popov <alex.popov@linux.com>
Subject: [PATCH v2 2/2] ide: Fix incorrect handling of some PRDTs in
 ide_dma_cb()
Date: Mon, 16 Dec 2019 21:14:05 +0300
Message-Id: <20191216181405.462292-2-alex.popov@linux.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191216181405.462292-1-alex.popov@linux.com>
References: <20191216181405.462292-1-alex.popov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.68
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The commit a718978ed58a from July 2015 introduced the assertion which
implies that the size of successful DMA transfers handled in ide_dma_cb()
should be multiple of 512 (the size of a sector). But guest systems can
initiate DMA transfers that don't fit this requirement.

For fixing that let's check the number of bytes prepared for the transfer
by the prepare_buf() handler. The code in ide_dma_cb() must behave
according to the Programming Interface for Bus Master IDE Controller
(Revision 1.0 5/16/94):
1. If PRDs specified a smaller size than the IDE transfer
   size, then the Interrupt and Active bits in the Controller
   status register are not set (Error Condition).
2. If the size of the physical memory regions was equal to
   the IDE device transfer size, the Interrupt bit in the
   Controller status register is set to 1, Active bit is set to 0.
3. If PRDs specified a larger size than the IDE transfer size,
   the Interrupt and Active bits in the Controller status register
   are both set to 1.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 hw/ide/core.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 754ff4dc34..171831c7bd 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -849,6 +849,7 @@ static void ide_dma_cb(void *opaque, int ret)
     int64_t sector_num;
     uint64_t offset;
     bool stay_active = false;
+    int32_t prep_size = 0;
 
     if (ret == -EINVAL) {
         ide_dma_error(s);
@@ -863,13 +864,15 @@ static void ide_dma_cb(void *opaque, int ret)
         }
     }
 
-    n = s->io_buffer_size >> 9;
-    if (n > s->nsector) {
-        /* The PRDs were longer than needed for this request. Shorten them so
-         * we don't get a negative remainder. The Active bit must remain set
-         * after the request completes. */
+    if (s->io_buffer_size > s->nsector * 512) {
+        /*
+         * The PRDs were longer than needed for this request.
+         * The Active bit must remain set after the request completes.
+         */
         n = s->nsector;
         stay_active = true;
+    } else {
+        n = s->io_buffer_size >> 9;
     }
 
     sector_num = ide_get_sector(s);
@@ -892,9 +895,20 @@ static void ide_dma_cb(void *opaque, int ret)
     n = s->nsector;
     s->io_buffer_index = 0;
     s->io_buffer_size = n * 512;
-    if (s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer_size) < 512) {
-        /* The PRDs were too short. Reset the Active bit, but don't raise an
-         * interrupt. */
+    prep_size = s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer_size);
+    /* prepare_buf() must succeed and respect the limit */
+    assert(prep_size > 0 && prep_size <= n * 512);
+
+    /*
+     * Now prep_size stores the number of bytes in the sglist, and
+     * s->io_buffer_size stores the number of bytes described by the PRDs.
+     */
+
+    if (prep_size < n * 512) {
+        /*
+         * The PRDs are too short for this request. Error condition!
+         * Reset the Active bit and don't raise the interrupt.
+         */
         s->status = READY_STAT | SEEK_STAT;
         dma_buf_commit(s, 0);
         goto eot;
-- 
2.23.0


