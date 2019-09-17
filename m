Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0953C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3EB12171F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3EB12171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAFHA-0001A7-Pn
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 11:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iAF85-0002Ru-Eg
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iAF84-0000OH-7C
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:10:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34926)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iAF83-0000O6-Sk
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:10:56 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2BECEC0568FD
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 15:10:55 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id m19so4565453qtm.13
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 08:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bWWyi+bKsJBamFEp83FoaU14XqxtNJjR/kc9Oy+g4FU=;
 b=U4XiRFwtmnBsoGlcK1BBXhQUV7aQCddO+2GVobWB9Pf+D2wC3GdEES9aw2NXnfyvNa
 8GnjLLdFtO/O4W4K9nEEjEAFgQmxSFaLNA+p4MDcfuw4/SsT0qWenqO2sp8oUjskdDmS
 ASghW6Bb1Kbh2/f2alAArN7xRavlCqZKqkZOfOGrNvmjt3Sen7cdHTPJ/Nl27VehHoqr
 eTYXcq9zsKESaolPdjdOSAm9OQKaidj64H4Xv5a/6y9sgrAMvrQd4ryepR+3RCFTLsHE
 6LuTkc4pisnXCa4ef2HeRmFBCUiSasRI9mPjulRwat4gUug86fR9U6+Pk8DI6DARzSvf
 mRvw==
X-Gm-Message-State: APjAAAVSVwMe6ij9TehdAqEYV54zoXC2eTprvHj15qlQ5f1YyDZ5ZCic
 GI9qUTxp9tRRbAnq94wmmlED10w/BWX+5QxJdGXuPjISgCZB2v0ykHaOrb5iPXobxHOPENFn0OQ
 VZ8O6c8oqDRWXWOY=
X-Received: by 2002:a0c:cc14:: with SMTP id r20mr2929340qvk.61.1568733053920; 
 Tue, 17 Sep 2019 08:10:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyEiwYLifdoYSZTYhVRAkj3MY7KQVATtLUe+MPbKX4NbYDs9yw8eBM5BBgPYYVAHQZRpvAhvg==
X-Received: by 2002:a0c:cc14:: with SMTP id r20mr2929319qvk.61.1568733053704; 
 Tue, 17 Sep 2019 08:10:53 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id e13sm1131622qkm.110.2019.09.17.08.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 08:10:53 -0700 (PDT)
Date: Tue, 17 Sep 2019 11:10:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1566498865-55506-2-git-send-email-raphael.norwitz@nutanix.com>
References: <20190917151011.24588-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190917151011.24588-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/10] backends/vhost-user.c: prevent using
 uninitialized vqs
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
 Philippe Mathieu-Daude <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190917151049.0OTxS_DataignyoJ220RACDjRnokt_hR3TwU5Y8ZZm0@z>

From: Raphael Norwitz <raphael.norwitz@nutanix.com>

Similar rational to: e6cc11d64fc998c11a4dfcde8fda3fc33a74d844

For vhost scsi and vhost-user-scsi an issue was observed
where, of the 3 virtqueues, seabios would only set cmd,
leaving ctrl and event without a physical address.
This can caused vhost_verify_ring_part_mapping to return
ENOMEM, causing the following logs:

qemu-system-x86_64: Unable to map available ring for ring 0
qemu-system-x86_64: Verify ring failure on region 0

The issue has already been fixed elsewhere, but it was noted
that in backends/vhost-user.c, the vhost_user_backend_dev_init()
function, which other vdevs use in their realize() to initialize
their vqs, was not being properly zeroing out the queues. This
commit ensures hardware modules using the
vhost_user_backend_dev_init() API properly zero out their vqs on
initialization.

Suggested-by: Philippe Mathieu-Daude <philmd@redhat.com>
Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <1566498865-55506-2-git-send-email-raphael.norwitz@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 backends/vhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backends/vhost-user.c b/backends/vhost-user.c
index 0a13506c98..2bf3406525 100644
--- a/backends/vhost-user.c
+++ b/backends/vhost-user.c
@@ -46,7 +46,7 @@ vhost_user_backend_dev_init(VhostUserBackend *b, VirtIODevice *vdev,
 
     b->vdev = vdev;
     b->dev.nvqs = nvqs;
-    b->dev.vqs = g_new(struct vhost_virtqueue, nvqs);
+    b->dev.vqs = g_new0(struct vhost_virtqueue, nvqs);
 
     ret = vhost_dev_init(&b->dev, &b->vhost_user, VHOST_BACKEND_TYPE_USER, 0);
     if (ret < 0) {
-- 
MST


