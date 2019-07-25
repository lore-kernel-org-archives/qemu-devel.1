Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DB1C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:34:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EFBC229F3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFBC229F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqflR-0004LP-8n
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49281)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqfjB-0005CJ-Ee
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqfj8-0002K1-V3
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:32:21 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:42793)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqfj6-0002F9-Uw
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:32:18 -0400
Received: by mail-qk1-f176.google.com with SMTP id 201so36713851qkm.9
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 08:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mv6QSSakgNkEC6bqYoUC/UKfe3IEFiZtbH4KYgyfJQs=;
 b=tb7S/BDDSkzn4ucfWW/74++CLc2O2sR751boltnDLVRF0/Kw/HVJNK6KZuoWQG1L4M
 y2BPg/1nh6LN/HLiziw7XPQnj3cZqW1r4JZizOcpLZo1CJOjGFGY5uKqfqUecVUlvWOq
 LiDG9aNPmjwj0SAvsJuz0nHwJiQ0KjIP5vFnLisB+2QN0RbRROKa89o0flnNp3KSvXd5
 Pa+7qx7ahscvbBVMhAvsBQDDvIRAnhZ7Zr3JOZXoHzYuhD0+mi/v+aGtOfd54Nw23nLe
 AWCyO4oo7UJByy62Hm7XpFBEShMf1Y03UaQ0A0NAx8rGUjGoiFUSuSa2J8XJzk30HILy
 0SXg==
X-Gm-Message-State: APjAAAWO7vJ/uqb2P41sklvvPgVb6E+oef80Lf9tXi7SJk3qbXR6hHMr
 XUTLyI6pWJaRmZqRgKs+dRcNl3ee5GUboQ==
X-Google-Smtp-Source: APXvYqzs4dr7XkuXbE9Z/b00r7jgy50AZdhDN3WYXEdRQTElIPEpeoFFZUp7r5kJjuXxethjD2RLJA==
X-Received: by 2002:a05:620a:14bc:: with SMTP id
 x28mr26605435qkj.116.1564068734046; 
 Thu, 25 Jul 2019 08:32:14 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 r5sm22267703qkc.42.2019.07.25.08.32.11
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 08:32:13 -0700 (PDT)
Date: Thu, 25 Jul 2019 11:32:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190722134108.22151-6-david@redhat.com>
References: <20190725153059.7313-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190725153059.7313-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.176
Subject: [Qemu-devel] [PULL 09/12] virtio-balloon: Rework pbp tracking data
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190725153209.ZFTBLuIg-3SGwSf1hqRq0-DcSYtzL4Li5ikikrRrxAI@z>

From: David Hildenbrand <david@redhat.com>

Using the address of a RAMBlock to test for a matching pbp is not really
safe. Instead, let's use the guest physical address of the base page
along with the page size (via the number of subpages).

Also, let's allocate the bitmap separately. This makes the code
easier to read and maintain - we can reuse bitmap_new().

Prepare the code to move the PBP out of the device.

Fixes: ed48c59875b6 ("virtio-balloon: Safely handle BALLOON_PAGE_SIZE < host page size")
Fixes: b27b32391404 ("virtio-balloon: Fix possible guest memory corruption with inflates & deflates")
Cc: qemu-stable@nongnu.org #v4.0.0
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190722134108.22151-6-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-balloon.c | 69 +++++++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 23 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index f206cc8bf7..40d493a31a 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -35,16 +35,44 @@
 #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
 
 struct PartiallyBalloonedPage {
-    RAMBlock *rb;
-    ram_addr_t base;
-    unsigned long bitmap[];
+    ram_addr_t base_gpa;
+    long subpages;
+    unsigned long *bitmap;
 };
 
