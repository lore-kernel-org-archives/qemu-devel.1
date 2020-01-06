Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7E0C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A44A208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nu0kKN/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A44A208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXGB-0000zc-VN
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4L-0002LW-Jh
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4K-0004N6-0o
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:37 -0500
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:39292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX4J-0004Mk-SN; Mon, 06 Jan 2020 13:25:35 -0500
Received: by mail-qv1-xf43.google.com with SMTP id y8so19431485qvk.6;
 Mon, 06 Jan 2020 10:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1eNWCesezoeCHU4P6XXmYWzX+KWcO3wBsevjsS6K9fg=;
 b=Nu0kKN/mxLka/H/3rWIpQbIG6c9bN9JQ85u2Z01T8cvkL4gjy7BxQihZSMLpMLUklq
 Vqg76xrZlnb6wmDKUUeUpvbQxFZGd7JmKMFdPj/VoIBcDhCxEiqfSGd1GoEyroFDgFJa
 tHjY0lqU+XOQd458ZLr/EQO1Bd83NFE9CXCgZitBjxwJWZFXwkkkOm7ih9cBnxX6NmmN
 QgQa6CuISUm9Q9ntrKJAumoUi5MvmEryIh0IBODnTON0O8LSvTfaQpBivcbtLiz2EslZ
 ZQlRgJmQApUN06vFTQ1mfpGL9YGXImbdAHMkX0U07th7TSBEQLn2TV78jtUED5fwTRRd
 /kMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1eNWCesezoeCHU4P6XXmYWzX+KWcO3wBsevjsS6K9fg=;
 b=LEOxwHVuSspPIi63ArFbaQeqUDQvoLDg1Pb0Y4ZXdluk1eqMRLOhdatFP31MkMPxtJ
 krydVUgiDrsgm27MJZnrc9308Y4ZNZrQRuvGSD010anZraZplOPjf5dEqQOMinQoLgun
 GOlTts6o1gLvgVv/7PYmZGAhWRIap2UVW+c4RqtUHgVTqYGmkvbgZqSTyC3NsmbIq9GM
 0JwTHC3iXuCvxPLxhPfK/kHTouHPU3wja9uGtjv3mHpI/g8SYxurA0TcaDD5hN7oUVG/
 SvVtASKJmmSPyAhY2+LWNR+l4IaTwB8jg8ixk2jTyVggpSenpXIKDzOuV9fM5jQKKpzz
 z2bQ==
X-Gm-Message-State: APjAAAXJvaITTws1rQX41Fwdeh3ddLk+QhdBVxrDd/zXtpAO7RVxWyg4
 TENyIcypMEGFBubH4/tVhkCp4Xub
X-Google-Smtp-Source: APXvYqw9VquKkGWHrF4hZ6jV1CoCcGb2PRdGGrSSPEADPaUlEEOsRNz2cwqWfgIdzM0AbV/oVRUjgw==
X-Received: by 2002:a0c:fa87:: with SMTP id o7mr81007061qvn.160.1578335135150; 
 Mon, 06 Jan 2020 10:25:35 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:25:34 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 24/59] block/vhdx-log.c: remove unneeded labels
Date: Mon,  6 Jan 2020 15:23:50 -0300
Message-Id: <20200106182425.20312-25-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f43
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
Cc: qemu-trivial@nongnu.org, Jeff Cody <codyprime@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Removing some 'exit' labels used in some functions that are
unneeded, changing them for the adequate 'return' value
for the context.

CC: Jeff Cody <codyprime@gmail.com>
CC: qemu-block@nongnu.org
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 block/vhdx-log.c | 86 ++++++++++++++++++------------------------------
 1 file changed, 32 insertions(+), 54 deletions(-)

diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index 13a49c2a33..ba89f0adc6 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -64,8 +64,7 @@ static int vhdx_log_peek_hdr(BlockDriverState *bs, VHDXLogEntries *log,
 
     /* peek is only supported on sector boundaries */
     if (log->read % VHDX_LOG_SECTOR_SIZE) {
-        ret = -EFAULT;
-        goto exit;
+        return -EFAULT;
     }
 
     read = log->read;
@@ -77,19 +76,17 @@ static int vhdx_log_peek_hdr(BlockDriverState *bs, VHDXLogEntries *log,
     }
 
     if (read == log->write) {
-        ret = -EINVAL;
-        goto exit;
+        return -EINVAL;
     }
 
     offset = log->offset + read;
 
     ret = bdrv_pread(bs->file, offset, hdr, sizeof(VHDXLogEntryHeader));
     if (ret < 0) {
-        goto exit;
+        return ret;
     }
     vhdx_log_entry_hdr_le_import(hdr);
 
-exit:
     return ret;
 }
 
