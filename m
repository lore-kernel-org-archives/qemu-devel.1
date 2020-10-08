Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E99C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31E3F204EF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rgYl28lo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E3F204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQZYy-0006ev-4F
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 13:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kQZXJ-0004wR-R7
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:17:01 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kQZXH-0006fh-W2
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:17:01 -0400
Received: by mail-wm1-x343.google.com with SMTP id d3so7298077wma.4
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 10:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7wgbcRbIFliMePbKm6Q5mkeuUC4ljzQPMAK2NaADXH4=;
 b=rgYl28lo9ds5EHPl0QJhjUSisk9hqTi+rpnJ+tzy1oNSxphqXM+RSDQ+kUTk5a3SeO
 OHw4Hr8d4NQsXhQdJI+0jRq8+kqTArBO47w2Kun2wxsye3bNsGj41MlpTcGYwOoGn6+0
 VT1detNeMxGshnx85IFnUMLBK7LmrvzT9bRDNoGSrJl1fMiPzRljktUvHXHPuqDAENzU
 HfCfYwdnjKaFLRy6+ctuyQNS9+qEvrn1IXRjdwBWizSiWOr6dloJjVJl6tEJ5/RqHua2
 A3clYucgXXTD5kUkD6lxjM+ka4Trt4ObNM7vRpFBhPu+aE0Ckiy5s1ohlfPKdjgk/KG1
 OxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7wgbcRbIFliMePbKm6Q5mkeuUC4ljzQPMAK2NaADXH4=;
 b=ZTwh1BpvyWMoKXh5fqjPfD2lwYBNbZspih0WowPYn8+/eovcyILFk6RcSlGfXjkD5A
 +bXcbJEoJoRSTUhoGWMch/WR0ca3THTLhW3nU5y2nNQUvyK7Ns6qbeWhPVQBKFTkmOqJ
 8THrf6QpdNu8W4BlPT16Wd5Hfw8H2FjFb5ETxYOYwvgRvkHg6zBwsrF8KiZdx/3Si4rV
 rfK+LjQ7bg94PyPmc10Gn1bSbtbvePIgGJRArS0WKyyG6P0qC5lGqSmhLSWFdLBZEw00
 7RjVme3J8XD+94GSxw63BcWoXAJ1jxSAZJZCo9ePEX4fK3fJiNUL9yJj2CM4pRMm75Co
 D3bw==
X-Gm-Message-State: AOAM533PoLcWfmVLLTl2iqLIZAJvhSoth/rtBZXf8MI9NI7yP3JbxLsF
 mTLrMsEofI/P7uw2sV1UGGzUDQ==
X-Google-Smtp-Source: ABdhPJw7Hs3XKpGnf7TX8L0e5srtXTzJGGpauZIcG45vs78HB+CHxcBJCukiCuECFnYOQ8zOoW8XDg==
X-Received: by 2002:a1c:b103:: with SMTP id a3mr10049448wmf.68.1602177418602; 
 Thu, 08 Oct 2020 10:16:58 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x1sm719413wrl.41.2020.10.08.10.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 10:16:57 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: eric.auger@redhat.com,
	alex.williamson@redhat.com
Subject: [PATCH v10 09/10] virtio-iommu: Set supported page size mask
Date: Thu,  8 Oct 2020 19:15:57 +0200
Message-Id: <20201008171558.410886-10-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008171558.410886-1-jean-philippe@linaro.org>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x343.google.com
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

The virtio-iommu device can deal with arbitrary page sizes for virtual
endpoints, but for endpoints assigned with VFIO it must follow the page
granule used by the host IOMMU driver.

Implement the interface to set the vIOMMU page size mask, called by VFIO
for each endpoint. We assume that all host IOMMU drivers use the same
page granule (the host page granule). Override the page_size_mask field
in the virtio config space.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v10: Use global page mask, allowing VFIO to override it until boot.
---
 hw/virtio/virtio-iommu.c | 51 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 8823bfc804a..dd0b3093d1b 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -914,6 +914,56 @@ static int virtio_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu_mr,
     return 0;
 }
 
+static int virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
+                                           uint64_t page_size_mask,
+                                           Error **errp)
+{
+    int new_granule, old_granule;
+    IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
+    VirtIOIOMMU *s = sdev->viommu;
+
+    if (!page_size_mask) {
+        return -1;
+    }
+
+    new_granule = ctz64(page_size_mask);
+    old_granule = ctz64(s->config.page_size_mask);
+
+    /*
+     * Modifying the page size after machine initialization isn't supported.
+     * Having a different mask is possible but the guest will use sub-optimal
+     * block sizes, so warn about it.
+     */
+    if (qdev_hotplug) {
+        if (new_granule != old_granule) {
+            error_setg(errp,
+                       "virtio-iommu page mask 0x%"PRIx64
+                       " is incompatible with mask 0x%"PRIx64,
+                       s->config.page_size_mask, page_size_mask);
+            return -1;
+        } else if (page_size_mask != s->config.page_size_mask) {
+            warn_report("virtio-iommu page mask 0x%"PRIx64
+                        " does not match 0x%"PRIx64,
+                        s->config.page_size_mask, page_size_mask);
+        }
+        return 0;
+    }
+
+    /*
+     * Disallow shrinking the page size. For example if an endpoint only
+     * supports 64kB pages, we can't globally enable 4kB pages. But that
+     * shouldn't happen, the host is unlikely to setup differing page granules.
+     * The other bits are only hints describing optimal block sizes.
+     */
+    if (new_granule < old_granule) {
+        error_setg(errp, "memory region shrinks the virtio-iommu page granule");
+        return -1;
+    }
+
+    s->config.page_size_mask = page_size_mask;
+    return 0;
+}
+
 static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -1146,6 +1196,7 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
     imrc->translate = virtio_iommu_translate;
     imrc->replay = virtio_iommu_replay;
     imrc->notify_flag_changed = virtio_iommu_notify_flag_changed;
+    imrc->iommu_set_page_size_mask = virtio_iommu_set_page_size_mask;
 }
 
 static const TypeInfo virtio_iommu_info = {
-- 
2.28.0


