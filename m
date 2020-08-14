Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624C2C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 08:34:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C8E2074D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 08:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzLLf7Ye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C8E2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6VAK-00035x-EQ
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 04:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6V57-0003hh-4J; Fri, 14 Aug 2020 04:28:57 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:32972)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6V55-0004NW-Dd; Fri, 14 Aug 2020 04:28:56 -0400
Received: by mail-wr1-x442.google.com with SMTP id p20so7619007wrf.0;
 Fri, 14 Aug 2020 01:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kICf/oOlxbEpUy2A8qbGbhAQ8hahnF5MjM5qVIu7nK0=;
 b=qzLLf7Yeuff1VtLspR4cwk8NlCV0iOBhO5MH5JZaA75iaVM4AEEkQQFF3G7BKFmdux
 xk6vRYuT3NwxeKvyPnhX8aUi5dpt//MOrv5NbpSK7Np085RPX7TDNlMWm0JDbN1VcCxe
 nNvqNnCPwD3rEavgdwDvW8xE5GaPdNej2ECwQWYnWThWG2cgDC2rT/nbw5eYTjUMiuBX
 bq6xFv0rL7LVcvDbvucZnIWaudKsrAEMXNeXqyUpwXB9YDvFTLtfnmdZ9Fc241V7Le/u
 JZR44J/Jc0OgEXF8EZOHtsqgBOmiL67ongWvq3depPm8vwy9NTXpGea8z720VqsSyj2R
 OPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=kICf/oOlxbEpUy2A8qbGbhAQ8hahnF5MjM5qVIu7nK0=;
 b=bChvx8W5pE0dHBFPV7LsK3LoJJ5rkTg6c3dehBtlhE8J60jXhnByrT0lk3HP8vh+gP
 VCvSkfgMRivjBkX9xw9ebq8QfnHaPLnmL5XZXcAIbxyTgu2EXJjokwbVu22s11xDifJ9
 ifJ1TjLnf+ccFTTonEYj7AtgV/KJyHzFU1nacmwvBucjolwLSBzq5PH25Pf4FIVuIr52
 dUoBj1wYwUEdCUthjnmqOGvO42EUf0LkOFyAxFTvrpjJ8YOY4F42kIsdXO+IgCiiMkGm
 yA9ZdHNbYHlV0j9d/UWkKOJNr5ZG1cBhn6MZYf82sODpe8Ue7pVmgRFzDbTUCUK8ZQFQ
 AMXg==
X-Gm-Message-State: AOAM533r0WE0m4qAagv3JGkBTflnRUkh1kUuPNfzJRS+tPfNOQ298lk5
 2quvIEucf4hLrFbIQbNDkqzflNqzThA=
X-Google-Smtp-Source: ABdhPJyWftTMtPmpreoRSjy9cmcWWTgFxxLwHE3TGVrC5Mots5S5rse5xofT6EtCeS9JtWTnTprSuA==
X-Received: by 2002:adf:b1dc:: with SMTP id r28mr1658308wra.242.1597393732862; 
 Fri, 14 Aug 2020 01:28:52 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id d14sm14668107wre.44.2020.08.14.01.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 01:28:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/7] hw/scsi/scsi-disk: Replace magic '512' value by
 BDRV_SECTOR_SIZE
Date: Fri, 14 Aug 2020 10:28:41 +0200
Message-Id: <20200814082841.27000-8-f4bug@amsat.org>
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
 hw/scsi/scsi-disk.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 8ce68a9dd6..7612035a4e 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -71,7 +71,7 @@ typedef struct SCSIDiskClass {
 
 typedef struct SCSIDiskReq {
     SCSIRequest req;
-    /* Both sector and sector_count are in terms of qemu 512 byte blocks.  */
+    /* Both sector and sector_count are in terms of BDRV_SECTOR_SIZE bytes.  */
     uint64_t sector;
     uint32_t sector_count;
     uint32_t buflen;
@@ -141,7 +141,7 @@ static void scsi_init_iovec(SCSIDiskReq *r, size_t size)
         r->buflen = size;
         r->iov.iov_base = blk_blockalign(s->qdev.conf.blk, r->buflen);
     }
-    r->iov.iov_len = MIN(r->sector_count * 512, r->buflen);
+    r->iov.iov_len = MIN(r->sector_count * BDRV_SECTOR_SIZE, r->buflen);
     qemu_iovec_init_external(&r->qiov, &r->iov, 1);
 }
 
@@ -311,7 +311,7 @@ static void scsi_read_complete_noio(SCSIDiskReq *r, int ret)
         goto done;
     }
 
-    n = r->qiov.size / 512;
+    n = r->qiov.size / BDRV_SECTOR_SIZE;
     r->sector += n;
     r->sector_count -= n;
     scsi_req_data(&r->req, r->qiov.size);
@@ -505,7 +505,7 @@ static void scsi_write_complete_noio(SCSIDiskReq *r, int ret)
         goto done;
     }
 
-    n = r->qiov.size / 512;
+    n = r->qiov.size / BDRV_SECTOR_SIZE;
     r->sector += n;
     r->sector_count -= n;
     if (r->sector_count == 0) {
@@ -1284,7 +1284,7 @@ static int scsi_disk_emulate_mode_sense(SCSIDiskReq *r, uint8_t *outbuf)
         } else { /* MODE_SENSE_10 */
             outbuf[7] = 8; /* Block descriptor length  */
         }
