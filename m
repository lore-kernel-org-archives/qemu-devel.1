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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D581CC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C777208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWSKhXgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C777208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXJQ-0005yr-FV
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX41-0001uc-LF
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX40-00043W-56
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:17 -0500
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:46125)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX40-00042q-0F; Mon, 06 Jan 2020 13:25:16 -0500
Received: by mail-qv1-xf43.google.com with SMTP id u1so18595118qvk.13;
 Mon, 06 Jan 2020 10:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JYeXo1PZyJ3bV7EW4va4cPF2eGfCKteiWZKnaCT0LBw=;
 b=gWSKhXgWxHgTVSyrxbw5oJ/d/BrxyglvHXecQ9nrd1nu1vWZN6BSx8UyreJZ/M2Ymv
 l7d9fLf8MuYu0uvEA1l8lOF1GiAVb68ZkzYuwaoaQM/cgLcWG0UYjAzBkge53M+5Fcwp
 1yBa+4USzdtZJwesk6R7HL3aNWVOI9JrmPBfBMfRnUh3tq4i3X399vTK9kbRvNMUgeGQ
 IFpJ/TOCYmVt00vgv+CG0HEVun7QlAu1NvWheOQJDp1LQJtB9r7DgMeR/RFnJsU2pgMU
 +P67sQsfxaqoqDZhieYgssNvehYBu/lW4qLqzXu5A5Mvvkr4zyo9Bb/yX2V/QVqFTLcj
 dzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JYeXo1PZyJ3bV7EW4va4cPF2eGfCKteiWZKnaCT0LBw=;
 b=hLWFJ4yF4V8isEy0gmTDH+TFLIj4VwJ5Y581TNDFfBwrxokxR5dUUMcZ6CEF0KntSy
 LrhWWjmqTH85JBtPHLX0OK6i6JcAxkQE77LYyB3orXxr8lDjj8rxFua3FUyHOxnnzY5b
 nn94PhGiOc3s5J21qTNmiV+9fJuBQPvLIeS5cVLHfTBOr1pD4omHP8Sn2omJY0IRyrWn
 oQk5LYv6enItsOhlDDdvdQtLLPn58I9IZkCD1n9W56HL5IwrNjGW0eorD+mNDD/hAPPW
 CmOd8HffU/hKUCIzmT5j5IpkBchZwXJmpNjjVvpP7VBMdbf/hG8B7Lwwg35VwczRcMu+
 eHAg==
X-Gm-Message-State: APjAAAWohdwwwB+EVWL1CmAX1+QcPwwG4v3P8JKMHlvqZgk7q/AmUlpA
 u1eDcZaelUv36PVmOLzCvXDogOvQ
X-Google-Smtp-Source: APXvYqzp+VHHwmI3uPG7Wjis4BMw6w1fISV9ea/h3lm2ND4OXS3Gr3UsCu7/I71BgTJTYUxKMxzCSA==
X-Received: by 2002:a05:6214:1348:: with SMTP id
 b8mr80477849qvw.137.1578335115308; 
 Mon, 06 Jan 2020 10:25:15 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:25:15 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 13/59] block/vdi.c: remove 'fail' label in vdi_open()
Date: Mon,  6 Jan 2020 15:23:39 -0300
Message-Id: <20200106182425.20312-14-danielhb413@gmail.com>
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
Cc: qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'fail' label can be replaced by 'return ret' or by
a 'return' with the error code that was being set right
before the 'goto' call.

CC: Stefan Weil <sw@weilnetz.de>
CC: qemu-block@nongnu.org
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 block/vdi.c | 40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 0142da7233..6d486ffed9 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -388,7 +388,7 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
 
     ret = bdrv_pread(bs->file, 0, &header, sizeof(header));
     if (ret < 0) {
-        goto fail;
+        return ret;
     }
 
     vdi_header_to_cpu(&header);
@@ -400,8 +400,7 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
         error_setg(errp, "Unsupported VDI image size (size is 0x%" PRIx64
                           ", max supported is 0x%" PRIx64 ")",
                           header.disk_size, VDI_DISK_SIZE_MAX);
