Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA3CC43457
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:05:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22F5421D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F5421D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpSV-0007lu-1Y
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kUpQs-00060E-5j; Tue, 20 Oct 2020 07:03:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38448 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kUpQo-0006lj-81; Tue, 20 Oct 2020 07:03:57 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 892D5F5F9B0A65AD92F4;
 Tue, 20 Oct 2020 19:03:44 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 20 Oct 2020
 19:03:37 +0800
From: Gan Qixin <ganqixin@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH 01/10] hw/virtio/:split some lines containing more than 80
 characters
Date: Tue, 20 Oct 2020 04:30:14 +0800
Message-ID: <20201019203023.658555-2-ganqixin@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201019203023.658555-1-ganqixin@huawei.com>
References: <20201019203023.658555-1-ganqixin@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=ganqixin@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 07:03:45
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org,
 zhang.zhanghailiang@huawei.com, mst@redhat.com, f4bug@amsat.org,
 alistair.francis@wdc.com, Gan Qixin <ganqixin@huawei.com>,
 kuhn.chenqun@huawei.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By using scripts/checkpatch.pl, it is found that many files in hw/virtio/
contain lines with more than 80 characters.

Signed-off-by: Gan Qixin <ganqixin@huawei.com>
---
 hw/virtio/vhost-backend.c  |  3 ++-
 hw/virtio/vhost-user-fs.c  |  6 ++++--
 hw/virtio/vhost-user.c     | 10 +++++-----
 hw/virtio/virtio-balloon.c |  6 ++++--
 hw/virtio/virtio-bus.c     |  3 ++-
 hw/virtio/virtio-crypto.c  |  3 ++-
 hw/virtio/virtio-pci.c     |  4 ++--
 hw/virtio/virtio-pci.h     |  8 +++++---
 hw/virtio/virtio-rng.c     |  3 ++-
 hw/virtio/virtio.c         | 14 +++++++++-----
 10 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 88c8ecc9e0..588a1f64fe 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -85,7 +85,8 @@ static int vhost_kernel_scsi_clear_endpoint(struct vhost_dev *dev,
     return vhost_kernel_call(dev, VHOST_SCSI_CLEAR_ENDPOINT, target);
 }
 
-static int vhost_kernel_scsi_get_abi_version(struct vhost_dev *dev, int *version)
+static int vhost_kernel_scsi_get_abi_version(struct vhost_dev *dev,
+                                             int *version)
 {
     return vhost_kernel_call(dev, VHOST_SCSI_GET_ABI_VERSION, version);
 }
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 1bc5d03a00..a17a5ac236 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -209,12 +209,14 @@ static void vuf_device_realize(DeviceState *dev, Error **errp)
                 sizeof(struct virtio_fs_config));
 
     /* Hiprio queue */
-    fs->hiprio_vq = virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_output);
+    fs->hiprio_vq = virtio_add_queue(vdev, fs->conf.queue_size,
+                                     vuf_handle_output);
 
     /* Request queues */
     fs->req_vqs = g_new(VirtQueue *, fs->conf.num_request_queues);
     for (i = 0; i < fs->conf.num_request_queues; i++) {
-        fs->req_vqs[i] = virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_output);
+        fs->req_vqs[i] = virtio_add_queue(vdev, fs->conf.queue_size,
+                                          vuf_handle_output);
     }
 
     /* 1 high prio queue, plus the number configured */
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 9c5b4f7fbc..a3134cd07b 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -755,8 +755,8 @@ static int send_add_regions(struct vhost_dev *dev,
                         reg_fd_idx, reg_idx);
                 } else {
                     error_report("%s: invalid postcopy reply for region. "
-                                 "Got guest physical address %" PRIX64 ", expected "
-                                 "%" PRIX64, __func__, reply_gpa,
+                                 "Got guest physical address %" PRIX64
+                                 ", expected %" PRIX64, __func__, reply_gpa,
                                  dev->mem->regions[reg_idx].guest_phys_addr);
                     return -1;
                 }
@@ -1872,9 +1872,9 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque)
 
             if (ram_slots < u->user->memory_slots) {
                 error_report("The backend specified a max ram slots limit "
-                             "of %" PRIu64", when the prior validated limit was %d. "
-                             "This limit should never decrease.", ram_slots,
-                             u->user->memory_slots);
+                             "of %" PRIu64", when the prior validated limit "
+                             "was %d. This limit should never decrease.",
+                             ram_slots, u->user->memory_slots);
                 return -1;
             }
 
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index b22b5beda3..c10aa16cf0 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -212,7 +212,8 @@ static void balloon_stats_destroy_timer(VirtIOBalloon *s)
 
 static void balloon_stats_change_timer(VirtIOBalloon *s, int64_t secs)
 {
-    timer_mod(s->stats_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + secs * 1000);
+    timer_mod(s->stats_timer,
+              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + secs * 1000);
 }
 
 static void balloon_stats_poll_cb(void *opaque)
@@ -425,7 +426,8 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
                     balloon_inflate_page(s, section.mr,
                                          section.offset_within_region, &pbp);
                 } else if (vq == s->dvq) {
-                    balloon_deflate_page(s, section.mr, section.offset_within_region);
+                    balloon_deflate_page(s, section.mr,
+                                         section.offset_within_region);
                 } else {
                     g_assert_not_reached();
                 }
diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index d6332d45c3..66f8ab0baf 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -221,7 +221,8 @@ int virtio_bus_start_ioeventfd(VirtioBusState *bus)
     if (!bus->ioeventfd_grabbed) {
         r = vdc->start_ioeventfd(vdev);
         if (r < 0) {
-            error_report("%s: failed. Fallback to userspace (slower).", __func__);
+            error_report("%s: failed. Fallback to userspace (slower).",
+                         __func__);
             return r;
         }
     }
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 54f9bbb789..6d3616ea98 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -798,7 +798,8 @@ static void virtio_crypto_device_realize(DeviceState *dev, Error **errp)
         return;
     } else if (cryptodev_backend_is_used(vcrypto->cryptodev)) {
         error_setg(errp, "can't use already used cryptodev backend: %s",
-                   object_get_canonical_path_component(OBJECT(vcrypto->conf.cryptodev)));
+                   object_get_canonical_path_component(
+                       OBJECT(vcrypto->conf.cryptodev)));
         return;
     }
 
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 36524a5728..de6704f8c7 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1887,8 +1887,8 @@ static void virtio_pci_reset(DeviceState *qdev)
 }
 
 static Property virtio_pci_properties[] = {
-    DEFINE_PROP_BIT("virtio-pci-bus-master-bug-migration", VirtIOPCIProxy, flags,
-                    VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT, false),
+    DEFINE_PROP_BIT("virtio-pci-bus-master-bug-migration", VirtIOPCIProxy,
+                    flags, VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT, false),
     DEFINE_PROP_BIT("migrate-extra", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_MIGRATE_EXTRA_BIT, true),
     DEFINE_PROP_BIT("modern-pio-notify", VirtIOPCIProxy, flags,
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 06e2af12de..d9049c2c44 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -201,8 +201,9 @@ typedef struct VirtioPCIDeviceTypeInfo {
      * If disable-legacy=auto, (non-)transitional mode is selected
      * depending on the bus where the device is plugged.
      *
-     * Implements both INTERFACE_PCIE_DEVICE and INTERFACE_CONVENTIONAL_PCI_DEVICE,
-     * but PCI Express is supported only in non-transitional mode.
+     * Implements both INTERFACE_PCIE_DEVICE and
+     * INTERFACE_CONVENTIONAL_PCI_DEVICE, but PCI Express is supported only in
+     * non-transitional mode.
      *
      * The only type implemented by QEMU 3.1 and older.
      */
@@ -210,7 +211,8 @@ typedef struct VirtioPCIDeviceTypeInfo {
     /*
      * The transitional device type.  Optional.
      *
-     * Implements both INTERFACE_PCIE_DEVICE and INTERFACE_CONVENTIONAL_PCI_DEVICE.
+     * Implements both INTERFACE_PCIE_DEVICE and
+     * INTERFACE_CONVENTIONAL_PCI_DEVICE.
      */
     const char *transitional_name;
     /*
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 2886c0ce2a..9515ce87de 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -257,7 +257,8 @@ static Property virtio_rng_properties[] = {
      */
     DEFINE_PROP_UINT64("max-bytes", VirtIORNG, conf.max_bytes, INT64_MAX),
     DEFINE_PROP_UINT32("period", VirtIORNG, conf.period_ms, 1 << 16),
-    DEFINE_PROP_LINK("rng", VirtIORNG, conf.rng, TYPE_RNG_BACKEND, RngBackend *),
+    DEFINE_PROP_LINK("rng", VirtIORNG, conf.rng, TYPE_RNG_BACKEND,
+                     RngBackend *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 6f8f865aff..66c5011748 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -309,7 +309,8 @@ static inline uint16_t vring_avail_idx(VirtQueue *vq)
         return 0;
     }
 
-    vq->shadow_avail_idx = virtio_lduw_phys_cached(vq->vdev, &caches->avail, pa);
+    vq->shadow_avail_idx = virtio_lduw_phys_cached(vq->vdev,
+                                                   &caches->avail, pa);
     return vq->shadow_avail_idx;
 }
 
@@ -1065,7 +1066,8 @@ static void virtqueue_split_get_avail_bytes(VirtQueue *vq,
                 goto done;
             }
 
-            rc = virtqueue_split_read_next_desc(vdev, &desc, desc_cache, max, &i);
+            rc = virtqueue_split_read_next_desc(vdev, &desc,
+                                                desc_cache, max, &i);
         } while (rc == VIRTQUEUE_READ_DESC_MORE);
 
         if (rc == VIRTQUEUE_READ_DESC_ERROR) {
@@ -1388,7 +1390,8 @@ void virtqueue_map(VirtIODevice *vdev, VirtQueueElement *elem)
                                                                         false);
 }
 
-static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_num)
+static void *virtqueue_alloc_element(size_t sz, unsigned out_num,
+                                     unsigned in_num)
 {
     VirtQueueElement *elem;
     size_t in_addr_ofs = QEMU_ALIGN_UP(sz, __alignof__(elem->in_addr[0]));
@@ -3558,7 +3561,7 @@ static void virtio_queue_host_notifier_aio_poll_end(EventNotifier *n)
 }
 
 void virtio_queue_aio_set_host_notifier_handler(VirtQueue *vq, AioContext *ctx,
-                                                VirtIOHandleAIOOutput handle_output)
+                                            VirtIOHandleAIOOutput handle_output)
 {
     if (handle_output) {
         vq->handle_aio_output = handle_output;
@@ -3716,7 +3719,8 @@ static void virtio_device_instance_finalize(Object *obj)
 static Property virtio_properties[] = {
     DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
     DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
-    DEFINE_PROP_BOOL("use-disabled-flag", VirtIODevice, use_disabled_flag, true),
+    DEFINE_PROP_BOOL("use-disabled-flag", VirtIODevice,
+                     use_disabled_flag, true),
     DEFINE_PROP_BOOL("x-disable-legacy-check", VirtIODevice,
                      disable_legacy_check, false),
     DEFINE_PROP_END_OF_LIST(),
-- 
2.23.0


