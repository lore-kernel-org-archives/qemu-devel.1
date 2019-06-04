Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FE3C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 07:39:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E65724C4F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 07:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MK92V1Hg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E65724C4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47460 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY42j-0004ME-1Y
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 03:39:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hY3yo-0001F2-JU
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hY3yn-0003fS-HQ
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:35:34 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hY3yn-0003bq-97
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:35:33 -0400
Received: by mail-pf1-x444.google.com with SMTP id q10so1935602pff.9
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 00:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=kr819H7lf43YtonHy3KPFOGfzuzf63KXY2ivIp5O1R0=;
	b=MK92V1Hgrn/hsMFylc7hj2LnV3wXX11rAB9Eta32S35opPYOOdlpYR2jEURZKXyeVM
	czKPdr0MQhGoHIh5M9kITpTzmmkuS+c6YPJl7LQqeQGsJ/z2/3RWS0zjHkMPSwY+safp
	uRuFgQbZM6K2W+JjKiLmRtG23D9dW9ZvIffVwDTm7W0GHEX3wkHZsd/mh7J2moxp7Tqa
	w60QfT/E+r9vPKETb4cDK73gQxFcZ7JBAeDWnB/eHrCxzpV0ioz9t0EHFXv6B5fVG69m
	dmfgy/jbn+oYkYG8VgOs9VXKVb/m1mrMRzUEwk/DjMIyxpp0tPn2llsHe/rKUNuK3TOo
	giZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=kr819H7lf43YtonHy3KPFOGfzuzf63KXY2ivIp5O1R0=;
	b=MJqHuU6FYl54UrWY34rMkr0V8t3w+W7Yg+ZlZrf79Kma8pNdgo4zM83/+qZQ1L2fx3
	22lhotlGiwiBJjX055Ws7jFwEHO9NZEU1VrBq6JMhINYMFB94Qo9WHwCvdZxwO8segxD
	s9qb6mzlJ5QiTn/yMTLbCR/fACn5cZFju1rnFC0GDALJ7KFypM6cxR5eY5UK0vs9rPm+
	J2mIiOWaii8JJaMJuz5h6h5c9r72r8L9MRF68AEDNtYNwt167sjUubJKeR2P/GlBDM8m
	ZEsUVoRHD3tMVmrvG5uqPBeUmFS9iKSpqowVl909oQIYl53utp64bmOCzSOYzbtW5Uhy
	O9rg==
X-Gm-Message-State: APjAAAUFexMrIgnMKdaY0BBegI6ozvGswJqLIgJDkR3rfOd5WAhp+9uj
	TQjG9tUSlpYyP9pqObnP+Vk=
X-Google-Smtp-Source: APXvYqwuMS0dJ7cxNZCohtYFJjt4GsyYFUIGCVZ3dLdjYoEZ1NImmL/yEHWLGzH7x/uduqxJIwdl7A==
X-Received: by 2002:a63:e408:: with SMTP id a8mr34019828pgi.146.1559633732044; 
	Tue, 04 Jun 2019 00:35:32 -0700 (PDT)
Received: from localhost ([116.247.112.152]) by smtp.gmail.com with ESMTPSA id
	v4sm20017907pfe.180.2019.06.04.00.35.31
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 04 Jun 2019 00:35:31 -0700 (PDT)
From: elohimes@gmail.com
X-Google-Original-From: xieyongji@baidu.com
To: mst@redhat.com,
	groug@kaod.org
Date: Tue,  4 Jun 2019 15:34:55 +0800
Message-Id: <20190604073459.15651-2-xieyongji@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604073459.15651-1-xieyongji@baidu.com>
References: <20190604073459.15651-1-xieyongji@baidu.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v2 1/5] virtio: Set "start_on_kick" on
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
Cc: Xie Yongji <xieyongji@baidu.com>, dgilbert@redhat.com,
	qemu-devel@nongnu.org
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
 hw/virtio/virtio.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 07f4a64b48..6508b2faad 100644
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
@@ -2069,14 +2068,22 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
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
+        if (!vdev->started &&
+            virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
+            !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+            vdev->start_on_kick = true;
+        }
     }
     return ret;
 }
@@ -2228,6 +2235,12 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         }
     }
 
+    if (!vdev->started &&
+        virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
+        !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+        vdev->start_on_kick = true;
+    }
+
     rcu_read_lock();
     for (i = 0; i < num; i++) {
         if (vdev->vq[i].vring.desc) {
@@ -2330,8 +2343,7 @@ void virtio_init(VirtIODevice *vdev, const char *name,
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


