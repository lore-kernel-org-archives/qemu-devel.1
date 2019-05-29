Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970B6C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 16:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FB1523DFC
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 16:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB1523DFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57865 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW1ex-0004Ot-Nj
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 12:42:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hW1a6-0000Bz-Jt
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hW1a5-0002uJ-MY
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:37:38 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:44298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hW1a5-0002tz-IX
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:37:37 -0400
Received: by mail-qt1-f182.google.com with SMTP id m2so3358247qtp.11
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 09:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=oWUawf31eMQD6ACHrKCfMWf9y12ShHT6G47Hktpyv9Q=;
	b=FO7ngOtVL8ZztA43D88g9kpqTmOMPZIzmD0wDy6w1jJdQJQgeVmr6lbAVi2//VXoks
	JqPFBzWmc6su20kLZFN1cOi8NwASEI9s633Ro+Rtz8aHfltcYV8RtGgvpQ5MpLwGQCtW
	936Pvy5r59NoPEYIw7H1zFC+mxHYUr1jQ6/CyrRN0MfqGpEC+sR+fgLTp5CsFkgvd1JS
	8lfjQMCwKaxNDuW919lE9FXK7Z3TNfWgT8bnE6mT59D3jDZMcKVF0nwYFddKJ7Jb9OGb
	/YVWsF5rlV8uyy/4IOMdDDCDEz/Y+/DqOIfRaFMClfVVTUK70YDmurU5OKrnPZuUgeMU
	GtsA==
X-Gm-Message-State: APjAAAUr0P9GXZoBcOpzKzaP7bOlQpwJqLB2zpdeCGCSEMd4bqgTLF4S
	7+LY48cuwRsiMrL3WLdTGRUbK1M4TnU=
X-Google-Smtp-Source: APXvYqwKGiEmCOovN367gIQaWKlj38MpHm6b6G8uYqL8ztgDatB/JGNARa/JMW35eljR2eBkAW4ebQ==
X-Received: by 2002:a0c:af51:: with SMTP id j17mr77292207qvc.34.1559147856882; 
	Wed, 29 May 2019 09:37:36 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103])
	by smtp.gmail.com with ESMTPSA id q9sm4810735qtr.83.2019.05.29.09.37.35
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 29 May 2019 09:37:36 -0700 (PDT)
Date: Wed, 29 May 2019 12:37:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556608500-12183-1-git-send-email-wangjie88@huawei.com>
References: <20190529163604.18560-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190529163604.18560-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.182
Subject: [Qemu-devel] [PULL 10/10] vhost: fix memory leak in
 vhost_user_scsi_realize
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	Jie Wang <wangjie88@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190529163734.7pgtJGs0VXYqZaVpUNnTVWxvURGpe4A7PttFrUcghMc@z>

From: Jie Wang <wangjie88@huawei.com>

fix memory leak in vhost_user_scsi_realize

Signed-off-by: Jie Wang <wangjie88@huawei.com>
Message-Id: <1556608500-12183-1-git-send-email-wangjie88@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/scsi/vhost-user-scsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 8b1e6876db..a9fd8ea305 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -69,6 +69,7 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
     VHostUserSCSI *s = VHOST_USER_SCSI(dev);
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
+    struct vhost_virtqueue *vqs = NULL;
     Error *err = NULL;
     int ret;
 
@@ -93,6 +94,7 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
     vsc->dev.vqs = g_new(struct vhost_virtqueue, vsc->dev.nvqs);
     vsc->dev.vq_index = 0;
     vsc->dev.backend_features = 0;
+    vqs = vsc->dev.vqs;
 
     ret = vhost_dev_init(&vsc->dev, &s->vhost_user,
                          VHOST_BACKEND_TYPE_USER, 0);
@@ -100,6 +102,7 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "vhost-user-scsi: vhost initialization failed: %s",
                    strerror(-ret));
         vhost_user_cleanup(&s->vhost_user);
+        g_free(vqs);
         return;
     }
 
-- 
MST


