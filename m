Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC17C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 07:39:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29C7324C4F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 07:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRY7kWAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C7324C4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47462 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY42p-0004Qo-EU
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 03:39:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hY3yu-0001IS-9o
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hY3yt-00045Y-ER
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:35:40 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hY3yt-0003y4-8E
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:35:39 -0400
Received: by mail-pg1-x541.google.com with SMTP id h2so6598602pgg.1
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 00:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=XTNMBKN2X1BkfbMgr70LpEg84K+wAte084VIv3k+D1I=;
	b=eRY7kWAUZ8kn8Qqjp0Boz4O+CM1SK9RoFVjsxl4IlCWcIT0XPsDCg0rY6hBO1QZy/k
	OIqwzZQf6tJWZMbD5I+3ssuCzh9vNOmWcUTn4fd3rWHjoVO5WoB8eDzNmCv2ihGZenAS
	+InfQzqHdphxpS46Ng40pLDGH6sbLF/WSUZOUbPJZbtyYq9PqlaXrNBrYHV2h1CtgafL
	wVsKZv8IMPB1R/GXXEBYfUede9bWmbXDfA8q59vLUfN3v79jJQxWEpVQ3DBNUx5CGMmw
	cOSd3Ymj9SFCz08t6KNiO+na2J8UNr2HGQW//fpGKxv2d/bQwV7vqB+aI5SI1tMsmY/p
	j3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=XTNMBKN2X1BkfbMgr70LpEg84K+wAte084VIv3k+D1I=;
	b=H6rZqgWMLOVMEi6lZL3vyaLnwaxir8V5wys7s0eiICP8kLA1LsdhKp60NEU26X/5ia
	CLtCTMPAQCABPlegR4r7Ucav+KJlQ1fFhVPR6dhCyPg8SYua/FgD49AippAAhpOLVguf
	coVEjJ9/Oz8+594VhFnz4uef4oSUKZX0DXD/xLl7dUHmxBYydKVvqZPpWuup7aIbtAFn
	AGTqdwE5olZViHSEwTvrYtFDVDfvjWZv/SlH2snkZAK7pJy3TeHzf16tqEpRV2NUDBnB
	UswIaisO23eNbggRR6gDffveeepMqjgFYnZkJbQvRv3bHnXv8qyXdZ4hUFkaFo4Nj1nG
	88mw==
X-Gm-Message-State: APjAAAU0P9aZ30crxFd4WF3G9R78su1dk2P0/79bDXwxDAmH6W+8hdbA
	89GrXTvruAvNWXJvjoZ7s40=
X-Google-Smtp-Source: APXvYqybLj7SVGuaVCTwtM8siXHKLSXVO1OnORlyJUFJmtcl5/6c0LO2gFkEgMz1OAfPGgsY7ltXcA==
X-Received: by 2002:a17:90a:62c6:: with SMTP id
	k6mr33981582pjs.7.1559633738223; 
	Tue, 04 Jun 2019 00:35:38 -0700 (PDT)
Received: from localhost ([116.247.112.152]) by smtp.gmail.com with ESMTPSA id
	b16sm17232845pfd.12.2019.06.04.00.35.37
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 04 Jun 2019 00:35:37 -0700 (PDT)
From: elohimes@gmail.com
X-Google-Original-From: xieyongji@baidu.com
To: mst@redhat.com,
	groug@kaod.org
Date: Tue,  4 Jun 2019 15:34:57 +0800
Message-Id: <20190604073459.15651-4-xieyongji@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604073459.15651-1-xieyongji@baidu.com>
References: <20190604073459.15651-1-xieyongji@baidu.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v2 3/5] virtio: Make sure we get correct state
 of device on handle_aio_output()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Xie Yongji <xieyongji@baidu.com>, dgilbert@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xie Yongji <xieyongji@baidu.com>

We should set the flags: "start_on_kick" and "started" after we call
the kick functions (handle_aio_output() and handle_output()).

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
---
 hw/virtio/virtio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 6ec45d8f0a..3dc2f8c223 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1575,11 +1575,11 @@ void virtio_queue_notify(VirtIODevice *vdev, int n)
         event_notifier_set(&vq->host_notifier);
     } else if (vq->handle_output) {
         vq->handle_output(vdev, vq);
-    }
 
-    if (unlikely(vdev->start_on_kick)) {
-        vdev->started = true;
-        vdev->start_on_kick = false;
+        if (unlikely(vdev->start_on_kick)) {
+            vdev->started = true;
+            vdev->start_on_kick = false;
+        }
     }
 }
 
-- 
2.17.1


