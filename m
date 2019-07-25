Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9A1C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:17:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15D222238C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D222238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfUp-0005Fd-7b
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45426)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqfUa-0004gN-2Q
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:17:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqfUY-00018S-OU
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:17:15 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45199)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqfUY-00015q-IF
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:17:14 -0400
Received: by mail-qk1-f195.google.com with SMTP id s22so36714718qkj.12
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 08:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=dbV723SnkUWXM6z3Yfauoj/670FR7hHgo3E4qVH3ikM=;
 b=VaxVbGibpoyuEs1mR06FemwcffcXe+P9oF7We9+XcGDj6V511KTMLfgGy+z1FIAwex
 Wt5tPI2bWiJYew2oWFsgNucuK4F0lb/MZxmDk4OkKakwr43AYZuEpUf6H5ULRCxww2nD
 HVETspZhrjFifIdDyIB1eSu5429KoFsfe8K0nyzkRpz2iWynKrxGUqBFKyZ127/4Ylyh
 65t1SWe938W073LM/XlXQLyBwsucxLSArdw/aJFNt0L//DzFuOcE3BSFZfGoiq+eWex2
 VTU1Fan8hyfTMkF9DKWcqHzytg2GKFia+yq2ydqNWxHvIYESHVTO2s9mBqELH8O/d5ne
 xouQ==
X-Gm-Message-State: APjAAAW/CT3PP10U3TwRc08y1Wh5FTOd40tD7NADXiemiv7PPyImubEN
 w7F0zy+61qeDFu5Uu8eCZhvC1vM+yd/eSg==
X-Google-Smtp-Source: APXvYqwoUvSH1B6yfh4c7qLyi31wFh0t03yaBQSiB6NitgJj4Sv/Q72GUnIhDnsovYnZ3QJoP+y/Qg==
X-Received: by 2002:a37:4bd3:: with SMTP id
 y202mr59932583qka.253.1564067830284; 
 Thu, 25 Jul 2019 08:17:10 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 r4sm33813042qta.93.2019.07.25.08.17.08
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 08:17:09 -0700 (PDT)
Date: Thu, 25 Jul 2019 11:17:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190725151649.28653-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.195
Subject: [Qemu-devel] [PATCH v3] virtio-balloon: free pbp more aggressively
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
Cc: qemu-stable@nongnu.org, David Hildenbrand <david@redhat.com>
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

since v2:
typo fix

 hw/virtio/virtio-balloon.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index fe9664e42c..b72ed68794 100644
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
@@ -104,16 +101,15 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
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

