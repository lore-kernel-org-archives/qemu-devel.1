Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE38C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 199DB2171F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199DB2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAFHj-0001x5-1e
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 11:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iAF8Y-0002zF-P4
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:11:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iAF8W-0000X1-7S
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:11:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38863)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iAF8V-0000Wm-Tj
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:11:24 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 15BF83D94D
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 15:11:23 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id c8so4528114qtd.20
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 08:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nQf6ecGYajcVAEF7dCCPKHDMUmITzulZi9OdOrvRJLE=;
 b=OEtiJS/CkC/F+ZRA5wXyi2JmKN2Q0frlGmKfLP2r4KR0QnNVyiDRn2V7bJZ3/E8pdK
 qA2ZWNN8tfp7GbD6WVDnAzf+GLlttcfdZv0N4ecypLtZD+ToxbnuUn5cKjjhQN6vozoE
 4a2mcWZnQhqSu2KsztawctgzVhLYRbV6KMS+Yz6P69aXU2PQtgw2Q0y8AUjtvk7Tzzmm
 sOcNwxZyq4iCL09rY6vKr0F1XzjlhrLSMoAhIOWJGrBBb0uZa0c8vSVjg7+HiRwHGIHr
 N7m6C8fuwfCe6CEJL0jttCHUvn1S5b9JbDU9uoy4PcFpYt9nWZrdmaU6no0GrJATuwdj
 98zw==
X-Gm-Message-State: APjAAAXmDlxB+VUCW8/G9VpqM4t0hNsDyoaG2/LnuBxq4caG4MJKsudZ
 fj8vOwVO68UrU3ow20wma4WCBhthOSRAkiK3djTHMNHJSelbYlL4TSaycSJkpk7wTtf5r00X5RN
 MS8+0Jsb6V88dnIY=
X-Received: by 2002:ac8:7599:: with SMTP id s25mr4249461qtq.146.1568733081878; 
 Tue, 17 Sep 2019 08:11:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwMPg1omZftrC69emigIxqvewPFlLQLks1zV+bTbcJqf8zSCQcsdlWFv7TKqmoh5aYCuv/J4A==
X-Received: by 2002:ac8:7599:: with SMTP id s25mr4249409qtq.146.1568733081464; 
 Tue, 17 Sep 2019 08:11:21 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id c14sm1609479qta.80.2019.09.17.08.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 08:11:20 -0700 (PDT)
Date: Tue, 17 Sep 2019 11:11:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190913120559.40835-1-slp@redhat.com>
References: <20190917151011.24588-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190917151011.24588-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 10/10] virtio-mmio: implement modern (v2)
 personality (virtio-1)
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190917151117.qpxTEc9RVIxuIki-oqyyin6jnRQRmPFC3unPALuyV6c@z>

From: Sergio Lopez <slp@redhat.com>

Implement the modern (v2) personality, according to the VirtIO 1.0
specification.

Support for v2 among guests is not as widespread as it'd be
desirable. While the Linux driver has had it for a while, support is
missing, at least, from Tianocore EDK II, NetBSD and FreeBSD.

For this reason, the v2 personality is disabled, keeping the legacy
behavior as default. Machine types willing to use v2, can enable it
using MachineClass's compat_props.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Message-Id: <20190913120559.40835-1-slp@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-mmio.c | 342 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 319 insertions(+), 23 deletions(-)

diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index eccc795f28..3d5ca0f667 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -50,14 +50,24 @@
         OBJECT_CHECK(VirtIOMMIOProxy, (obj), TYPE_VIRTIO_MMIO)
 
 #define VIRT_MAGIC 0x74726976 /* 'virt' */
-#define VIRT_VERSION 1
+#define VIRT_VERSION 2
+#define VIRT_VERSION_LEGACY 1
 #define VIRT_VENDOR 0x554D4551 /* 'QEMU' */
 
