Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC3FC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:45:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CDA8206EF
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0dnaJxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CDA8206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDx2S-0006KE-8o
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwMB-00053W-8I; Thu, 03 Sep 2020 17:01:19 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:35412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwM8-0007to-Dj; Thu, 03 Sep 2020 17:01:17 -0400
Received: by mail-oi1-x22f.google.com with SMTP id w16so4538889oia.2;
 Thu, 03 Sep 2020 14:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Gp/FZKkqU04XfSMs8F0HgQ0MGLufMuTTwBeTutB4Yfc=;
 b=W0dnaJxyLxEtYVUQkNBcw94SnTLexrnfXoacpK8hj4/14ekxTOCFZffjuQDrlQeMW8
 8c8i842QBlTBGnNow3sEUpV5BErW9ozafWYrw2dHaQevhVdhDzlVb0yIGlOsCGe5cv0a
 vSYpy0BkznZl0/dKU8vE4FyCATkI5vd7bYj4XFg65GVCD88h+KkBUEcbk7dhH5138Iyj
 V92FJHMazdYjZs6551FWkQqFC+ZuFv6Fc9BcyfUAOzhHbE1hKWmLhVJyK5Y6meBVlDib
 qOWJuD9y8WqNyFateEEc0b7bF504PsjaxGfc/RkYT2jZOetX6mJVzS9j6sOoG9kvf3Ul
 /tEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Gp/FZKkqU04XfSMs8F0HgQ0MGLufMuTTwBeTutB4Yfc=;
 b=WrWv6qLbiOABhtJlmHrIOipMT3kqZ0W8j7qzbEHyrRsLxxefWz+B/C0BZKOxDHiTo4
 jaPrPDheWn2CczoBaguINGTEOsr8fBoKFtdtJK2zThkdJ/kfNCvfeMtv+Qp/6dmFHIjj
 t4Tkljmjmhz6+Q7QebXa0J3Z98Bq6VcydOQpz8HK55XvHujBK/FGhyNwp39gTusf7Ij/
 cWU5EsO9hQsz5fwWHoaWj7jnvbYiX1rqioFyVjLFJl+48qnEPlzP1HIC37RArzVxhcK1
 oiI9+XYxiln6Dg7LSj1m58FZNRgOVrLcb5MqeHvwQzff8dDT6wXTRflkm0/AcSDtEv+o
 KK5w==
X-Gm-Message-State: AOAM530ikzARdlk5EASjTQn87h2Bn5r12c4QWSb4QXxt9oVFtYK1eQSj
 uXoWlumRV7JNxIcms27NcGtQMRQ2Z3OUzQ==
X-Google-Smtp-Source: ABdhPJw0FKmpIMmf8R4+W5pubrGUqPcTL8IfyihYyCD7YNqT4kGmUwWFFhU6u/JrT4d2nHddRYWlsQ==
X-Received: by 2002:aca:4403:: with SMTP id r3mr823175oia.94.1599166874742;
 Thu, 03 Sep 2020 14:01:14 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id b188sm716337oif.19.2020.09.03.14.01.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:01:14 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 69/77] libvhost-user: Report descriptor index on panic
Date: Thu,  3 Sep 2020 15:59:27 -0500
Message-Id: <20200903205935.27832-70-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x22f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-stable@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

We want to report the index of the descriptor,
not its pointer.

Fixes: 7b2e5c65f4 ("contrib: add libvhost-user")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200723171935.18535-1-philmd@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 8fe9805c73c277dc2feeaa83de73d6a58bf23f39)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 contrib/libvhost-user/libvhost-user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 3bca996c62..301f6d68b3 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -1867,7 +1867,7 @@ virtqueue_get_head(VuDev *dev, VuVirtq *vq,
 
     /* If their number is silly, that's a fatal mistake. */
     if (*head >= vq->vring.num) {
-        vu_panic(dev, "Guest says index %u is available", head);
+        vu_panic(dev, "Guest says index %u is available", *head);
         return false;
     }
 
@@ -1926,7 +1926,7 @@ virtqueue_read_next_desc(VuDev *dev, struct vring_desc *desc,
     smp_wmb();
 
     if (*next >= max) {
-        vu_panic(dev, "Desc next is %u", next);
+        vu_panic(dev, "Desc next is %u", *next);
         return VIRTQUEUE_READ_DESC_ERROR;
     }
 
-- 
2.17.1


