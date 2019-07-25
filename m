Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4192CC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13F82229F3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F82229F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfle-0005Ls-VS
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49354)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqfjG-0005RC-2s
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqfjE-0002R6-S8
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:32:25 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:34128)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqfjE-0002Qi-NB
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:32:24 -0400
Received: by mail-qt1-f169.google.com with SMTP id k10so49554741qtq.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 08:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=po97RziE8KXKwTVyD2O5SsM0P9yhVHUKou7V2tleblI=;
 b=gIenA37lLIV98qJbGb9UOO5T1BFwHG3C4nx+ydk78rcHUFYkROxBCJw9UvM/hisQH7
 f6UBZabfpTXkz84Oa4AsFSAiUk7yf8rSiuGNaTax/iZeSPvTJVViRzog2XMos4kmSbbF
 kXEGIVeyM0jRDZppKY/8SLlSe1W+sz0Wb6wKnQXAX1jFKqyjjimdk5n0hmNHolciAmfp
 5gW0lNBYq4umn495sumUTcqlKptNCYLy5YY1crOYMug44GiOkCvweIRdRO/Yemv+Jprg
 A1QXIjLwJFngUjHekh3ytlBxAAbVtGROo5fZl2cEcba6+MtbIEu2GadCrdb195h+ogIz
 UUYg==
X-Gm-Message-State: APjAAAXKsDAwDiNJL57bC9rXtJUdN3CbBWrWqKS/tpMEJCwwZ+swyqnh
 IqG5vDM+iXUukPU+Lb2ozNrH2Y0oPq9mxA==
X-Google-Smtp-Source: APXvYqwMd4VxTxFcXgahco+NROsxz4us0Dfx38Bpeb3wjAFAOXd0IVQCpGiESIr50aD4x21f6xJyZw==
X-Received: by 2002:aed:2fa7:: with SMTP id m36mr64139596qtd.344.1564068743903; 
 Thu, 25 Jul 2019 08:32:23 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 i27sm21344486qkk.58.2019.07.25.08.32.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 08:32:23 -0700 (PDT)
Date: Thu, 25 Jul 2019 11:32:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190725113638.4702-8-david@redhat.com>
References: <20190725153059.7313-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190725153059.7313-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.169
Subject: [Qemu-devel] [PULL 11/12] virtio-balloon: don't track subpages for
 the PBP
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
Message-ID: <20190725153219.KJc835e4u9REtn73oOW5cGnikogb6haucZQcLQdN3x0@z>

From: David Hildenbrand <david@redhat.com>

As ramblocks cannot get removed/readded while we are processing a bulk
of inflation requests, there is no more need to track the page size
in form of the number of subpages.

Suggested-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190725113638.4702-8-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-balloon.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a6282d58d4..fe9664e42c 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -36,7 +36,6 @@
 
 typedef struct PartiallyBalloonedPage {
     ram_addr_t base_gpa;
-    long subpages;
     unsigned long *bitmap;
 } PartiallyBalloonedPage;
 
@@ -55,16 +54,15 @@ static PartiallyBalloonedPage *virtio_balloon_pbp_alloc(ram_addr_t base_gpa,
     PartiallyBalloonedPage *pbp = g_new0(PartiallyBalloonedPage, 1);
 
     pbp->base_gpa = base_gpa;
-    pbp->subpages = subpages;
     pbp->bitmap = bitmap_new(subpages);
 
     return pbp;
 }
 
 static bool virtio_balloon_pbp_matches(PartiallyBalloonedPage *pbp,
-                                       ram_addr_t base_gpa, long subpages)
+                                       ram_addr_t base_gpa)
 {
-    return pbp->subpages == subpages && pbp->base_gpa == base_gpa;
+    return pbp->base_gpa == base_gpa;
 }
 
 static void balloon_inflate_page(VirtIOBalloon *balloon,
@@ -106,7 +104,7 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
     base_gpa = memory_region_get_ram_addr(mr) + mr_offset -
                (rb_offset - rb_aligned_offset);
 
-    if (*pbp && !virtio_balloon_pbp_matches(*pbp, base_gpa, subpages)) {
+    if (*pbp && !virtio_balloon_pbp_matches(*pbp, base_gpa)) {
         /* We've partially ballooned part of a host page, but now
          * we're trying to balloon part of a different one.  Too hard,
          * give up on the old partial page */
-- 
MST


