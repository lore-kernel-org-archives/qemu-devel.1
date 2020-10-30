Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1530DC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E376206E5
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xlBHFdmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E376206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYYra-0003vQ-EP
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 14:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kYYmo-000587-1f
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:06:03 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:45394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kYYmf-0004q3-2V
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:05:58 -0400
Received: by mail-wr1-x42e.google.com with SMTP id a9so7413718wrg.12
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 11:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ej1fodcMaFb0u/aG6D5WFwOmMShNXQ/JZRK7Jgg8zcU=;
 b=xlBHFdmhXjztVOxAH++ajnfav437zwW1ucZZwyrJKmfe8GNEdDAGnDR+ZkyT6SVz/v
 esCnG92y5+82iM778VESCuSyABhC+Bjse0dy3G8LYRYP9GN7N5NWyWmAGdGbav9cw/2W
 E+lJxMXFZuo4ENIntUCbHWEGxDBv5CwF0nuxhjoNM6L2p8uYoSCQpgXzKjLuWaAv7BTg
 RlG1eA2NwkLyf5QhDpxfpWrM8Q8k5FHNYbgcSTNgSdz/jUTV52zUMID+Uxpa5sOHkCos
 cLuBl5Y/1xiaU574aaBeXQh4h5R8DVY4JyoQIPDsws/GltTK4PiEomQfs5epJkFy3Arz
 DLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ej1fodcMaFb0u/aG6D5WFwOmMShNXQ/JZRK7Jgg8zcU=;
 b=ual1/JxYYhxFZHt42anllGgvrmLndH/C638zvzCV4950IqeoViTIhY6nrrfZPOOLnP
 205D1i+0uia5DYL3tXM3KDPXMh2/wh8BlBadQKNZR3Cox4+hRc//FoEIwepU9rJhL0Wp
 Bz38B98LEoFeC0lxN3eKfu9/Xjs0sBbYOiicIUzxLhWOpWu3+IIHf3Q7KHPhODRUruPA
 7COcdNF0Ks0SiCPse5/xO0baji8jgh8FfG6d7dpYZy49PLMMjinIhvqfkzzqwt/XXufO
 w5U8f6qA4VyVetFc9oPTfpq2QztwJgVdAkCMuR6QCDMHWi1EnaFvLc0mJHcKLuAKlSUt
 Py0Q==
X-Gm-Message-State: AOAM532tH9SQMmd42Eveb/Y3DEC8WaqW+ILOgqdXw8qG6kK6aDe21Qbd
 uksasJtuDEKflfqjlgKkeO2Stg==
X-Google-Smtp-Source: ABdhPJzTChbKCWnZ4AHdX0vjIlWD00tnrSOJrTIdekAes8OFpua+LUu3B2xS/66oyVhrrZdxhSbNHw==
X-Received: by 2002:adf:ec47:: with SMTP id w7mr4714098wrn.253.1604081150164; 
 Fri, 30 Oct 2020 11:05:50 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u3sm10044438wro.33.2020.10.30.11.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 11:05:49 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: eric.auger@redhat.com,
	alex.williamson@redhat.com
Subject: [PATCH v11 03/10] virtio-iommu: Add memory notifiers for map/unmap
Date: Fri, 30 Oct 2020 19:05:03 +0100
Message-Id: <20201030180510.747225-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201030180510.747225-1-jean-philippe@linaro.org>
References: <20201030180510.747225-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, mst@redhat.com,
 qemu-devel@nongnu.org, peterx@redhat.com, pbonzini@redhat.com,
 bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bharat Bhushan <bbhushan2@marvell.com>

Extend VIRTIO_IOMMU_T_MAP/UNMAP request to notify memory listeners. It
will call VFIO notifier to map/unmap regions in the physical IOMMU.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v11:
* Forward permissions from the MAP request
* Don't notify MMIO mappings
---
 hw/virtio/virtio-iommu.c | 56 ++++++++++++++++++++++++++++++++++++++++
 hw/virtio/trace-events   |  2 ++
 2 files changed, 58 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index a5c2d69aad6..7dd15c5eacd 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -125,6 +125,51 @@ static gint interval_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
     }
 }
 
