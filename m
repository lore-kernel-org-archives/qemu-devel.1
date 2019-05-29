Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEBCC07542
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0301121670
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqa8ii6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0301121670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48869 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsux-0001E5-4Y
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 03:22:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hVsjl-0000ae-JK
	for qemu-devel@nongnu.org; Wed, 29 May 2019 03:11:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hVsjj-0006R3-Ke
	for qemu-devel@nongnu.org; Wed, 29 May 2019 03:11:01 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hVsjh-0006PA-KD
	for qemu-devel@nongnu.org; Wed, 29 May 2019 03:10:59 -0400
Received: by mail-pg1-x544.google.com with SMTP id v9so782472pgr.13
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 00:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=GjcX2eS1qWnd/pfqLo8M97WyTdrvK7+rz7aAhVuI32E=;
	b=fqa8ii6B3pDGwtNzmAtAtIZ+g03DBeYwNeakYkbtOh4SavsZuY8XV8yVgsaggskbTJ
	2GF7SfAeUPJbl8xqUKBrlmwVSTfyqPuCouZi4QN2v3ZseDEzTk2drpHAGfOFi7t7z08X
	7IJSdGAE43tOzDHRoXPoyvsiPQMIa7cP4Eviy4NZoVaCfjomfIOIz+E0ILiUEi4OV6RV
	nOqW4PuG2UxWWQzSjz+fS0OBxnkGDLvKZaKW031YmIfvcYbIrX1BXAa689BoJi07uuiZ
	lpQDbBVtcfZl3qXQUV0tWQiPyTVj3wPj6UFKSuHyOUOEMPQYMW9pcv1lcv32vL2n7gem
	CxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=GjcX2eS1qWnd/pfqLo8M97WyTdrvK7+rz7aAhVuI32E=;
	b=OB34nfl/Y6Z3XXR7hDCkJq40S/X4bFpWEY6x/UO+RgJXqclLQQxi34QOJd+d5gSf9G
	8aNYAGP6APMPEBRFjQ1w76nbkTvaz6gHI1YFC9jDPCBnkj8RYNAtmufqst80dx1cQ9d2
	H1cA3vQM3VvHKowD8Z7qGVBRrI2DJuleut/Tm7HnLGv70Qt8WqOCTPgVP0TrR9ID8UWN
	/ysKiAOsBkOIo31CRtTWhDMEIWjmSqYH1DhRCILktQFfZMu/5XOZ5VHBFTGnDE6Eoenb
	0kwShsLH4RPiCbTAK1enmL8+LnlX6PLM4AmYzNOuBHRLBqQvnpL7EhiIuFRlPm0us4Ew
	nXig==
X-Gm-Message-State: APjAAAXjglZLD3vP9Yj5jHgdmjDM56t7qSd2p51Rr56v+R1sCBz53LvV
	/YNv7C92hxea8NkCMRGfOVc=
X-Google-Smtp-Source: APXvYqzMQrN7WpQ4HgD5jGm7YyQEsSHQpyTnP7/o8i5oQ+8l8N902SqK6EDKwHcwgROqeZMlJ+vnfw==
X-Received: by 2002:a17:90a:ac03:: with SMTP id
	o3mr10472629pjq.114.1559113855429; 
	Wed, 29 May 2019 00:10:55 -0700 (PDT)
Received: from localhost ([116.247.112.152])
	by smtp.gmail.com with ESMTPSA id r4sm4619471pjd.28.2019.05.29.00.10.54
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 29 May 2019 00:10:55 -0700 (PDT)
From: elohimes@gmail.com
X-Google-Original-From: xieyongji@baidu.com
To: mst@redhat.com,
	groug@kaod.org,
	dgilbert@redhat.com
Date: Wed, 29 May 2019 15:09:51 +0800
Message-Id: <20190529070955.25565-2-xieyongji@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529070955.25565-1-xieyongji@baidu.com>
References: <20190529070955.25565-1-xieyongji@baidu.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH 1/5] virtio: Set "start_on_kick" on
 virtio_set_features()
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
Cc: Xie Yongji <xieyongji@baidu.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xie Yongji <xieyongji@baidu.com>

The guest feature is not set correctly on virtio_reset() and
virtio_init(). So we should not use it to set "start_on_kick" at that
point. This patch set "start_on_kick" on virtio_set_features() instead.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
---
 hw/virtio/virtio.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 4805727b53..fc8fca81ad 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1214,8 +1214,7 @@ void virtio_reset(void *opaque)
         k->reset(vdev);
     }
 
-    vdev->start_on_kick = (virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
-                          !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1));
+    vdev->start_on_kick = false;
     vdev->started = false;
     vdev->broken = false;
     vdev->guest_features = 0;
@@ -2069,14 +2068,21 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
         return -EINVAL;
     }
     ret = virtio_set_features_nocheck(vdev, val);
-    if (!ret && virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
-        /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
-        int i;
-        for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
-            if (vdev->vq[i].vring.num != 0) {
-                virtio_init_region_cache(vdev, i);
+    if (!ret) {
+        if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
+            /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
+            int i;
+            for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
+                if (vdev->vq[i].vring.num != 0) {
+                    virtio_init_region_cache(vdev, i);
+                }
             }
         }
+
+        if (virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
+            !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+            vdev->start_on_kick = true;
+        }
     }
     return ret;
 }
@@ -2331,8 +2337,7 @@ void virtio_init(VirtIODevice *vdev, const char *name,
             g_malloc0(sizeof(*vdev->vector_queues) * nvectors);
     }
 
-    vdev->start_on_kick = (virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
-                          !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1));
+    vdev->start_on_kick = false;
     vdev->started = false;
     vdev->device_id = device_id;
     vdev->status = 0;
-- 
2.17.1


