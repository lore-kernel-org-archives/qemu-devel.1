Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737C9C4742C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB5C720780
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJKYfZEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB5C720780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaNuC-0002RV-Nm
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:53:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNjp-0001gT-GQ
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:42:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33450)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNjk-000261-Kz
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:42:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604515343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BrWBtHz+T2+mIPkAWH3w+WMghO+0VMpKeuA9wyAHhqM=;
 b=ZJKYfZEEBup3amu2+h2acwnrazICWxy/+z+8HwP37cxcMqGfkEkAVmB7Ad4vzm53ZyatP0
 AikJErY9TpbAMTV5z4FscQAQZf5fdmZrs3Bk+Z/0KMBMC/ajcFzXQpV99/9cZMLvlKrfnB
 J7hAcS9RcP8fvTAUAGZbTreK90BeSd0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-QAbuIb0zOtG66rsBDivJRA-1; Wed, 04 Nov 2020 13:42:21 -0500
X-MC-Unique: QAbuIb0zOtG66rsBDivJRA-1
Received: by mail-wr1-f72.google.com with SMTP id j15so9618569wrd.16
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 10:42:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BrWBtHz+T2+mIPkAWH3w+WMghO+0VMpKeuA9wyAHhqM=;
 b=P1A5jXD5px40u/AU/OKHV1OEmgu38SfD3aGFdu2eNE8ZX0LfVsspiLDJmeP1wgOyZp
 Aju7me1aFgTcRhsgAYmaiz4ZkGwKBLFbSSTxglcJp3CMoOARlKkzHn0j4OtCWnWHNJuN
 ptZAFTw0P4EPpKGF+fLLR5G17I1Tn8DdiXKWZ+wWL71OYvNJ9J79SDGjsn7yeOMQRNA2
 t63R9+qdKHFboqPXBjuIdGA4L+FAuTgg3zyoNyErH3VqoadDMJCIVn7JFFebFRhBtEId
 sVOoSDNphkZHPk1Sd8ELBSbaznnfZ18aMB692oCck2Rj+iHWcFHyBBWdAu1il4jgst7H
 nrWg==
X-Gm-Message-State: AOAM5317MRkZn5gHFmg4B7fIijZXKfmksCRO6bS+xdSFv7auid9bQkQl
 7n8fSQCwxcLWsIV5hMCISbem19g3GdPhoVwC//Rn4Pj6vnHWmn6IvJ8nZ23j85/lvpy694M8fZQ
 Ma6kJEZP1K3PHJ1U=
X-Received: by 2002:a1c:23cf:: with SMTP id j198mr6008712wmj.6.1604515339709; 
 Wed, 04 Nov 2020 10:42:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVQ2/0HYyscWHoChvPXC4VxuvozF5XL4cTE1jZGncs/o6QVqXPFZfRn8Th61SxpG/mzYhrNQ==
X-Received: by 2002:a1c:23cf:: with SMTP id j198mr6008695wmj.6.1604515339472; 
 Wed, 04 Nov 2020 10:42:19 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id 71sm3580651wrm.20.2020.11.04.10.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 10:42:18 -0800 (PST)
Date: Wed, 4 Nov 2020 13:42:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 21/31] virtio-iommu: Set supported page size mask
Message-ID: <20201104184040.285057-22-mst@redhat.com>
References: <20201104184040.285057-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104184040.285057-1-mst@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bharat Bhushan <bbhushan2@marvell.com>, Eric Auger <eric.auger@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bharat Bhushan <bbhushan2@marvell.com>

The virtio-iommu device can deal with arbitrary page sizes for virtual
endpoints, but for endpoints assigned with VFIO it must follow the page
granule used by the host IOMMU driver.

Implement the interface to set the vIOMMU page size mask, called by VFIO
for each endpoint. We assume that all host IOMMU drivers use the same
page granule (the host page granule). Override the page_size_mask field
in the virtio config space.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-Id: <20201030180510.747225-10-jean-philippe@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 50 ++++++++++++++++++++++++++++++++++++++++
 hw/virtio/trace-events   |  1 +
 2 files changed, 51 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 78e07aa40a..fc5c75d693 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -899,6 +899,55 @@ static int virtio_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu_mr,
     return 0;
 }
 
+/*
+ * The default mask (TARGET_PAGE_MASK) is the smallest supported guest granule,
+ * for example 0xfffffffffffff000. When an assigned device has page size
+ * restrictions due to the hardware IOMMU configuration, apply this restriction
+ * to the mask.
+ */
+static int virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
+                                           uint64_t new_mask,
+                                           Error **errp)
+{
+    IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
+    VirtIOIOMMU *s = sdev->viommu;
+    uint64_t cur_mask = s->config.page_size_mask;
+
+    trace_virtio_iommu_set_page_size_mask(mr->parent_obj.name, cur_mask,
+                                          new_mask);
+
+    if ((cur_mask & new_mask) == 0) {
+        error_setg(errp, "virtio-iommu page mask 0x%"PRIx64
+                   " is incompatible with mask 0x%"PRIx64, cur_mask, new_mask);
+        return -1;
+    }
+
+    /*
+     * After the machine is finalized, we can't change the mask anymore. If by
+     * chance the hotplugged device supports the same granule, we can still
+     * accept it. Having a different masks is possible but the guest will use
+     * sub-optimal block sizes, so warn about it.
+     */
+    if (qdev_hotplug) {
+        int new_granule = ctz64(new_mask);
+        int cur_granule = ctz64(cur_mask);
+
+        if (new_granule != cur_granule) {
+            error_setg(errp, "virtio-iommu page mask 0x%"PRIx64
+                       " is incompatible with mask 0x%"PRIx64, cur_mask,
+                       new_mask);
+            return -1;
+        } else if (new_mask != cur_mask) {
+            warn_report("virtio-iommu page mask 0x%"PRIx64
+                        " does not match 0x%"PRIx64, cur_mask, new_mask);
+        }
+        return 0;
+    }
+
+    s->config.page_size_mask &= new_mask;
+    return 0;
+}
+
 static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -1130,6 +1179,7 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
     imrc->translate = virtio_iommu_translate;
     imrc->replay = virtio_iommu_replay;
     imrc->notify_flag_changed = virtio_iommu_notify_flag_changed;
+    imrc->iommu_set_page_size_mask = virtio_iommu_set_page_size_mask;
 }
 
 static const TypeInfo virtio_iommu_info = {
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 982d0002a6..2060a144a2 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -109,6 +109,7 @@ virtio_iommu_fill_resv_property(uint32_t devid, uint8_t subtype, uint64_t start,
 virtio_iommu_notify_map(const char *name, uint64_t virt_start, uint64_t virt_end, uint64_t phys_start, uint32_t flags) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64" phys_start=0x%"PRIx64" flags=%d"
 virtio_iommu_notify_unmap(const char *name, uint64_t virt_start, uint64_t virt_end) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64
 virtio_iommu_remap(const char *name, uint64_t virt_start, uint64_t virt_end, uint64_t phys_start) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64" phys_start=0x%"PRIx64
+virtio_iommu_set_page_size_mask(const char *name, uint64_t old, uint64_t new) "mr=%s old_mask=0x%"PRIx64" new_mask=0x%"PRIx64
 virtio_iommu_notify_flag_add(const char *name) "add notifier to mr %s"
 virtio_iommu_notify_flag_del(const char *name) "del notifier from mr %s"
 
-- 
MST


