Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478C0CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:40:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A38620856
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A38620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPb66-0004u0-5O
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 19:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iPb4n-0003b0-D2
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iPb4k-0005Bu-PS
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:39:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45634)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iPb4k-0005Ah-Gc
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:38:58 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 50132859FF
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 23:38:57 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id i25so586314qtm.17
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 16:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ztycBp7vjPAwLxtvbH8FaYqSo3NXWJ6H6qqiAGLgv5Y=;
 b=lPuVRPGntZnYL87fQ8bpD9iQmDBs6beehbPmqRh81BCfauE3tWvoiPuNhP+Z4MgTpm
 nS46H4HMKiwH67V52Poc0BSuXcE+Q67l/ioNWrcDA/6dN/GKRGUNOkd+A3qPf9V6Thxc
 hWldxHkenTvfy6J8Iox+QAdg1QEh+7ecN+p2U76OeZyx6ZzQbJI86WSXrQrdtAjHsCD2
 oaULUehNkwaEQzlQ3G9id6BT8rkNxYs8kOYNGj35olrh98kfbHO/eOZfA1A6OMruKOOd
 aw7/7mOAnuXy7T7MP7epM4h2Eo043VgIqSDXVcub0ER2QFx+0vdm5P0kIdUit+z4mk/u
 3qlw==
X-Gm-Message-State: APjAAAWqugSiVBCJtTSwTdCFhm9JqECavJ69LdBap9BSlzXTrxvY5x/a
 9ao6CBpdxJHJXRrYyglujaitq2ldPFjJev8B6qlxmU9zEaVR5IN209KtQkq6aosmg4WhG1D6taY
 bqolml11YuTD8+d0=
X-Received: by 2002:ae9:c20d:: with SMTP id j13mr23374993qkg.461.1572392336022; 
 Tue, 29 Oct 2019 16:38:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxNUb355SogdElm3kF/E14rONZw9+XwWcoofkuxIgsO8DEnencm2l/bDKjWKbheWj8qkCyKBQ==
X-Received: by 2002:ae9:c20d:: with SMTP id j13mr23374968qkg.461.1572392335551; 
 Tue, 29 Oct 2019 16:38:55 -0700 (PDT)
Received: from redhat.com (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id t66sm292757qka.108.2019.10.29.16.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 16:38:54 -0700 (PDT)
Date: Tue, 29 Oct 2019 19:38:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/14] virtio: Use auto rcu_read macros
Message-ID: <20191029225932.14585-15-mst@redhat.com>
References: <20191029225932.14585-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029225932.14585-1-mst@redhat.com>
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Use RCU_READ_LOCK_GUARD and WITH_RCU_READ_LOCK_GUARD
to replace the manual rcu_read_(un)lock calls.

I think the only change is virtio_load which was missing unlocks
in error paths; those end up being fatal errors so it's not
that important anyway.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20191028161109.60205-1-dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 65 ++++++++++++++++------------------------------
 1 file changed, 23 insertions(+), 42 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 6348cd30e9..762df12f4c 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -387,7 +387,8 @@ static inline void vring_set_avail_event(VirtQueue *vq, uint16_t val)
 
 static void virtio_queue_split_set_notification(VirtQueue *vq, int enable)
 {
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
+
     if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
         vring_set_avail_event(vq, vring_avail_idx(vq));
     } else if (enable) {
@@ -399,7 +400,6 @@ static void virtio_queue_split_set_notification(VirtQueue *vq, int enable)
         /* Expose avail event/used flags before caller checks the avail idx. */
         smp_mb();
     }
-    rcu_read_unlock();
 }
 
 static void virtio_queue_packed_set_notification(VirtQueue *vq, int enable)
@@ -408,7 +408,7 @@ static void virtio_queue_packed_set_notification(VirtQueue *vq, int enable)
     VRingPackedDescEvent e;
     VRingMemoryRegionCaches *caches;
 
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     caches  = vring_get_region_caches(vq);
     vring_packed_event_read(vq->vdev, &caches->used, &e);
 
@@ -429,7 +429,6 @@ static void virtio_queue_packed_set_notification(VirtQueue *vq, int enable)
         /* Expose avail event/used flags before caller checks the avail idx. */
         smp_mb();
     }
-    rcu_read_unlock();
 }
 
 void virtio_queue_set_notification(VirtQueue *vq, int enable)
@@ -577,9 +576,8 @@ static int virtio_queue_split_empty(VirtQueue *vq)
         return 0;
     }
 
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     empty = vring_avail_idx(vq) == vq->last_avail_idx;
-    rcu_read_unlock();
     return empty;
 }
 
