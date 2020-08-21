Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C169C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B0ED20724
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kO3g8v1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0ED20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k99xd-0001o9-Us
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 12:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1k99vz-0007ut-Ri
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:30:33 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:34488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1k99vv-0006oC-KG
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:30:31 -0400
Received: by mail-ed1-x543.google.com with SMTP id bs17so1953410edb.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 09:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TxGD9EzF0atjNPI3j2WNYptRLPX7AMvR+MeE+NZH67c=;
 b=kO3g8v1q0f7H3hTLphPPV3FBTUrC4poIBwQrOkiQ5YjlAeyRY/IITAyhLYuiRHSXFh
 c3NB7mo/7qnxxY/ihLkoHeg8/18q0nDWDfDvZuTYey8yKzlZcJEYC9/66cwVdlh+OX7U
 jhLvNcpG5ypJgcmlWNVnt5AaCZlW4+HeWmhgbH2XU5tvjoK873ogHchZCoenXe8LOSz2
 Ib1y+dHARnQqGYhJvd+MY35KiSc2wo5OaMJhxH3tgOqL3D+lvm57Y83p9XbSaq1v6wGa
 V7Fnj00TSWZCNfJEVuJfUain8Ra5POsr34dzX3JUFm5IQBuwzAxtpVrInvLTZ1q+G93O
 IR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TxGD9EzF0atjNPI3j2WNYptRLPX7AMvR+MeE+NZH67c=;
 b=mAEEyQwQ5S6hCRNwCtoIiJgSemV0vbi+nPO2NHQYbyMZD88jw2Qx/0xlkmBJHAo3eu
 DP8UgH05KipkRwhQZiCx8FwRM5MwfB3O78kQC0McvhmDdQkD2/Fx8p+QP5Kd5MDWzDth
 OERRsJEc7rZbRJ6nIGxItYadLC5wOArNJ0EfiLA7TwB0kiR0r2bFF2RaWeleM68eFMdV
 E6hWoe8Ek4jelsXKluE2Sa+ocB6pAhVfnOdMDkdQMzn+j70/K295L+8F60bbAcud4ZTq
 MIQPnN+ZYm3yOd1S8MR4g9vuLlMxAHcF7iJcfRZcEowgA/azTQvarc8cC+droDQVJ2ot
 mBXg==
X-Gm-Message-State: AOAM533+AGori5fcyasXzfuEX3LwoqvUzcwthg/0WrSoZH7TrBfsLxcy
 eiGAu/LbmiL1Xu0u2mhvGeHWcw==
X-Google-Smtp-Source: ABdhPJwtORdgeJH4zWU3nHnM9Cze/sPsDJdTJdTCj5radZQVQ3aEsuBnpSYyPoFftZY3NC/vPuMnYw==
X-Received: by 2002:a05:6402:22ab:: with SMTP id
 cx11mr3816150edb.102.1598027426267; 
 Fri, 21 Aug 2020 09:30:26 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id dk28sm1398030edb.90.2020.08.21.09.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 09:30:25 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/5] virtio-iommu: Declare topology in config space
Date: Fri, 21 Aug 2020 18:28:37 +0200
Message-Id: <20200821162839.3182051-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821162839.3182051-1-jean-philippe@linaro.org>
References: <20200821162839.3182051-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=jean-philippe@linaro.org; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, mst@redhat.com,
 eric.auger@redhat.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When requested on the command-line, by adding topology=on to the
