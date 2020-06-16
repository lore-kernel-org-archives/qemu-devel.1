Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34639C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:49:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF1D208B8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYVwFBH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF1D208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCuA-0001OF-7r
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQM-00039l-21; Tue, 16 Jun 2020 10:18:50 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41881)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQI-0006uI-UC; Tue, 16 Jun 2020 10:18:49 -0400
Received: by mail-ot1-x342.google.com with SMTP id k15so16043643otp.8;
 Tue, 16 Jun 2020 07:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=SgpdSwyB/UPAjpHte2vWC5d1tT7Kus4ixfvhv062JB4=;
 b=MYVwFBH7/AnBnwQ9A2eK8LFphytp8bU3pr/4X3LPC/jAKosUDZqoKZk7NzToK98JEz
 YIPZ73mGRHWalaaAsGcLg4rDCoPXnMOZn9SUUNw4EZMkrczWsbOnL/XBVuejR67llLgo
 JSHMGKGeFt3EPut/Y24TDy0JoAyZuxvFFvkcPVinFjzdE3XL1GDep4PBeAo52uBQhY1P
 9sUE5XR6sYAz83dIaJAk4ML5SUI7T+4mSCeKnQJ1KGdgeW2rRhA3LkT19weuSPLk7QLJ
 EquGD0SlIadpksv/VnSdI35FX//2h23b9E7BOW+ewrnVK/VNCleIwK3W8EV1U2Mt3rs+
 2wxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=SgpdSwyB/UPAjpHte2vWC5d1tT7Kus4ixfvhv062JB4=;
 b=dlyVNQjtCiRDEmUcm/RoM9PfNcvrcMtHgA/bq/5kPcRH4CLOcW2NFOhJizZ4ROA//3
 hAFyhuzvNNcwanoWMcxw2R9eO88UKhPvmNUn0SCVZMB1pLKy67UZUfZKrSQsbFeFcbsG
 FDKTUpRWlT8ftQyQHj+nZ7wyJN8BfzXK/QoIGXcwQwjSeLaNkjBWK7prcpgeb9+uGxcQ
 WZ/w8MLXf4BA1Y+rA4I32dY5bQdvPrZ49sk8ipZsMSiDlmBCvUILCZTPjpVBmNDUsu+s
 6R9yJt6cXiBsXE6kO4gYjGd9iX65AMbtp8V8NoGu0t8zxLb4aV2aUe0dhMog9rvlJbba
 h7xw==
X-Gm-Message-State: AOAM533o+Duh9riDck214BE3EfBTHY4MuNdWHDaQuqIPLQ4CldzZoXoq
 3iGDNopdeX9HWNvAmNs9x1SQLBJ2
X-Google-Smtp-Source: ABdhPJw575GwJSJIKal5/MbtrI6wUpCYlFqgB+cYolkPOq7hIJCi05KVx01bi+3n0IykxXgHJVDxkw==
X-Received: by 2002:a9d:34c:: with SMTP id 70mr2662442otv.224.1592317123373;
 Tue, 16 Jun 2020 07:18:43 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id f1sm4093085ool.16.2020.06.16.07.18.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:41 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 50/78] virtio: gracefully handle invalid region caches
Date: Tue, 16 Jun 2020 09:15:19 -0500
Message-Id: <20200616141547.24664-51-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tsirkin <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

The virtqueue code sets up MemoryRegionCaches to access the virtqueue
guest RAM data structures.  The code currently assumes that
VRingMemoryRegionCaches is initialized before device emulation code
accesses the virtqueue.  An assertion will fail in
vring_get_region_caches() when this is not true.  Device fuzzing found a
case where this assumption is false (see below).

Virtqueue guest RAM addresses can also be changed from a vCPU thread
while an IOThread is accessing the virtqueue.  This breaks the same
assumption but this time the caches could become invalid partway through
the virtqueue code.  The code fetches the caches RCU pointer multiple
times so we will need to validate the pointer every time it is fetched.

Add checks each time we call vring_get_region_caches() and treat invalid
caches as a nop: memory stores are ignored and memory reads return 0.

