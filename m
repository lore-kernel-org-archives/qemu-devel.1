Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C7BC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:23:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E2DD221FE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cQhGCYAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2DD221FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQZd4-0004bc-UW
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 13:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kQZXD-0004jh-JJ
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:16:55 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kQZXC-0006eV-14
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:16:55 -0400
Received: by mail-wm1-x343.google.com with SMTP id l15so7216271wmh.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 10:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MBcMMP4Ua2k2Hsawb+KgncwLSiAkybM0QPyQamrDzng=;
 b=cQhGCYAksbtlKV5fVTngQBBHJnM5wvHFTUnjin/wrRSyu3dp/V4Ru57dsLeZS8ntIm
 8W68x4aLKaDH+zJstPU/eSxmZkiOu2TI99X2+ppDEUFFtdxo0QHu7D/cN8OvpLANd1tj
 TS1pIn0zokptu7dCp3mYJkVLkFEjh7g/IfgczAqw9l1TeVHJh+3HmO4/NiyobhiDqiyH
 xGqpHrFjOPYXQ60WznRuJdfFSS12VY7ljTEYqbuaMUhUbyIluFVlrG8Vp3QpqCy1nWdS
 I1fdgg1Hg7GX+XBNFe66WA9oQXqwdX+RrdwOnhmwkCJw7Lmy9FkHErH0EyED5tLEoput
 p1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MBcMMP4Ua2k2Hsawb+KgncwLSiAkybM0QPyQamrDzng=;
 b=P6Qi6YyCSrDM6YrYBDKizS7IhFfPhpwvuHhtQCMKyu3oP0vCZgsTfSQIchVOH2MMbl
 QoXNbBEBXA7xRUpyp+7yfJZMGcyfMLbtxUrKNMfA/LQrAJECcK8+zf7y6vBuAfcYeOsM
 4u93RXmKJg2iTTo0Ngk/oJNbWgfwKdlXp4KF/r06p9Qhg211Rp/lC5t0zB/r04Ly1+V0
 gmcD0lEkZODgoXrlhebJs33bda+x7pQs6M9IbavrHhzLtXc1vvrx0hsJaNuKR45+c1t5
 GPT7qAaawBitGtTU9u5GFC3Y26Xu/fXU26lgk21AfMXzGm+jABhjb1z+7Gn7jVFZ4Qsw
 fBTw==
X-Gm-Message-State: AOAM532XK+iuG7Jk8Ol9Y5HhCiKS2u/QZybE8nxY8wvR8bldvprMNEPT
 N4UY3vWlLsix3re1u8pOuxVlMQ==
X-Google-Smtp-Source: ABdhPJwZyBPp/LT5cmBkbGm2v3+sMkXAaevxR/o2y+UkDgTmn3IJiSXmrkWUggS6ci2wWNB4Qrxg3A==
X-Received: by 2002:a7b:c92c:: with SMTP id h12mr9138951wml.134.1602177412717; 
 Thu, 08 Oct 2020 10:16:52 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x1sm719413wrl.41.2020.10.08.10.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 10:16:52 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: eric.auger@redhat.com,
	alex.williamson@redhat.com
Subject: [PATCH v10 04/10] virtio-iommu: Call memory notifiers in attach/detach
Date: Thu,  8 Oct 2020 19:15:52 +0200
Message-Id: <20201008171558.410886-5-jean-philippe@linaro.org>
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

Call the memory notifiers when attaching an endpoint to a domain, to
replay existing mappings, and when detaching the endpoint, to remove all
mappings.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v10: Remove notifiers_list, rename callbacks
---
 hw/virtio/virtio-iommu.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index fcdf3a819f8..7e6e3cf5200 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -168,11 +168,39 @@ static void virtio_iommu_notify_unmap(IOMMUMemoryRegion *mr, hwaddr virt_start,
     memory_region_notify_iommu(mr, 0, entry);
 }
 
+static gboolean virtio_iommu_notify_unmap_cb(gpointer key, gpointer value,
+                                             gpointer data)
+{
+    VirtIOIOMMUInterval *interval = (VirtIOIOMMUInterval *) key;
+    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
+
+    virtio_iommu_notify_unmap(mr, interval->low, interval->high);
+
+    return false;
+}
+
+static gboolean virtio_iommu_notify_map_cb(gpointer key, gpointer value,
+                                           gpointer data)
+{
+    VirtIOIOMMUMapping *mapping = (VirtIOIOMMUMapping *) value;
+    VirtIOIOMMUInterval *interval = (VirtIOIOMMUInterval *) key;
+    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
+
+    virtio_iommu_notify_map(mr, interval->low, interval->high,
+                            mapping->phys_addr);
+
+    return false;
+}
+
 static void virtio_iommu_detach_endpoint_from_domain(VirtIOIOMMUEndpoint *ep)
 {
+    VirtIOIOMMUDomain *domain = ep->domain;
+
     if (!ep->domain) {
         return;
     }
+    g_tree_foreach(domain->mappings, virtio_iommu_notify_unmap_cb,
+                   ep->iommu_mr);
     QLIST_REMOVE(ep, next);
     ep->domain = NULL;
 }
@@ -315,6 +343,10 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
 
     ep->domain = domain;
 
+    /* Replay domain mappings on the associated memory region */
+    g_tree_foreach(domain->mappings, virtio_iommu_notify_map_cb,
+                   ep->iommu_mr);
+
     return VIRTIO_IOMMU_S_OK;
 }
 
-- 
2.28.0


