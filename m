Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56F4C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0916206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnoUn7Fg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0916206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipCmY-00070s-Dh
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 09:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipCkd-0004bk-4G
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:56:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipCkb-0005Qe-Oq
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:56:03 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38950)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipCkb-0005Q6-Hc; Wed, 08 Jan 2020 09:56:01 -0500
Received: by mail-wm1-x343.google.com with SMTP id 20so2812622wmj.4;
 Wed, 08 Jan 2020 06:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=55yi1vJuIPc6uvcE+4FM+S7vWH9/hsBz/Hp/0qkGAcQ=;
 b=CnoUn7FgkPHdQcIV91sThsYdyY2OwOXjVAf7x7fp3H5AIJcr+HrENJ9Fkc+1FD2tKO
 D20lOcZiol5DXp/LDMHcENRJa4ITJ1g3VZWS0DLSoU29WHD4FoKN4FvMGX5zR0+Z28Mh
 S9Fve0u+FAKZmmuVJB93+FCCuHutBYFEyEcj024Baaoxk/O/9dTCozRyTTZmLLfkEb24
 ViaNbnHMRWakS0+D+UV/eNG4xQLP+Z08looFW+9UDyVqtpMm9T5z+jCgLHtjRzjGGBj3
 hwTQC6gAgA0aFxg0WARs5RpKO2C5isAeS7JzNWJto888L4FkwyzOJKWq2FP0OeQFbCCV
 wyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=55yi1vJuIPc6uvcE+4FM+S7vWH9/hsBz/Hp/0qkGAcQ=;
 b=fWuDle6ln1u+1w3a5JEQnVXBDKpRZj7WcZORqnVCfjq/kmj+drl57Wsxqtd7pfBv8I
 hER2JZjtnjLU0ItK0VbOdtfGAZKZPiRLLW0zgC2LuZCg4HuQsBs6/sd5/YJmrCLg5Lu5
 AN0Q2wOiYOoRGOTGuNm2x/pCBmoQBD9aymU7a85q8LPFKnxIzgLncPpfH4ZLmQV3HYle
 YDx5uplER2LunD7OiooSziljXRQHoCfET5WMbh2XOL6+2DEICFB8z0VlMljjNFie1o0t
 HrsU8mmQKTKryLIuLvRR/IRQS9pgZq+DK3228IInc1xJK40QV0/uEM9ePcaKcvW1X7aR
 5T/Q==
X-Gm-Message-State: APjAAAXxjZ/r+sp9Nf1aN4js1T+afo3f2aVmYfyzE4yJKGn+i1toJQqY
 uj8rjz8nqhkk6cCiZRQjthvtQWC9
X-Google-Smtp-Source: APXvYqyWg27U+eNw3TbGnM+Z1vCCIukWhA2gslQAkdwDorUxEx3CQOmWqSIAPNocQfnk8An88rOFRQ==
X-Received: by 2002:a1c:23d7:: with SMTP id j206mr4198369wmj.39.1578495360251; 
 Wed, 08 Jan 2020 06:56:00 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g21sm4703529wrb.48.2020.01.08.06.55.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 06:55:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] block/io: wait for serialising requests when a request
 becomes serialising
Date: Wed,  8 Jan 2020 15:55:55 +0100
Message-Id: <1578495356-46219-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578495356-46219-1-git-send-email-pbonzini@redhat.com>
References: <1578495356-46219-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marking without waiting would not result in actual serialising behavior.
Thus, make a call bdrv_mark_request_serialising sufficient for
serialisation to happen.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/file-posix.c        |  1 -
 block/io.c                | 40 +++++++++++++++++-----------------------
 include/block/block_int.h |  3 +--
 3 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 1b805bd..2b08b02 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2753,7 +2753,6 @@ raw_do_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int bytes,
         req->overlap_bytes = req->bytes;
 
         bdrv_mark_request_serialising(req, bs->bl.request_alignment);
-        bdrv_wait_serialising_requests(req);
     }
 #endif
 
diff --git a/block/io.c b/block/io.c
index b3a67fe..c466df8 100644
--- a/block/io.c
+++ b/block/io.c
@@ -41,6 +41,7 @@
 #define MAX_BOUNCE_BUFFER (32768 << BDRV_SECTOR_BITS)
 
 static void bdrv_parent_cb_resize(BlockDriverState *bs);