-        ret = -ENOTSUP;
-        goto fail;
+        return -ENOTSUP;
     }
 
     uuid_link = header.uuid_link;
@@ -418,58 +417,48 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
     if (header.signature != VDI_SIGNATURE) {
         error_setg(errp, "Image not in VDI format (bad signature %08" PRIx32
                    ")", header.signature);
-        ret = -EINVAL;
-        goto fail;
+        return -EINVAL;
     } else if (header.version != VDI_VERSION_1_1) {
         error_setg(errp, "unsupported VDI image (version %" PRIu32 ".%" PRIu32
                    ")", header.version >> 16, header.version & 0xffff);
-        ret = -ENOTSUP;
-        goto fail;
+        return -ENOTSUP;
     } else if (header.offset_bmap % SECTOR_SIZE != 0) {
         /* We only support block maps which start on a sector boundary. */
         error_setg(errp, "unsupported VDI image (unaligned block map offset "
                    "0x%" PRIx32 ")", header.offset_bmap);
-        ret = -ENOTSUP;
-        goto fail;
+        return -ENOTSUP;
     } else if (header.offset_data % SECTOR_SIZE != 0) {
         /* We only support data blocks which start on a sector boundary. */
         error_setg(errp, "unsupported VDI image (unaligned data offset 0x%"
                    PRIx32 ")", header.offset_data);
-        ret = -ENOTSUP;
-        goto fail;
+        return -ENOTSUP;
     } else if (header.sector_size != SECTOR_SIZE) {
         error_setg(errp, "unsupported VDI image (sector size %" PRIu32
                    " is not %u)", header.sector_size, SECTOR_SIZE);
-        ret = -ENOTSUP;
-        goto fail;
+        return -ENOTSUP;
     } else if (header.block_size != DEFAULT_CLUSTER_SIZE) {
         error_setg(errp, "unsupported VDI image (block size %" PRIu32
                          " is not %" PRIu32 ")",
                    header.block_size, DEFAULT_CLUSTER_SIZE);
-        ret = -ENOTSUP;
-        goto fail;
+        return -ENOTSUP;
     } else if (header.disk_size >
                (uint64_t)header.blocks_in_image * header.block_size) {
         error_setg(errp, "unsupported VDI image (disk size %" PRIu64 ", "
                    "image bitmap has room for %" PRIu64 ")",
                    header.disk_size,
                    (uint64_t)header.blocks_in_image * header.block_size);
-        ret = -ENOTSUP;
-        goto fail;
+        return -ENOTSUP;
     } else if (!qemu_uuid_is_null(&uuid_link)) {
         error_setg(errp, "unsupported VDI image (non-NULL link UUID)");
-        ret = -ENOTSUP;
-        goto fail;
+        return -ENOTSUP;
     } else if (!qemu_uuid_is_null(&uuid_parent)) {
         error_setg(errp, "unsupported VDI image (non-NULL parent UUID)");
-        ret = -ENOTSUP;
-        goto fail;
+        return -ENOTSUP;
     } else if (header.blocks_in_image > VDI_BLOCKS_IN_IMAGE_MAX) {
         error_setg(errp, "unsupported VDI image "
                          "(too many blocks %u, max is %u)",
                           header.blocks_in_image, VDI_BLOCKS_IN_IMAGE_MAX);
-        ret = -ENOTSUP;
-        goto fail;
+        return -ENOTSUP;
     }
 
     bs->total_sectors = header.disk_size / SECTOR_SIZE;
@@ -482,8 +471,7 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
     bmap_size = DIV_ROUND_UP(bmap_size, SECTOR_SIZE);
     s->bmap = qemu_try_blockalign(bs->file->bs, bmap_size * SECTOR_SIZE);
     if (s->bmap == NULL) {
-        ret = -ENOMEM;
-        goto fail;
+        return -ENOMEM;
     }
 
     ret = bdrv_pread(bs->file, header.offset_bmap, s->bmap,
@@ -509,8 +497,6 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
 
  fail_free_bmap:
     qemu_vfree(s->bmap);
-
- fail:
     return ret;
 }
 
-- 
2.24.1


