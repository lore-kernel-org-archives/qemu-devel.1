Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F30EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 07:44:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA8F206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 07:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HH64tEcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA8F206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg1bI-0008Lm-82
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 03:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <morecache@gmail.com>)
 id 1jg1ZG-0003sv-3n
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 03:42:38 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <morecache@gmail.com>)
 id 1jg1ZF-0000ZB-CE
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 03:42:37 -0400
Received: by mail-wm1-x341.google.com with SMTP id c71so1870180wmd.5
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 00:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jhAbJ4GRGhtDDVKIxTwS8TPvMGErkabeXRmJPRzEdzM=;
 b=HH64tEcTh2bYLaAwptSA5cSoe0GnCZleCtOT+lWyHEDZe+ZE6bwAqxFczuBRNRa62J
 4fAkk83vTdEUfHfkSiQkVxzRUhsk3ddXak0mQRNl5QM4u7m08tVJQv4v/wOc+ybMhEUo
 0s/ge9ChCFGiNogcpyW7cuQHgLLvPdLYO7uAPsaXWDpITr1yoDizOsxB3W3NUaPE22PM
 q0J9R+ElNGW5pNu5u8Yamk4UhNBtQzqeHWjLpobIj//N4+8H63fTotFQ5wSkfz3Kknx5
 NZmESQSfYp9X2hnB16LJglKpPCqWNJWt9Vj8peYjX+UcQUXHp1dy+77kmEZdPWvYc7vD
 e9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jhAbJ4GRGhtDDVKIxTwS8TPvMGErkabeXRmJPRzEdzM=;
 b=WPnqr95D96awvb8Ap4XXs/Gq/g8v9tozzOIRPvN4kN7+6J+pVTm4XKoZdHUSYp8oIK
 fyipJBGAUOBrl2Pa6oU/kaPOd0E21M63saluG3z1QXGpfm2HZnb1zASt4j4ZkwQrKyH5
 U1cQrUPyqj7zCFsZwuWhevka90r8Tb2ejjd7aGehV+Pvon5I0ZKGZW09EXW/6QzWlCyy
 Z4xOVUHY6jwBzCgCzimnYCQMj5/b9fAU1bl6PEKfnMGK9UVdWVLLCJCNxv3yUaRrmb6g
 Vd22DukKxKHTevstZs4i61ShS9e8P9r+uQ0ry5GI/6i7+hmW/0wG554V4rrnGBGoU6N9
 c0oA==
X-Gm-Message-State: AOAM533uPUtfGuD+SXB6wb+gPcYUQL6KGKddLhJcWVZFjkGZ+30B2Mqv
 z69z4WOpg4hzAyU+PvJWLvaMNaUo3UM=
X-Google-Smtp-Source: ABdhPJyFD57ySBj1mj6h6wHYgqD+b1Ksjg2wi6MMtqvOj/WUHNl+4VOZ801yFkyo4cp30jRG/Wo9MA==
X-Received: by 2002:a1c:3c89:: with SMTP id j131mr2820557wma.59.1591083754653; 
 Tue, 02 Jun 2020 00:42:34 -0700 (PDT)
Received: from t440p.suse.asia (60-251-47-115.HINET-IP.hinet.net.
 [60.251.47.115])
 by smtp.gmail.com with ESMTPSA id w3sm2294518wmg.44.2020.06.02.00.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 00:42:34 -0700 (PDT)
From: Lin Ma <lma@suse.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] block: Add GET LBA STATUS support
Date: Tue,  2 Jun 2020 15:41:59 +0800
Message-Id: <20200602074201.10879-3-lma@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200602074201.10879-1-lma@suse.com>
References: <20200602074201.10879-1-lma@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=morecache@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, stefanha@redhat.com, Lin Ma <lma@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Lin Ma <lma@suse.com>
---
 block/block-backend.c          | 38 ++++++++++++++++++++++++++++++++++
 include/sysemu/block-backend.h |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 6936b25c83..feb1f38b98 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1650,6 +1650,44 @@ int blk_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
     return blk_prw(blk, offset, NULL, bytes, blk_pdiscard_entry, 0);
 }
 
+static int coroutine_fn
+blk_do_get_lba_status(BlockBackend *blk, int64_t offset, int bytes,
+                      uint32_t *num_blocks, uint32_t *is_deallocated)
+{
+    int ret;
+
+    blk_wait_while_drained(blk);
+
+    ret = blk_check_byte_request(blk, offset, bytes);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return bdrv_co_get_lba_status(blk->root, offset, bytes, num_blocks,
+                                  is_deallocated);
+}
+
+static void blk_aio_get_lba_status_entry(void *opaque)
+{
+    BlkAioEmAIOCB *acb = opaque;
+    BlkRwCo *rwco = &acb->rwco;
+
+    void *data = acb->common.opaque;
+    uint32_t *num_blocks = &data[0];
+    uint32_t *is_deallocated = &data[sizeof(uint32_t)];
+
+    rwco->ret = blk_do_get_lba_status(rwco->blk, rwco->offset, acb->bytes,
+                                      num_blocks, is_deallocated);
+    blk_aio_complete(acb);
+}
+
+BlockAIOCB *blk_aio_get_lba_status(BlockBackend *blk, int64_t offset, int bytes,
+                                   BlockCompletionFunc *cb, void *opaque)
+{
+    return blk_aio_prwv(blk, offset, bytes, NULL, blk_aio_get_lba_status_entry,
+                        0, cb, opaque);
+}
+
 /* To be called between exactly one pair of blk_inc/dec_in_flight() */
 static int coroutine_fn blk_do_flush(BlockBackend *blk)
 {
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 8203d7f6f9..cd527ec0c9 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -171,6 +171,8 @@ BlockAIOCB *blk_aio_flush(BlockBackend *blk,
                           BlockCompletionFunc *cb, void *opaque);
 BlockAIOCB *blk_aio_pdiscard(BlockBackend *blk, int64_t offset, int bytes,
                              BlockCompletionFunc *cb, void *opaque);
+BlockAIOCB *blk_aio_get_lba_status(BlockBackend *blk, int64_t offset, int bytes,
+                                   BlockCompletionFunc *cb, void *opaque);
 void blk_aio_cancel(BlockAIOCB *acb);
 void blk_aio_cancel_async(BlockAIOCB *acb);
 int blk_ioctl(BlockBackend *blk, unsigned long int req, void *buf);
-- 
2.24.0


