Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD8AC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:07:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 790DF206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790DF206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49153 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYcBw-00086H-OZ
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 16:07:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYc5P-00034E-2H
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYc5K-0005YF-HA
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:38 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:38984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hYc5K-0005S6-8Y
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:34 -0400
Received: by mail-qk1-f177.google.com with SMTP id i125so14544qkd.6
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 13:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=oWUawf31eMQD6ACHrKCfMWf9y12ShHT6G47Hktpyv9Q=;
	b=q5llxD4egr0h949w0XzpdmTG20Wk69qKCDK8z56JuBeMmx0lwbo/9nF2kt8eJXwpDX
	eAhNFTfyEDE/uoCAdGAbRREFl3VONGJxbSYiEExfNV9sTpHrt+5ug0RRn3MnPhelYV2Q
	DWcaRzDoC/szW3AbTWTC/6U5K+rq2sEEnAdX0QidpbaOCVBqmaX4gIPeuZruASDqnuPJ
	2oTaVlhom5R1l02Iu0rxbMBe2/i4pW8zVDJ4SpNf17nDCFGzFYvXtfFHKkxS0dsyyhFZ
	SrCx4f28Zu+nMqyXHrgK6MokNo5GjJ4BsYID3/aHueGafBU0qvPQUEeSnQCzRUE5hm23
	Syqg==
X-Gm-Message-State: APjAAAUAFYooT4bridVwEXzBtDmGLJatEfW99oBlzUNsCI4RgEqK8L+a
	Ibop0SGe0EuigHCRAKfqAQkn3y9imsg=
X-Google-Smtp-Source: APXvYqy5gBBDtyELR+odhBlxh6XC34KxFSvbHoFD4dB1BFp2UlRz3v+AWendTGyfjGJ2PvB/hV9u9Q==
X-Received: by 2002:a37:4152:: with SMTP id o79mr6863827qka.276.1559764830950; 
	Wed, 05 Jun 2019 13:00:30 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103])
	by smtp.gmail.com with ESMTPSA id k6sm1280188qkd.21.2019.06.05.13.00.29
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 05 Jun 2019 13:00:30 -0700 (PDT)
Date: Wed, 5 Jun 2019 16:00:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556608500-12183-1-git-send-email-wangjie88@huawei.com>
References: <20190605195913.12243-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190605195913.12243-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.177
Subject: [Qemu-devel] [PULL v3 09/17] vhost: fix memory leak in
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
Message-ID: <20190605200029.ibDij7PYTENvvxP7gbNrzsES26G3x7c9NI772HArG8E@z>

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


