Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC816C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F7C2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="abinKzoj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F7C2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k99zl-0005kw-Qn
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 12:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1k99w1-0007w6-LP
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:30:33 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:41121)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1k99vw-0006og-U6
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:30:33 -0400
Received: by mail-ej1-x641.google.com with SMTP id t10so2996474ejs.8
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2+K4uxN0kyhXy6kN+ijSa8qFKCUtC4za1XiAKyb7Tws=;
 b=abinKzoj5alQRqRp3d9/Y8vcOnoqK1So6bFU7ki3PlKlt1uvNdKbCPdngAzKsy+y5W
 OiHVOyZwhIeMR2BcuDAYXgAk1APbs4CV2S2fPd2D0+YlQDbzD+AVHl1Q+usVPUibVRQz
 5RVjIt8AbuNJIv5DrBzz9ScYlA8i0Xa9wXdALwwG/0LGLXznK0Nwbl3Luk7tfG4dvBaq
 eGUs4kBH/Lgaoagre6TlxJQ85DG9o65B+tuQovOEobP4vja1JlZkys8FrODbhoVAo25i
 ZN5HzeYw5T1hKUXYIBBScrItkssCoWKu1V0E8N3hmRJbqhfFByZ8xDOivB0exQ0srG6U
 0AOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2+K4uxN0kyhXy6kN+ijSa8qFKCUtC4za1XiAKyb7Tws=;
 b=OmUnTDEATtjW9RnB5Ro5FVYlvIFdyyLhGhndV7M/K7mtIBBScQe0E3NVm/hCpny4Iy
 CT0N0Bx61Tv6nF0RibnPWW5jz4+nydIlcjioeZj1Rub8q/B1Jsnx2PYb49ZMNv+C1d0F
 OgU/I6kauqgr5gtlIx1t6+1GZdcDNzkiBMsrNfep/TQBC01CgxqcMD5lDecC5a3R6i6o
 Fkdpprc+VuxuaBFQAks13GM9MvCZ55cnU4L4815s/2SQg/zt0F9Ui6VM176JpQmFgIcE
 FoFiQNduvK7RrZGWi8f781eu3tPr3eZ9NDCvUnqfyHGg7TKoyS5NTIs2LbXiuiPWtnow
 jGug==
X-Gm-Message-State: AOAM5329AqxjCQ6i1fOHO3vXOuBEVPsHxQTvRWkPVok/xcLmsMTiY9h3
 RGaRFvEAjR5FkIWLW+XiMoGqHQ==
X-Google-Smtp-Source: ABdhPJyUnVb8/3qw1H3CVTRWIncK4qlWEp5LRMfAHEJuKl69PJdPSjmADy7i7NpXLTVuyBo4NBI7cg==
X-Received: by 2002:a17:907:7292:: with SMTP id
 dt18mr3849992ejc.512.1598027427415; 
 Fri, 21 Aug 2020 09:30:27 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id dk28sm1398030edb.90.2020.08.21.09.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 09:30:26 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/5] hw/arm/virt: Remove device-tree restriction on
 virtio-iommu
Date: Fri, 21 Aug 2020 18:28:38 +0200
Message-Id: <20200821162839.3182051-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821162839.3182051-1-jean-philippe@linaro.org>
References: <20200821162839.3182051-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=jean-philippe@linaro.org; helo=mail-ej1-x641.google.com
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

Now that the virtio-iommu has a built-in topology mechanism, it can be
used without a device tree. Remove the restriction on !ACPI or
!firmware.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 hw/arm/virt.c                | 10 ++--------
 hw/virtio/virtio-iommu-pci.c |  2 --
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ecfee362a18..2742c28054a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2358,16 +2358,10 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
                                                         DeviceState *dev)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE) ||
-       (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM))) {
+        object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
         return HOTPLUG_HANDLER(machine);
     }
-    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
-        VirtMachineState *vms = VIRT_MACHINE(machine);
-
-        if (!vms->bootinfo.firmware_loaded || !virt_is_acpi_enabled(vms)) {
-            return HOTPLUG_HANDLER(machine);
-        }
-    }
     return NULL;
 }
 
diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
index ba62d60a0a0..240e85e6363 100644
--- a/hw/virtio/virtio-iommu-pci.c
+++ b/hw/virtio/virtio-iommu-pci.c
@@ -54,8 +54,6 @@ static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
         error_append_hint(errp,
                           "Check your machine implements a hotplug handler "
                           "for the virtio-iommu-pci device\n");
-        error_append_hint(errp, "Check the guest is booted without FW or with "
-                          "-no-acpi\n");
         return;
     }
     for (int i = 0; i < s->nb_reserved_regions; i++) {
-- 
2.28.0


