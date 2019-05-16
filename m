Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9ACC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCCAE20848
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCCAE20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53782 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFQ6-0003ew-VD
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:23:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFLO-0008JZ-EU
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:18:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFLL-0001SA-Dp
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:18:42 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:45983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFLL-0001Ro-B0
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:18:39 -0400
Received: by mail-qt1-f172.google.com with SMTP id t1so3505220qtc.12
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=UziJRori9S+z3EUDEkru1+Hy2CIhR7bIJWpVumMrw3A=;
	b=jCnH80L6J7Dl0dZi7Z9Zd36S3uQfQesqdgHye0kzC4+TqxQQUegBkPJq05lUNgXGTq
	ifTLlnetPyLjvowoZ669S9m+t8Q1C+Uuj53I9KrXK6qqtLk+UtTJZKOUDxBWQ44Wg3KF
	Blk20CNvc55ygSE5fJQz2cu8hL+s/Yj1sJSSMoNPlyrFP4ocB48oOXxtUPiIkUAnqbOy
	rbxcc98UAKaeU4klBRoQUbdxva9Nr8yKjf4zzFQJQX2yUYYAujQ4+5zuP6bgey1OBt/h
	q0vf9QHAHcAoqgX/RqQizP4vseaYKUTqeRXp1W88o3udhe7Q+9flPtBNZ/kvJd9wUHtD
	VAoA==
X-Gm-Message-State: APjAAAV+EOy0Ht1zYxgJ9EogBqPAIc+sAk2qBOqC9HaRMoaPnGikW28x
	5dYCU1bv5wcp8GlMDfCB9RBYMEkI+cI=
X-Google-Smtp-Source: APXvYqznW1IHyp5iMJswchIG56yEe5kW+24TQuOGBbC70v6lrSxtOjvDpdncTIXopFmqv3p5D3YHJQ==
X-Received: by 2002:a0c:d48a:: with SMTP id u10mr19732766qvh.169.1558009118569;
	Thu, 16 May 2019 05:18:38 -0700 (PDT)
Received: from redhat.com ([185.54.206.10]) by smtp.gmail.com with ESMTPSA id
	x30sm3562856qtx.35.2019.05.16.05.18.36
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:18:37 -0700 (PDT)
Date: Thu, 16 May 2019 08:18:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190320112646.3712-6-xieyongji@baidu.com>
References: <20190515121146.7248-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515121146.7248-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.172
Subject: [Qemu-devel] [PULL 08/37] vhost-user-blk: Add return value for
 vhost_user_blk_start()
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

Add a return value for vhost_user_blk_start() to check whether
we start vhost-user backend successfully or not.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
Message-Id: <20190320112646.3712-6-xieyongji@baidu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/block/vhost-user-blk.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 39e1adc60a..6802c19d65 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -103,7 +103,7 @@ const VhostDevConfigOps blk_ops = {
     .vhost_dev_config_notifier = vhost_user_blk_handle_config_change,
 };
 
-static void vhost_user_blk_start(VirtIODevice *vdev)
+static int vhost_user_blk_start(VirtIODevice *vdev)
 {
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
@@ -112,13 +112,13 @@ static void vhost_user_blk_start(VirtIODevice *vdev)
 
     if (!k->set_guest_notifiers) {
         error_report("binding does not support guest notifiers");
-        return;
+        return -ENOSYS;
     }
 
     ret = vhost_dev_enable_notifiers(&s->dev, vdev);
     if (ret < 0) {
         error_report("Error enabling host notifiers: %d", -ret);
-        return;
+        return ret;
     }
 
     ret = k->set_guest_notifiers(qbus->parent, s->dev.nvqs, true);
@@ -157,12 +157,13 @@ static void vhost_user_blk_start(VirtIODevice *vdev)
         vhost_virtqueue_mask(&s->dev, vdev, i, false);
     }
 
-    return;
+    return ret;
 
 err_guest_notifiers:
     k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
 err_host_notifiers:
     vhost_dev_disable_notifiers(&s->dev, vdev);
+    return ret;
 }
 
 static void vhost_user_blk_stop(VirtIODevice *vdev)
-- 
MST