+typedef struct VirtIOMMIOQueue {
+    uint16_t num;
+    bool enabled;
+    uint32_t desc[2];
+    uint32_t avail[2];
+    uint32_t used[2];
+} VirtIOMMIOQueue;
+
 typedef struct {
     /* Generic */
     SysBusDevice parent_obj;
     MemoryRegion iomem;
     qemu_irq irq;
+    bool legacy;
     /* Guest accessible state needing migration and reset */
     uint32_t host_features_sel;
     uint32_t guest_features_sel;
@@ -65,6 +75,9 @@ typedef struct {
     /* virtio-bus */
     VirtioBusState bus;
     bool format_transport_address;
+    /* Fields only used for non-legacy (v2) devices */
+    uint32_t guest_features[2];
+    VirtIOMMIOQueue vqs[VIRTIO_QUEUE_MAX];
 } VirtIOMMIOProxy;
 
 static bool virtio_mmio_ioeventfd_enabled(DeviceState *d)
@@ -118,7 +131,11 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
         case VIRTIO_MMIO_MAGIC_VALUE:
             return VIRT_MAGIC;
         case VIRTIO_MMIO_VERSION:
-            return VIRT_VERSION;
+            if (proxy->legacy) {
+                return VIRT_VERSION_LEGACY;
+            } else {
+                return VIRT_VERSION;
+            }
         case VIRTIO_MMIO_VENDOR_ID:
             return VIRT_VENDOR;
         default:
@@ -149,28 +166,64 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
     case VIRTIO_MMIO_MAGIC_VALUE:
         return VIRT_MAGIC;
     case VIRTIO_MMIO_VERSION:
-        return VIRT_VERSION;
+        if (proxy->legacy) {
+            return VIRT_VERSION_LEGACY;
+        } else {
+            return VIRT_VERSION;
+        }
     case VIRTIO_MMIO_DEVICE_ID:
         return vdev->device_id;
     case VIRTIO_MMIO_VENDOR_ID:
         return VIRT_VENDOR;
     case VIRTIO_MMIO_DEVICE_FEATURES:
-        if (proxy->host_features_sel) {
-            return 0;
+        if (proxy->legacy) {
+            if (proxy->host_features_sel) {
+                return 0;
+            } else {
+                return vdev->host_features;
+            }
+        } else {
+            VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
+            return (vdev->host_features & ~vdc->legacy_features)
+                >> (32 * proxy->host_features_sel);
         }
-        return vdev->host_features;
     case VIRTIO_MMIO_QUEUE_NUM_MAX:
         if (!virtio_queue_get_num(vdev, vdev->queue_sel)) {
             return 0;
         }
         return VIRTQUEUE_MAX_SIZE;
     case VIRTIO_MMIO_QUEUE_PFN:
+        if (!proxy->legacy) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: read from legacy register (0x%"
+                          HWADDR_PRIx ") in non-legacy mode\n",
+                          __func__, offset);
+            return 0;
+        }
         return virtio_queue_get_addr(vdev, vdev->queue_sel)
             >> proxy->guest_page_shift;
+    case VIRTIO_MMIO_QUEUE_READY:
+        if (proxy->legacy) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: read from non-legacy register (0x%"
+                          HWADDR_PRIx ") in legacy mode\n",
+                          __func__, offset);
+            return 0;
+        }
+        return proxy->vqs[vdev->queue_sel].enabled;
     case VIRTIO_MMIO_INTERRUPT_STATUS:
         return atomic_read(&vdev->isr);
     case VIRTIO_MMIO_STATUS:
         return vdev->status;
+    case VIRTIO_MMIO_CONFIG_GENERATION:
+        if (proxy->legacy) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: read from non-legacy register (0x%"
+                          HWADDR_PRIx ") in legacy mode\n",
+                          __func__, offset);
+            return 0;
+        }
+        return vdev->generation;
     case VIRTIO_MMIO_DEVICE_FEATURES_SEL:
     case VIRTIO_MMIO_DRIVER_FEATURES:
     case VIRTIO_MMIO_DRIVER_FEATURES_SEL:
@@ -180,12 +233,20 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
     case VIRTIO_MMIO_QUEUE_ALIGN:
     case VIRTIO_MMIO_QUEUE_NOTIFY:
     case VIRTIO_MMIO_INTERRUPT_ACK:
+    case VIRTIO_MMIO_QUEUE_DESC_LOW:
+    case VIRTIO_MMIO_QUEUE_DESC_HIGH:
+    case VIRTIO_MMIO_QUEUE_AVAIL_LOW:
+    case VIRTIO_MMIO_QUEUE_AVAIL_HIGH:
+    case VIRTIO_MMIO_QUEUE_USED_LOW:
+    case VIRTIO_MMIO_QUEUE_USED_HIGH:
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: read of write-only register\n",
-                      __func__);
+                      "%s: read of write-only register (0x%" HWADDR_PRIx ")\n",
+                      __func__, offset);
         return 0;
     default:
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad register offset\n", __func__);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad register offset (0x%" HWADDR_PRIx ")\n",
+                      __func__, offset);
         return 0;
     }
     return 0;
