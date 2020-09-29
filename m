Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849CEC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:28:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA22D207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YsKLULbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA22D207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNA3o-0003KZ-21
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xD-00036x-VI
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:21:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52209)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xB-0001cx-Ce
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:21:39 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nwXzjoB3abzuE2fXE5hCIG97lYiB5tKKngurg8k59Ao=;
 b=YsKLULbVN0q7NpvIgrKv/esVvr7DEg/tFwBf1Vv4X1KI53U563z8fuXd+4Z55SLM5IXeAN
 tmHsTOzPV7czL+ow20F7YOt0LyElSOZzcwaMzR8xhniTnGxf44Icz5RLDzaWdkBza4Vtid
 ySUJEKarLmOKOLI0KXrBJI2m5LCA+0Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-Ff9oSvbNOGy_lXkmVMf7hQ-1; Tue, 29 Sep 2020 03:21:32 -0400
X-MC-Unique: Ff9oSvbNOGy_lXkmVMf7hQ-1
Received: by mail-wr1-f71.google.com with SMTP id b7so1368870wrn.6
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nwXzjoB3abzuE2fXE5hCIG97lYiB5tKKngurg8k59Ao=;
 b=HUajU7y/h4KgQHLePmBUicSJD2MFvzmN/atYF2Glu9e4xXbfL8bZq0On4nsD5pucks
 oo/cMr+dGO8tQ+yA2N6LbDy305d8oiRjZ63IR4rEm0qd9/w6cGt+Cb/eNV/uxxwSghGZ
 Du6le4VJozr8seozI4naCMII6iDND2W80WiVBdOmXWtYulz7TIiDImWqBPjEEzxuZLnv
 8BQzfHFnWLzcXlEb8oKLi3sstTdx002ur69KaK0KtmtnzhiMO5aEAVm0Hx8jbSZDe4IJ
 we/1FWcdq/v6aM9hEYd7iI8/4pcroKBJHkif4Yv3aXpXUFM1kAOr+m/VAYqRvPVdJZo2
 BpfA==
X-Gm-Message-State: AOAM532XPqpPZryOqfKBJOBCO7HFQ44uBgB0GpgTcrlBWeyHNCEASfxR
 ZLX+60ybN6ngVc3faftr5R+nVFQ6Ruum4Mbe1rJzMsb8DLpl5ChJKzP6vf8sD/V7wqbiymMG9iZ
 6AsurDnnqlbYsBsw=
X-Received: by 2002:a7b:ca56:: with SMTP id m22mr2825231wml.12.1601364091240; 
 Tue, 29 Sep 2020 00:21:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcdHWyMjo8LJzhKcTmwXguSuyzyxTQ3DHwoo8XB9h2A/heltXdMW2iGY6mSY25zcFVDlCmFQ==
X-Received: by 2002:a7b:ca56:: with SMTP id m22mr2825215wml.12.1601364090986; 
 Tue, 29 Sep 2020 00:21:30 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id d2sm4518759wro.34.2020.09.29.00.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:21:30 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:21:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 14/48] vhost-vdpa: add trace-events
Message-ID: <20200929071948.281157-15-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

Add trace functions in vhost-vdpa.c.

All traces from this file can be enabled with '-trace vhost_vdpa*'.

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20200925091055.186023-3-lvivier@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 92 +++++++++++++++++++++++++++++++++++++++---
 hw/virtio/trace-events | 31 ++++++++++++++
 2 files changed, 118 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index dbf2643ff7..4f1039910a 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -20,6 +20,8 @@
 #include "hw/virtio/vhost-vdpa.h"
 #include "qemu/main-loop.h"
 #include "cpu.h"
