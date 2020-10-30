Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049FCC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DF39206E5
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D3iCA7Ty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF39206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYYrW-0003ob-Ca
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 14:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kYYmx-00059t-0C
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:06:11 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kYYmi-0004qn-UI
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:06:09 -0400
Received: by mail-wm1-x342.google.com with SMTP id e2so3756650wme.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 11:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ef4X5GDU46mHK5Ifa4jRh1y2HrDd3BRHGBVmcwvvC1M=;
 b=D3iCA7TyC2/fLSoOAU3HkjFQRW9DGyLVcztyJuZ4q2zNGgFJzkvd4aZbLPvI4tBdsD
 uSfwCkAV65ZMU/yBRomGlj/svfHckWeMx9xgPxkmnr0dGZZHURrHPBPse2K3vy8Tn7Bs
 3sc5W1zK8o4C0jqSskg5Y6fcywZRg9MItLNKRpRv/WXOMrlCRVQ3A/ADQjeAzxCG9/6K
 GfxHXYBu+XBtatWPvTKReTb0zl5YY+aQdA4MKBcc3SMwSKE0ty/47T6PMVVKgH1BO3Ig
 6o2xL3HLcpwB+cw9J+zucU2PEMUOsfrcUxNvMHJpwpZYguT/bNuhh/dIDDk69TEumi/l
 VUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ef4X5GDU46mHK5Ifa4jRh1y2HrDd3BRHGBVmcwvvC1M=;
 b=hGmfkLYgi7NX1sx/9zN2Uug0IkdoGN2knXDLm0LllVRExGj738qF8YXMEikVsejjTo
 Yr5FKLE/avjVald/awpzF6BdNdsHL4P4aTJM637edFZlZLk5dg1sNIfBYZNP3SfeDR1A
 I780SiTOlRXnDvTpGWC0bYSjJJ8RdB7qGHw13lC4hH2nIH/a+KidYL1KDfax77grBn34
 /hye4Q0xDYvzUN+lBOp95CzIVnViFyKAT2gSGJNZVqFOAurmHlAEhxCFcDLMUndpfshr
 6H99Us/HmIlAAxPTDXXZUj8f+6wDgU7H6dMlGXnXTasZfquVHv5XDa4DUjkVf+eLP4JG
 d1pA==
X-Gm-Message-State: AOAM530Lp/28zsTqLLaT0/2+q0Tzdk+ncccrB/KE7wCIYUxwfX1aB7Zl
 sqhJYKR8rRqWi9k/UXH7t5Eo8g==
X-Google-Smtp-Source: ABdhPJyvjrVBuvWTLr1pBGxHh3iCxmc1/5yhCR4ruJjTbwytJSb8BSBlxnjnOMRAY5r0WFkO3t7MDg==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr4098589wmj.149.1604081155108; 
 Fri, 30 Oct 2020 11:05:55 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u3sm10044438wro.33.2020.10.30.11.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 11:05:54 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: eric.auger@redhat.com,
	alex.williamson@redhat.com
Subject: [PATCH v11 07/10] memory: Add interface to set iommu page size mask
Date: Fri, 30 Oct 2020 19:05:07 +0100
Message-Id: <20201030180510.747225-8-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201030180510.747225-1-jean-philippe@linaro.org>
References: <20201030180510.747225-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x342.google.com
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, mst@redhat.com,
 qemu-devel@nongnu.org, peterx@redhat.com, pbonzini@redhat.com,
 bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bharat Bhushan <bbhushan2@marvell.com>

Allow to set the page size mask supported by an iommu memory region.
This enables a vIOMMU to communicate the page size granule supported by
an assigned device, on hosts that use page sizes greater than 4kB.

Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v11: improve comment
---
 include/exec/memory.h | 38 ++++++++++++++++++++++++++++++++++++++
 softmmu/memory.c      | 13 +++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index aff6ef76053..0f3e6bcd5e7 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -397,6 +397,32 @@ struct IOMMUMemoryRegionClass {
      * @iommu: the IOMMUMemoryRegion
      */
     int (*num_indexes)(IOMMUMemoryRegion *iommu);
+
+    /**
+     * @iommu_set_page_size_mask:
+     *
+     * Restrict the page size mask that can be supported with a given IOMMU
+     * memory region. Used for example to propagate host physical IOMMU page
+     * size mask limitations to the virtual IOMMU.
+     *
+     * Optional method: if this method is not provided, then the default global
+     * page mask is used.
+     *
+     * @iommu: the IOMMUMemoryRegion
+     *
+     * @page_size_mask: a bitmask of supported page sizes. At least one bit,
+     * representing the smallest page size, must be set. Additional set bits
+     * represent supported block sizes. For example a host physical IOMMU that
+     * uses page tables with a page size of 4kB, and supports 2MB and 4GB
+     * blocks, will set mask 0x40201000. A granule of 4kB with indiscriminate
+     * block sizes is specified with mask 0xfffffffffffff000.
+     *
+     * Returns 0 on success, or a negative error. In case of failure, the error
+     * object must be created.
+     */
+     int (*iommu_set_page_size_mask)(IOMMUMemoryRegion *iommu,
+                                     uint64_t page_size_mask,
+                                     Error **errp);
 };
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
@@ -1409,6 +1435,18 @@ int memory_region_iommu_attrs_to_index(IOMMUMemoryRegion *iommu_mr,
  */
 int memory_region_iommu_num_indexes(IOMMUMemoryRegion *iommu_mr);
 
+/**
+ * memory_region_iommu_set_page_size_mask: set the supported page
+ * sizes for a given IOMMU memory region
+ *
+ * @iommu_mr: IOMMU memory region
+ * @page_size_mask: supported page size mask
+ * @errp: pointer to Error*, to store an error if it happens.
+ */
+int memory_region_iommu_set_page_size_mask(IOMMUMemoryRegion *iommu_mr,
+                                           uint64_t page_size_mask,
+                                           Error **errp);
+
 /**
  * memory_region_name: get a memory region's name
  *
diff --git a/softmmu/memory.c b/softmmu/memory.c
index ee4a6bc1685..bb40d2a1d8b 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1841,6 +1841,19 @@ static int memory_region_update_iommu_notify_flags(IOMMUMemoryRegion *iommu_mr,
     return ret;
 }
 
+int memory_region_iommu_set_page_size_mask(IOMMUMemoryRegion *iommu_mr,
+                                           uint64_t page_size_mask,
+                                           Error **errp)
+{
+    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
+    int ret = 0;
+
+    if (imrc->iommu_set_page_size_mask) {
+        ret = imrc->iommu_set_page_size_mask(iommu_mr, page_size_mask, errp);
+    }
+    return ret;
+}
+
 int memory_region_register_iommu_notifier(MemoryRegion *mr,
                                           IOMMUNotifier *n, Error **errp)
 {
-- 
2.29.1