@@ -232,17 +293,41 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
     }
     switch (offset) {
     case VIRTIO_MMIO_DEVICE_FEATURES_SEL:
-        proxy->host_features_sel = value;
+        if (value) {
+            proxy->host_features_sel = 1;
+        } else {
+            proxy->host_features_sel = 0;
+        }
         break;
     case VIRTIO_MMIO_DRIVER_FEATURES:
-        if (!proxy->guest_features_sel) {
-            virtio_set_features(vdev, value);
+        if (proxy->legacy) {
+            if (proxy->guest_features_sel) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "%s: attempt to write guest features with "
+                              "guest_features_sel > 0 in legacy mode\n",
+                              __func__);
+            } else {
+                virtio_set_features(vdev, value);
+            }
+        } else {
+            proxy->guest_features[proxy->guest_features_sel] = value;
         }
         break;
     case VIRTIO_MMIO_DRIVER_FEATURES_SEL:
-        proxy->guest_features_sel = value;
+        if (value) {
+            proxy->guest_features_sel = 1;
+        } else {
+            proxy->guest_features_sel = 0;
+        }
         break;
     case VIRTIO_MMIO_GUEST_PAGE_SIZE:
+        if (!proxy->legacy) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: write to legacy register (0x%"
+                          HWADDR_PRIx ") in non-legacy mode\n",
+                          __func__, offset);
+            return;
+        }
         proxy->guest_page_shift = ctz32(value);
         if (proxy->guest_page_shift > 31) {
             proxy->guest_page_shift = 0;
@@ -256,15 +341,31 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
         break;
     case VIRTIO_MMIO_QUEUE_NUM:
         trace_virtio_mmio_queue_write(value, VIRTQUEUE_MAX_SIZE);
-        virtio_queue_set_num(vdev, vdev->queue_sel, value);
-        /* Note: only call this function for legacy devices */
-        virtio_queue_update_rings(vdev, vdev->queue_sel);
+        if (proxy->legacy) {
+            virtio_queue_set_num(vdev, vdev->queue_sel, value);
+            virtio_queue_update_rings(vdev, vdev->queue_sel);
+        } else {
+            proxy->vqs[vdev->queue_sel].num = value;
+        }
         break;
     case VIRTIO_MMIO_QUEUE_ALIGN:
-        /* Note: this is only valid for legacy devices */
+        if (!proxy->legacy) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: write to legacy register (0x%"
+                          HWADDR_PRIx ") in non-legacy mode\n",
+                          __func__, offset);
+            return;
+        }
         virtio_queue_set_align(vdev, vdev->queue_sel, value);
         break;
     case VIRTIO_MMIO_QUEUE_PFN:
+        if (!proxy->legacy) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: write to legacy register (0x%"
+                          HWADDR_PRIx ") in non-legacy mode\n",
+                          __func__, offset);
+            return;
+        }
         if (value == 0) {
             virtio_reset(vdev);
         } else {
@@ -272,6 +373,29 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
                                   value << proxy->guest_page_shift);
         }
         break;
+    case VIRTIO_MMIO_QUEUE_READY:
+        if (proxy->legacy) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: write to non-legacy register (0x%"
+                          HWADDR_PRIx ") in legacy mode\n",
+                          __func__, offset);
+            return;
+        }
+        if (value) {
+            virtio_queue_set_num(vdev, vdev->queue_sel,
+                                 proxy->vqs[vdev->queue_sel].num);
+            virtio_queue_set_rings(vdev, vdev->queue_sel,
+                ((uint64_t)proxy->vqs[vdev->queue_sel].desc[1]) << 32 |
+                proxy->vqs[vdev->queue_sel].desc[0],
+                ((uint64_t)proxy->vqs[vdev->queue_sel].avail[1]) << 32 |
+                proxy->vqs[vdev->queue_sel].avail[0],
+                ((uint64_t)proxy->vqs[vdev->queue_sel].used[1]) << 32 |
+                proxy->vqs[vdev->queue_sel].used[0]);
+            proxy->vqs[vdev->queue_sel].enabled = 1;
+        } else {
+            proxy->vqs[vdev->queue_sel].enabled = 0;
+        }
+        break;
     case VIRTIO_MMIO_QUEUE_NOTIFY:
         if (value < VIRTIO_QUEUE_MAX) {
             virtio_queue_notify(vdev, value);
@@ -286,6 +410,12 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
             virtio_mmio_stop_ioeventfd(proxy);
         }
 
+        if (!proxy->legacy && (value & VIRTIO_CONFIG_S_FEATURES_OK)) {
+            virtio_set_features(vdev,
+                                ((uint64_t)proxy->guest_features[1]) << 32 |
+                                proxy->guest_features[0]);
+        }
+
         virtio_set_status(vdev, value & 0xff);
 
         if (value & VIRTIO_CONFIG_S_DRIVER_OK) {
@@ -296,6 +426,66 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
             virtio_reset(vdev);
         }
         break;
