Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC07C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B6C420724
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jntCwjwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6C420724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k99yN-0002zM-F2
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 12:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1k99w3-0007yf-2Y
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:30:35 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:37850)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1k99vy-0006pb-0c
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:30:34 -0400
Received: by mail-ej1-x643.google.com with SMTP id qc22so3011602ejb.4
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 09:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5joFadNGRqyI9ygkH+sBW3/GPpVUuhHiLgETPkq0zN0=;
 b=jntCwjwlK6crnSoYOahrPvHKLeFtEckXfw2hh1SxYdy8zvZRkGBTDC7kyuk+AJ4irn
 Vd55WK82KWEK389HYCg5/i8x/nsjNVwPhom0R7zpGPQG5/QEzYuucs8ZvUumzaOQcVpm
 geyPsJSuCj+KSksJx+KRTvVWA5dxqb1ywvYYQ3XIeL6PgyA+DsUJ9trFRE/+lMsJ4N43
 NVPAYfVd0ttx31V148K8N4GYmK7hoj0iBoZbmQ79NRdn8jq+GkqNtdqfRBvd+X0Pr6Aa
 J/e88DIeNq0Enx0PVMS00hV3q6XDys/PanmjcxMz9Ag1YNkrcDkzd7WY86PDrHBIywWX
 yQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5joFadNGRqyI9ygkH+sBW3/GPpVUuhHiLgETPkq0zN0=;
 b=a0B7GM46+kWyJgGTXcuStlD8VuIgv/39TQAfjp+sRzJsdSpUECm0Fhj8uNtMHISzBM
 stcHrJ7kIbVtbDyf3CBYKD+8r7or+LHxyafVj5joN91xMs20N2DGPgn3b+NXyn+RRMSa
 2o8JOLlEwd5ecpnOdZQ7K3hQatDrjJsWAqLmECxEn/wr25X6yaVI6olKDs43JkvJGOzq
 Z4XEN8J3FILjnKc3UmdKv7D3MXkS7R5dmGAIJuLBQ3wAkfg7CZJ5B1HfonJX7fqpxYDf
 yLF/Y3P+pDCnARF7hAgCPGaXRUMtcof4xg1xJg1XN0SjOWD6eSABXoRbb4fIjVjiK5Cx
 zoKQ==
X-Gm-Message-State: AOAM531LycN5HaJTcELdm3iSZ11IwMHhXf7i552LAjN4HA8svbiNBK/L
 vm8sgIO4w6OGazUWQAq7chgJ2w==
X-Google-Smtp-Source: ABdhPJz2WOH3L1Y9o/9IqBJyR0Kl+3FnrqpRdbQP+VMigE2Wxl/iUXed7ql32cL8Lhd0lF5onc2uSg==
X-Received: by 2002:a17:906:cc51:: with SMTP id
 mm17mr3734323ejb.137.1598027428558; 
 Fri, 21 Aug 2020 09:30:28 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id dk28sm1398030edb.90.2020.08.21.09.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 09:30:27 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 5/5] hw/i386/pc: Add support for virtio-iommu-pci
Date: Fri, 21 Aug 2020 18:28:39 +0200
Message-Id: <20200821162839.3182051-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821162839.3182051-1-jean-philippe@linaro.org>
References: <20200821162839.3182051-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=jean-philippe@linaro.org; helo=mail-ej1-x643.google.com
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

From: Eric Auger <eric.auger@redhat.com>

The virtio-iommu-pci is instantiated through the -device QEMU
option. Declare the [0xfee00000 - 0xfeefffff] MSI reserved region so
that it gets bypassed by the IOMMU.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 hw/i386/pc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 47c5ca3e342..79ab7e06066 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -89,6 +89,7 @@
 #include "standard-headers/asm-x86/bootparam.h"
 #include "hw/virtio/virtio-pmem-pci.h"
 #include "hw/virtio/virtio-mem-pci.h"
+#include "hw/virtio/virtio-iommu.h"
 #include "hw/mem/memory-device.h"
 #include "sysemu/replay.h"
 #include "qapi/qmp/qerror.h"
@@ -1698,6 +1699,11 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
                object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
         pc_virtio_md_pci_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
+        /* we declare a VIRTIO_IOMMU_RESV_MEM_T_MSI region */
+        qdev_prop_set_uint32(dev, "len-reserved-regions", 1);
+        qdev_prop_set_string(dev, "reserved-regions[0]",
+                             "0xfee00000:0xfeefffff:1");
     }
 }
 
@@ -1752,7 +1758,8 @@ static HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
         object_dynamic_cast(OBJECT(dev), TYPE_CPU) ||
         object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
-        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
         return HOTPLUG_HANDLER(machine);
     }
 
-- 
2.28.0


