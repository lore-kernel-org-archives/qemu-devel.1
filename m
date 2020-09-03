Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A588C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:54:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0731720678
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQjL4VHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0731720678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxBr-0004bE-6A
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwMB-00053X-82; Thu, 03 Sep 2020 17:01:19 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34056)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwM8-0007tQ-D1; Thu, 03 Sep 2020 17:01:17 -0400
Received: by mail-ot1-x343.google.com with SMTP id h17so3210739otr.1;
 Thu, 03 Sep 2020 14:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=n/Y0ED6jz0ryYpBgvkE7oSql+mNnQ/ED8BzlFc5aOpo=;
 b=oQjL4VHbFjthDqTqh+7CgzXWbqRKSplmPXjIF7QiAVYkc1+JO8HkOwviNGDDkl1fSD
 HMJHBNgAqo1JOvnEKB48CkNP6MmOnwjSWJ1707topycQJd7uGz76hHND1pHsWfAVhLbb
 /q76evI+dJLSxwOv2jdinpYnhkdYcWct8TkU/n9kX8vIUmRgN3UtU8LGgyrq1pPo/yyf
 IoKZcMVCApVoCWTItRIBQ81qOJ0O1XRwRpURK3t/EN9+X0xyLJOYbdVSH3w6xUSjR5nF
 TUO+SpaPPQHBLO1Dv9QQ2aGz35TAiefiOW6lommVhWOgn36KwH3EpfTzSwyaePdWWhA2
 jdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=n/Y0ED6jz0ryYpBgvkE7oSql+mNnQ/ED8BzlFc5aOpo=;
 b=sSBPwKW5iEkpGmPQIII7LzpD9syE7M12hrX3OCxgjUtw9hDnjQQ783Hd47CP+JRc9e
 mg27lDT75PcEagfG8FWzQN5C4lpuMc5HO8D7f8DUm97cMUMIxT7ZHp/026wIVcdkf6KH
 7vbvgLmCRSCPqWuQtTRQi5YUkkhG+7r0rF0FVEZnlHam+mqlT1riy9HqJ+qISKe8+HRQ
 7aEVgXlSm5E9KZlWvBFmsKwEp25Aa6NDvU0DkHLplEaCRO8qQLTSv6VVAd+V3VD7AXfA
 /9SjnxE99gl7PueUGCpOBgJDIvAMNC4fSDGNlOi+U4TgIHWybsp1g2yKY0VXgcmD1ZqH
 J/Qw==
X-Gm-Message-State: AOAM5326qHaxzeOCqa9d+Dvl8oCYe2rnMHWzeQvKBAl0BBxEZg+Yctfe
 fD60CqCQQH7haW3xknET6jEZ8ZSdyL9gBQ==
X-Google-Smtp-Source: ABdhPJxjAw8KfmHTVuIJa9amBqio0ZRxQE+p2I2iruF+ViEeTxXfCrszfmyWrpwi1NSdRwzjHQrYRg==
X-Received: by 2002:a9d:a6e:: with SMTP id 101mr2994077otg.80.1599166873456;
 Thu, 03 Sep 2020 14:01:13 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id 91sm793490otn.18.2020.09.03.14.01.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:01:12 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 68/77] virtio-pci: Changed vdev to proxy for VirtIO PCI BAR
 callbacks.
Date: Thu,  3 Sep 2020 15:59:26 -0500
Message-Id: <20200903205935.27832-69-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Andrew Melnychenko <andrew@daynix.com>, qemu-stable@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Melnychenko <andrew@daynix.com>

There is an issue when callback may be called with invalid vdev.
It happens on unplug when vdev already deleted and VirtIOPciProxy is not.
So now, callbacks accept proxy device, and vdev retrieved from it.
Technically memio callbacks should be removed during the flatview update,
but memoryregions remain til PCI device(and it's address space) completely deleted.
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1716352

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
Message-Id: <20200706112123.971087-1-andrew@daynix.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit ccec7e9603f446fe75c6c563ba335c00cfda6a06)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio-pci.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 2ca266e1cb..ef11c66a21 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1317,11 +1317,12 @@ static uint64_t virtio_pci_notify_read(void *opaque, hwaddr addr,
 static void virtio_pci_notify_write(void *opaque, hwaddr addr,
                                     uint64_t val, unsigned size)
 {
-    VirtIODevice *vdev = opaque;
-    VirtIOPCIProxy *proxy = VIRTIO_PCI(DEVICE(vdev)->parent_bus->parent);
+    VirtIOPCIProxy *proxy = opaque;
+    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
+
     unsigned queue = addr / virtio_pci_queue_mem_mult(proxy);
 
-    if (queue < VIRTIO_QUEUE_MAX) {
+    if (vdev != NULL && queue < VIRTIO_QUEUE_MAX) {
         virtio_queue_notify(vdev, queue);
     }
 }
@@ -1329,10 +1330,12 @@ static void virtio_pci_notify_write(void *opaque, hwaddr addr,
 static void virtio_pci_notify_write_pio(void *opaque, hwaddr addr,
                                         uint64_t val, unsigned size)
 {
-    VirtIODevice *vdev = opaque;
+    VirtIOPCIProxy *proxy = opaque;
+    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
+
     unsigned queue = val;
 
-    if (queue < VIRTIO_QUEUE_MAX) {
+    if (vdev != NULL && queue < VIRTIO_QUEUE_MAX) {
         virtio_queue_notify(vdev, queue);
     }
 }
@@ -1356,9 +1359,14 @@ static void virtio_pci_isr_write(void *opaque, hwaddr addr,
 static uint64_t virtio_pci_device_read(void *opaque, hwaddr addr,
                                        unsigned size)
 {
-    VirtIODevice *vdev = opaque;
+    VirtIOPCIProxy *proxy = opaque;
+    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
     uint64_t val = 0;
 
+    if (vdev == NULL) {
+        return val;
+    }
+
     switch (size) {
     case 1:
         val = virtio_config_modern_readb(vdev, addr);
@@ -1376,7 +1384,13 @@ static uint64_t virtio_pci_device_read(void *opaque, hwaddr addr,
 static void virtio_pci_device_write(void *opaque, hwaddr addr,
                                     uint64_t val, unsigned size)
 {
-    VirtIODevice *vdev = opaque;
+    VirtIOPCIProxy *proxy = opaque;
+    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
+
+    if (vdev == NULL) {
+        return;
+    }
+
     switch (size) {
     case 1:
         virtio_config_modern_writeb(vdev, addr, val);
@@ -1453,19 +1467,19 @@ static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy)
 
     memory_region_init_io(&proxy->device.mr, OBJECT(proxy),
                           &device_ops,
-                          virtio_bus_get_device(&proxy->bus),
+                          proxy,
                           "virtio-pci-device",
                           proxy->device.size);
 
     memory_region_init_io(&proxy->notify.mr, OBJECT(proxy),
                           &notify_ops,
-                          virtio_bus_get_device(&proxy->bus),
+                          proxy,
                           "virtio-pci-notify",
                           proxy->notify.size);
 
     memory_region_init_io(&proxy->notify_pio.mr, OBJECT(proxy),
                           &notify_pio_ops,
-                          virtio_bus_get_device(&proxy->bus),
+                          proxy,
                           "virtio-pci-notify-pio",
                           proxy->notify_pio.size);
 }
-- 
2.17.1


