Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A445AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 08:32:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F64F2074D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 08:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uHNobyX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F64F2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6V88-0000bY-NE
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 04:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6V52-0003U0-17; Fri, 14 Aug 2020 04:28:52 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34977)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6V50-0004M3-6A; Fri, 14 Aug 2020 04:28:51 -0400
Received: by mail-wr1-x442.google.com with SMTP id f1so7614451wro.2;
 Fri, 14 Aug 2020 01:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MHwsW3nEzd0gLVyoTqr0zx54B5tpAsp2Gj+L5fVRrhY=;
 b=uHNobyX8IN836KBI4XwLZSVIsEA+KOp8gt7K6LC4CaJhMJkQGKOeFig3znr3lR5qiB
 ILAPAlDrfJ4mfwmJzDwgOBdn/VgcBiSRu7A3KsvUiCxe3X5zZyPkIuVx70sKjhtjM5at
 JaO13fz2shzzXd9B+alfJprBheIACu13kFHrPjImg9QxLMEQPfbe73C/Jbf5NlcgzVxS
 VfkpWvZfcRJsmwPHbFWs46DwUTUpFcVqa3CJmOYvud4UZEnC9vdQaIDC7Ge2eZIK0AZq
 iDJStx1yw87QfCLA+hut+GAy3Q9DAqJREUFQE5WXMhMr7n0xAX+UyabeWTn4j2SkdeVl
 u7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=MHwsW3nEzd0gLVyoTqr0zx54B5tpAsp2Gj+L5fVRrhY=;
 b=m4EQY+2DTJkkaCDPXe9innuLEM7o/GHZle0kdlahmZRFLJXrrl19bTmLK6jWWyM8mH
 Rn5AAFiUQlhYtbKz53wZAqTuxFULJsA99BwYznmwgve1SnnWQESahTj1ya7IYZD/zZG0
 hewsnddoO9XXmT2jt0UdRL/E0VK7hqNYfN9JbvZHIpBkYtyx3qckKm0H147CTWs9VajT
 tfmA41UBawmImVFvCkGYbfJUgDeIcRaSW921jSp+7Xca9ubCDcOTuDWHrXMSJ7p543IS
 wXUECfMMteE9D3v7fHczkqPPUlDr6npbkQ6dWbmvMmGDTIOaRm3zutytigNEIRRSnr1s
 uM2Q==
X-Gm-Message-State: AOAM5312Ro0Cr6oe40jpa7UEz3nM/E9Qs3CdAoMeHm2e820rLpbhKhmo
 RLKgvg0pznCGIocLAwFf0dWul/TozcY=
X-Google-Smtp-Source: ABdhPJzJkrAkaLBKsQWUfnMfCToWt4YCf8RmwVTW5vjXhDhn4elYHu+XWoYV/Axw++1sPsNLFwJcyw==
X-Received: by 2002:a5d:4947:: with SMTP id r7mr1673726wrs.165.1597393727667; 
 Fri, 14 Aug 2020 01:28:47 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id d14sm14668107wre.44.2020.08.14.01.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 01:28:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] hw/ide/core: Replace magic '512' value by BDRV_SECTOR_SIZE
Date: Fri, 14 Aug 2020 10:28:37 +0200
Message-Id: <20200814082841.27000-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200814082841.27000-1-f4bug@amsat.org>
References: <20200814082841.27000-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use self-explicit definitions instead of magic '512' value.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/ide/core.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index f76f7e5234..bcb2aa85fc 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -121,7 +121,7 @@ static void ide_identify(IDEState *s)
     put_le16(p + 0, 0x0040);
     put_le16(p + 1, s->cylinders);
     put_le16(p + 3, s->heads);
-    put_le16(p + 4, 512 * s->sectors); /* XXX: retired, remove ? */
+    put_le16(p + 4, BDRV_SECTOR_SIZE * s->sectors); /* XXX: retired, remove ? */
     put_le16(p + 5, 512); /* XXX: retired, remove ? */
     put_le16(p + 6, s->sectors);
     padstr((char *)(p + 10), s->drive_serial_str, 20); /* serial number */
@@ -864,7 +864,7 @@ static void ide_dma_cb(void *opaque, int ret)
         }
     }
 
