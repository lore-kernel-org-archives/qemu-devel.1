Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE1EC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:19:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBF9A2238C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF9A2238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfWU-00084m-0S
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45899)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqfWH-0007fw-UD
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqfWG-00020a-Iu
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:19:01 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32864)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqfWG-0001yr-E2
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:19:00 -0400
Received: by mail-qt1-f193.google.com with SMTP id r6so45213501qtt.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 08:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=90Tl041o8ADF/DIqY7fnqH1k25cYZ/IcGAXjvzAUKkU=;
 b=A9mVyL7FX0L+p27diAga1qYZQP8jqW+OkzaVQaGPiI6HKAYtqABG073ryFhkPx6hmV
 lHKDDA3mhacidMs2op8C9ELueGdAocEkhRR2r9/FSJdwHHez63GF3darNSVDdoKWbkW6
 kcxa+RATh3zmKfMkAArzjB2TfYBJEfNntWqQyvePjfynXqsjf8bFipTV/XZawtvQPi0T
 07tIbEND7rxAwjS/r/GGKcjKCKRlBqtqiaLoZl1mEAq5GH9nV7prhmoLseSzenezC0IW
 ViGXEFVWAt0/X6u3Ieht71oDAwMTgvZCEJSBxFzS856m/8xAOy9NSjngULsYI/fLsxLa
 RFMA==
X-Gm-Message-State: APjAAAVK3/OnEf9ZfrXOJEkhu0i0n98LWKkUM9Aj1n/KICAD/YVf9Y/y
 IrqKlkX8fNEzWzzgkBdQvcSPJb4U1TEcjw==
X-Google-Smtp-Source: APXvYqy+AglBLlxnkX6w8FWtTUVkQmE2gRMJVT02rUcbo0NKXFJ5WWm7xt6BnlJFrf63Q9heDHe9Tg==
X-Received: by 2002:ac8:32e8:: with SMTP id a37mr63611658qtb.231.1564067939527; 
 Thu, 25 Jul 2019 08:18:59 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 x46sm30928525qtx.96.2019.07.25.08.18.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 08:18:58 -0700 (PDT)
Date: Thu, 25 Jul 2019 11:18:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190725151735.29334-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.193
Subject: [Qemu-devel] [PATCH v4] virtio-balloon: free pbp more aggressively
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Previous patches switched to a temporary pbp but that does not go far
enough: after device uses a buffer, guest is free to reuse it, so
tracking the page and freeing it later is wrong.

Free and reset the pbp after we push each element.

Fixes: ed48c59875b6 ("virtio-balloon: Safely handle BALLOON_PAGE_SIZE < host page size")
Cc: qemu-stable@nongnu.org #v4.0.0
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

changes from v2, v3:
    v3 was same as v2, sent by mistake
    v4 fixes a typo

 hw/virtio/virtio-balloon.c | 37 ++++++++++++++++---------------------

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index fe9664e42c..25de154307 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -41,22 +41,19 @@ typedef struct PartiallyBalloonedPage {
 
 static void virtio_balloon_pbp_free(PartiallyBalloonedPage *pbp)
 {
-    if (!pbp) {
+    if (!pbp->bitmap) {
         return;
     }
     g_free(pbp->bitmap);
-    g_free(pbp);
+    pbp->bitmap = NULL;
 }
 
-static PartiallyBalloonedPage *virtio_balloon_pbp_alloc(ram_addr_t base_gpa,
-                                                        long subpages)
+static void virtio_balloon_pbp_alloc(PartiallyBalloonedPage *pbp,
+                                     ram_addr_t base_gpa,
+                                     long subpages)
 {
-    PartiallyBalloonedPage *pbp = g_new0(PartiallyBalloonedPage, 1);
-
     pbp->base_gpa = base_gpa;
     pbp->bitmap = bitmap_new(subpages);
-
-    return pbp;
 }
 
 static bool virtio_balloon_pbp_matches(PartiallyBalloonedPage *pbp,
@@ -67,7 +64,7 @@ static bool virtio_balloon_pbp_matches(PartiallyBalloonedPage *pbp,
 
 static void balloon_inflate_page(VirtIOBalloon *balloon,
                                  MemoryRegion *mr, hwaddr mr_offset,
-                                 PartiallyBalloonedPage **pbp)
+                                 PartiallyBalloonedPage *pbp)
 {
     void *addr = memory_region_get_ram_ptr(mr) + mr_offset;
     ram_addr_t rb_offset, rb_aligned_offset, base_gpa;
@@ -104,22 +101,21 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
     base_gpa = memory_region_get_ram_addr(mr) + mr_offset -
                (rb_offset - rb_aligned_offset);
 
-    if (*pbp && !virtio_balloon_pbp_matches(*pbp, base_gpa)) {
+    if (pbp->bitmap && !virtio_balloon_pbp_matches(pbp, base_gpa)) {
         /* We've partially ballooned part of a host page, but now
          * we're trying to balloon part of a different one.  Too hard,
          * give up on the old partial page */
-        virtio_balloon_pbp_free(*pbp);
-        *pbp = NULL;
+        virtio_balloon_pbp_free(pbp);
     }
 
-    if (!*pbp) {
-        *pbp = virtio_balloon_pbp_alloc(base_gpa, subpages);
+    if (!pbp->bitmap) {
+        virtio_balloon_pbp_alloc(pbp, base_gpa, subpages);
     }
 
     set_bit((rb_offset - rb_aligned_offset) / BALLOON_PAGE_SIZE,
-            (*pbp)->bitmap);
+            pbp->bitmap);
 
-    if (bitmap_full((*pbp)->bitmap, subpages)) {
+    if (bitmap_full(pbp->bitmap, subpages)) {
         /* We've accumulated a full host page, we can actually discard
          * it now */
 
@@ -127,8 +123,7 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
         /* We ignore errors from ram_block_discard_range(), because it
          * has already reported them, and failing to discard a balloon
          * page is not fatal */
-        virtio_balloon_pbp_free(*pbp);
-        *pbp = NULL;
+        virtio_balloon_pbp_free(pbp);
     }
 }
 
@@ -328,13 +323,14 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
 static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
-    PartiallyBalloonedPage *pbp = NULL;
     VirtQueueElement *elem;
     MemoryRegionSection section;
 
     for (;;) {
+        PartiallyBalloonedPage pbp = {};
         size_t offset = 0;
         uint32_t pfn;
+
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
         if (!elem) {
             break;
@@ -379,9 +375,8 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
         virtqueue_push(vq, elem, offset);
         virtio_notify(vdev, vq);
         g_free(elem);
+        virtio_balloon_pbp_free(&pbp);
     }
-
-    virtio_balloon_pbp_free(pbp);
 }
 
 static void virtio_balloon_receive_stats(VirtIODevice *vdev, VirtQueue *vq)
-- 
MST

