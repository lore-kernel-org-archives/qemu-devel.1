Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D03C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 811E5229F3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811E5229F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfl8-0002xa-FV
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49219)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqfjA-00053s-63
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:32:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqfj7-0002Hf-0O
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:32:18 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:38948)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqfj6-0002Az-Qb
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:32:16 -0400
Received: by mail-qk1-f178.google.com with SMTP id w190so36718255qkc.6
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 08:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WOXPqJ4+Hge2VEteGDijbUrAkaUYAj+l5U/9MYyqPGM=;
 b=srtpb+jhS13qq2AIjqnE0sScdFugNNPlXlbYUYp7mb5IzMr6Nrl0Uz/SsYGJE6058m
 +tMl2+pM+SknUtUnom05aGGu+ed3TxwMASVUz2y1/BhmwiUe/NbYEjG06iHY+JPha7KA
 DZ6w0OGlvTe4Lw82ptV0KKqI4W9QLvvtzShXyt+EnFZh19ruq9wWesWftlky3lcLWAgX
 gLefL7kLtGMjZU4+hmoYj8hPHJOyKwu5siiPR1NFya/TJJvU8WGnFtS9NpxoN5i5lgeu
 OhDmIAzPyQhAVAJJ0IjUr8k5zHy8pIoDbYTzI+RObgi1GfzCA1DT5FOnzouCO/GPH31n
 4nWQ==
X-Gm-Message-State: APjAAAW/fZavSFjVLprpV+9hvngBwvodc6JcE3XV6l9Tycr9TKFt5W8H
 ICULtv9sMOvgOztcihBId3P28mV51Xk54g==
X-Google-Smtp-Source: APXvYqygV2ylkFCU7/BB4NP3L8mkfNaKNO6bscNYvtsuPRHqSwiToJrr3CJhXoi9npRmvyVRPmeKpw==
X-Received: by 2002:a37:8604:: with SMTP id i4mr58230467qkd.255.1564068729077; 
 Thu, 25 Jul 2019 08:32:09 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 k38sm28532902qtk.10.2019.07.25.08.32.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 08:32:08 -0700 (PDT)
Date: Thu, 25 Jul 2019 11:32:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190722134108.22151-5-david@redhat.com>
References: <20190725153059.7313-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190725153059.7313-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.178
Subject: [Qemu-devel] [PULL 08/12] virtio-balloon: Better names for offset
 variables in inflate/deflate code
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190725153204.ZPAi2c2Kpyy4U9MFqw6iChVZwLj2_ME1R1rn5hzho8I@z>

From: David Hildenbrand <david@redhat.com>

"host_page_base" is really confusing, let's make this clearer, also
rename the other offsets to indicate to which base they apply.

offset -> mr_offset
ram_offset -> rb_offset
host_page_base -> rb_aligned_offset

While at it, use QEMU_ALIGN_DOWN() instead of a handcrafted computation
and move the computation to the place where it is needed.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190722134108.22151-5-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-balloon.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 04a7e6c772..f206cc8bf7 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -41,24 +41,23 @@ struct PartiallyBalloonedPage {
 };
 
 static void balloon_inflate_page(VirtIOBalloon *balloon,
-                                 MemoryRegion *mr, hwaddr offset)
+                                 MemoryRegion *mr, hwaddr mr_offset)
 {
-    void *addr = memory_region_get_ram_ptr(mr) + offset;
+    void *addr = memory_region_get_ram_ptr(mr) + mr_offset;
+    ram_addr_t rb_offset, rb_aligned_offset;
     RAMBlock *rb;
     size_t rb_page_size;
     int subpages;
-    ram_addr_t ram_offset, host_page_base;
 
     /* XXX is there a better way to get to the RAMBlock than via a
      * host address? */
-    rb = qemu_ram_block_from_host(addr, false, &ram_offset);
+    rb = qemu_ram_block_from_host(addr, false, &rb_offset);
     rb_page_size = qemu_ram_pagesize(rb);
-    host_page_base = ram_offset & ~(rb_page_size - 1);
 
     if (rb_page_size == BALLOON_PAGE_SIZE) {
         /* Easy case */
 
-        ram_block_discard_range(rb, ram_offset, rb_page_size);
+        ram_block_discard_range(rb, rb_offset, rb_page_size);
         /* We ignore errors from ram_block_discard_range(), because it
          * has already reported them, and failing to discard a balloon
          * page is not fatal */
@@ -74,11 +73,12 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
     warn_report_once(
 "Balloon used with backing page size > 4kiB, this may not be reliable");
 
+    rb_aligned_offset = QEMU_ALIGN_DOWN(rb_offset, rb_page_size);
     subpages = rb_page_size / BALLOON_PAGE_SIZE;
 
     if (balloon->pbp
         && (rb != balloon->pbp->rb
-            || host_page_base != balloon->pbp->base)) {
+            || rb_aligned_offset != balloon->pbp->base)) {
         /* We've partially ballooned part of a host page, but now
          * we're trying to balloon part of a different one.  Too hard,
          * give up on the old partial page */
@@ -91,10 +91,10 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
         size_t bitlen = BITS_TO_LONGS(subpages) * sizeof(unsigned long);
         balloon->pbp = g_malloc0(sizeof(PartiallyBalloonedPage) + bitlen);
         balloon->pbp->rb = rb;
-        balloon->pbp->base = host_page_base;
+        balloon->pbp->base = rb_aligned_offset;
     }
 
-    set_bit((ram_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
+    set_bit((rb_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
             balloon->pbp->bitmap);
 
     if (bitmap_full(balloon->pbp->bitmap, subpages)) {
@@ -112,18 +112,18 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
 }
 
 static void balloon_deflate_page(VirtIOBalloon *balloon,
-                                 MemoryRegion *mr, hwaddr offset)
+                                 MemoryRegion *mr, hwaddr mr_offset)
 {
-    void *addr = memory_region_get_ram_ptr(mr) + offset;
+    void *addr = memory_region_get_ram_ptr(mr) + mr_offset;
+    ram_addr_t rb_offset;
     RAMBlock *rb;
     size_t rb_page_size;
-    ram_addr_t ram_offset;
     void *host_addr;
     int ret;
 
     /* XXX is there a better way to get to the RAMBlock than via a
      * host address? */
-    rb = qemu_ram_block_from_host(addr, false, &ram_offset);
+    rb = qemu_ram_block_from_host(addr, false, &rb_offset);
     rb_page_size = qemu_ram_pagesize(rb);
 
     if (balloon->pbp) {
-- 
MST