-    if (s->io_buffer_size > s->nsector * 512) {
+    if (s->io_buffer_size > s->nsector * BDRV_SECTOR_SIZE) {
         /*
          * The PRDs were longer than needed for this request.
          * The Active bit must remain set after the request completes.
@@ -877,7 +877,7 @@ static void ide_dma_cb(void *opaque, int ret)
 
     sector_num = ide_get_sector(s);
     if (n > 0) {
-        assert(n * 512 == s->sg.size);
+        assert(n * BDRV_SECTOR_SIZE == s->sg.size);
         dma_buf_commit(s, s->sg.size);
         sector_num += n;
         ide_set_sector(s, sector_num);
@@ -894,17 +894,17 @@ static void ide_dma_cb(void *opaque, int ret)
     /* launch next transfer */
     n = s->nsector;
     s->io_buffer_index = 0;
-    s->io_buffer_size = n * 512;
+    s->io_buffer_size = n * BDRV_SECTOR_SIZE;
     prep_size = s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer_size);
     /* prepare_buf() must succeed and respect the limit */
-    assert(prep_size >= 0 && prep_size <= n * 512);
+    assert(prep_size >= 0 && prep_size <= n * BDRV_SECTOR_SIZE);
 
     /*
      * Now prep_size stores the number of bytes in the sglist, and
      * s->io_buffer_size stores the number of bytes described by the PRDs.
      */
 
-    if (prep_size < n * 512) {
+    if (prep_size < n * BDRV_SECTOR_SIZE) {
         /*
          * The PRDs are too short for this request. Error condition!
          * Reset the Active bit and don't raise the interrupt.
@@ -1412,7 +1412,8 @@ static bool cmd_identify(IDEState *s, uint8_t cmd)
             ide_cfata_identify(s);
         }
         s->status = READY_STAT | SEEK_STAT;
-        ide_transfer_start(s, s->io_buffer, 512, ide_transfer_stop);
+        ide_transfer_start(s, s->io_buffer, BDRV_SECTOR_SIZE,
+                           ide_transfer_stop);
         ide_set_irq(s->bus);
         return false;
     } else {
@@ -1482,7 +1483,7 @@ static bool cmd_write_multiple(IDEState *s, uint8_t cmd)
     n = MIN(s->nsector, s->req_nb_sectors);
 
     s->status = SEEK_STAT | READY_STAT;
-    ide_transfer_start(s, s->io_buffer, 512 * n, ide_sector_write);
+    ide_transfer_start(s, s->io_buffer, BDRV_SECTOR_SIZE * n, ide_sector_write);
 
     s->media_changed = 1;
 
@@ -1524,7 +1525,7 @@ static bool cmd_write_pio(IDEState *s, uint8_t cmd)
 
     s->req_nb_sectors = 1;
     s->status = SEEK_STAT | READY_STAT;
-    ide_transfer_start(s, s->io_buffer, 512, ide_sector_write);
+    ide_transfer_start(s, s->io_buffer, BDRV_SECTOR_SIZE, ide_sector_write);
 
     s->media_changed = 1;
 
@@ -1678,7 +1679,7 @@ static bool cmd_identify_packet(IDEState *s, uint8_t cmd)
 {
     ide_atapi_identify(s);
     s->status = READY_STAT | SEEK_STAT;
-    ide_transfer_start(s, s->io_buffer, 512, ide_transfer_stop);
+    ide_transfer_start(s, s->io_buffer, BDRV_SECTOR_SIZE, ide_transfer_stop);
     ide_set_irq(s->bus);
     return false;
 }
@@ -2559,7 +2560,7 @@ static void ide_init1(IDEBus *bus, int unit)
     s->unit = unit;
     s->drive_serial = drive_serial++;
     /* we need at least 2k alignment for accessing CDROMs using O_DIRECT */
-    s->io_buffer_total_len = IDE_DMA_BUF_SECTORS*512 + 4;
+    s->io_buffer_total_len = IDE_DMA_BUF_SECTORS * BDRV_SECTOR_SIZE + 4;
     s->io_buffer = qemu_memalign(2048, s->io_buffer_total_len);
     memset(s->io_buffer, 0, s->io_buffer_total_len);
 
-- 
2.21.3