+    case VIRTIO_MMIO_QUEUE_DESC_LOW:
+        if (proxy->legacy) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: write to non-legacy register (0x%"
+                          HWADDR_PRIx ") in legacy mode\n",
+                          __func__, offset);
+            return;
+        }
+        proxy->vqs[vdev->queue_sel].desc[0] = value;
+        break;
+    case VIRTIO_MMIO_QUEUE_DESC_HIGH:
+        if (proxy->legacy) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: write to non-legacy register (0x%"
+                          HWADDR_PRIx ") in legacy mode\n",
+                          __func__, offset);
+            return;
+        }
+        proxy->vqs[vdev->queue_sel].desc[1] = value;
+        break;
+    case VIRTIO_MMIO_QUEUE_AVAIL_LOW:
+        if (proxy->legacy) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: write to non-legacy register (0x%"
+                          HWADDR_PRIx ") in legacy mode\n",
+                          __func__, offset);
+            return;
+        }
+        proxy->vqs[vdev->queue_sel].avail[0] = value;
+        break;
+    case VIRTIO_MMIO_QUEUE_AVAIL_HIGH:
+        if (proxy->legacy) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: write to non-legacy register (0x%"
+                          HWADDR_PRIx ") in legacy mode\n",
+                          __func__, offset);
+            return;
+        }
+        proxy->vqs[vdev->queue_sel].avail[1] = value;
+        break;
+    case VIRTIO_MMIO_QUEUE_USED_LOW:
+        if (proxy->legacy) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: write to non-legacy register (0x%"
+                          HWADDR_PRIx ") in legacy mode\n",
+                          __func__, offset);
+            return;
+        }
+        proxy->vqs[vdev->queue_sel].used[0] = value;
+        break;
+    case VIRTIO_MMIO_QUEUE_USED_HIGH:
+        if (proxy->legacy) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: write to non-legacy register (0x%"
+                          HWADDR_PRIx ") in legacy mode\n",
+                          __func__, offset);
+            return;
+        }
+        proxy->vqs[vdev->queue_sel].used[1] = value;
+        break;
     case VIRTIO_MMIO_MAGIC_VALUE:
     case VIRTIO_MMIO_VERSION:
     case VIRTIO_MMIO_DEVICE_ID:
@@ -303,22 +493,31 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
     case VIRTIO_MMIO_DEVICE_FEATURES:
     case VIRTIO_MMIO_QUEUE_NUM_MAX:
     case VIRTIO_MMIO_INTERRUPT_STATUS:
+    case VIRTIO_MMIO_CONFIG_GENERATION:
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: write to readonly register\n",
-                      __func__);
+                      "%s: write to read-only register (0x%" HWADDR_PRIx ")\n",
+                      __func__, offset);
         break;
 
     default:
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad register offset\n", __func__);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad register offset (0x%" HWADDR_PRIx ")\n",
+                      __func__, offset);
     }
 }
 