@@ -179,7 +176,7 @@ static int vhdx_log_write_sectors(BlockDriverState *bs, VHDXLogEntries *log,
 
     ret = vhdx_user_visible_write(bs, s);
     if (ret < 0) {
-        goto exit;
+        return ret;
     }
 
     write = log->write;
@@ -196,7 +193,7 @@ static int vhdx_log_write_sectors(BlockDriverState *bs, VHDXLogEntries *log,
         ret = bdrv_pwrite(bs->file, offset, buffer_tmp,
                           VHDX_LOG_SECTOR_SIZE);
         if (ret < 0) {
-            goto exit;
+            return ret;
         }
         buffer_tmp += VHDX_LOG_SECTOR_SIZE;
 
@@ -205,7 +202,6 @@ static int vhdx_log_write_sectors(BlockDriverState *bs, VHDXLogEntries *log,
         num_sectors--;
     }
 
-exit:
     return ret;
 }
 
@@ -214,42 +210,37 @@ exit:
 static bool vhdx_log_hdr_is_valid(VHDXLogEntries *log, VHDXLogEntryHeader *hdr,
                                   BDRVVHDXState *s)
 {
-    int valid = false;
-
     if (hdr->signature != VHDX_LOG_SIGNATURE) {
-        goto exit;
+        return false;
     }
 
     /* if the individual entry length is larger than the whole log
      * buffer, that is obviously invalid */
     if (log->length < hdr->entry_length) {
-        goto exit;
+        return false;
     }
 
     /* length of entire entry must be in units of 4KB (log sector size) */
     if (hdr->entry_length % (VHDX_LOG_SECTOR_SIZE)) {
-        goto exit;
+        return false;
     }
 
     /* per spec, sequence # must be > 0 */
     if (hdr->sequence_number == 0) {
-        goto exit;
+        return false;
     }
 
     /* log entries are only valid if they match the file-wide log guid
      * found in the active header */
     if (!guid_eq(hdr->log_guid, s->headers[s->curr_header]->log_guid)) {
-        goto exit;
+        return false;
     }
 
     if (hdr->descriptor_count * sizeof(VHDXLogDescriptor) > hdr->entry_length) {
-        goto exit;
+        return false;
     }
 
-    valid = true;
-
-exit:
-    return valid;
+    return true;
 }
 
 /*
@@ -274,10 +265,10 @@ static bool vhdx_log_desc_is_valid(VHDXLogDescriptor *desc,
     bool ret = false;
 
     if (desc->sequence_number != hdr->sequence_number) {
-        goto exit;
+        return false;
     }
     if (desc->file_offset % VHDX_LOG_SECTOR_SIZE) {
-        goto exit;
+        return false;
     }
 
     if (desc->signature == VHDX_LOG_ZERO_SIGNATURE) {
@@ -290,7 +281,6 @@ static bool vhdx_log_desc_is_valid(VHDXLogDescriptor *desc,
             ret = true;
     }
 
-exit:
     return ret;
 }
 
@@ -347,20 +337,18 @@ static int vhdx_log_read_desc(BlockDriverState *bs, BDRVVHDXState *s,
 
     ret = vhdx_log_peek_hdr(bs, log, &hdr);
     if (ret < 0) {
-        goto exit;
+        return ret;
     }
 
     if (vhdx_log_hdr_is_valid(log, &hdr, s) == false) {
-        ret = -EINVAL;
-        goto exit;
+        return -EINVAL;
     }
 
     desc_sectors = vhdx_compute_desc_sectors(hdr.descriptor_count);
     desc_entries = qemu_try_blockalign(bs->file->bs,
                                        desc_sectors * VHDX_LOG_SECTOR_SIZE);
     if (desc_entries == NULL) {
-        ret = -ENOMEM;
-        goto exit;
+        return -ENOMEM;
     }
 
     ret = vhdx_log_read_sectors(bs, log, &sectors_read, desc_entries,
@@ -390,11 +378,10 @@ static int vhdx_log_read_desc(BlockDriverState *bs, BDRVVHDXState *s,
     }
 
     *buffer = desc_entries;
-    goto exit;
+    return ret;
 
 free_and_exit:
     qemu_vfree(desc_entries);
-exit:
     return ret;
 }
 
@@ -688,7 +675,7 @@ static int vhdx_log_search(BlockDriverState *bs, BDRVVHDXState *s,
         ret = vhdx_validate_log_entry(bs, s, &curr_log, curr_seq,
                                       &seq_valid, &hdr);
         if (ret < 0) {
-            goto exit;
+            return ret;
         }
 
         if (seq_valid) {
@@ -704,7 +691,7 @@ static int vhdx_log_search(BlockDriverState *bs, BDRVVHDXState *s,
                 ret = vhdx_validate_log_entry(bs, s, &curr_log, curr_seq,
                                               &seq_valid, &hdr);
                 if (ret < 0) {
-                    goto exit;
+                    return ret;
                 }
                 if (seq_valid == false) {
                     break;
@@ -735,8 +722,6 @@ static int vhdx_log_search(BlockDriverState *bs, BDRVVHDXState *s,
         s->log.sequence = candidate.hdr.sequence_number + 1;
     }
 
-
-exit:
     return ret;
 }
 
@@ -766,29 +751,26 @@ int vhdx_parse_log(BlockDriverState *bs, BDRVVHDXState *s, bool *flushed,
 
     if (s->log.offset < VHDX_LOG_MIN_SIZE ||
         s->log.offset % VHDX_LOG_MIN_SIZE) {
-        ret = -EINVAL;
-        goto exit;
+        return -EINVAL;
     }
 
     /* per spec, only log version of 0 is supported */
     if (hdr->log_version != 0) {
-        ret = -EINVAL;
-        goto exit;
+        return -EINVAL;
     }
 
     /* If either the log guid, or log length is zero,
      * then a replay log is not present */
     if (guid_eq(hdr->log_guid, zero_guid)) {
-        goto exit;
+        return 0;
     }
 
     if (hdr->log_length == 0) {
-        goto exit;
+        return 0;
     }
 
     if (hdr->log_length % VHDX_LOG_MIN_SIZE) {
-        ret = -EINVAL;
-        goto exit;
+        return -EINVAL;
     }
 
 
@@ -797,13 +779,12 @@ int vhdx_parse_log(BlockDriverState *bs, BDRVVHDXState *s, bool *flushed,
 
     ret = vhdx_log_search(bs, s, &logs);
     if (ret < 0) {
-        goto exit;
+        return ret;
     }
 
     if (logs.valid) {
         if (bs->read_only) {
             bdrv_refresh_filename(bs);
-            ret = -EPERM;
             error_setg(errp,
                        "VHDX image file '%s' opened read-only, but "
                        "contains a log that needs to be replayed",
@@ -811,18 +792,16 @@ int vhdx_parse_log(BlockDriverState *bs, BDRVVHDXState *s, bool *flushed,
             error_append_hint(errp,  "To replay the log, run:\n"
                               "qemu-img check -r all '%s'\n",
                               bs->filename);
-            goto exit;
+            return -EPERM;
         }
         /* now flush the log */
         ret = vhdx_log_flush(bs, s, &logs);
         if (ret < 0) {
-            goto exit;
+            return ret;
         }
         *flushed = true;
     }
 
-
-exit:
     return ret;
 }
 
@@ -1048,29 +1027,28 @@ int vhdx_log_write_and_flush(BlockDriverState *bs, BDRVVHDXState *s,
      * on disk, before creating log entry */
     ret = bdrv_flush(bs);
     if (ret < 0) {
-        goto exit;
+        return ret;
     }
 
     ret = vhdx_log_write(bs, s, data, length, offset);
     if (ret < 0) {
-        goto exit;
+        return ret;
     }
     logs.log = s->log;
 
     /* Make sure log is stable on disk */
     ret = bdrv_flush(bs);
     if (ret < 0) {
-        goto exit;
+        return ret;
     }
 
     ret = vhdx_log_flush(bs, s, &logs);
     if (ret < 0) {
-        goto exit;
+        return ret;
     }
 
     s->log = logs.log;
 
-exit:
     return ret;
 }
 
-- 
2.24.1


