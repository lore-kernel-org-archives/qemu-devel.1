Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCBFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:53:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F7920715
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="HSNr36AQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F7920715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsOk8-0003k0-Dp
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 06:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jsOjZ-0003KW-Ax
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:52:25 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:43147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jsOjX-0003PU-80
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:52:25 -0400
Received: by mail-lj1-x244.google.com with SMTP id f5so28852345ljj.10
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 03:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mfg3UXx+kQ8L82ftMFnvaicyP4lVZZK0W3m5aNci2oc=;
 b=HSNr36AQOJ9HhnMUrN67miV23jPkiQDIs34Hhcwe1CEadx/pnvFvzJYnbFo6PBjjnP
 lMedTMh6Q+S/NCno3laB6fCjqk9TE7/DmUj4S7sNjkBnrd5lnSX2lXaR3OE6RqFcYfO2
 /DY05UCu4zmbVBT5J6OvnYKBxUuvUdYVE5EjD6PPEpyLE353uQllOQySJ5TznBASFLwW
 MOElRm9uod+wb5mavZyOsfLJux5WdrEbTjrMJ488X/57mzCaNsHOWRdYH4Js+rLt9shr
 0rrlieh4APYu4ha/UAQCSHSNlAGb+rdAolNCeEA4M5oZAMmv7oiymzBJPcIk2UpzXiYn
 OZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mfg3UXx+kQ8L82ftMFnvaicyP4lVZZK0W3m5aNci2oc=;
 b=PlFa49VFSHUxlQEfwpWdTSkyZ3WUiIeWM4JwUfGD3r4p28PuC0ZLkQPOBOIbmL9xC8
 veYNDMzr/mKmj8TECbEmrzuAujDPCbHOOIL9pSKCQQkVcGPKqv3NepyinMPtM6TJhoGl
 NBbmgfB3ubsSVm+7rD+FVS/aXgRYm1EdKiumyzUbsfuZlHHPQoCyssYMr+XYl0E/mp7/
 MryHwMcilD8JHLddhu5ktrM3xGNhX4MtzdZ4aQr/U7eRTft7SsDaNnbqlir+GtlVkS/J
 NqYwW+ysy993yxTDZGObb9bt3UEmRDPiyiOl6YCEp9lham7l/MqNKPnFUJfQxRS9vCEI
 T+Cg==
X-Gm-Message-State: AOAM530r3lDpTM+PXJTK/YfuPoI1ZY+Up4O6E1h7hbnuXqIcEzpawhTy
 4kV37AVTBXVxHLMlCZEUBtqjiU6xKXOJkg==
X-Google-Smtp-Source: ABdhPJzCTXmBowDXATh3NsXUVzpmIHDTEg1kvh6OgNEz/p64z0ZLu8V0vOJcypgU7hTQjO83h73J4A==
X-Received: by 2002:a2e:80da:: with SMTP id r26mr13930572ljg.179.1594032740559; 
 Mon, 06 Jul 2020 03:52:20 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id h22sm7791940ljg.1.2020.07.06.03.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 03:52:19 -0700 (PDT)
From: andrew@daynix.com
To: qemu-devel@nongnu.org
Subject: [PATCH] virtio-pci: Changed vdev to proxy for VirtIO PCI BAR
 callbacks.
Date: Mon,  6 Jul 2020 14:21:23 +0300
Message-Id: <20200706112123.971087-1-andrew@daynix.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::244;
 envelope-from=andrew@daynix.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: mst@redhat.com
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
---
 hw/virtio/virtio-pci.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 7bc8c1c056..904010f1cc 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1321,11 +1321,12 @@ static uint64_t virtio_pci_notify_read(void *opaque, hwaddr addr,
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
@@ -1333,10 +1334,12 @@ static void virtio_pci_notify_write(void *opaque, hwaddr addr,
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
@@ -1360,9 +1363,14 @@ static void virtio_pci_isr_write(void *opaque, hwaddr addr,
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
@@ -1380,7 +1388,13 @@ static uint64_t virtio_pci_device_read(void *opaque, hwaddr addr,
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
@@ -1457,19 +1471,19 @@ static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy)
 
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
2.27.0


