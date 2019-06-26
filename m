Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A495C48BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 02:37:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECB6B205C9
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 02:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjQ4nGV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB6B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfxor-0005tr-48
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 22:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48230)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elohimes@gmail.com>) id 1hfxjH-0001Vz-O0
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 22:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elohimes@gmail.com>) id 1hfxj9-0001jU-Qq
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 22:32:06 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36082)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hfxj9-0001hJ-Iv
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 22:32:03 -0400
Received: by mail-pl1-x644.google.com with SMTP id k8so520452plt.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 19:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hL8K5Kz2dooDS7h4mI8LPQsh2fPsmgF3Cej6yW+tB9U=;
 b=MjQ4nGV2MX4jdP0vA4TQ7mJgoitzIHWqQD+d8oxOhMboAfiEOBq/HvnsL2XdXEIMb7
 lqNio7vmqciecdeHoSh6JpHVvs4U2Gx561vUvM8KLgy4Ai54HhZqLaFs1dGEBfmy1PlQ
 uOCYTDrUHQ8Wg/X017hXrWGddFQhmyqahG5lnmGqCCDWBOpEV0/RQEKz/lJhCQ8JJtVP
 wnDaBHPOs9IabFN9glr09tOoKlzi7hzy71nqceN0/UXNI6UHBuy+6SxdzV7nhdStAouD
 h0HE5bjPUmfRw2LYar/l50OZP8qYGzPp7lir8rDtpEn5ol0Y9bMPMe/qwUJxX+2Uh0J2
 P2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=hL8K5Kz2dooDS7h4mI8LPQsh2fPsmgF3Cej6yW+tB9U=;
 b=APMDWkwjIAb1O1Z6fvIB2VaAk5Z0R3+N5q6esJdWkW49IIVRkzONJn0iC2TtHKxVBD
 qCO8WOj8WaXpkX860lBNc3KgNs3zEXpsnqPoGltVVdAxC8FcsMESk7Md+YY8E5IJDJB5
 Ls87fPTBy8R4dhDJJVyvARHWINYmzkQfL/UTAu57eFVLQ/5hzvy8s8xypAaG+cxEE9So
 zKlMcMh8pHAH8JnxDMOOpQCKvpTLFCBAKZXL4L5e7ATcnTa9DKAxq14MKiqDPnGlZ/be
 jDryacPl6UmPvReDY9q1/x6PVtG3Qa/bq2gC59xmzOKUveyGNLw6TyxjtuRWjmBKrOHb
 peVA==
X-Gm-Message-State: APjAAAVRU1WQf2Ld+TRIetKQd9jcT5hvLO/RpRElW+BIf+pq6h3uscwZ
 i5Mvh3XaGDSBisu5FTlYcbQ=
X-Google-Smtp-Source: APXvYqxN97+rj8d7/wycLADPgymISub6wgYCxHgzR8Ry4dOT+EVsTcXiATpmTYhq7Y4zPnchQCIJlQ==
X-Received: by 2002:a17:902:e01:: with SMTP id 1mr2231993plw.268.1561516322032; 
 Tue, 25 Jun 2019 19:32:02 -0700 (PDT)
Received: from localhost ([116.247.112.152])
 by smtp.gmail.com with ESMTPSA id y16sm21043219pff.89.2019.06.25.19.32.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 25 Jun 2019 19:32:01 -0700 (PDT)
From: elohimes@gmail.com
X-Google-Original-From: xieyongji@baidu.com
To: mst@redhat.com,
	groug@kaod.org
Date: Wed, 26 Jun 2019 10:31:28 +0800
Message-Id: <20190626023130.31315-4-xieyongji@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626023130.31315-1-xieyongji@baidu.com>
References: <20190626023130.31315-1-xieyongji@baidu.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v4 3/5] virtio: Set "start_on_kick" on
 virtio_set_features()
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
Cc: lvivier@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, Xie Yongji <xieyongji@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xie Yongji <xieyongji@baidu.com>

The guest feature is not set correctly on virtio_reset() and
virtio_init(). So we should not use it to set "start_on_kick" at that
point. This patch set "start_on_kick" on virtio_set_features() instead.

Fixes: badaf79cfdbd3 ("virtio: Introduce started flag to VirtioDevice")
Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/virtio/virtio.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index f7504d1395..5fd25d98a9 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1212,7 +1212,7 @@ void virtio_reset(void *opaque)
         k->reset(vdev);
     }
 
-    vdev->start_on_kick = !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1);
+    vdev->start_on_kick = false;
     vdev->started = false;
     vdev->broken = false;
     vdev->guest_features = 0;
@@ -2063,14 +2063,21 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
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
+        if (!virtio_device_started(vdev, vdev->status) &&
+            !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+            vdev->start_on_kick = true;
+        }
     }
     return ret;
 }
@@ -2222,6 +2229,11 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         }
     }
 
+    if (!virtio_device_started(vdev, vdev->status) &&
+        !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+        vdev->start_on_kick = true;
+    }
+
     rcu_read_lock();
     for (i = 0; i < num; i++) {
         if (vdev->vq[i].vring.desc) {
@@ -2324,7 +2336,7 @@ void virtio_init(VirtIODevice *vdev, const char *name,
             g_malloc0(sizeof(*vdev->vector_queues) * nvectors);
     }
 
-    vdev->start_on_kick = !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1);
+    vdev->start_on_kick = false;
     vdev->started = false;
     vdev->device_id = device_id;
     vdev->status = 0;
-- 
2.17.1


