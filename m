Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09D7C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2142084E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwaiTHXx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2142084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49632 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbikW-0001vV-W2
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 05:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40783)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elohimes@gmail.com>) id 1hbieL-0004oG-Fb
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elohimes@gmail.com>) id 1hbiZ9-0000oH-QK
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:32:12 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41939)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hbiZ9-0000nu-KL
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:32:11 -0400
Received: by mail-pf1-x443.google.com with SMTP id m30so1093071pff.8
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 02:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5gEwUgV90VGPkybRlF87iI9aEs2jpt7pXyXMGJx2x8Y=;
 b=BwaiTHXxkT6K7/708vu76GMse0kABjKG3hkK+BaBl8N36soaDkPMff4FsXjkSATTUV
 SKteHTtQF9QGG+E0uf9O48Qo/GnSsaeFrHj/mAXM/Bl3Qf/IP2Uku8Ew8yLZGhyuTI2u
 Ko+A/u9rdNnZ9lG4Mfpb2AjN+lPGk4cBGzHuaIZQJxGRs9sNzcb+MX93538H4kXGNzqV
 CCfgX37wiGWX/oQN4tia/0Kochp9yI9glYBTkv9vs3DfRgH91gCsIp8UGvzspV//SHJp
 GsFI91R4Dy449oNAJtXvhLcs1mo6nLBNaw/hFJd9Pezr8LimssfdHQpt56g/cpziQ1cS
 jkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5gEwUgV90VGPkybRlF87iI9aEs2jpt7pXyXMGJx2x8Y=;
 b=t51Oq5/ogBrdcZDPoAVm5U0NFRhkyIE7M4VAAHsKffbZGtqwxG0+Ouoix0waJqoQMh
 GXM0CSpLqf+jspTbvarTheZoyzC9M/QoYILAuY0JOD6PJXWSgTYnc/fyp/tRLdz8S98m
 lj7MKGDxkuQ0g4aSY7wGQXLp9oEzKjunLPkJrF7/e+oMqXbaAmNKaYZ1S5RYE4w/N9iB
 5sh2TfOdKqV8dz5HA7l879/SNufF6ezkayT/UR4CwiZABNrbSHHVVtnbHA0/MNDWoMKW
 NQ2SNUqSp4Xb3ApI1EqZoNRRBIIc5BQM4aoCj1yCOI44DR94INtfMkAsq97bOFJ/bd6B
 3Mrg==
X-Gm-Message-State: APjAAAVNWa5ZAX/xBy8kz9mCXXQBwaP/Ech0q5g/HVLmZ9FIC1Roj4qn
 Pd1djHZiqU+WWgVDQt4HR0o=
X-Google-Smtp-Source: APXvYqzj/n2IdbnCf8ihfJiEN6zuoZ+ug1PQVlNbzde0lWnz1DjFhmjcP53JbrImofNiKV0JvQgVVg==
X-Received: by 2002:a63:8449:: with SMTP id k70mr35872853pgd.208.1560504730772; 
 Fri, 14 Jun 2019 02:32:10 -0700 (PDT)
Received: from localhost ([116.247.112.152])
 by smtp.gmail.com with ESMTPSA id a16sm2192308pfc.167.2019.06.14.02.32.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 14 Jun 2019 02:32:10 -0700 (PDT)
From: elohimes@gmail.com
X-Google-Original-From: xieyongji@baidu.com
To: mst@redhat.com,
	groug@kaod.org
Date: Fri, 14 Jun 2019 17:31:19 +0800
Message-Id: <20190614093121.5580-4-xieyongji@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614093121.5580-1-xieyongji@baidu.com>
References: <20190614093121.5580-1-xieyongji@baidu.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v3 3/5] virtio: Set "start_on_kick" on
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
Cc: qemu-devel@nongnu.org, Xie Yongji <xieyongji@baidu.com>,
 dgilbert@redhat.com, ehabkost@redhat.com
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
index 473881e9ec..034320d277 100644
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