virtio-iommu device, provide the IOMMU topology in the virtio config
space. It describes which endpoints are managed by the IOMMU - all PCI
devices - and allows to support:
* virtio-iommu for platforms without ACPI or DT (e.g. microvm),
* virtio-iommu for ACPI platforms, temporarily. A new ACPI table will be
  introduced to handle those, but this provides a boot method in the
  meantime.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/hw/virtio/virtio-iommu.h |  3 +++
 hw/virtio/virtio-iommu.c         | 40 ++++++++++++++++++++++++++++----
 hw/virtio/trace-events           |  4 ++--
 3 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index ae57efab1f3..7ba1dacf75d 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -49,6 +49,7 @@ typedef struct VirtIOIOMMU {
     VirtQueue *req_vq;
     VirtQueue *event_vq;
     struct virtio_iommu_config config;
+    struct virtio_iommu_topo_pci_range pci_topo;
     uint64_t features;
     GHashTable *as_by_busptr;
     IOMMUPciBus *iommu_pcibus_by_bus_num[PCI_BUS_MAX];
@@ -59,6 +60,8 @@ typedef struct VirtIOIOMMU {
     QemuMutex mutex;
     GTree *endpoints;
     bool boot_bypass;
+    /* Declare topology in config space */
+    bool topology;
 } VirtIOIOMMU;
 
 #endif
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 3b821fc005d..08ab457ccf1 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -731,15 +731,24 @@ unlock:
 
 static void virtio_iommu_get_config(VirtIODevice *vdev, uint8_t *config_data)
 {
+    off_t offset;
     VirtIOIOMMU *dev = VIRTIO_IOMMU(vdev);
     struct virtio_iommu_config *config = &dev->config;
+    struct virtio_iommu_topo_pci_range *pci_topo = &dev->pci_topo;
 
     trace_virtio_iommu_get_config(config->page_size_mask,
                                   config->input_range.start,
                                   config->input_range.end,
                                   config->domain_range.end,
-                                  config->probe_size);
-    memcpy(config_data, &dev->config, sizeof(struct virtio_iommu_config));
+                                  config->probe_size,
+                                  config->topo_config.offset,
+                                  config->topo_config.count);
+    memcpy(config_data, config, sizeof(*config));
+
+    offset = config->topo_config.offset;
+    if (offset) {
+        memcpy(config_data + offset, pci_topo, sizeof(*pci_topo));
+    }
 }
 
 static void virtio_iommu_set_config(VirtIODevice *vdev,
@@ -747,12 +756,14 @@ static void virtio_iommu_set_config(VirtIODevice *vdev,
 {
     struct virtio_iommu_config config;
 
-    memcpy(&config, config_data, sizeof(struct virtio_iommu_config));
+    memcpy(&config, config_data, sizeof(config));
     trace_virtio_iommu_set_config(config.page_size_mask,
                                   config.input_range.start,
                                   config.input_range.end,
                                   config.domain_range.end,
-                                  config.probe_size);
+                                  config.probe_size,
+                                  config.topo_config.offset,
+                                  config.topo_config.count);
 }
 
 static uint64_t virtio_iommu_get_features(VirtIODevice *vdev, uint64_t f,
@@ -776,9 +787,10 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOIOMMU *s = VIRTIO_IOMMU(dev);
+    size_t aligned_config_size = QEMU_ALIGN_UP(sizeof(s->config), 8);
 
     virtio_init(vdev, "virtio-iommu", VIRTIO_ID_IOMMU,
-                sizeof(struct virtio_iommu_config));
+                aligned_config_size + sizeof(s->pci_topo));
 
     memset(s->iommu_pcibus_by_bus_num, 0, sizeof(s->iommu_pcibus_by_bus_num));
 
@@ -791,6 +803,12 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
     s->config.domain_range.end = 32;
     s->config.probe_size = VIOMMU_PROBE_SIZE;
 
+    if (s->topology) {
+        s->config.topo_config.offset = aligned_config_size;
+        s->config.topo_config.count = 1;
+        virtio_add_feature(&s->features, VIRTIO_IOMMU_F_TOPOLOGY);
+    }
+
     virtio_add_feature(&s->features, VIRTIO_RING_F_EVENT_IDX);
     virtio_add_feature(&s->features, VIRTIO_RING_F_INDIRECT_DESC);
     virtio_add_feature(&s->features, VIRTIO_F_VERSION_1);
@@ -810,6 +828,17 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
     } else {
         error_setg(errp, "VIRTIO-IOMMU is not attached to any PCI bus!");
     }
+
+    if (s->topology) {
+        s->pci_topo = (struct virtio_iommu_topo_pci_range) {
+            .type               = cpu_to_le16(VIRTIO_IOMMU_TOPO_PCI_RANGE),
+            .length             = cpu_to_le16(sizeof(s->pci_topo)),
+            .endpoint_start     = 0,
+            .segment            = 0,
+            .bdf_start          = 0,
+            .bdf_end            = 0xffff,
+        };
+    }
 }
 
 static void virtio_iommu_device_unrealize(DeviceState *dev)
@@ -965,6 +994,7 @@ static const VMStateDescription vmstate_virtio_iommu = {
 static Property virtio_iommu_properties[] = {
     DEFINE_PROP_LINK("primary-bus", VirtIOIOMMU, primary_bus, "PCI", PCIBus *),
     DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
+    DEFINE_PROP_BOOL("topology", VirtIOIOMMU, topology, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 045e89cae69..6c5830ca47c 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -59,8 +59,8 @@ virtio_mmio_setting_irq(int level) "virtio_mmio setting IRQ %d"
 virtio_iommu_device_reset(void) "reset!"
 virtio_iommu_get_features(uint64_t features) "device supports features=0x%"PRIx64
 virtio_iommu_device_status(uint8_t status) "driver status = %d"
-virtio_iommu_get_config(uint64_t page_size_mask, uint64_t start, uint64_t end, uint32_t domain_range, uint32_t probe_size) "page_size_mask=0x%"PRIx64" start=0x%"PRIx64" end=0x%"PRIx64" domain_range=%d probe_size=0x%x"
-virtio_iommu_set_config(uint64_t page_size_mask, uint64_t start, uint64_t end, uint32_t domain_range, uint32_t probe_size) "page_size_mask=0x%"PRIx64" start=0x%"PRIx64" end=0x%"PRIx64" domain_bits=%d probe_size=0x%x"
+virtio_iommu_get_config(uint64_t page_size_mask, uint64_t start, uint64_t end, uint32_t domain_range, uint32_t probe_size, uint16_t topo_offset, uint16_t topo_count) "page_size_mask=0x%"PRIx64" start=0x%"PRIx64" end=0x%"PRIx64" domain_range=%d probe_size=0x%x topo_off=0x%x topo_count=%u"
+virtio_iommu_set_config(uint64_t page_size_mask, uint64_t start, uint64_t end, uint32_t domain_range, uint32_t probe_size, uint16_t topo_offset, uint16_t topo_count) "page_size_mask=0x%"PRIx64" start=0x%"PRIx64" end=0x%"PRIx64" domain_bits=%d probe_size=0x%x topo_off=0x%x topo_count=%u"
 virtio_iommu_attach(uint32_t domain_id, uint32_t ep_id) "domain=%d endpoint=%d"
 virtio_iommu_detach(uint32_t domain_id, uint32_t ep_id) "domain=%d endpoint=%d"
 virtio_iommu_map(uint32_t domain_id, uint64_t virt_start, uint64_t virt_end, uint64_t phys_start, uint32_t flags) "domain=%d virt_start=0x%"PRIx64" virt_end=0x%"PRIx64 " phys_start=0x%"PRIx64" flags=%d"
-- 
2.28.0


