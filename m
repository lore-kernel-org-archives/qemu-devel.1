Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164A1C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F64A20833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F64A20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53713 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFMw-0000mc-Fg
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:20:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFL6-00086r-PM
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFL3-0001Gb-Oj
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:18:24 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:43272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFL3-0001GC-M7
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:18:21 -0400
Received: by mail-qt1-f182.google.com with SMTP id i26so3508605qtr.10
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=BdQmdQ0lBDJ6Q7Q+g+I1UB4uSsg7bUq8SfpRaDBHlX4=;
	b=NWr4DSvYvCvhmhKT4tRxDhDF/wTjYrH6FOGfLoWHUrE/IZoHjUG3U++buwvSqBiclu
	/Tbi4bWrg7a7oEaTtedv1qsTDAyrmTEFy5h9GFSmUJbsHTk63tFSCRz2BopDqdzUP/oo
	evE0rU0ytS4kAzzALbB3g2Is5t7vWS69hR/ONQSu+1MitIna4k/skNmI7aqWoROby73P
	ANjr3n7/9Jzb5oVNaxZPgt/+w76Z9Th+pgF88gaNV98HAn1UIN6Q+jOSuTop7BQnlLFs
	P0C3Nzurj/RO0D3h1WO7Yag3Pm76tMVxQEZAb+nsu7syObDe7IpEJiI7RYnCOJgDvsDV
	/o1A==
X-Gm-Message-State: APjAAAXpat+apg9/dftIvcnNuKLouQsTQc8y7Wv0uRsLilR7XCrAaXud
	aFWHqVdElPrfm/1HaMDAPif6N0OFXhM=
X-Google-Smtp-Source: APXvYqxou0TZddpmUVDHRZRFJ3io/v294/jv4jvLW7knu1raXC5Q9tJwa63p3+cnxCdMqNlIisvsrw==
X-Received: by 2002:ac8:1985:: with SMTP id u5mr39409311qtj.389.1558009100866; 
	Thu, 16 May 2019 05:18:20 -0700 (PDT)
Received: from redhat.com ([185.54.206.10]) by smtp.gmail.com with ESMTPSA id
	q66sm2569078qke.66.2019.05.16.05.18.19
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:18:20 -0700 (PDT)
Date: Thu, 16 May 2019 08:18:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190320112646.3712-4-xieyongji@baidu.com>
References: <20190515121146.7248-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515121146.7248-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.182
Subject: [Qemu-devel] [PULL 06/37] vhost-user-blk: Use started flag in
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


