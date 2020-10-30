Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BECC4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:07:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59D302227F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nasy0kWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D302227F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYYoN-0006qR-7L
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 14:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kYYmp-00058u-N3
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:06:05 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:39038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kYYmi-0004qU-U5
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:06:03 -0400
Received: by mail-wm1-x329.google.com with SMTP id d3so3744603wma.4
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 11:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CgsfmPEJUSprxXHS+NXfbp1mG3kP5a7TnQouVrlttaA=;
 b=nasy0kWmxeuCUKXqITCACoFBLGFhObiWEANa57TLgLljdkPGx1puu45zIc03VCDaWi
 yKejtuMHuAi16mfQ86p8C3hfNTMO6yr4rx3K9puCXMq97gN5JCF/rcPesHsolj+Y41Cd
 VAxpl51DW87YfdtfqNuk5mGynURvRTmewO/Qf4H3zheNjIi3BuzvXJSnUqEdmyoXVKoV
 UsU8pDB4KYsHUtZNUrwCU3v3J2O1vycrgxRh3vm7AquA4SnU1vWfdXgKfJ5ivHPNHZn2
 3NgBS0WUDOGViIDW5EIIkyt0gBv4j298dVV/RBhgpzeALTvq7rhcKU6nuxtS5hDChY/q
 kiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CgsfmPEJUSprxXHS+NXfbp1mG3kP5a7TnQouVrlttaA=;
 b=UtnG6/Hk/Zpz+1BksFMepG3UF2a96AcXqdGLLJ7OcEqD0cVq9AHWLPkCF2L4AZ3lLw
 06rVy6S2WhydsqTEP6f8smq9MmBiSG11dDTy+sm8Ec6fzmEfKJGYJ1XIGJ7cNK1ZWc1i
 NeVsxW9dt8oA44MMNIdTyZLgx6wKcY9XRpELgpQzJkWDbc3NC5x/cHqOKYCZNb0b5X2x
 ZByODBdahiWjzj6mhlFOLHDpq5TMObnxiN9dZ4t44xnCPwYeMSsVabm99eZ++A4p5LrZ
 FAgNhjZ344ycGcFaH+HeUP3rXVB0DItEGux3QIy2GjeKYhDTM8//WDRjZlpN8sAp+W2h
 sW6A==
X-Gm-Message-State: AOAM530oiqEJ9ZL6b0X7RvGOMBSj8uk7eNxHiTeN9u+UFC1I5W1lPJHO
 x1l+Sxfiy4Zm62tN9Xn2vNiNEw==
X-Google-Smtp-Source: ABdhPJwA7D6uabCwMlbOTwVvZ1JkO+5scqE+mxWLvTru4Z0E3jvTsQF+zhYvIbTEyDn6mUVwGNMfTw==
X-Received: by 2002:a1c:ddd7:: with SMTP id u206mr3464085wmg.27.1604081152746; 
 Fri, 30 Oct 2020 11:05:52 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u3sm10044438wro.33.2020.10.30.11.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 11:05:51 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: eric.auger@redhat.com,
	alex.williamson@redhat.com
Subject: [PATCH v11 05/10] virtio-iommu: Add replay() memory region callback
Date: Fri, 30 Oct 2020 19:05:05 +0100
Message-Id: <20201030180510.747225-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201030180510.747225-1-jean-philippe@linaro.org>
References: <20201030180510.747225-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x329.google.com
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

Implement the replay callback to setup all mappings for a new memory
region.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v11: Don't notify unmap before map, add permission flags
---
 hw/virtio/virtio-iommu.c | 40 ++++++++++++++++++++++++++++++++++++++++
 hw/virtio/trace-events   |  1 +
 2 files changed, 41 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 7b648923517..985257c88fd 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -847,6 +847,45 @@ static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
     return (ua > ub) - (ua < ub);
 }
 
+static gboolean virtio_iommu_remap(gpointer key, gpointer value, gpointer data)
+{
+    VirtIOIOMMUMapping *mapping = (VirtIOIOMMUMapping *) value;
+    VirtIOIOMMUInterval *interval = (VirtIOIOMMUInterval *) key;
+    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
+
+    trace_virtio_iommu_remap(mr->parent_obj.name, interval->low, interval->high,
+                             mapping->phys_addr);
+    virtio_iommu_notify_map(mr, interval->low, interval->high,
+                            mapping->phys_addr, mapping->flags);
+    return false;
+}
+
+static void virtio_iommu_replay(IOMMUMemoryRegion *mr, IOMMUNotifier *n)
+{
+    IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
+    VirtIOIOMMU *s = sdev->viommu;
+    uint32_t sid;
+    VirtIOIOMMUEndpoint *ep;
+
+    sid = virtio_iommu_get_bdf(sdev);
+
+    qemu_mutex_lock(&s->mutex);
+
+    if (!s->endpoints) {
+        goto unlock;
+    }
+
+    ep = g_tree_lookup(s->endpoints, GUINT_TO_POINTER(sid));
+    if (!ep || !ep->domain) {
+        goto unlock;
+    }
+
+    g_tree_foreach(ep->domain->mappings, virtio_iommu_remap, mr);
+
+unlock:
+    qemu_mutex_unlock(&s->mutex);
+}
+
 static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -1076,6 +1115,7 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
 
     imrc->translate = virtio_iommu_translate;
+    imrc->replay = virtio_iommu_replay;
 }
 
 static const TypeInfo virtio_iommu_info = {
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index b87a3974069..ea3c3b25ad7 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -108,6 +108,7 @@ virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpoint, uin
 virtio_iommu_fill_resv_property(uint32_t devid, uint8_t subtype, uint64_t start, uint64_t end) "dev= %d, type=%d start=0x%"PRIx64" end=0x%"PRIx64
 virtio_iommu_notify_map(const char *name, uint64_t virt_start, uint64_t virt_end, uint64_t phys_start, uint32_t flags) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64" phys_start=0x%"PRIx64" flags=%d"
 virtio_iommu_notify_unmap(const char *name, uint64_t virt_start, uint64_t virt_end) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64
+virtio_iommu_remap(const char *name, uint64_t virt_start, uint64_t virt_end, uint64_t phys_start) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64" phys_start=0x%"PRIx64
 
 # virtio-mem.c
 virtio_mem_send_response(uint16_t type) "type=%" PRIu16
-- 
2.29.1


