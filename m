Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B6BC43457
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:23:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D853221FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W8K24xAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D853221FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQZd7-0004eL-0o
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 13:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kQZXH-0004qG-1S
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:16:59 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44870)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kQZXF-0006fM-DC
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:16:58 -0400
Received: by mail-wr1-x444.google.com with SMTP id t9so7447621wrq.11
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+aXjyG0i9oQTA80CkQjiRbI+6mZLaGZ14n2CNbod0io=;
 b=W8K24xAan3nU461ZtUCOJDnTvMW8hiJpuiuR+l0BiT6hp/MaLrTs/mPdK610q8iff2
 h3khiJ/AvmxtnO4UGE38f0TRsVf2rjop4Um+LPsUl6Z/ZlH9fg32zkrxnKgQzdJyykim
 6wjoUqhW/Y7i3rM00i4OC7eW7UKkFzH99i0evDP/FbclG0ywi7wMD0wBbeAWe3q9qkY9
 PHpAtwv/derzbP7jZhq5YhfMP3NhnMc4ssIDudguGfaP/q+V43PVamSJld+8P5halW1i
 Ikz7qqp7h4q0269BwbLLz7VLstT8b2emi5chL4K2B0Kjr1tzaNZFU02w7yVlkfijETzR
 B/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+aXjyG0i9oQTA80CkQjiRbI+6mZLaGZ14n2CNbod0io=;
 b=NwQOtu8ehBpg3olmQrzQ8M3hBJAjJ22snwxs/wbuoIf1taYjQzYPPMQSSBbCX7Ab/c
 BxEbhq0pn4i2BBTlXbM7pe5RqKkGiuPEndq8E2fPSjnyx12Hy8iB20yCDtrfD/E295aT
 l9UoyjAR2gBZOT6AN3FeUtLV9Vzi8wtev+n04IxQ6pqD4n+Eshdv4PqIYhr9HnAxaG+s
 WLvBI2Hkvw5hPyhZLhvaRSOH+KxqFrSARiGH7M87ynzTFkx0doBE7cwoblOOMIekQhIA
 IZqeAp7nAJZy+VCSBe+2clqXqtjZI3/MyKPdGKaBb1tsyxPr+iTja31iY4nKDczuzZB0
 /w9Q==
X-Gm-Message-State: AOAM530Oxq7AD/ESXr4P9ejEQK3FqisyMud9TgbbwaBRdx2Z3LBmroLw
 1hASNrGhtQSL6P6yhDBtjPg8Jw==
X-Google-Smtp-Source: ABdhPJxoYgK5NxUIsI+NyZx99DfZ0TKTcLWZnW0VkuBDeHAa7nLJ/VEaTVU+dl3Zhbk8KvWiTNOdCg==
X-Received: by 2002:a5d:5482:: with SMTP id h2mr1057165wrv.165.1602177416053; 
 Thu, 08 Oct 2020 10:16:56 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x1sm719413wrl.41.2020.10.08.10.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 10:16:55 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: eric.auger@redhat.com,
	alex.williamson@redhat.com
Subject: [PATCH v10 07/10] memory: Add interface to set iommu page size mask
Date: Thu,  8 Oct 2020 19:15:55 +0200
Message-Id: <20201008171558.410886-8-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008171558.410886-1-jean-philippe@linaro.org>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x444.google.com
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

Allow to set the page size mask supported by an iommu memory region.
This enables a vIOMMU to communicate the page size granule supported by
an assigned device, on hosts that use page sizes greater than 4kB.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v10: Add errp parameter
---
 include/exec/memory.h | 26 ++++++++++++++++++++++++++
 softmmu/memory.c      | 13 +++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index dee09851622..c2da8381bec 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -382,6 +382,20 @@ struct IOMMUMemoryRegionClass {
      * @iommu: the IOMMUMemoryRegion
      */
     int (*num_indexes)(IOMMUMemoryRegion *iommu);
+
+    /*
+     * Set supported IOMMU page size
+     *
+     * If supported, allows to restrict the page size mask that can be supported
+     * with a given IOMMU memory region. For example, to propagate host physical
+     * IOMMU page size mask limitations to the virtual IOMMU.
+     *
+     * Returns 0 on success, or a negative error. In case of failure, the error
+     * object must be created.
+     */
+     int (*iommu_set_page_size_mask)(IOMMUMemoryRegion *iommu,
+                                     uint64_t page_size_mask,
+                                     Error **errp);
 };
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
@@ -1389,6 +1403,18 @@ int memory_region_iommu_attrs_to_index(IOMMUMemoryRegion *iommu_mr,
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
index fa280a19f7f..5c855a02704 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1811,6 +1811,19 @@ static int memory_region_update_iommu_notify_flags(IOMMUMemoryRegion *iommu_mr,
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
2.28.0


