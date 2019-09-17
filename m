Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02D5C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74A0C2171F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A0C2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAFAd-0003x4-Dr
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 11:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iAF7y-0002KW-PP
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iAF7x-0000Mr-LQ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:10:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51466)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iAF7x-0000MW-E2
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:10:49 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AE4A43D94D
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 15:10:48 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id x26so4536368qtr.17
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 08:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4g62E+SBDzJ7ohzk2fS075D7alU2of+XsKpha575t9M=;
 b=MA1yl1clxK9xJid48x+XyOeweayGa6c+j1IaVUU7QUs2wqGj3bd1PpGUX8JLukWw0z
 nRVubbRzQGBFWPkn7CCUZvcbvhRbcQM0wQ1qFYTKEN8sTnN6pwIi5gaX7pXDrx2g+Icn
 xCfM/VGeCDR9N8bFMV5e/xiUPVBVzTEAxsa+KZ5xXWgBFB9oNEUoB6LngRj+zhF3b1ek
 AFRyTLbe+sxAuBkSAQl4uW73cCP6nlXTuBaJ3S/f/v92JCNuUYsJlf1Ac/Yy/fwiLFMM
 8vYTYdBz0SMrA4cU1vjsEE9TzZeoher0tUqu14RRO0QJNR+q5CLLlghXgPBvJ5Q2UcYP
 RlgA==
X-Gm-Message-State: APjAAAWsdB/w+uLIU5iH6D1iVjW1r4ngA6GA8XOrXZ4NAh0nJn6mIvkt
 WLe+yhWz4OqPhwEjgMTAqrwTgzC5BlsE1TN8FNMdo7i5wd2BlmErnL0NW6iNZCCuJ6DLpWmiVYL
 pl1SXd1+F0u/WDAU=
X-Received: by 2002:a37:7fc7:: with SMTP id a190mr4345698qkd.351.1568733047542; 
 Tue, 17 Sep 2019 08:10:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzSwns0NPDOWV3HM1sc1XC6CC1aIrYqfZejpr81R+hm77xAiHg4w49c1fAvrB2v/9x/e8dNWg==
X-Received: by 2002:a37:7fc7:: with SMTP id a190mr4345673qkd.351.1568733047363; 
 Tue, 17 Sep 2019 08:10:47 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id i30sm1502063qte.27.2019.09.17.08.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 08:10:46 -0700 (PDT)
Date: Tue, 17 Sep 2019 11:10:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1566498865-55506-1-git-send-email-raphael.norwitz@nutanix.com>
References: <20190917151011.24588-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190917151011.24588-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 03/10] vhost-user-blk: prevent using
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Phillippe Mathieu-Daude <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190917151043.Xmevx_m3LWqLP9ciPS9RYK4t-LP-q91cfSud9JqWhGo@z>

From: Raphael Norwitz <raphael.norwitz@nutanix.com>

Same rational as: e6cc11d64fc998c11a4dfcde8fda3fc33a74d844

Of the 3 virtqueues, seabios only sets cmd, leaving ctrl
and event without a physical address. This can cause
vhost_verify_ring_part_mapping to return ENOMEM, causing
the following logs:

qemu-system-x86_64: Unable to map available ring for ring 0
qemu-system-x86_64: Verify ring failure on region 0

This has already been fixed for vhost scsi devices and was
recently vhost-user scsi devices. This commit fixes it for
vhost-user-blk devices.

Suggested-by: Phillippe Mathieu-Daude <philmd@redhat.com>
Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <1566498865-55506-1-git-send-email-raphael.norwitz@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/vhost-user-blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 0b8c5dfeab..63da9bb619 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -421,7 +421,7 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
     }
 
     s->inflight = g_new0(struct vhost_inflight, 1);
-    s->vqs = g_new(struct vhost_virtqueue, s->num_queues);
+    s->vqs = g_new0(struct vhost_virtqueue, s->num_queues);
     s->watch = 0;
     s->connected = false;
 
-- 
MST