-static const MemoryRegionOps virtio_mem_ops = {
+static const MemoryRegionOps virtio_legacy_mem_ops = {
     .read = virtio_mmio_read,
     .write = virtio_mmio_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
+static const MemoryRegionOps virtio_mem_ops = {
+    .read = virtio_mmio_read,
+    .write = virtio_mmio_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
 static void virtio_mmio_update_irq(DeviceState *opaque, uint16_t vector)
 {
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
@@ -352,15 +551,90 @@ static void virtio_mmio_save_config(DeviceState *opaque, QEMUFile *f)
     qemu_put_be32(f, proxy->guest_page_shift);
 }
 
+static const VMStateDescription vmstate_virtio_mmio_queue_state = {
+    .name = "virtio_mmio/queue_state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT16(num, VirtIOMMIOQueue),
+        VMSTATE_BOOL(enabled, VirtIOMMIOQueue),
+        VMSTATE_UINT32_ARRAY(desc, VirtIOMMIOQueue, 2),
+        VMSTATE_UINT32_ARRAY(avail, VirtIOMMIOQueue, 2),
+        VMSTATE_UINT32_ARRAY(used, VirtIOMMIOQueue, 2),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_virtio_mmio_state_sub = {
+    .name = "virtio_mmio/state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(guest_features, VirtIOMMIOProxy, 2),
+        VMSTATE_STRUCT_ARRAY(vqs, VirtIOMMIOProxy, VIRTIO_QUEUE_MAX, 0,
+                             vmstate_virtio_mmio_queue_state,
+                             VirtIOMMIOQueue),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_virtio_mmio = {
+    .name = "virtio_mmio",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .minimum_version_id_old = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_virtio_mmio_state_sub,
+        NULL
+    }
+};
+
+static void virtio_mmio_save_extra_state(DeviceState *opaque, QEMUFile *f)
+{
+    VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
+
+    vmstate_save_state(f, &vmstate_virtio_mmio, proxy, NULL);
+}
+
+static int virtio_mmio_load_extra_state(DeviceState *opaque, QEMUFile *f)
+{
+    VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
+
+    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1);
+}
+
+static bool virtio_mmio_has_extra_state(DeviceState *opaque)
+{
+    VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
+
+    return !proxy->legacy;
+}
+
 static void virtio_mmio_reset(DeviceState *d)
 {
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(d);
+    int i;
 
     virtio_mmio_stop_ioeventfd(proxy);
     virtio_bus_reset(&proxy->bus);
     proxy->host_features_sel = 0;
     proxy->guest_features_sel = 0;
     proxy->guest_page_shift = 0;
+
+    if (!proxy->legacy) {
+        proxy->guest_features[0] = proxy->guest_features[1] = 0;
+
+        for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
+            proxy->vqs[i].enabled = 0;
+            proxy->vqs[i].num = 0;
+            proxy->vqs[i].desc[0] = proxy->vqs[i].desc[1] = 0;
+            proxy->vqs[i].avail[0] = proxy->vqs[i].avail[1] = 0;
+            proxy->vqs[i].used[0] = proxy->vqs[i].used[1] = 0;
+        }
+    }
 }
 
 static int virtio_mmio_set_guest_notifier(DeviceState *d, int n, bool assign,
@@ -423,11 +697,22 @@ assign_error:
     return r;
 }
 
+static void virtio_mmio_pre_plugged(DeviceState *d, Error **errp)
+{
+    VirtIOMMIOProxy *proxy = VIRTIO_MMIO(d);
+    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
+
+    if (!proxy->legacy) {
+        virtio_add_feature(&vdev->host_features, VIRTIO_F_VERSION_1);
+    }
+}
+
 /* virtio-mmio device */
 
 static Property virtio_mmio_properties[] = {
     DEFINE_PROP_BOOL("format_transport_address", VirtIOMMIOProxy,
                      format_transport_address, true),
+    DEFINE_PROP_BOOL("force-legacy", VirtIOMMIOProxy, legacy, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -439,8 +724,15 @@ static void virtio_mmio_realizefn(DeviceState *d, Error **errp)
     qbus_create_inplace(&proxy->bus, sizeof(proxy->bus), TYPE_VIRTIO_MMIO_BUS,
                         d, NULL);
     sysbus_init_irq(sbd, &proxy->irq);
-    memory_region_init_io(&proxy->iomem, OBJECT(d), &virtio_mem_ops, proxy,
-                          TYPE_VIRTIO_MMIO, 0x200);
+    if (proxy->legacy) {
+        memory_region_init_io(&proxy->iomem, OBJECT(d),
+                              &virtio_legacy_mem_ops, proxy,
+                              TYPE_VIRTIO_MMIO, 0x200);
+    } else {
+        memory_region_init_io(&proxy->iomem, OBJECT(d),
+                              &virtio_mem_ops, proxy,
+                              TYPE_VIRTIO_MMIO, 0x200);
+    }
     sysbus_init_mmio(sbd, &proxy->iomem);
 }
 
@@ -511,9 +803,13 @@ static void virtio_mmio_bus_class_init(ObjectClass *klass, void *data)
     k->notify = virtio_mmio_update_irq;
     k->save_config = virtio_mmio_save_config;
     k->load_config = virtio_mmio_load_config;
+    k->save_extra_state = virtio_mmio_save_extra_state;
+    k->load_extra_state = virtio_mmio_load_extra_state;
+    k->has_extra_state = virtio_mmio_has_extra_state;
     k->set_guest_notifiers = virtio_mmio_set_guest_notifiers;
     k->ioeventfd_enabled = virtio_mmio_ioeventfd_enabled;
     k->ioeventfd_assign = virtio_mmio_ioeventfd_assign;
+    k->pre_plugged = virtio_mmio_pre_plugged;
     k->has_variable_vring_alignment = true;
     bus_class->max_dev = 1;
     bus_class->get_dev_path = virtio_mmio_bus_get_dev_path;
-- 
MST