@@ -601,12 +599,8 @@ static int virtio_queue_packed_empty_rcu(VirtQueue *vq)
 
 static int virtio_queue_packed_empty(VirtQueue *vq)
 {
-    bool empty;
-
-    rcu_read_lock();
-    empty = virtio_queue_packed_empty_rcu(vq);
-    rcu_read_unlock();
-    return empty;
+    RCU_READ_LOCK_GUARD();
+    return virtio_queue_packed_empty_rcu(vq);
 }
 
 int virtio_queue_empty(VirtQueue *vq)
@@ -859,10 +853,9 @@ void virtqueue_flush(VirtQueue *vq, unsigned int count)
 void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
                     unsigned int len)
 {
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     virtqueue_fill(vq, elem, len, 0);
     virtqueue_flush(vq, 1);
-    rcu_read_unlock();
 }
 
 /* Called within rcu_read_lock().  */
@@ -943,7 +936,8 @@ static void virtqueue_split_get_avail_bytes(VirtQueue *vq,
     int64_t len = 0;
     int rc;
 
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
+
     idx = vq->last_avail_idx;
     total_bufs = in_total = out_total = 0;
 
@@ -1033,7 +1027,6 @@ done:
     if (out_bytes) {
         *out_bytes = out_total;
     }
-    rcu_read_unlock();
     return;
 
 err:
@@ -1083,7 +1076,7 @@ static void virtqueue_packed_get_avail_bytes(VirtQueue *vq,
     VRingPackedDesc desc;
     bool wrap_counter;
 
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     idx = vq->last_avail_idx;
     wrap_counter = vq->last_avail_wrap_counter;
     total_bufs = in_total = out_total = 0;
@@ -1176,7 +1169,6 @@ done:
     if (out_bytes) {
         *out_bytes = out_total;
     }
-    rcu_read_unlock();
     return;
 
 err:
@@ -1360,7 +1352,7 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
     VRingDesc desc;
     int rc;
 
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     if (virtio_queue_empty_rcu(vq)) {
         goto done;
     }
@@ -1469,7 +1461,6 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
     trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
 done:
     address_space_cache_destroy(&indirect_desc_cache);
-    rcu_read_unlock();
 
     return elem;
 
@@ -1494,7 +1485,7 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
     uint16_t id;
     int rc;
 
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     if (virtio_queue_packed_empty_rcu(vq)) {
         goto done;
     }
@@ -1600,7 +1591,6 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
     trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
 done:
     address_space_cache_destroy(&indirect_desc_cache);
-    rcu_read_unlock();
 
     return elem;
 
@@ -2437,13 +2427,10 @@ static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
 
 void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
 {
-    bool should_notify;
-    rcu_read_lock();
-    should_notify = virtio_should_notify(vdev, vq);
-    rcu_read_unlock();
-
-    if (!should_notify) {
-        return;
+    WITH_RCU_READ_LOCK_GUARD() {
+        if (!virtio_should_notify(vdev, vq)) {
+            return;
+        }
     }
 
     trace_virtio_notify_irqfd(vdev, vq);
@@ -2475,13 +2462,10 @@ static void virtio_irq(VirtQueue *vq)
 
 void virtio_notify(VirtIODevice *vdev, VirtQueue *vq)
 {
-    bool should_notify;
-    rcu_read_lock();
-    should_notify = virtio_should_notify(vdev, vq);
-    rcu_read_unlock();
-
-    if (!should_notify) {
-        return;
+    WITH_RCU_READ_LOCK_GUARD() {
+        if (!virtio_should_notify(vdev, vq)) {
+            return;
+        }
     }
 
     trace_virtio_notify(vdev, vq);
@@ -3032,7 +3016,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         vdev->start_on_kick = true;
     }
 
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     for (i = 0; i < num; i++) {
         if (vdev->vq[i].vring.desc) {
             uint16_t nheads;
@@ -3087,7 +3071,6 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
             }
         }
     }
-    rcu_read_unlock();
 
     if (vdc->post_load) {
         ret = vdc->post_load(vdev);
@@ -3297,12 +3280,11 @@ static void virtio_queue_packed_restore_last_avail_idx(VirtIODevice *vdev,
 static void virtio_queue_split_restore_last_avail_idx(VirtIODevice *vdev,
                                                       int n)
 {
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     if (vdev->vq[n].vring.desc) {
         vdev->vq[n].last_avail_idx = vring_used_idx(&vdev->vq[n]);
         vdev->vq[n].shadow_avail_idx = vdev->vq[n].last_avail_idx;
     }
-    rcu_read_unlock();
 }
 
 void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n)
@@ -3322,11 +3304,10 @@ static void virtio_queue_packed_update_used_idx(VirtIODevice *vdev, int n)
 
 static void virtio_split_packed_update_used_idx(VirtIODevice *vdev, int n)
 {
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     if (vdev->vq[n].vring.desc) {
         vdev->vq[n].used_idx = vring_used_idx(&vdev->vq[n]);
     }
-    rcu_read_unlock();
 }
 
 void virtio_queue_update_used_idx(VirtIODevice *vdev, int n)
-- 
MST