+static void virtio_balloon_pbp_free(PartiallyBalloonedPage *pbp)
+{
+    if (!pbp) {
+        return;
+    }
+    g_free(pbp->bitmap);
+    g_free(pbp);
+}
+
+static PartiallyBalloonedPage *virtio_balloon_pbp_alloc(ram_addr_t base_gpa,
+                                                        long subpages)
+{
+    PartiallyBalloonedPage *pbp = g_new0(PartiallyBalloonedPage, 1);
+
+    pbp->base_gpa = base_gpa;
+    pbp->subpages = subpages;
+    pbp->bitmap = bitmap_new(subpages);
+
+    return pbp;
+}
+
+static bool virtio_balloon_pbp_matches(PartiallyBalloonedPage *pbp,
+                                       ram_addr_t base_gpa, long subpages)
+{
+    return pbp->subpages == subpages && pbp->base_gpa == base_gpa;
+}
+
 static void balloon_inflate_page(VirtIOBalloon *balloon,
                                  MemoryRegion *mr, hwaddr mr_offset)
 {
     void *addr = memory_region_get_ram_ptr(mr) + mr_offset;
-    ram_addr_t rb_offset, rb_aligned_offset;
+    ram_addr_t rb_offset, rb_aligned_offset, base_gpa;
+    PartiallyBalloonedPage **pbp = &balloon->pbp;
     RAMBlock *rb;
     size_t rb_page_size;
     int subpages;
@@ -75,39 +103,34 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
 
     rb_aligned_offset = QEMU_ALIGN_DOWN(rb_offset, rb_page_size);
     subpages = rb_page_size / BALLOON_PAGE_SIZE;
+    base_gpa = memory_region_get_ram_addr(mr) + mr_offset -
+               (rb_offset - rb_aligned_offset);
 
-    if (balloon->pbp
-        && (rb != balloon->pbp->rb
-            || rb_aligned_offset != balloon->pbp->base)) {
+    if (*pbp && !virtio_balloon_pbp_matches(*pbp, base_gpa, subpages)) {
         /* We've partially ballooned part of a host page, but now
          * we're trying to balloon part of a different one.  Too hard,
          * give up on the old partial page */
-        g_free(balloon->pbp);
-        balloon->pbp = NULL;
+        virtio_balloon_pbp_free(*pbp);
+        *pbp = NULL;
     }
 
-    if (!balloon->pbp) {
-        /* Starting on a new host page */
-        size_t bitlen = BITS_TO_LONGS(subpages) * sizeof(unsigned long);
-        balloon->pbp = g_malloc0(sizeof(PartiallyBalloonedPage) + bitlen);
-        balloon->pbp->rb = rb;
-        balloon->pbp->base = rb_aligned_offset;
+    if (!*pbp) {
+        *pbp = virtio_balloon_pbp_alloc(base_gpa, subpages);
     }
 
-    set_bit((rb_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
-            balloon->pbp->bitmap);
+    set_bit((rb_offset - rb_aligned_offset) / BALLOON_PAGE_SIZE,
+            (*pbp)->bitmap);
 
-    if (bitmap_full(balloon->pbp->bitmap, subpages)) {
+    if (bitmap_full((*pbp)->bitmap, subpages)) {
         /* We've accumulated a full host page, we can actually discard
          * it now */
 
-        ram_block_discard_range(rb, balloon->pbp->base, rb_page_size);
+        ram_block_discard_range(rb, rb_aligned_offset, rb_page_size);
         /* We ignore errors from ram_block_discard_range(), because it
          * has already reported them, and failing to discard a balloon
          * page is not fatal */
-
-        g_free(balloon->pbp);
-        balloon->pbp = NULL;
+        virtio_balloon_pbp_free(*pbp);
+        *pbp = NULL;
     }
 }
 
@@ -128,7 +151,7 @@ static void balloon_deflate_page(VirtIOBalloon *balloon,
 
     if (balloon->pbp) {
         /* Let's play safe and always reset the pbp on deflation requests. */
-        g_free(balloon->pbp);
+        virtio_balloon_pbp_free(balloon->pbp);
         balloon->pbp = NULL;
     }
 
-- 
MST


