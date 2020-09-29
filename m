Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E334AC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:22:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40FC3207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1KRo/hP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FC3207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN9yM-0003xp-8g
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9wl-0002Ho-O4
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:21:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9wf-0001Xb-Fq
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:21:11 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yn4Su/ll+KmlPGSsofYwl9Lxh3eqQ1zBVxoDIecfowc=;
 b=N1KRo/hPYrpez/MDNACrbggkCqiDMCF6KfIIVyKEXOz/fXwiqnIu5iVUy7xQVXmHnN9b0k
 HURs1TLJIRdzfz+70+eG8T0KYFDVsOXBGqPctAl4pVohOG4Iivu6/loMiAHu79jkA+ha4H
 eq22syDYnEy1yz+aZqg+ta4i6icnjLU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-Gcy_NaPFO32SawgD8KNZMw-1; Tue, 29 Sep 2020 03:21:02 -0400
X-MC-Unique: Gcy_NaPFO32SawgD8KNZMw-1
Received: by mail-wr1-f72.google.com with SMTP id d13so1340777wrr.23
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yn4Su/ll+KmlPGSsofYwl9Lxh3eqQ1zBVxoDIecfowc=;
 b=g+ZiTolDyrOEbkO86XE/iVZQkmamPPCeGwpKX51arenVQATN6jbkmciEsau1RMfA+E
 h66qXOhbqEZPG1AqhXX3w2J9OqRfSbt3smhuQkg8PiSUNL5plqcjs2E+1Xo/9Nx549/E
 xYlfgLcFvL3oS81LV2X05TGm399CUHuMcldTwANfOGwkoOh9RQjYcA7s1vLuGYnyVNc1
 WIaHMpWXJPW/yQa43CH6F/W85xN7W0g3XU39id91L+9oSsAVqM4VV5lJd/VoarZxa5HS
 wimNa+rijGq1Eq8S/2cI0bAY2DPS+r/3VASsmnKLZB/AtgFIG5rpszJAKYSZ/HTF6ND2
 AElQ==
X-Gm-Message-State: AOAM531HTlE/vquqg2XI9biGpIfbhRxLgHIkaYvortPEs6JNRvsOCJwI
 0QuPdXqvpicq4ikzHpHCJPKE0TTpWTS4Isw5G+QZAjZVMz+oy+YoycrTj1vkeB2esLpuPpVvrAW
 2HYds9ICn6/kzpIE=
X-Received: by 2002:a5d:5512:: with SMTP id b18mr2729330wrv.229.1601364060608; 
 Tue, 29 Sep 2020 00:21:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYNO8sEolNYaI+XVV2Zs1cn9goMHFW5NQh4a8ZPfztRbw1Af3VAZ2gGBih3jf82jhnzsSYhg==
X-Received: by 2002:a5d:5512:: with SMTP id b18mr2729308wrv.229.1601364060371; 
 Tue, 29 Sep 2020 00:21:00 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id b84sm4614337wmd.0.2020.09.29.00.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:20:59 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:20:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 03/48] vhost-vdpa: batch updating IOTLB mappings
Message-ID: <20200929071948.281157-4-mst@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Wang <jasowang@redhat.com>

To speed up the memory mapping updating between vhost-vDPA and vDPA
device driver, this patch passes the IOTLB batching flags via IOTLB
API. Two new flags was introduced, VHOST_IOTLB_BATCH_BEGIN is a hint
that a bathced IOTLB updating may be initiated from the
userspace. VHOST_IOTLB_BATCH_END is a hint that userspace has finished
the updating:

VHOST_IOTLB_BATCH_BEGIN
VHOST_IOTLB_UPDATE/VHOST_IOTLB_INVALIDATE
...
VHOST_IOTLB_BATCH_END