+#include "trace.h"
+#include "qemu-common.h"
 
 static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *section)
 {
@@ -48,6 +50,9 @@ static int vhost_vdpa_dma_map(struct vhost_vdpa *v, hwaddr iova, hwaddr size,
     msg.iotlb.perm = readonly ? VHOST_ACCESS_RO : VHOST_ACCESS_RW;
     msg.iotlb.type = VHOST_IOTLB_UPDATE;
 
+   trace_vhost_vdpa_dma_map(v, fd, msg.type, msg.iotlb.iova, msg.iotlb.size,
+                            msg.iotlb.uaddr, msg.iotlb.perm, msg.iotlb.type);
+
     if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {
         error_report("failed to write, fd=%d, errno=%d (%s)",
             fd, errno, strerror(errno));
@@ -69,6 +74,9 @@ static int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, hwaddr iova,
     msg.iotlb.size = size;
     msg.iotlb.type = VHOST_IOTLB_INVALIDATE;
 
+    trace_vhost_vdpa_dma_unmap(v, fd, msg.type, msg.iotlb.iova,
+                               msg.iotlb.size, msg.iotlb.type);
+
     if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {
         error_report("failed to write, fd=%d, errno=%d (%s)",
             fd, errno, strerror(errno));
@@ -154,6 +162,9 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
             section->offset_within_region +
             (iova - section->offset_within_address_space);
 
+    trace_vhost_vdpa_listener_region_add(v, iova, int128_get64(llend),
+                                         vaddr, section->readonly);
+
     llsize = int128_sub(llend, int128_make64(iova));
 
     ret = vhost_vdpa_dma_map(v, iova, int128_get64(llsize),
@@ -209,6 +220,8 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
     llend = int128_add(llend, section->size);
     llend = int128_and(llend, int128_exts64(TARGET_PAGE_MASK));
 
+    trace_vhost_vdpa_listener_region_del(v, iova, int128_get64(llend));
+
     if (int128_ge(int128_make64(iova), llend)) {
         return;
     }
@@ -249,6 +262,7 @@ static void vhost_vdpa_add_status(struct vhost_dev *dev, uint8_t status)
 {
     uint8_t s;
 
+    trace_vhost_vdpa_add_status(dev, status);
     if (vhost_vdpa_call(dev, VHOST_VDPA_GET_STATUS, &s)) {
         return;
     }
@@ -263,6 +277,7 @@ static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque)
     struct vhost_vdpa *v;
     uint64_t features;
     assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_VDPA);
+    trace_vhost_vdpa_init(dev, opaque);
 
     v = opaque;
     v->dev = dev;
@@ -283,6 +298,7 @@ static int vhost_vdpa_cleanup(struct vhost_dev *dev)
     struct vhost_vdpa *v;
     assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_VDPA);
     v = dev->opaque;
+    trace_vhost_vdpa_cleanup(dev, v);
     memory_listener_unregister(&v->listener);
 
     dev->opaque = NULL;
@@ -291,13 +307,25 @@ static int vhost_vdpa_cleanup(struct vhost_dev *dev)
 
 static int vhost_vdpa_memslots_limit(struct vhost_dev *dev)
 {
+    trace_vhost_vdpa_memslots_limit(dev, INT_MAX);
     return INT_MAX;
 }
 
 static int vhost_vdpa_set_mem_table(struct vhost_dev *dev,
                                     struct vhost_memory *mem)
 {
-
+    trace_vhost_vdpa_set_mem_table(dev, mem->nregions, mem->padding);
+    if (trace_event_get_state_backends(TRACE_VHOST_VDPA_SET_MEM_TABLE) &&
+        trace_event_get_state_backends(TRACE_VHOST_VDPA_DUMP_REGIONS)) {
+        int i;
+        for (i = 0; i < mem->nregions; i++) {
+            trace_vhost_vdpa_dump_regions(dev, i,
+                                          mem->regions[i].guest_phys_addr,
+                                          mem->regions[i].memory_size,
+                                          mem->regions[i].userspace_addr,
+                                          mem->regions[i].flags_padding);
+        }
+    }
     if (mem->padding) {
         return -1;
     }
@@ -309,6 +337,7 @@ static int vhost_vdpa_set_features(struct vhost_dev *dev,
                                    uint64_t features)
 {
     int ret;
+    trace_vhost_vdpa_set_features(dev, features);
     ret = vhost_vdpa_call(dev, VHOST_SET_FEATURES, &features);
     uint8_t status = 0;
     if (ret) {
@@ -345,26 +374,34 @@ static int vhost_vdpa_set_backend_cap(struct vhost_dev *dev)
 int vhost_vdpa_get_device_id(struct vhost_dev *dev,
                                    uint32_t *device_id)
 {
-    return vhost_vdpa_call(dev, VHOST_VDPA_GET_DEVICE_ID, device_id);
+    int ret;
+    ret = vhost_vdpa_call(dev, VHOST_VDPA_GET_DEVICE_ID, device_id);
+    trace_vhost_vdpa_get_device_id(dev, *device_id);
+    return ret;
 }
 
 static int vhost_vdpa_reset_device(struct vhost_dev *dev)
 {
+    int ret;
     uint8_t status = 0;
 
-    return vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &status);
+    ret = vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &status);
+    trace_vhost_vdpa_reset_device(dev, status);
+    return ret;
 }
 
 static int vhost_vdpa_get_vq_index(struct vhost_dev *dev, int idx)
 {
     assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
 
+    trace_vhost_vdpa_get_vq_index(dev, idx, idx - dev->vq_index);
     return idx - dev->vq_index;
 }
 
 static int vhost_vdpa_set_vring_ready(struct vhost_dev *dev)
 {
     int i;
+    trace_vhost_vdpa_set_vring_ready(dev);
     for (i = 0; i < dev->nvqs; ++i) {
         struct vhost_vring_state state = {
             .index = dev->vq_index + i,
@@ -375,6 +412,19 @@ static int vhost_vdpa_set_vring_ready(struct vhost_dev *dev)
     return 0;
 }
 
+static void vhost_vdpa_dump_config(struct vhost_dev *dev, const uint8_t *config,
+                                   uint32_t config_len)
+{
+    int b, len;
+    char line[QEMU_HEXDUMP_LINE_LEN];
+
+    for (b = 0; b < config_len; b += 16) {
+        len = config_len - b;
+        qemu_hexdump_line(line, b, config, len, false);
+        trace_vhost_vdpa_dump_config(dev, line);
+    }
+}
+
 static int vhost_vdpa_set_config(struct vhost_dev *dev, const uint8_t *data,
                                    uint32_t offset, uint32_t size,
                                    uint32_t flags)
@@ -383,10 +433,15 @@ static int vhost_vdpa_set_config(struct vhost_dev *dev, const uint8_t *data,
     int ret;
     unsigned long config_size = offsetof(struct vhost_vdpa_config, buf);
 
+    trace_vhost_vdpa_set_config(dev, offset, size, flags);
     config = g_malloc(size + config_size);
     config->off = offset;
     config->len = size;
     memcpy(config->buf, data, size);
+    if (trace_event_get_state_backends(TRACE_VHOST_VDPA_SET_CONFIG) &&
+        trace_event_get_state_backends(TRACE_VHOST_VDPA_DUMP_CONFIG)) {
+        vhost_vdpa_dump_config(dev, data, size);
+    }
     ret = vhost_vdpa_call(dev, VHOST_VDPA_SET_CONFIG, config);
     g_free(config);
     return ret;
@@ -399,18 +454,24 @@ static int vhost_vdpa_get_config(struct vhost_dev *dev, uint8_t *config,
     unsigned long config_size = offsetof(struct vhost_vdpa_config, buf);
     int ret;
 
+    trace_vhost_vdpa_get_config(dev, config, config_len);
     v_config = g_malloc(config_len + config_size);
     v_config->len = config_len;
     v_config->off = 0;
     ret = vhost_vdpa_call(dev, VHOST_VDPA_GET_CONFIG, v_config);
     memcpy(config, v_config->buf, config_len);
     g_free(v_config);
+    if (trace_event_get_state_backends(TRACE_VHOST_VDPA_GET_CONFIG) &&
+        trace_event_get_state_backends(TRACE_VHOST_VDPA_DUMP_CONFIG)) {
+        vhost_vdpa_dump_config(dev, config, config_len);
+    }
     return ret;
  }
 
 static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
 {
     struct vhost_vdpa *v = dev->opaque;
+    trace_vhost_vdpa_dev_start(dev, started);
     if (started) {
         uint8_t status = 0;
         memory_listener_register(&v->listener, &address_space_memory);
@@ -432,53 +493,72 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
 static int vhost_vdpa_set_log_base(struct vhost_dev *dev, uint64_t base,
                                      struct vhost_log *log)
 {
+    trace_vhost_vdpa_set_log_base(dev, base, log->size, log->refcnt, log->fd,
+                                  log->log);
     return vhost_vdpa_call(dev, VHOST_SET_LOG_BASE, &base);
 }
 
 static int vhost_vdpa_set_vring_addr(struct vhost_dev *dev,
                                        struct vhost_vring_addr *addr)
 {
+    trace_vhost_vdpa_set_vring_addr(dev, addr->index, addr->flags,
+                                    addr->desc_user_addr, addr->used_user_addr,
+                                    addr->avail_user_addr,
+                                    addr->log_guest_addr);
     return vhost_vdpa_call(dev, VHOST_SET_VRING_ADDR, addr);
 }
 
 static int vhost_vdpa_set_vring_num(struct vhost_dev *dev,
                                       struct vhost_vring_state *ring)
 {
+    trace_vhost_vdpa_set_vring_num(dev, ring->index, ring->num);
     return vhost_vdpa_call(dev, VHOST_SET_VRING_NUM, ring);
 }
 
 static int vhost_vdpa_set_vring_base(struct vhost_dev *dev,
                                        struct vhost_vring_state *ring)
 {
+    trace_vhost_vdpa_set_vring_base(dev, ring->index, ring->num);
     return vhost_vdpa_call(dev, VHOST_SET_VRING_BASE, ring);
 }
 
 static int vhost_vdpa_get_vring_base(struct vhost_dev *dev,
                                        struct vhost_vring_state *ring)
 {
-    return vhost_vdpa_call(dev, VHOST_GET_VRING_BASE, ring);
+    int ret;
+
+    ret = vhost_vdpa_call(dev, VHOST_GET_VRING_BASE, ring);
+    trace_vhost_vdpa_get_vring_base(dev, ring->index, ring->num);
+    return ret;
 }
 
 static int vhost_vdpa_set_vring_kick(struct vhost_dev *dev,
                                        struct vhost_vring_file *file)
 {
+    trace_vhost_vdpa_set_vring_kick(dev, file->index, file->fd);
     return vhost_vdpa_call(dev, VHOST_SET_VRING_KICK, file);
 }
 
 static int vhost_vdpa_set_vring_call(struct vhost_dev *dev,
                                        struct vhost_vring_file *file)
 {
+    trace_vhost_vdpa_set_vring_call(dev, file->index, file->fd);
     return vhost_vdpa_call(dev, VHOST_SET_VRING_CALL, file);
 }
 
 static int vhost_vdpa_get_features(struct vhost_dev *dev,
                                      uint64_t *features)
 {
-    return vhost_vdpa_call(dev, VHOST_GET_FEATURES, features);
+    int ret;
+
+    ret = vhost_vdpa_call(dev, VHOST_GET_FEATURES, features);
+    trace_vhost_vdpa_get_features(dev, *features);
+    return ret;
 }
 
 static int vhost_vdpa_set_owner(struct vhost_dev *dev)
 {
+    trace_vhost_vdpa_set_owner(dev);
     return vhost_vdpa_call(dev, VHOST_SET_OWNER, NULL);
 }
 
@@ -489,6 +569,8 @@ static int vhost_vdpa_vq_get_addr(struct vhost_dev *dev,
     addr->desc_user_addr = (uint64_t)(unsigned long)vq->desc_phys;
     addr->avail_user_addr = (uint64_t)(unsigned long)vq->avail_phys;
     addr->used_user_addr = (uint64_t)(unsigned long)vq->used_phys;
+    trace_vhost_vdpa_vq_get_addr(dev, vq, addr->desc_user_addr,
+                                 addr->avail_user_addr, addr->used_user_addr);
     return 0;
 }
 
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 845200bf10..cf1e59de30 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -22,6 +22,37 @@ vhost_user_postcopy_waker(const char *rb, uint64_t rb_offset) "%s + 0x%"PRIx64
 vhost_user_postcopy_waker_found(uint64_t client_addr) "0x%"PRIx64
 vhost_user_postcopy_waker_nomatch(const char *rb, uint64_t rb_offset) "%s + 0x%"PRIx64
 
+# vhost-vdpa.c
+vhost_vdpa_dma_map(void *vdpa, int fd, uint32_t msg_type, uint64_t iova, uint64_t size, uint64_t uaddr, uint8_t perm, uint8_t type) "vdpa:%p fd: %d msg_type: %"PRIu32" iova: 0x%"PRIx64" size: 0x%"PRIx64" uaddr: 0x%"PRIx64" perm: 0x%"PRIx8" type: %"PRIu8
+vhost_vdpa_dma_unmap(void *vdpa, int fd, uint32_t msg_type, uint64_t iova, uint64_t size, uint8_t type) "vdpa:%p fd: %d msg_type: %"PRIu32" iova: 0x%"PRIx64" size: 0x%"PRIx64" type: %"PRIu8
+vhost_vdpa_listener_region_add(void *vdpa, uint64_t iova, uint64_t llend, void *vaddr, bool readonly) "vdpa: %p iova 0x%"PRIx64" llend 0x%"PRIx64" vaddr: %p read-only: %d"
+vhost_vdpa_listener_region_del(void *vdpa, uint64_t iova, uint64_t llend) "vdpa: %p iova 0x%"PRIx64" llend 0x%"PRIx64
+vhost_vdpa_add_status(void *dev, uint8_t status) "dev: %p status: 0x%"PRIx8
+vhost_vdpa_init(void *dev, void *vdpa) "dev: %p vdpa: %p"
+vhost_vdpa_cleanup(void *dev, void *vdpa) "dev: %p vdpa: %p"
+vhost_vdpa_memslots_limit(void *dev, int ret) "dev: %p = 0x%x"
+vhost_vdpa_set_mem_table(void *dev, uint32_t nregions, uint32_t padding) "dev: %p nregions: %"PRIu32" padding: 0x%"PRIx32
+vhost_vdpa_dump_regions(void *dev, int i, uint64_t guest_phys_addr, uint64_t memory_size, uint64_t userspace_addr, uint64_t flags_padding) "dev: %p %d: guest_phys_addr: 0x%"PRIx64" memory_size: 0x%"PRIx64" userspace_addr: 0x%"PRIx64" flags_padding: 0x%"PRIx64
+vhost_vdpa_set_features(void *dev, uint64_t features) "dev: %p features: 0x%"PRIx64
+vhost_vdpa_get_device_id(void *dev, uint32_t device_id) "dev: %p device_id %"PRIu32
+vhost_vdpa_reset_device(void *dev, uint8_t status) "dev: %p status: 0x%"PRIx8
+vhost_vdpa_get_vq_index(void *dev, int idx, int vq_idx) "dev: %p idx: %d vq idx: %d"
+vhost_vdpa_set_vring_ready(void *dev) "dev: %p"
+vhost_vdpa_dump_config(void *dev, const char *line) "dev: %p %s"
+vhost_vdpa_set_config(void *dev, uint32_t offset, uint32_t size, uint32_t flags) "dev: %p offset: %"PRIu32" size: %"PRIu32" flags: 0x%"PRIx32
+vhost_vdpa_get_config(void *dev, void *config, uint32_t config_len) "dev: %p config: %p config_len: %"PRIu32
+vhost_vdpa_dev_start(void *dev, bool started) "dev: %p started: %d"
+vhost_vdpa_set_log_base(void *dev, uint64_t base, unsigned long long size, int refcnt, int fd, void *log) "dev: %p base: 0x%"PRIx64" size: %llu refcnt: %d fd: %d log: %p"
+vhost_vdpa_set_vring_addr(void *dev, unsigned int index, unsigned int flags, uint64_t desc_user_addr, uint64_t used_user_addr, uint64_t avail_user_addr, uint64_t log_guest_addr) "dev: %p index: %u flags: 0x%x desc_user_addr: 0x%"PRIx64" used_user_addr: 0x%"PRIx64" avail_user_addr: 0x%"PRIx64" log_guest_addr: 0x%"PRIx64
+vhost_vdpa_set_vring_num(void *dev, unsigned int index, unsigned int num) "dev: %p index: %u num: %u"
+vhost_vdpa_set_vring_base(void *dev, unsigned int index, unsigned int num) "dev: %p index: %u num: %u"
+vhost_vdpa_get_vring_base(void *dev, unsigned int index, unsigned int num) "dev: %p index: %u num: %u"
+vhost_vdpa_set_vring_kick(void *dev, unsigned int index, int fd) "dev: %p index: %u fd: %d"
+vhost_vdpa_set_vring_call(void *dev, unsigned int index, int fd) "dev: %p index: %u fd: %d"
+vhost_vdpa_get_features(void *dev, uint64_t features) "dev: %p features: 0x%"PRIx64
+vhost_vdpa_set_owner(void *dev) "dev: %p"
+vhost_vdpa_vq_get_addr(void *dev, void *vq, uint64_t desc_user_addr, uint64_t avail_user_addr, uint64_t used_user_addr) "dev: %p vq: %p desc_user_addr: 0x%"PRIx64" avail_user_addr: 0x%"PRIx64" used_user_addr: 0x%"PRIx64
+
 # virtio.c
 virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned out_num) "elem %p size %zd in_num %u out_num %u"
 virtqueue_fill(void *vq, const void *elem, unsigned int len, unsigned int idx) "vq %p elem %p len %u idx %u"
-- 
MST