-        nb_sectors /= (s->qdev.blocksize / 512);
+        nb_sectors /= (s->qdev.blocksize / BDRV_SECTOR_SIZE);
         if (nb_sectors > 0xffffff) {
             nb_sectors = 0;
         }
@@ -1342,7 +1342,7 @@ static int scsi_disk_emulate_read_toc(SCSIRequest *req, uint8_t *outbuf)
     start_track = req->cmd.buf[6];
     blk_get_geometry(s->qdev.conf.blk, &nb_sectors);
     trace_scsi_disk_emulate_read_toc(start_track, format, msf >> 1);
-    nb_sectors /= s->qdev.blocksize / 512;
+    nb_sectors /= s->qdev.blocksize / BDRV_SECTOR_SIZE;
     switch (format) {
     case 0:
         toclen = cdrom_read_toc(nb_sectors, outbuf, msf, start_track);
@@ -1738,9 +1738,10 @@ static void scsi_write_same_complete(void *opaque, int ret)
 
     block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
 
-    data->nb_sectors -= data->iov.iov_len / 512;
-    data->sector += data->iov.iov_len / 512;
-    data->iov.iov_len = MIN(data->nb_sectors * 512, data->iov.iov_len);
+    data->nb_sectors -= data->iov.iov_len / BDRV_SECTOR_SIZE;
+    data->sector += data->iov.iov_len / BDRV_SECTOR_SIZE;
+    data->iov.iov_len = MIN(data->nb_sectors * BDRV_SECTOR_SIZE,
+                            data->iov.iov_len);
     if (data->iov.iov_len) {
         block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct,
                          data->iov.iov_len, BLOCK_ACCT_WRITE);
@@ -1805,9 +1806,10 @@ static void scsi_disk_emulate_write_same(SCSIDiskReq *r, uint8_t *inbuf)
 
     data = g_new0(WriteSameCBData, 1);
     data->r = r;
-    data->sector = r->req.cmd.lba * (s->qdev.blocksize / 512);
-    data->nb_sectors = nb_sectors * (s->qdev.blocksize / 512);
-    data->iov.iov_len = MIN(data->nb_sectors * 512, SCSI_WRITE_SAME_MAX);
+    data->sector = r->req.cmd.lba * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
+    data->nb_sectors = nb_sectors * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
+    data->iov.iov_len = MIN(data->nb_sectors * BDRV_SECTOR_SIZE,
+                            SCSI_WRITE_SAME_MAX);
     data->iov.iov_base = buf = blk_blockalign(s->qdev.conf.blk,
                                               data->iov.iov_len);
     qemu_iovec_init_external(&data->qiov, &data->iov, 1);
@@ -1980,7 +1982,7 @@ static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
         if ((req->cmd.buf[8] & 1) == 0 && req->cmd.lba) {
             goto illegal_request;
         }
-        nb_sectors /= s->qdev.blocksize / 512;
+        nb_sectors /= s->qdev.blocksize / BDRV_SECTOR_SIZE;
         /* Returned value is the address of the last sector.  */
         nb_sectors--;
         /* Remember the new size for read/write sanity checking. */
@@ -2049,7 +2051,7 @@ static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
             if ((req->cmd.buf[14] & 1) == 0 && req->cmd.lba) {
                 goto illegal_request;
             }
-            nb_sectors /= s->qdev.blocksize / 512;
+            nb_sectors /= s->qdev.blocksize / BDRV_SECTOR_SIZE;
             /* Returned value is the address of the last sector.  */
             nb_sectors--;
             /* Remember the new size for read/write sanity checking. */
@@ -2180,8 +2182,8 @@ static int32_t scsi_disk_dma_command(SCSIRequest *req, uint8_t *buf)
         if (!check_lba_range(s, r->req.cmd.lba, len)) {
             goto illegal_lba;
         }
-        r->sector = r->req.cmd.lba * (s->qdev.blocksize / 512);
-        r->sector_count = len * (s->qdev.blocksize / 512);
+        r->sector = r->req.cmd.lba * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
+        r->sector_count = len * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
         break;
     case WRITE_6:
     case WRITE_10:
@@ -2211,8 +2213,8 @@ static int32_t scsi_disk_dma_command(SCSIRequest *req, uint8_t *buf)
         if (!check_lba_range(s, r->req.cmd.lba, len)) {
             goto illegal_lba;
         }
-        r->sector = r->req.cmd.lba * (s->qdev.blocksize / 512);
-        r->sector_count = len * (s->qdev.blocksize / 512);
+        r->sector = r->req.cmd.lba * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
+        r->sector_count = len * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
         break;
     default:
         abort();
@@ -2229,9 +2231,9 @@ static int32_t scsi_disk_dma_command(SCSIRequest *req, uint8_t *buf)
     }
     assert(r->iov.iov_len == 0);
     if (r->req.cmd.mode == SCSI_XFER_TO_DEV) {
-        return -r->sector_count * 512;
+        return -r->sector_count * BDRV_SECTOR_SIZE;
     } else {
-        return r->sector_count * 512;
+        return r->sector_count * BDRV_SECTOR_SIZE;
     }
 }
 
@@ -2243,7 +2245,7 @@ static void scsi_disk_reset(DeviceState *dev)
     scsi_device_purge_requests(&s->qdev, SENSE_CODE(RESET));
 
     blk_get_geometry(s->qdev.conf.blk, &nb_sectors);
-    nb_sectors /= s->qdev.blocksize / 512;
+    nb_sectors /= s->qdev.blocksize / BDRV_SECTOR_SIZE;
     if (nb_sectors) {
         nb_sectors--;
     }
-- 
2.21.3