+static bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest *self);
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags);
 
@@ -715,7 +716,7 @@ static void tracked_request_begin(BdrvTrackedRequest *req,
     qemu_co_mutex_unlock(&bs->reqs_lock);
 }
 
-void bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
+bool bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
 {
     int64_t overlap_offset = req->offset & ~(align - 1);
     uint64_t overlap_bytes = ROUND_UP(req->offset + req->bytes, align)
@@ -728,18 +729,7 @@ void bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
 
     req->overlap_offset = MIN(req->overlap_offset, overlap_offset);
     req->overlap_bytes = MAX(req->overlap_bytes, overlap_bytes);
-}
-
-static bool is_request_serialising_and_aligned(BdrvTrackedRequest *req)
-{
-    /*
-     * If the request is serialising, overlap_offset and overlap_bytes are set,
-     * so we can check if the request is aligned. Otherwise, don't care and
-     * return false.
-     */
-
-    return req->serialising && (req->offset == req->overlap_offset) &&
-           (req->bytes == req->overlap_bytes);
+    return bdrv_wait_serialising_requests(req);
 }
 
 /**
@@ -823,7 +813,7 @@ void bdrv_dec_in_flight(BlockDriverState *bs)
     bdrv_wakeup(bs);
 }
 
-bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest *self)
+static bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest *self)
 {
     BlockDriverState *bs = self->bs;
     BdrvTrackedRequest *req;
@@ -1455,10 +1445,10 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
          * it ensures that the CoR read and write operations are atomic and
          * guest writes cannot interleave between them. */
         bdrv_mark_request_serialising(req, bdrv_get_cluster_size(bs));
+    } else {
+        bdrv_wait_serialising_requests(req);
     }
 
-    bdrv_wait_serialising_requests(req);
-
     if (flags & BDRV_REQ_COPY_ON_READ) {
         int64_t pnum;
 
@@ -1851,13 +1841,19 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
     assert(!(flags & ~BDRV_REQ_MASK));
 
     if (flags & BDRV_REQ_SERIALISING) {
-        bdrv_mark_request_serialising(req, bdrv_get_cluster_size(bs));
+        waited = bdrv_mark_request_serialising(req, bdrv_get_cluster_size(bs));
+        /*
+         * For a misaligned request we should have already waited earlier,
+         * because we come after bdrv_padding_rmw_read which must be called
+         * with the request already marked as serialising.
+         */
+        assert(!waited ||
+               (req->offset == req->overlap_offset &&
+                req->bytes == req->overlap_bytes));
+    } else {
+        bdrv_wait_serialising_requests(req);
     }
 
-    waited = bdrv_wait_serialising_requests(req);
-
-    assert(!waited || !req->serialising ||
-           is_request_serialising_and_aligned(req));
     assert(req->overlap_offset <= offset);
     assert(offset + bytes <= req->overlap_offset + req->overlap_bytes);
     assert(end_sector <= bs->total_sectors || child->perm & BLK_PERM_RESIZE);
@@ -2019,7 +2015,6 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
     padding = bdrv_init_padding(bs, offset, bytes, &pad);
     if (padding) {
         bdrv_mark_request_serialising(req, align);
-        bdrv_wait_serialising_requests(req);
 
         bdrv_padding_rmw_read(child, req, &pad, true);
 
@@ -2122,7 +2117,6 @@ int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
 
     if (bdrv_pad_request(bs, &qiov, &qiov_offset, &offset, &bytes, &pad)) {
         bdrv_mark_request_serialising(&req, align);
-        bdrv_wait_serialising_requests(&req);
         bdrv_padding_rmw_read(child, &req, &pad, false);
     }
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index dd033d0..640fb82 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -999,8 +999,7 @@ extern unsigned int bdrv_drain_all_count;
 void bdrv_apply_subtree_drain(BdrvChild *child, BlockDriverState *new_parent);
 void bdrv_unapply_subtree_drain(BdrvChild *child, BlockDriverState *old_parent);
 
-bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest *self);
-void bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align);
+bool coroutine_fn bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align);
 BdrvTrackedRequest *coroutine_fn bdrv_co_get_self_request(BlockDriverState *bs);
 
 int get_tmp_filename(char *filename, int size);
-- 
1.8.3.1



