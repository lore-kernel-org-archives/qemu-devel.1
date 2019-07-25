Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FADAC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:34:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59017229F3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59017229F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfl0-0002XC-Uw
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49154)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqfix-0004Oi-JW
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqfis-00025X-AS
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:32:04 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:44741)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqfiq-00023d-Iy
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:32:00 -0400
Received: by mail-qt1-f173.google.com with SMTP id 44so18462110qtg.11
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 08:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qXQUg4Kta23ntDHkhiVCZLYlJLKuuOflKsyqruTW+1M=;
 b=bkByt7qWiHBQr9flWJNmR8iIHTjTt3yEt5nFRV/miVN8A9rfgxVWMvUs5/j/Vrgj/6
 Oh1NvBnTfaVpilglH8PYCxvuo7oP5LgBgQHbk77K4Jkpv3RoVta8YbM9o+gXAJVH0c9e
 3EOGKgNmzPFM6AJ4R1qyz5+GWqYCE4vE4rD0ZdUJB2p+7v8cACZw1rTVBrnHvlGR85+r
 mTBQBPHdPc4HNzH0dauwX9BN1HzFXBGiOtvTNNa8gM9pqxan9MYmqFnlB57adPsZBdlO
 OpYjXlgFCul/cVuHAUOJan944guacv23nE/3T+XXvXeL8Q3uTfxswQ0c6rqCSPjeYFG0
 LMNA==
X-Gm-Message-State: APjAAAUvmJdLv7/o7vuVsZJwnF/joLBFIxqTwkGfLjnkyr2+qs2PxR7z
 yuc0ixT+PVJBtN6lebUuVGy2h08FsVa0Cw==
X-Google-Smtp-Source: APXvYqwZ1+zIIB1hHKLF0WLwI92BGFUDWofm44TgEEBzAYxPmqOaJ3mpipMZSluAn0jukuhL2+/0/g==
X-Received: by 2002:a0c:81f0:: with SMTP id 45mr65622140qve.13.1564068719420; 
 Thu, 25 Jul 2019 08:31:59 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 m12sm20453575qkk.123.2019.07.25.08.31.57
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 08:31:58 -0700 (PDT)
Date: Thu, 25 Jul 2019 11:31:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190722134108.22151-3-david@redhat.com>
References: <20190725153059.7313-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190725153059.7313-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.173
Subject: [Qemu-devel] [PULL 06/12] virtio-balloon: Fix QEMU crashes on
 pagesize > BALLOON_PAGE_SIZE
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
 David Gibson <david@gibson.dropbear.id.au>, qemu-stable@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190725153155.FPV5JPHNf8iXpoDw4t9Frtqtef33ciDjQq0mmw8gTvk@z>

From: David Hildenbrand <david@redhat.com>

We are using the wrong functions to set/clear bits, effectively touching
multiple bits, writing out of range of the bitmap, resulting in memory
corruptions. We have to use set_bit()/clear_bit() instead.

Can easily be reproduced by starting a qemu guest on hugetlbfs memory,
inflating the balloon. QEMU crashes. This never could have worked
properly - especially, also pages would have been discarded when the
first sub-page would be inflated (the whole bitmap would be set).

While testing I realized, that on hugetlbfs it is pretty much impossible
to discard a page - the guest just frees the 4k sub-pages in random order
most of the time. I was only able to discard a hugepage a handful of
times - so I hope that now works correctly.

Fixes: ed48c59875b6 ("virtio-balloon: Safely handle BALLOON_PAGE_SIZE < host page size")
Fixes: b27b32391404 ("virtio-balloon: Fix possible guest memory corruption with inflates & deflates")
Cc: qemu-stable@nongnu.org #v4.0.0
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190722134108.22151-3-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-balloon.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 515abf6553..a78d2d2184 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -94,9 +94,8 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
         balloon->pbp->base = host_page_base;
     }
 
-    bitmap_set(balloon->pbp->bitmap,
-               (ram_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
-               subpages);
+    set_bit((ram_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
+            balloon->pbp->bitmap);
 
     if (bitmap_full(balloon->pbp->bitmap, subpages)) {
         /* We've accumulated a full host page, we can actually discard
@@ -140,9 +139,8 @@ static void balloon_deflate_page(VirtIOBalloon *balloon,
          * for a guest to do this in practice, but handle it anyway,
          * since getting it wrong could mean discarding memory the
          * guest is still using. */
-        bitmap_clear(balloon->pbp->bitmap,
-                     (ram_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
-                     subpages);
+        clear_bit((ram_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
+                  balloon->pbp->bitmap);
 
         if (bitmap_empty(balloon->pbp->bitmap, subpages)) {
             g_free(balloon->pbp);
-- 
MST


