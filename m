Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE3FC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:59:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B727F22C7B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B727F22C7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqcPI-00079S-Sl
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 07:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56764)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqcP7-0006du-5U
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:59:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqcP6-00078Q-3n
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:59:25 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44139)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqcP5-00077P-Ts
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:59:23 -0400
Received: by mail-qt1-f195.google.com with SMTP id 44so17722826qtg.11
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 04:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=pvjz9rWfCywHeHoWu5I6HCWyzyK20pVQC/bjCbcdA+A=;
 b=HffysR6OT8c2n3b6XCcsRi85J9eNhG7DdNeHRAzpubFlcymQRPobidBD+j5STtex78
 eR4/zc5uDyUVBayiyFOvRLCmJh7d558FPovyTsAC3HfnRWqrj1X/tQnVkgDy6M1MSKi5
 23ASO/+12hkBZS3bSKKcLU5SvuJxyqNGxeA2k51C+lRN5jk+sozc35rTPUTm6MOXf74+
 cwmpt0LKD2RsQCb/jlJISX247xzNWE4DNoPfK1qzzHm9/lqC7pSDMJBTDgOxgvIcdT5R
 tejNlJQ7PB+gbsT7zcO1ViONgBW7ihmLPJss3JB1v2ZM9prGgCLU6R2Kg59GsHyxnUdZ
 lYgA==
X-Gm-Message-State: APjAAAVpz5TyfG+yW9Apb3Zk3vBUXgY0uaykVqII+lRp5GcfoBOEHM/M
 8aMYxFNRRIWiaNB8DFquzmR/q/WUr0M1Yw==
X-Google-Smtp-Source: APXvYqzEWSr8P5aX1NMm0J4ywtSNBvHuAQnFMlqGpIG/K0Xymq241HeRGxrbI1BIMH2mg0QHLCc5rw==
X-Received: by 2002:ac8:2a88:: with SMTP id b8mr56029536qta.331.1564055961697; 
 Thu, 25 Jul 2019 04:59:21 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 42sm26348304qtm.27.2019.07.25.04.59.19
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 04:59:20 -0700 (PDT)
Date: Thu, 25 Jul 2019 07:59:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190725115914.26983-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.195
Subject: [Qemu-devel] [PATCH] virtio-balloon: free pbp more aggressively
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
 hw/virtio/virtio-balloon.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index fe9664e42c..460a702463 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -39,13 +39,14 @@ typedef struct PartiallyBalloonedPage {
     unsigned long *bitmap;
 } PartiallyBalloonedPage;
 
-static void virtio_balloon_pbp_free(PartiallyBalloonedPage *pbp)
+static void virtio_balloon_pbp_free(PartiallyBalloonedPage **pbp)
 {
-    if (!pbp) {
+    if (!*pbp) {
         return;
     }
-    g_free(pbp->bitmap);
-    g_free(pbp);
+    g_free(*pbp->bitmap);
+    g_free(*pbp);
+    *pbp = NULL;
 }
 
 static PartiallyBalloonedPage *virtio_balloon_pbp_alloc(ram_addr_t base_gpa,
@@ -108,8 +109,7 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
         /* We've partially ballooned part of a host page, but now
          * we're trying to balloon part of a different one.  Too hard,
          * give up on the old partial page */
-        virtio_balloon_pbp_free(*pbp);
-        *pbp = NULL;
+        virtio_balloon_pbp_free(pbp);
     }
 
     if (!*pbp) {
@@ -127,8 +127,7 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
         /* We ignore errors from ram_block_discard_range(), because it
          * has already reported them, and failing to discard a balloon
          * page is not fatal */
-        virtio_balloon_pbp_free(*pbp);
-        *pbp = NULL;
+        virtio_balloon_pbp_free(pbp);
     }
 }
 
@@ -379,9 +378,8 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
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

