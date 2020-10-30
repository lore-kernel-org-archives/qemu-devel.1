Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4BEC55178
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 952E8206E5
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XrBSSSMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952E8206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYYoL-0006l4-8i
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 14:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kYYml-00056t-7s
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:05:59 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kYYmf-0004qM-2l
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:05:56 -0400
Received: by mail-wr1-x442.google.com with SMTP id n18so7437728wrs.5
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 11:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Eu3dQfIpFEu6odtk6adJYWVijDRkJcSgv2bG/hnjotM=;
 b=XrBSSSMPcfWhvaAs8QTr5lBqsN4ERI5rf+hGVeIS5zfAtMFkPI6SICPchaJ2Qz2Sw8
 cCra2I84SkoRrWOC/6LBDtAnpZrF623k3vGQ7u7dzccO4FbimAP6IWajfpLUrUe1T4up
 33xU59uBRu41iFm0FHx0MQpP2nFgvu9PXUxLlZmwqZno//LI02YRC6x7MgjpZNA69m90
 r36iQtBo9DOEmpwcvLev6wkmlQMWKIus7E3y56+zhley0X50nLKc85Wl4nr6rOw4L8/d
 3ys44RB5elYj5DlkxnmxDynhZh1ie5L0echLmU0Sx7Sy0Ay8N6q3q9nW6u1HPUEeim7X
 lv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Eu3dQfIpFEu6odtk6adJYWVijDRkJcSgv2bG/hnjotM=;
 b=GHxTfKvroq58hTQV+YOiyCbJUl1o1adlHuoOmbJSrN+Yo6EkskS/270Cz1tdikSdGl
 Qou5F0E6LIqGIpeyM09phTJpSr8DiV1+4Gihv1dnI/uOzQ/QpfkoQyPS2uBqkp5gw+QT
 uqVKAlthU46Egka9JPchrm9QuRLXxMmX6HXs2PQKnppYcTUNZhMYDzl/7rSYi3Rv4tSo
 ji5yZ/RW0/yFZdLCjWzPos47qo4F/Lp1jMI8hDFSg4YeZlIn5UCy7aFw10Ab2gqELFVb
 6Mi/H8dhWMUx3hnW0598aH0Wo9qngF0oFEOpuE8sDQZfh3vhNjcPfkRjSctwmLIzcMqz
 E/uA==
X-Gm-Message-State: AOAM531xhMj2WqhPe/x625/wTrXZi5UDS4VgSs5QqetPw7eaTG/DEM5Q
 sMwf+L/osHXVlykgp5xMR0DzSA==
X-Google-Smtp-Source: ABdhPJx+XjjSXEOXZYplqrc43yAVnyTh1mNU8ls3qpMzwlgsVmYkvFiDTL1adBk019yPq/WEmiYZXA==
X-Received: by 2002:a05:6000:83:: with SMTP id
 m3mr4465518wrx.147.1604081151314; 
 Fri, 30 Oct 2020 11:05:51 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u3sm10044438wro.33.2020.10.30.11.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 11:05:50 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: eric.auger@redhat.com,
	alex.williamson@redhat.com
Subject: [PATCH v11 04/10] virtio-iommu: Call memory notifiers in attach/detach
Date: Fri, 30 Oct 2020 19:05:04 +0100
Message-Id: <20201030180510.747225-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201030180510.747225-1-jean-philippe@linaro.org>
References: <20201030180510.747225-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x442.google.com
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
v11: Pass mapping permissions to the notifiers
---
 hw/virtio/virtio-iommu.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 7dd15c5eacd..7b648923517 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -170,11 +170,39 @@ static void virtio_iommu_notify_unmap(IOMMUMemoryRegion *mr, hwaddr virt_start,
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
+                            mapping->phys_addr, mapping->flags);
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
@@ -317,6 +345,10 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
 
     ep->domain = domain;
 
+    /* Replay domain mappings on the associated memory region */
+    g_tree_foreach(domain->mappings, virtio_iommu_notify_map_cb,
+                   ep->iommu_mr);
+
     return VIRTIO_IOMMU_S_OK;
 }
 
-- 
2.29.1


