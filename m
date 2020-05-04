Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A0AC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:37:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A688206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YMzU5nyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A688206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaM0-0000MH-Mb
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHs-0000GV-Fd
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:32 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:46000)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHr-0000wR-A4
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:32 -0400
Received: by mail-wr1-x42f.google.com with SMTP id k1so1831448wro.12
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=CGmRWhipF2RqadKcryx2/fZJUAv/8mJO7ibJMjfeHzI=;
 b=YMzU5nyVt8LUwmb9y9u84vPNjLLR9lxe0fmi7YW+NfdUMXkjPPSrXRNYHQc+eKBlnA
 5jflxMMmsQadH7G4d4i1SckC4lIecZXh0shYcRypVnuulnLBzukDwyNof+sSEW1zmmaD
 3QCYXZqxre7lKgLUzxbyOCaepyTV20jY15iesZsJl4MSyk6+eS/BVazMx/c5pRR6kJnF
 PfS/w3ISDE4HK2OZME9cT5WJCc8mAPBM+i+BRsmKOgBFxlZe8hEblo4/d+QWiDZ+Rnn0
 ywmPA2qdrzQgddKN2OWinc+HruwKehWUiTDqU9tNKGaRXxfT+6TBrGyZxs8/pVlOr/kp
 vsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CGmRWhipF2RqadKcryx2/fZJUAv/8mJO7ibJMjfeHzI=;
 b=QCyXnNMMymm4hxS2MMgahm0WLmsBFx9U0sP+rsw9p5WhTTjBAt/O46C+GPuOagmwal
 qWeobfNYJlsjZfj6JEvTgjqY7wdvafJ+9Kfe8COFuxqIwDFJ1veFeyB0MBHgTn7qzQpx
 PZhc2HOKZT0TTx9RXk5hztsJAsh218wXMTIj6hYZHIQo0cnJCNsbhGGCCLbc0Fd/4BdL
 g2pJXuSHsn4xGKC5Dn4q/WnDPbeTr+EsQ1ueJ6Vnt7pAPw1d+UJEVyuK6++FJJLxIfta
 BtrDFXFlxgpP/cC4pRGLDHHh4L5qnM9jf7mPTrYTJmcvoZseHlL4YNdlbwFSJNZwxMdB
 WsCQ==
X-Gm-Message-State: AGi0PubWDPUQhaavs8yv6Xca5/TTcbfHmaLAaYoriUFEAMqwkVyThxKV
 ra0mQ+NbOFoG5nBT99ltxb5W+Fal75y1lw==
X-Google-Smtp-Source: APiQypI4eeqft5vB5M8x7+Y43uTZ2NeQTWTrjW+ElKOssa4dylKMHl9mVPhgQn49ew6cr4Y1V3SKpQ==
X-Received: by 2002:a5d:4e06:: with SMTP id p6mr18577775wrt.35.1588595609652; 
 Mon, 04 May 2020 05:33:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/39] hw/arm: versal: Add support for SD
Date: Mon,  4 May 2020 13:32:46 +0100
Message-Id: <20200504123309.3808-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add support for SD.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20200427181649.26851-9-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h | 12 ++++++++++++
 hw/arm/xlnx-versal.c         | 31 +++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 426b66449de..e11693e29d3 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -14,6 +14,7 @@
 
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
+#include "hw/sd/sdhci.h"
 #include "hw/intc/arm_gicv3.h"
 #include "hw/char/pl011.h"
 #include "hw/dma/xlnx-zdma.h"
@@ -26,6 +27,7 @@
 #define XLNX_VERSAL_NR_UARTS   2
 #define XLNX_VERSAL_NR_GEMS    2
 #define XLNX_VERSAL_NR_ADMAS   8
+#define XLNX_VERSAL_NR_SDS     2
 #define XLNX_VERSAL_NR_IRQS    192
 
 typedef struct Versal {
@@ -58,6 +60,13 @@ typedef struct Versal {
         } iou;
     } lpd;
 
+    /* The Platform Management Controller subsystem.  */
+    struct {
+        struct {
+            SDHCIState sd[XLNX_VERSAL_NR_SDS];
+        } iou;
+    } pmc;
+
     struct {
         MemoryRegion *mr_ddr;
         uint32_t psci_conduit;
@@ -80,6 +89,7 @@ typedef struct Versal {
 #define VERSAL_GEM1_IRQ_0          58
 #define VERSAL_GEM1_WAKE_IRQ_0     59
 #define VERSAL_ADMA_IRQ_0          60
+#define VERSAL_SD0_IRQ_0           126
 
 /* Architecturally reserved IRQs suitable for virtualization.  */
 #define VERSAL_RSVD_IRQ_FIRST 111
@@ -129,6 +139,8 @@ typedef struct Versal {
 #define MM_FPD_CRF                  0xfd1a0000U
 #define MM_FPD_CRF_SIZE             0x140000
 
+#define MM_PMC_SD0                  0xf1040000U
+#define MM_PMC_SD0_SIZE             0x10000
 #define MM_PMC_CRP                  0xf1260000U
 #define MM_PMC_CRP_SIZE             0x10000
 #endif
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index c8a296e2e05..e263bdf77a9 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -210,6 +210,36 @@ static void versal_create_admas(Versal *s, qemu_irq *pic)
     }
 }
 
+#define SDHCI_CAPABILITIES  0x280737ec6481 /* Same as on ZynqMP.  */
+static void versal_create_sds(Versal *s, qemu_irq *pic)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(s->pmc.iou.sd); i++) {
+        DeviceState *dev;
+        MemoryRegion *mr;
+
+        sysbus_init_child_obj(OBJECT(s), "sd[*]",
+                              &s->pmc.iou.sd[i], sizeof(s->pmc.iou.sd[i]),
+                              TYPE_SYSBUS_SDHCI);
+        dev = DEVICE(&s->pmc.iou.sd[i]);
+
+        object_property_set_uint(OBJECT(dev),
+                                 3, "sd-spec-version", &error_fatal);
+        object_property_set_uint(OBJECT(dev), SDHCI_CAPABILITIES, "capareg",
+                                 &error_fatal);
+        object_property_set_uint(OBJECT(dev), UHS_I, "uhs", &error_fatal);
+        qdev_init_nofail(dev);
+
+        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+        memory_region_add_subregion(&s->mr_ps,
+                                    MM_PMC_SD0 + i * MM_PMC_SD0_SIZE, mr);
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                           pic[VERSAL_SD0_IRQ_0 + i * 2]);
+    }
+}
+
 /* This takes the board allocated linear DDR memory and creates aliases
  * for each split DDR range/aperture on the Versal address map.
  */
@@ -292,6 +322,7 @@ static void versal_realize(DeviceState *dev, Error **errp)
     versal_create_uarts(s, pic);
     versal_create_gems(s, pic);
     versal_create_admas(s, pic);
+    versal_create_sds(s, pic);
     versal_map_ddr(s);
     versal_unimp(s);
 
-- 
2.20.1


