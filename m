Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ED0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:32:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6FDF20724
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RtBd0+/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FDF20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k99xa-0001fY-0L
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 12:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1k99vx-0007tc-Rp
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:30:30 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:32796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1k99vt-0006na-KE
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:30:29 -0400
Received: by mail-ej1-x644.google.com with SMTP id u21so2335586ejz.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 09:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OuI8xnJndStSpo+ETjU3EU4hq5mCXR/FiYpus8sMWls=;
 b=RtBd0+/tA0QB1kHWt9+BsloshL2hCQZsnr/oWm+0HJJVwqLPFyn6AT+SofxvLmuImX
 PsAfS3QcpNvxXPTTMzY3cg6GuW96O0nt20YxLWuOGab+e7ycvFO3onzdsygv0zXeSGCm
 gYk+MvS8rqcGAYFuVDwVYaUqZk7juHUkq9QcyCJc/eXlChsskoDjukYCLbfPuTNafalP
 QDS9V8yzFoUdYxgtAC7XBfW5fVgxkgfXSNcj86Ohb4gMrHsqlCCf0qhOsxs6Lr3MgLT4
 cfYA588+j0y5p9YHHNgRaceedtGSBwmhCMKDLafRTMjagMg3ykvVBSqTwK/dVu4jpvJe
 a1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OuI8xnJndStSpo+ETjU3EU4hq5mCXR/FiYpus8sMWls=;
 b=g7gt+i2CVTcVEBdcaLTOciHqx772YhugYi5iJGHkeAv/TIeA8apiy/tlEwK3dRew31
 CulBLMaaVYPi3YB9om0gjl4Ty7/vmjjc7vEgVPd6AH/vgrws9r5kVnzbd3f9c7/OFlgT
 YxJZB2GCGwrxBiJs8V6zhV7SsYuX4MHVKRNnyOJ0PLIHhvhgAcZsm51fy/mtoSvKr3L6
 wZoLWnJv1pMtcG8mFpDtdGvdmmqYmONmiVtJUXaQWHEhDxvohvXfChq3Zze4hcMmw/7e
 OpwEbQvwzMs6NcKLB4MfTauGa0zwKJ2L0OJrrgOKUWGJxikdVR7vJuVMPPxKp/1BTOVl
 XYvw==
X-Gm-Message-State: AOAM531w/oJan7q+fqTM7IAebVer3In/B0U80jcRzbK0JEfADOVrotkY
 zweDQG5BDud5kddDALoD0yXElw==
X-Google-Smtp-Source: ABdhPJwMXGGsR4gh8umR9SklPbRw5s4nq1puTvleMsU70gLFRDo151sSV9Us4kSCKKUpuk9waTQ+KQ==
X-Received: by 2002:a17:906:3e06:: with SMTP id
 k6mr3616203eji.37.1598027423946; 
 Fri, 21 Aug 2020 09:30:23 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id dk28sm1398030edb.90.2020.08.21.09.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 09:30:23 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/5] virtio-iommu: Default to bypass during boot
Date: Fri, 21 Aug 2020 18:28:35 +0200
Message-Id: <20200821162839.3182051-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821162839.3182051-1-jean-philippe@linaro.org>
References: <20200821162839.3182051-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=jean-philippe@linaro.org; helo=mail-ej1-x644.google.com
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, mst@redhat.com,
 eric.auger@redhat.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a virtio-iommu is present, we currently require the guest to
configure it before it can use DMA in any other PCI device. This
prevents, for example, a bootloader that doesn't know how to drive
virtio-iommu from loading an OS from storage.

Add the "boot-bypass" option, defaulting to true, to let DMA bypass the
virtio-iommu during boot similarly to the other vIOMMUs. It makes the
system vulnerable to malicious endpoints during boot, but that isn't
much of a concern in virtual systems.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/hw/virtio/virtio-iommu.h |  1 +
 hw/virtio/virtio-iommu.c         | 22 ++++++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index 49eb105cd84..ae57efab1f3 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -58,6 +58,7 @@ typedef struct VirtIOIOMMU {
     GTree *domains;
     QemuMutex mutex;
     GTree *endpoints;
+    bool boot_bypass;
 } VirtIOIOMMU;
 
 #endif
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 5d56865e569..3b821fc005d 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -595,6 +595,24 @@ static void virtio_iommu_report_fault(VirtIOIOMMU *viommu, uint8_t reason,
 
 }
 
+static bool virtio_iommu_bypass_is_allowed(VirtIOIOMMU *s)
+{
+    VirtIODevice *vdev = &s->parent_obj;
+    /*
+     * Allow bypass if:
+     * - boot_bypass is enabled and the BYPASS feature hasn't yet been
+     *   acknowledged.
+     * - the BYPASS feature has been negotiated.
+     */
+    if (s->boot_bypass && !(vdev->status & VIRTIO_CONFIG_S_FEATURES_OK)) {
+        return true;
+    }
+    if (virtio_vdev_has_feature(vdev, VIRTIO_IOMMU_F_BYPASS)) {
+        return true;
+    }
+    return false;
+}
+
 static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
                                             IOMMUAccessFlags flag,
                                             int iommu_idx)
@@ -621,8 +639,7 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         .perm = IOMMU_NONE,
     };
 
-    bypass_allowed = virtio_vdev_has_feature(&s->parent_obj,
-                                             VIRTIO_IOMMU_F_BYPASS);
+    bypass_allowed = virtio_iommu_bypass_is_allowed(s);
 
     sid = virtio_iommu_get_bdf(sdev);
 
@@ -947,6 +964,7 @@ static const VMStateDescription vmstate_virtio_iommu = {
 
 static Property virtio_iommu_properties[] = {
     DEFINE_PROP_LINK("primary-bus", VirtIOIOMMU, primary_bus, "PCI", PCIBus *),
+    DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.28.0


