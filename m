Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116E0C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:57:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0458206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbzQRY0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0458206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipCmN-0006if-HT
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 09:57:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40338)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipCkc-0004an-7t
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:56:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipCkb-0005QA-0D
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:56:02 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36028)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipCka-0005Oy-PS; Wed, 08 Jan 2020 09:56:00 -0500
Received: by mail-wr1-x443.google.com with SMTP id z3so3726941wru.3;
 Wed, 08 Jan 2020 06:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=thqT8r9CcCG0T97Pz3DNSEuib2QMsHHphXqr+0a7uqc=;
 b=sbzQRY0KNmus5MMY6Rfoc+hLGOKn833YTEy+YoktzfgkZO5UnD8l0Yor8M0/rmjd9U
 F3apNtOHlaLPeTStQ8kwJyp7/UB25W0CI3nxeQLAbSc/87zY5j8dVjXPwgATwK4BuH4O
 G9hgtGDtylzSq3WdIMzaXnwgQ1DUcugsvhpQtzclJCtRscr2G+xgsySuC7sw3b+mDKIo
 1pvX/hN/csYFhp/EvvVo9yQWgbRpdc2jiVbunYMK5LoTndQk7tvsBtG7ja+Y2FLWrPDB
 sIxedMpp/BxeJZvRwTg4miqrfhwhaqfghaW9OEBmMjns+MpFZ217U514oSPcrwvTHvln
 RNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=thqT8r9CcCG0T97Pz3DNSEuib2QMsHHphXqr+0a7uqc=;
 b=ZFgi0cvHGXwd/hUhM3UZiKbciyvxjJu0u9erGceTzwdAMQk1yNkbVLPDURVYnV6u9D
 +55TVjnfdHGol8bh37YtJ0V5TH5R0x7lzRrHW8lBywuXk7pCaSLmAHr90WOsOQt8kOIl
 QfacNqD7UNr85NAjZBfEjsR9nwR2H98nsV3iOYL7Xy9Ut9oTOs5ddc94DkGK2lZSSCKz
 z+5UVmjRiSArrQwh5idXxBfiTGxKZHfYzpawHFnbHaSiMVmfMn/MPAwJjXzA1xR8XPEO
 p4YLYEorMYua5YvocX3ce4xz0XzZF3g21/eSidRxp0mb7WZ6n/PDECasxHQ4F+27AkGF
 AObg==
X-Gm-Message-State: APjAAAWJpV0iubizuWQDcH03i6K6g9KCTTzVGTOsgIb6lMpU4QR0TaZN
 Cd2OATzRyQYK4A7FhaptCw+W5LFj
X-Google-Smtp-Source: APXvYqwYg19dCC2FKaE1SnWdS2WrqK/9J5So61rrvTzpqM6ZguMFTANHBLVeA/UUrEFxVS/Zgo06Hw==
X-Received: by 2002:adf:e609:: with SMTP id p9mr4800868wrm.397.1578495359357; 
 Wed, 08 Jan 2020 06:55:59 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g21sm4703529wrb.48.2020.01.08.06.55.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 06:55:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] block: eliminate BDRV_REQ_NO_SERIALISING
Date: Wed,  8 Jan 2020 15:55:54 +0100
Message-Id: <1578495356-46219-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578495356-46219-1-git-send-email-pbonzini@redhat.com>
References: <1578495356-46219-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

It is unused since commit 00e30f0 ("block/backup: use backup-top instead
of write notifiers", 2019-10-01), drop it to simplify the code.

While at it, drop redundant assertions on flags.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io.c            | 18 ++++--------------
 include/block/block.h | 12 ------------
 2 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/block/io.c b/block/io.c
index f75777f..b3a67fe 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1445,8 +1445,7 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
      * potential fallback support, if we ever implement any read flags
      * to pass through to drivers.  For now, there aren't any
      * passthrough flags.  */
-    assert(!(flags & ~(BDRV_REQ_NO_SERIALISING | BDRV_REQ_COPY_ON_READ |
-                       BDRV_REQ_PREFETCH)));
+    assert(!(flags & ~(BDRV_REQ_COPY_ON_READ | BDRV_REQ_PREFETCH)));
 
     /* Handle Copy on Read and associated serialisation */
     if (flags & BDRV_REQ_COPY_ON_READ) {
@@ -1458,12 +1457,7 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
         bdrv_mark_request_serialising(req, bdrv_get_cluster_size(bs));
     }
 
-    /* BDRV_REQ_SERIALISING is only for write operation */
-    assert(!(flags & BDRV_REQ_SERIALISING));
-
-    if (!(flags & BDRV_REQ_NO_SERIALISING)) {
-        bdrv_wait_serialising_requests(req);
-    }
+    bdrv_wait_serialising_requests(req);
 
     if (flags & BDRV_REQ_COPY_ON_READ) {
         int64_t pnum;
@@ -1711,7 +1705,7 @@ int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
     bdrv_inc_in_flight(bs);
 
     /* Don't do copy-on-read if we read data before write operation */
-    if (atomic_read(&bs->copy_on_read) && !(flags & BDRV_REQ_NO_SERIALISING)) {
+    if (atomic_read(&bs->copy_on_read)) {
         flags |= BDRV_REQ_COPY_ON_READ;
     }
 
@@ -1852,8 +1846,6 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
         return -EPERM;
     }
 
-    /* BDRV_REQ_NO_SERIALISING is only for read operation */
-    assert(!(flags & BDRV_REQ_NO_SERIALISING));
     assert(!(bs->open_flags & BDRV_O_INACTIVE));
     assert((bs->open_flags & BDRV_O_NO_IO) == 0);
     assert(!(flags & ~BDRV_REQ_MASK));
@@ -3222,9 +3214,7 @@ static int coroutine_fn bdrv_co_copy_range_internal(
 
         /* BDRV_REQ_SERIALISING is only for write operation */
         assert(!(read_flags & BDRV_REQ_SERIALISING));
-        if (!(read_flags & BDRV_REQ_NO_SERIALISING)) {
-            bdrv_wait_serialising_requests(&req);
-        }
+        bdrv_wait_serialising_requests(&req);
 
         ret = src->bs->drv->bdrv_co_copy_range_from(src->bs,
                                                     src, src_offset,
diff --git a/include/block/block.h b/include/block/block.h
index e9dcfef..23c7642 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -51,18 +51,6 @@ typedef enum {
      */
     BDRV_REQ_MAY_UNMAP          = 0x4,
 
-    /*
-     * The BDRV_REQ_NO_SERIALISING flag is only valid for reads and means that
-     * we don't want wait_serialising_requests() during the read operation.
-     *
-     * This flag is used for backup copy-on-write operations, when we need to
-     * read old data before write (write notifier triggered). It is okay since
-     * we already waited for other serializing requests in the initiating write
-     * (see bdrv_aligned_pwritev), and it is necessary if the initiating write
-     * is already serializing (without the flag, the read would deadlock
-     * waiting for the serialising write to complete).
-     */
-    BDRV_REQ_NO_SERIALISING     = 0x8,
     BDRV_REQ_FUA                = 0x10,
     BDRV_REQ_WRITE_COMPRESSED   = 0x20,
 
-- 
1.8.3.1



