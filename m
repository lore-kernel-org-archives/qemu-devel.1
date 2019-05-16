Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDDFC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:28:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C1020848
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C1020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53880 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFVI-0000RU-7s
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:28:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFLF-0008Bb-Ls
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:18:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFLC-0001MY-KF
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:18:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFLC-0001MI-HU
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:18:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id z19so3488229qtz.13
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=lqcRP5TOl9HEzw5AKgljD79bRAyUWWqCwFejvOysXuY=;
	b=N1d5LgI6lELYbXsiiAK9PxVhzFWIuyaHzD/YhtqP9peN48LlrqbL1IUN99udQoKQyG
	ikPAVXtJxJ7+zNLgqDL+0yDqHzj1smn2gpvIm8oaoEk7TdCDo9vRgXaKaMqnvxBE2V0D
	+GU7uAskhZB6aibxcWD36DzqZyXgpLF6ASJiLw60BXe0v5J+QkYnYijmid4vZNbJzxPd
	6opRVlfLkeQ6BSkbG/q/7CMnoluMeWb1yGZGqLbKXTpp/5oU4XZGKlXh90DwuU7Aykm7
	jnX0AHLA5vufhmGgkxvwtVXC5DvEj0UunJeKi/ncHaQsTqwOhgWPmEEe0eqcPYrEnZmR
	nNtA==
X-Gm-Message-State: APjAAAXdvQmXz3vfA3veB3S8YAj65JqGitgU20aPTSMHjbHEkQrh28/q
	iTrUoFafRokp2+Ty9KHHKMRS/w8Nr3E=
X-Google-Smtp-Source: APXvYqwIeede6zl+eTrCbrZvSwwuNPBWsNCOVlYcvgHcRK9xAp1OPf5vnlv/mJm6Q0yBePSQ/Un9Iw==
X-Received: by 2002:a0c:b032:: with SMTP id k47mr34418946qvc.86.1558009109848; 
	Thu, 16 May 2019 05:18:29 -0700 (PDT)
Received: from redhat.com ([185.54.206.10]) by smtp.gmail.com with ESMTPSA id
	l40sm3703206qtc.32.2019.05.16.05.18.27
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:18:29 -0700 (PDT)
Date: Thu, 16 May 2019 08:18:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190320112646.3712-5-xieyongji@baidu.com>
References: <20190515121146.7248-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515121146.7248-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.194
Subject: [Qemu-devel] [PULL 07/37] vhost-user-blk: Only start vhost-user
 backend with the first kick
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

We should only start vhost-user backend at the first kick for
virtio 1.0 transitional devices.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
Message-Id: <20190320112646.3712-5-xieyongji@baidu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/block/vhost-user-blk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 700c1dd111..39e1adc60a 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -239,8 +239,7 @@ static void vhost_user_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
     int i;
 
-    if (!(virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
-        !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1))) {
+    if (!vdev->start_on_kick) {
         return;
     }
 
-- 
MST


