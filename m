Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92168CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:00:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64492214DA
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64492214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOU6Y-0001rI-DJ
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 18:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iOU02-0001PR-A9
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iOU00-0003k9-4Q
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:53:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56916)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iOTzz-0003jz-Sc
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:53:28 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 19F214E832
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 21:53:27 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id c32so6674842qtb.14
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 14:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9ubs1Dwo+2yEGEjjIZIZR5bnXBBhA5aFPitQR8k8KII=;
 b=L8VjzqNwxU+/vd2euwm38j5tzSwTfPJk0ctZpz00M4PBE4fHK6GPddzAI71KSQRc8K
 tLATa3KwVWPVKxu6GlQHt7QptX9ATM546I9zeUhbeY8JZuIJJP/m/4MaRMRPQ1Q/t+Bv
 5Ti1eU2jdIgE6kAZluCTGCL+R9R4efgpZcUNWuxWP4fJecgJnn0LVuiqrEHetj/q6SWr
 Lyu+lGtV+A+ntRP4BaMqE1bQ54KmdxHGn/ayyup3r+t4+BhnenQaz4WaU0Sq68i2izEW
 Tv8wuPmZHc0L3GXf+xbrBcO8KyFCYBBI7r4GrOnjWiEvtg/kM7lJgT9avHPIrItMFPIH
 7S6g==
X-Gm-Message-State: APjAAAVM4xCQQWTSlwzdiTCUq9O4iE0By1ZunhKMsSqBojmC/+GzNwRv
 Fwuton8Dd2s3Za/MQO/iFqtxbdDerv/aqdFmSIHYdifBjkTgM278OUIqD9eSfq07V+JEPTlzgpI
 Ryw/nPQ1CSKOAmmI=
X-Received: by 2002:ac8:c86:: with SMTP id n6mr10206195qti.80.1572126806097;
 Sat, 26 Oct 2019 14:53:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwYhipWVhl2oS0exc5PDf58aSZrVlBnoDVh+fQb/MduRnvVBHTEQwIkPRqkB8dQq1S1pSXd6A==
X-Received: by 2002:ac8:c86:: with SMTP id n6mr10206189qti.80.1572126805943;
 Sat, 26 Oct 2019 14:53:25 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 w20sm3148180qkj.58.2019.10.26.14.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2019 14:53:25 -0700 (PDT)
Date: Sat, 26 Oct 2019 17:53:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/25] virtio: drop unused virtio_device_stop_ioeventfd()
 function
Message-ID: <20191026193824.11926-26-mst@redhat.com>
References: <20191026193824.11926-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026193824.11926-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

virtio_device_stop_ioeventfd() has not been used since commit
310837de6c1e0badfd736b1b316b1698c53120a7 ("virtio: introduce
grab/release_ioeventfd to fix vhost") in 2016.

Nowadays ioeventfd is stopped implicitly by the virtio transport when
lifecycle events such as the VM pausing or device unplug occur.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20191021150343.30742-1-stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c         | 8 --------
 include/hw/virtio/virtio.h | 1 -
 2 files changed, 9 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 828c27de1f..2e91dec567 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3665,14 +3665,6 @@ static void virtio_device_stop_ioeventfd_impl(VirtIODevice *vdev)
     }
 }
 
-void virtio_device_stop_ioeventfd(VirtIODevice *vdev)
-{
-    BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
-    VirtioBusState *vbus = VIRTIO_BUS(qbus);
-
-    virtio_bus_stop_ioeventfd(vbus);
-}
-
 int virtio_device_grab_ioeventfd(VirtIODevice *vdev)
 {
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 40ddeafadb..5560f4a5ea 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -308,7 +308,6 @@ EventNotifier *virtio_queue_get_guest_notifier(VirtQueue *vq);
 void virtio_queue_set_guest_notifier_fd_handler(VirtQueue *vq, bool assign,
                                                 bool with_irqfd);
 int virtio_device_start_ioeventfd(VirtIODevice *vdev);
-void virtio_device_stop_ioeventfd(VirtIODevice *vdev);
 int virtio_device_grab_ioeventfd(VirtIODevice *vdev);
 void virtio_device_release_ioeventfd(VirtIODevice *vdev);
 bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev);
-- 
MST


