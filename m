Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0025CC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:21:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B91462171F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91462171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43474 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrb5-0007c2-TT
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:21:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrQZ-0006zM-6f
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrQY-0007vW-7U
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:43 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:41519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrQY-0007uv-3C
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:42 -0400
Received: by mail-qt1-f169.google.com with SMTP id y22so18332481qtn.8
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=BdQmdQ0lBDJ6Q7Q+g+I1UB4uSsg7bUq8SfpRaDBHlX4=;
	b=iJ2jkdjrkq+XgjPueKWV5iAMH9jN1KQ0DSSyD43zjwaP0HiYGkCGwCvyKmpTI2NnS+
	Rbm5GAV0/oXbk43gWjzaOCzWYRr+zW6U96L21qn+83FW3X1kku5EHxCgrZrSXXXxTzfH
	W1ufvd9amwtPL13n2BKxLT64ilUXI0mmp4n7W3b7VmMaPci40grJoaeV2q9Z9kUBWbQ3
	kmySreLhwVA4UWKmezAZ1/Oo7GApSaoH0fNMdoXLMKJbB1Dqo3xKQIubPa/GfNhH1VYj
	rVuebQpNHhIVAFwOS7/5Of0lbmp25mgqiMfXfsolS+U0VhP3RVvYzaTdb8hgLYn36cMy
	U/fQ==
X-Gm-Message-State: APjAAAVWozie2o36NiLbitodhjpAva3BSSnw2S5OjrL2+2sRZbOUfw/d
	bWmtkLZAnsd/PWlpE6PH7VABCNxJ+FI=
X-Google-Smtp-Source: APXvYqyjqZ3cQikpLf6Vojth7ujoYXNgMdV2IBAvvIOAkFTwETHtN1xTOuy0wZQdfcMOtSmltYU08Q==
X-Received: by 2002:a0c:adf7:: with SMTP id x52mr40719082qvc.21.1558393840799; 
	Mon, 20 May 2019 16:10:40 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	p8sm11130425qta.24.2019.05.20.16.10.39
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 16:10:40 -0700 (PDT)
Date: Mon, 20 May 2019 19:10:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190320112646.3712-4-xieyongji@baidu.com>
References: <20190520231008.20140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190520231008.20140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.169
Subject: [Qemu-devel] [PULL v2 06/36] vhost-user-blk: Use started flag in
 vhost_user_blk_set_status()
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	Zhang Yu <zhangyu31@baidu.com>, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>, Xie Yongji <xieyongji@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190520231038.k7nZAxBBizymfONCiFD604POogDA0Ne9DK5TflRmpWc@z>

From: Xie Yongji <xieyongji@baidu.com>

Use started flag in vhost_user_blk_set_status() to decide if
starting vhost-user backend or not.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
Message-Id: <20190320112646.3712-4-xieyongji@baidu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/block/vhost-user-blk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 28b81368f7..700c1dd111 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -190,7 +190,7 @@ static void vhost_user_blk_stop(VirtIODevice *vdev)
 static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
-    bool should_start = status & VIRTIO_CONFIG_S_DRIVER_OK;
+    bool should_start = vdev->started;
 
     if (!vdev->vm_running) {
         should_start = false;
@@ -350,7 +350,7 @@ static void vhost_user_blk_device_unrealize(DeviceState *dev, Error **errp)
     VHostUserBlk *s = VHOST_USER_BLK(dev);
     struct vhost_virtqueue *vqs = s->dev.vqs;
 
-    vhost_user_blk_set_status(vdev, 0);
+    virtio_set_status(vdev, 0);
     vhost_dev_cleanup(&s->dev);
     vhost_dev_free_inflight(s->inflight);
     g_free(vqs);
-- 
MST


