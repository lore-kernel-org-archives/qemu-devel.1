Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13CBC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:12:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E202171F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E202171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43334 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrSb-0000CG-J8
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:12:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrQe-00071q-8P
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrQd-0007yQ-1u
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:48 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:42202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrQc-0007xJ-Te
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:46 -0400
Received: by mail-qk1-f173.google.com with SMTP id d4so9897087qkc.9
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=UziJRori9S+z3EUDEkru1+Hy2CIhR7bIJWpVumMrw3A=;
	b=A96IyChsJpa207i0TX2eC8Z3PBTpqwPq86iFP0+Ob9ISHzjkzcyjryFXlV6/LJwle4
	OqhFQJ7Nw3tzYlK1uhDt5CWqC4+Z6+HEDBHAXAE5Mfdspk/69HXDl6oShsLUIjP1f1cD
	emGpVMHsjAyMJIkRtBCQsDhN1paxaOO2rCTZebLKa0GZU36blncrF7xybQRV2qYcVqyN
	p1fVsfUKt1kGXpUwyPguU0/twwFH4wm/ycQjgjkypLH9vjnu/7zUbgPmZSDEGS7UaE/U
	KVJqT93kZhsHunuF0YUsaHvoICyaO86C2qmYdKFVS85aK4YvRPTZuZd9U7GZskwVcIkI
	BfLw==
X-Gm-Message-State: APjAAAW40qnyByvHc6rBBwABcG8Q6fM9JKhf19+XUMCWXATFqJnzLmdY
	Fhjr41QmCA1hV0U3goaEJSIuNGCGstg=
X-Google-Smtp-Source: APXvYqz2rTBU9KNH3081hKqTG7bjmgyGNQiye0rfDSRKBkyfbUlQwmCWvmVPGFTb4urcI/qABbDFhA==
X-Received: by 2002:a37:a5c6:: with SMTP id
	o189mr60288869qke.318.1558393844859; 
	Mon, 20 May 2019 16:10:44 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	m8sm12396200qta.10.2019.05.20.16.10.43
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 16:10:44 -0700 (PDT)
Date: Mon, 20 May 2019 19:10:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190320112646.3712-6-xieyongji@baidu.com>
References: <20190520231008.20140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190520231008.20140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.173
Subject: [Qemu-devel] [PULL v2 08/36] vhost-user-blk: Add return value for
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
Message-ID: <20190520231043.b6LJhW9zdvsTAkn2FOYJUkzhE4a0L6CYHPKZ-zDhBkM@z>

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


