Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6527DC433E4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:15:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E94520771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5pYSbLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E94520771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyDf4-0006si-Ea
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 08:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyDZE-0006VQ-KQ
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:09:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46273
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyDZC-0006d4-V4
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595419786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sKanYFWXSB03AjZNgkORhhOD5JvmJAPTustMtaCVuJo=;
 b=T5pYSbLKU4xjC+2Ejh8syLH9WBWn+KXS6WYaYZ5VeBKjxaJ6mm+rLJRH4iORL2r0R1YxSq
 PYC/La9N6HpPqLMqlLqYpOtuVJcrp69JSpISwPNtiLCHbetlPHu5/KzWDrYn0BKqRabWwN
 g38pMjh6MrgcdkmYtprc+81XZv0Cgdc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-cT7gs42IPS6W-CDqViQdCA-1; Wed, 22 Jul 2020 08:09:42 -0400
X-MC-Unique: cT7gs42IPS6W-CDqViQdCA-1
Received: by mail-wr1-f70.google.com with SMTP id f7so548266wrs.8
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 05:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sKanYFWXSB03AjZNgkORhhOD5JvmJAPTustMtaCVuJo=;
 b=KYMSYo1TE+eP5b2r6V6Z9ZJl06jBMEHCR/55F2bLYrfu6RLtnJfpo2dsvMY9+aT7a9
 Voko6PI0ZT16gdVRyyVd12LHk+fJVt107a1CRQFvBnmQ9kOfrF86u8j4SDNhhtWqnhZV
 rUIZ3SHWcQIDIV2cqhfyOYyNNwgE5s48//IpluIoV0khCzplUPcrl4p+0ONfuNdosOmT
 gR6TtPRZG8Ye2EP2Fcm9HNYY31UYxitXwDcN8ySNe73bZggu9A7CWMMxMpl+FMmkk9U4
 Y3k3zJLG0QCm5/Upa5BbRkKbuD6CPeCaziB6UN/tPPd6d9nWII90JWA/J6ozrMIyCdiP
 qpDw==
X-Gm-Message-State: AOAM5318IbcpuYwhE1bKhNZnGy95B0nA5hCgAbObep8I3dJwFJp8P069
 RA6w8nnkyeALjyYcS2ufWF05ndNnJcrHQ5M+Z1dSk9t61G9un3BIoihIrRpzKSJpmYTrLB1l+tM
 x5+DpZpfeg/U2N+g=
X-Received: by 2002:a1c:7f0e:: with SMTP id a14mr8776526wmd.21.1595419781079; 
 Wed, 22 Jul 2020 05:09:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4PSOT4BA7QdGrYIwxe7HLjyaQ4K04fm+ljxiTNnhO1qdLUypgNf4YotQtZwdbIcm5FlrpJg==
X-Received: by 2002:a1c:7f0e:: with SMTP id a14mr8776509wmd.21.1595419780842; 
 Wed, 22 Jul 2020 05:09:40 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id b63sm1358879wme.41.2020.07.22.05.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 05:09:40 -0700 (PDT)
Date: Wed, 22 Jul 2020 08:09:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 9/9] virtio-pci: Changed vdev to proxy for VirtIO PCI BAR
 callbacks.
Message-ID: <20200722120853.9144-10-mst@redhat.com>
References: <20200722120853.9144-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200722120853.9144-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 21:28:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrew Melnychenko <andrew@daynix.com>, qemu-stable@nongnu.org
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
---
 hw/virtio/virtio-pci.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index db8b711b35..ada1101d07 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1333,11 +1333,12 @@ static uint64_t virtio_pci_notify_read(void *opaque, hwaddr addr,
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
@@ -1345,10 +1346,12 @@ static void virtio_pci_notify_write(void *opaque, hwaddr addr,
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
@@ -1372,9 +1375,14 @@ static void virtio_pci_isr_write(void *opaque, hwaddr addr,
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
@@ -1392,7 +1400,13 @@ static uint64_t virtio_pci_device_read(void *opaque, hwaddr addr,
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
@@ -1469,19 +1483,19 @@ static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy)
 
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
MST