Vhost-vDPA can then know that all mappings has been set and can do
optimization like passing all the mappings to the vDPA device driver.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20200907104903.31551-4-jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h |  1 +
 hw/virtio/vhost-vdpa.c         | 66 ++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 6455663388..9b81a409da 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -18,6 +18,7 @@ typedef struct vhost_vdpa {
     int device_fd;
     uint32_t msg_type;
     MemoryListener listener;
+    struct vhost_dev *dev;
 } VhostVDPA;
 
 extern AddressSpace address_space_memory;
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index aedc52c4d7..dbf2643ff7 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -78,6 +78,46 @@ static int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, hwaddr iova,
     return ret;
 }
 
+static void vhost_vdpa_listener_begin(MemoryListener *listener)
+{
+    struct vhost_vdpa *v = container_of(listener, struct vhost_vdpa, listener);
+    struct vhost_dev *dev = v->dev;
+    struct vhost_msg_v2 msg;
+    int fd = v->device_fd;
+
+    if (!(dev->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH))) {
+        return;
+    }
+
+    msg.type = v->msg_type;
+    msg.iotlb.type = VHOST_IOTLB_BATCH_BEGIN;
+
+    if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {
+        error_report("failed to write, fd=%d, errno=%d (%s)",
+                     fd, errno, strerror(errno));
+    }
+}
+
+static void vhost_vdpa_listener_commit(MemoryListener *listener)
+{
+    struct vhost_vdpa *v = container_of(listener, struct vhost_vdpa, listener);
+    struct vhost_dev *dev = v->dev;
+    struct vhost_msg_v2 msg;
+    int fd = v->device_fd;
+
+    if (!(dev->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH))) {
+        return;
+    }
+
+    msg.type = v->msg_type;
+    msg.iotlb.type = VHOST_IOTLB_BATCH_END;
+
+    if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {
+        error_report("failed to write, fd=%d, errno=%d (%s)",
+                     fd, errno, strerror(errno));
+    }
+}
+
 static void vhost_vdpa_listener_region_add(MemoryListener *listener,
                                            MemoryRegionSection *section)
 {
@@ -188,6 +228,8 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
  * depends on the addnop().
  */
 static const MemoryListener vhost_vdpa_memory_listener = {
+    .begin = vhost_vdpa_listener_begin,
+    .commit = vhost_vdpa_listener_commit,
     .region_add = vhost_vdpa_listener_region_add,
     .region_del = vhost_vdpa_listener_region_del,
 };
@@ -223,6 +265,7 @@ static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque)
     assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_VDPA);
 
     v = opaque;
+    v->dev = dev;
     dev->opaque =  opaque ;
     vhost_vdpa_call(dev, VHOST_GET_FEATURES, &features);
     dev->backend_features = features;
@@ -277,6 +320,28 @@ static int vhost_vdpa_set_features(struct vhost_dev *dev,
     return !(status & VIRTIO_CONFIG_S_FEATURES_OK);
 }
 
+static int vhost_vdpa_set_backend_cap(struct vhost_dev *dev)
+{
+    uint64_t features;
+    uint64_t f = 0x1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2 |
+        0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH;
+    int r;
+
+    if (vhost_vdpa_call(dev, VHOST_GET_BACKEND_FEATURES, &features)) {
+        return 0;
+    }
+
+    features &= f;
+    r = vhost_vdpa_call(dev, VHOST_SET_BACKEND_FEATURES, &features);
+    if (r) {
+        return 0;
+    }
+
+    dev->backend_cap = features;
+
+    return 0;
+}
+
 int vhost_vdpa_get_device_id(struct vhost_dev *dev,
                                    uint32_t *device_id)
 {
@@ -444,6 +509,7 @@ const VhostOps vdpa_ops = {
         .vhost_set_vring_kick = vhost_vdpa_set_vring_kick,
         .vhost_set_vring_call = vhost_vdpa_set_vring_call,
         .vhost_get_features = vhost_vdpa_get_features,
+        .vhost_set_backend_cap = vhost_vdpa_set_backend_cap,
         .vhost_set_owner = vhost_vdpa_set_owner,
         .vhost_set_vring_endian = NULL,
         .vhost_backend_memslots_limit = vhost_vdpa_memslots_limit,
-- 
MST