The fuzz test failure is as follows:

  $ qemu -M pc -device virtio-blk-pci,id=drv0,drive=drive0,addr=4.0 \
         -drive if=none,id=drive0,file=null-co://,format=raw,auto-read-only=off \
         -drive if=none,id=drive1,file=null-co://,file.read-zeroes=on,format=raw \
         -display none \
         -qtest stdio
  endianness
  outl 0xcf8 0x80002020
  outl 0xcfc 0xe0000000
  outl 0xcf8 0x80002004
  outw 0xcfc 0x7
  write 0xe0000000 0x24 0x00ffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffab5cffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffabffffffab0000000001
  inb 0x4
  writew 0xe000001c 0x1
  write 0xe0000014 0x1 0x0d

The following error message is produced:

  qemu-system-x86_64: /home/stefanha/qemu/hw/virtio/virtio.c:286: vring_get_region_caches: Assertion `caches != NULL' failed.

The backtrace looks like this:

  #0  0x00007ffff5520625 in raise () at /lib64/libc.so.6
  #1  0x00007ffff55098d9 in abort () at /lib64/libc.so.6
  #2  0x00007ffff55097a9 in _nl_load_domain.cold () at /lib64/libc.so.6
  #3  0x00007ffff5518a66 in annobin_assert.c_end () at /lib64/libc.so.6
  #4  0x00005555559073da in vring_get_region_caches (vq=<optimized out>) at qemu/hw/virtio/virtio.c:286
  #5  vring_get_region_caches (vq=<optimized out>) at qemu/hw/virtio/virtio.c:283
  #6  0x000055555590818d in vring_used_flags_set_bit (mask=1, vq=0x5555575ceea0) at qemu/hw/virtio/virtio.c:398
  #7  virtio_queue_split_set_notification (enable=0, vq=0x5555575ceea0) at qemu/hw/virtio/virtio.c:398
  #8  virtio_queue_set_notification (vq=vq@entry=0x5555575ceea0, enable=enable@entry=0) at qemu/hw/virtio/virtio.c:451
  #9  0x0000555555908512 in virtio_queue_set_notification (vq=vq@entry=0x5555575ceea0, enable=enable@entry=0) at qemu/hw/virtio/virtio.c:444
  #10 0x00005555558c697a in virtio_blk_handle_vq (s=0x5555575c57e0, vq=0x5555575ceea0) at qemu/hw/block/virtio-blk.c:775
  #11 0x0000555555907836 in virtio_queue_notify_aio_vq (vq=0x5555575ceea0) at qemu/hw/virtio/virtio.c:2244
  #12 0x0000555555cb5dd7 in aio_dispatch_handlers (ctx=ctx@entry=0x55555671a420) at util/aio-posix.c:429
  #13 0x0000555555cb67a8 in aio_dispatch (ctx=0x55555671a420) at util/aio-posix.c:460
  #14 0x0000555555cb307e in aio_ctx_dispatch (source=<optimized out>, callback=<optimized out>, user_data=<optimized out>) at util/async.c:260
  #15 0x00007ffff7bbc510 in g_main_context_dispatch () at /lib64/libglib-2.0.so.0
  #16 0x0000555555cb5848 in glib_pollfds_poll () at util/main-loop.c:219
  #17 os_host_main_loop_wait (timeout=<optimized out>) at util/main-loop.c:242
  #18 main_loop_wait (nonblocking=<optimized out>) at util/main-loop.c:518
  #19 0x00005555559b20c9 in main_loop () at vl.c:1683
  #20 0x0000555555838115 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at vl.c:4441

Reported-by: Alexander Bulekov <alxndr@bu.edu>
Cc: Michael Tsirkin <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200207104619.164892-1-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit abdd16f4681cc4d6bf84990227b5c9b98e869ccd)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio.c | 99 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 91 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 344d817644..6c71141ed1 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -282,15 +282,19 @@ static void vring_packed_flags_write(VirtIODevice *vdev,
 /* Called within rcu_read_lock().  */
 static VRingMemoryRegionCaches *vring_get_region_caches(struct VirtQueue *vq)
 {
-    VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
-    assert(caches != NULL);
-    return caches;
+    return atomic_rcu_read(&vq->vring.caches);
 }
+
 /* Called within rcu_read_lock().  */
 static inline uint16_t vring_avail_flags(VirtQueue *vq)
 {
     VRingMemoryRegionCaches *caches = vring_get_region_caches(vq);
     hwaddr pa = offsetof(VRingAvail, flags);
+
+    if (!caches) {
+        return 0;
+    }
+
     return virtio_lduw_phys_cached(vq->vdev, &caches->avail, pa);
 }
 
@@ -299,6 +303,11 @@ static inline uint16_t vring_avail_idx(VirtQueue *vq)
 {
     VRingMemoryRegionCaches *caches = vring_get_region_caches(vq);
     hwaddr pa = offsetof(VRingAvail, idx);
+
+    if (!caches) {
+        return 0;
+    }
+
     vq->shadow_avail_idx = virtio_lduw_phys_cached(vq->vdev, &caches->avail, pa);
     return vq->shadow_avail_idx;
 }
@@ -308,6 +317,11 @@ static inline uint16_t vring_avail_ring(VirtQueue *vq, int i)
 {
     VRingMemoryRegionCaches *caches = vring_get_region_caches(vq);
     hwaddr pa = offsetof(VRingAvail, ring[i]);
+
+    if (!caches) {
+        return 0;
+    }
+
     return virtio_lduw_phys_cached(vq->vdev, &caches->avail, pa);
 }
 
@@ -323,6 +337,11 @@ static inline void vring_used_write(VirtQueue *vq, VRingUsedElem *uelem,
 {
     VRingMemoryRegionCaches *caches = vring_get_region_caches(vq);
     hwaddr pa = offsetof(VRingUsed, ring[i]);
+
+    if (!caches) {
+        return;
+    }
+
     virtio_tswap32s(vq->vdev, &uelem->id);
     virtio_tswap32s(vq->vdev, &uelem->len);
     address_space_write_cached(&caches->used, pa, uelem, sizeof(VRingUsedElem));
@@ -334,6 +353,11 @@ static uint16_t vring_used_idx(VirtQueue *vq)
 {
     VRingMemoryRegionCaches *caches = vring_get_region_caches(vq);
     hwaddr pa = offsetof(VRingUsed, idx);
+
+    if (!caches) {
+        return 0;
+    }
+
     return virtio_lduw_phys_cached(vq->vdev, &caches->used, pa);
 }
 
@@ -342,8 +366,12 @@ static inline void vring_used_idx_set(VirtQueue *vq, uint16_t val)
 {
     VRingMemoryRegionCaches *caches = vring_get_region_caches(vq);
     hwaddr pa = offsetof(VRingUsed, idx);
-    virtio_stw_phys_cached(vq->vdev, &caches->used, pa, val);
-    address_space_cache_invalidate(&caches->used, pa, sizeof(val));
+
+    if (caches) {
+        virtio_stw_phys_cached(vq->vdev, &caches->used, pa, val);
+        address_space_cache_invalidate(&caches->used, pa, sizeof(val));
+    }
+
     vq->used_idx = val;
 }
 
@@ -353,8 +381,13 @@ static inline void vring_used_flags_set_bit(VirtQueue *vq, int mask)
     VRingMemoryRegionCaches *caches = vring_get_region_caches(vq);
     VirtIODevice *vdev = vq->vdev;
     hwaddr pa = offsetof(VRingUsed, flags);
-    uint16_t flags = virtio_lduw_phys_cached(vq->vdev, &caches->used, pa);
+    uint16_t flags;
 
+    if (!caches) {
+        return;
+    }
+
+    flags = virtio_lduw_phys_cached(vq->vdev, &caches->used, pa);
     virtio_stw_phys_cached(vdev, &caches->used, pa, flags | mask);
     address_space_cache_invalidate(&caches->used, pa, sizeof(flags));
 }
@@ -365,8 +398,13 @@ static inline void vring_used_flags_unset_bit(VirtQueue *vq, int mask)
     VRingMemoryRegionCaches *caches = vring_get_region_caches(vq);
     VirtIODevice *vdev = vq->vdev;
     hwaddr pa = offsetof(VRingUsed, flags);
-    uint16_t flags = virtio_lduw_phys_cached(vq->vdev, &caches->used, pa);
+    uint16_t flags;
 
+    if (!caches) {
+        return;
+    }
+
+    flags = virtio_lduw_phys_cached(vq->vdev, &caches->used, pa);
     virtio_stw_phys_cached(vdev, &caches->used, pa, flags & ~mask);
     address_space_cache_invalidate(&caches->used, pa, sizeof(flags));
 }
@@ -381,6 +419,10 @@ static inline void vring_set_avail_event(VirtQueue *vq, uint16_t val)
     }
 
     caches = vring_get_region_caches(vq);
+    if (!caches) {
+        return;
+    }
+
     pa = offsetof(VRingUsed, ring[vq->vring.num]);
     virtio_stw_phys_cached(vq->vdev, &caches->used, pa, val);
     address_space_cache_invalidate(&caches->used, pa, sizeof(val));
@@ -410,7 +452,11 @@ static void virtio_queue_packed_set_notification(VirtQueue *vq, int enable)
     VRingMemoryRegionCaches *caches;
 
     RCU_READ_LOCK_GUARD();
-    caches  = vring_get_region_caches(vq);
+    caches = vring_get_region_caches(vq);
+    if (!caches) {
+        return;
+    }
+
     vring_packed_event_read(vq->vdev, &caches->used, &e);
 
     if (!enable) {
@@ -592,6 +638,10 @@ static int virtio_queue_packed_empty_rcu(VirtQueue *vq)
     }
 
     cache = vring_get_region_caches(vq);
+    if (!cache) {
+        return 1;
+    }
+
     vring_packed_desc_read_flags(vq->vdev, &desc.flags, &cache->desc,
                                  vq->last_avail_idx);
 
@@ -772,6 +822,10 @@ static void virtqueue_packed_fill_desc(VirtQueue *vq,
     }
 
     caches = vring_get_region_caches(vq);
+    if (!caches) {
+        return;
+    }
+
     vring_packed_desc_write(vq->vdev, &desc, &caches->desc, head, strict_order);
 }
 
@@ -944,6 +998,10 @@ static void virtqueue_split_get_avail_bytes(VirtQueue *vq,
 
     max = vq->vring.num;
     caches = vring_get_region_caches(vq);
+    if (!caches) {
+        goto err;
+    }
+
     while ((rc = virtqueue_num_heads(vq, idx)) > 0) {
         MemoryRegionCache *desc_cache = &caches->desc;
         unsigned int num_bufs;
@@ -1084,6 +1142,9 @@ static void virtqueue_packed_get_avail_bytes(VirtQueue *vq,
 
     max = vq->vring.num;
     caches = vring_get_region_caches(vq);
+    if (!caches) {
+        goto err;
+    }
 
     for (;;) {
         unsigned int num_bufs = total_bufs;
@@ -1189,6 +1250,10 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
     }
 
     caches = vring_get_region_caches(vq);
+    if (!caches) {
+        goto err;
+    }
+
     desc_size = virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED) ?
                                 sizeof(VRingPackedDesc) : sizeof(VRingDesc);
     if (caches->desc.len < vq->vring.num * desc_size) {
@@ -1382,6 +1447,11 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
     i = head;
 
     caches = vring_get_region_caches(vq);
+    if (!caches) {
+        virtio_error(vdev, "Region caches not initialized");
+        goto done;
+    }
+
     if (caches->desc.len < max * sizeof(VRingDesc)) {
         virtio_error(vdev, "Cannot map descriptor ring");
         goto done;
@@ -1504,6 +1574,11 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
     i = vq->last_avail_idx;
 
     caches = vring_get_region_caches(vq);
+    if (!caches) {
+        virtio_error(vdev, "Region caches not initialized");
+        goto done;
+    }
+
     if (caches->desc.len < max * sizeof(VRingDesc)) {
         virtio_error(vdev, "Cannot map descriptor ring");
         goto done;
@@ -1623,6 +1698,10 @@ static unsigned int virtqueue_packed_drop_all(VirtQueue *vq)
     VRingPackedDesc desc;
 
     caches = vring_get_region_caches(vq);
+    if (!caches) {
+        return 0;
+    }
+
     desc_cache = &caches->desc;
 
     virtio_queue_set_notification(vq, 0);
@@ -2406,6 +2485,10 @@ static bool virtio_packed_should_notify(VirtIODevice *vdev, VirtQueue *vq)
     VRingMemoryRegionCaches *caches;
 
     caches = vring_get_region_caches(vq);
+    if (!caches) {
+        return false;
+    }
+
     vring_packed_event_read(vdev, &caches->avail, &e);
 
     old = vq->signalled_used;
-- 
2.17.1


