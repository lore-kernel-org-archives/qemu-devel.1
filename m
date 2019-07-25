Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352B3C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 12:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B72217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 12:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B72217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqd9o-0001Ed-Qq
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 08:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38287)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqd9V-0000W2-TR
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 08:47:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqd9U-0001zw-KR
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 08:47:21 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44153)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqd9O-0001u1-Sz
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 08:47:18 -0400
Received: by mail-qt1-f195.google.com with SMTP id 44so17869220qtg.11
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 05:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=T7gWq3B02kUPS45YxI+GpzRV5Vn5G3JzwdvL3XD/xMg=;
 b=CZ14KGm49rwIdenQPJyDXk/HA3OQd3YnoUKD4sYzyCQVWeHyW1lt4PUbSmZzKsN8yb
 PQPW1vtMst2CwJbgq/f8+1/2IfT77XXEpdGDDkE/rKzYcwQyGXK9Opn/DVTAX4UXrFo5
 7dxmW2OWOIU1enUqR/rqPaziK2UgegF6tpWRlHh9pnUV8hFWyurohWZS8WxmoXu0kCd8
 R7Qq4Aj1uEtAA6LVyKAe8vY3E8fWnVMzwh4847LHHqHOMJTLQRHwmFhpixXjEytRV+AC
 aRc9ssrbQ3ygLx5HhPhRs3i6jxqqaF1+gFFw3q7Ct5VTu8YiEXzXSUZp/vqFWMg90Jwi
 zrhw==
X-Gm-Message-State: APjAAAVH9rOsBc6wOVCi1U/mj83QgqtLGe/fSN30nE8dJjiHumhR5JsF
 UHzpbuL7lxnMdUrPfbLVKl87P3aHIrrfoA==
X-Google-Smtp-Source: APXvYqzpTHTzxwMPSBH7PyRvYc0tOezFWEAtOsO5vSiGOXCGD0T43YBFVs2czjLydmUgOzkPv+TFuw==
X-Received: by 2002:a05:6214:1312:: with SMTP id
 a18mr63006055qvv.241.1564058829284; 
 Thu, 25 Jul 2019 05:47:09 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 d12sm20560301qtj.50.2019.07.25.05.47.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 05:47:08 -0700 (PDT)
Date: Thu, 25 Jul 2019 08:47:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190725124632.29009-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.195
Subject: [Qemu-devel] [PATCH v2] virtio-balloon: free pbp more aggressively
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

changes from v1: moved pbp on stack

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