+static void virtio_iommu_notify_map(IOMMUMemoryRegion *mr, hwaddr virt_start,
+                                    hwaddr virt_end, hwaddr paddr,
+                                    uint32_t flags)
+{
+    IOMMUTLBEntry entry;
+    IOMMUAccessFlags perm = IOMMU_ACCESS_FLAG(flags & VIRTIO_IOMMU_MAP_F_READ,
+                                              flags & VIRTIO_IOMMU_MAP_F_WRITE);
+
+    if (!(mr->iommu_notify_flags & IOMMU_NOTIFIER_MAP) ||
+        (flags & VIRTIO_IOMMU_MAP_F_MMIO) || !perm) {
+        return;
+    }
+
+    trace_virtio_iommu_notify_map(mr->parent_obj.name, virt_start, virt_end,
+                                  paddr, perm);
+
+    entry.target_as = &address_space_memory;
+    entry.addr_mask = virt_end - virt_start;
+    entry.iova = virt_start;
+    entry.perm = perm;
+    entry.translated_addr = paddr;
+
+    memory_region_notify_iommu(mr, 0, entry);
+}
+
+static void virtio_iommu_notify_unmap(IOMMUMemoryRegion *mr, hwaddr virt_start,
+                                      hwaddr virt_end)
+{
+    IOMMUTLBEntry entry;
+
+    if (!(mr->iommu_notify_flags & IOMMU_NOTIFIER_UNMAP)) {
+        return;
+    }
+
+    trace_virtio_iommu_notify_unmap(mr->parent_obj.name, virt_start, virt_end);
+
+    entry.target_as = &address_space_memory;
+    entry.addr_mask = virt_end - virt_start;
+    entry.iova = virt_start;
+    entry.perm = IOMMU_NONE;
+    entry.translated_addr = 0;
+
+    memory_region_notify_iommu(mr, 0, entry);
+}
+
 static void virtio_iommu_detach_endpoint_from_domain(VirtIOIOMMUEndpoint *ep)
 {
     if (!ep->domain) {
@@ -315,6 +360,7 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
     VirtIOIOMMUDomain *domain;
     VirtIOIOMMUInterval *interval;
     VirtIOIOMMUMapping *mapping;
+    VirtIOIOMMUEndpoint *ep;
 
     if (flags & ~VIRTIO_IOMMU_MAP_F_MASK) {
         return VIRTIO_IOMMU_S_INVAL;
@@ -344,6 +390,11 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
 
     g_tree_insert(domain->mappings, interval, mapping);
 
+    QLIST_FOREACH(ep, &domain->endpoint_list, next) {
+        virtio_iommu_notify_map(ep->iommu_mr, virt_start, virt_end, phys_start,
+                                flags);
+    }
+
     return VIRTIO_IOMMU_S_OK;
 }
 
@@ -356,6 +407,7 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
     VirtIOIOMMUMapping *iter_val;
     VirtIOIOMMUInterval interval, *iter_key;
     VirtIOIOMMUDomain *domain;
+    VirtIOIOMMUEndpoint *ep;
     int ret = VIRTIO_IOMMU_S_OK;
 
     trace_virtio_iommu_unmap(domain_id, virt_start, virt_end);
@@ -373,6 +425,10 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
         uint64_t current_high = iter_key->high;
 
         if (interval.low <= current_low && interval.high >= current_high) {
+            QLIST_FOREACH(ep, &domain->endpoint_list, next) {
+                virtio_iommu_notify_unmap(ep->iommu_mr, current_low,
+                                          current_high);
+            }
             g_tree_remove(domain->mappings, iter_key);
             trace_virtio_iommu_unmap_done(domain_id, current_low, current_high);
         } else {
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index cf1e59de302..b87a3974069 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -106,6 +106,8 @@ virtio_iommu_put_domain(uint32_t domain_id) "Free domain=%d"
 virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, uint32_t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=%d"
 virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpoint, uint64_t addr) "FAULT reason=%d flags=%d endpoint=%d address =0x%"PRIx64
 virtio_iommu_fill_resv_property(uint32_t devid, uint8_t subtype, uint64_t start, uint64_t end) "dev= %d, type=%d start=0x%"PRIx64" end=0x%"PRIx64
+virtio_iommu_notify_map(const char *name, uint64_t virt_start, uint64_t virt_end, uint64_t phys_start, uint32_t flags) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64" phys_start=0x%"PRIx64" flags=%d"
+virtio_iommu_notify_unmap(const char *name, uint64_t virt_start, uint64_t virt_end) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64
 
 # virtio-mem.c
 virtio_mem_send_response(uint16_t type) "type=%" PRIu16
-- 
2.29.1


