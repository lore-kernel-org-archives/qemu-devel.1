Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C12C54EEB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:24:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D841F20775
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJbxbtxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D841F20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT8QN-00030S-09
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 14:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jT8JU-0000Li-GE
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jT8JU-0005VM-2E
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:17:04 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:46788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jT8JT-0005Lt-Ix; Mon, 27 Apr 2020 14:17:03 -0400
Received: by mail-lf1-x143.google.com with SMTP id g10so14591731lfj.13;
 Mon, 27 Apr 2020 11:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NRARNgi6yltPpesl7Da869Def6pOC6MvRH+ZwCzHtA0=;
 b=QJbxbtxfPR7HAOc7TG/Wuck/2QsWCq5dUBoLKfEwM3NmBvBms30LYe++33dqM81sTm
 RcwZ53c4cqqPJsETYbzAkG+QzjWV7vLqlRR7dEDvU0o19auqpD99g2AZp9+euLybcORD
 2hT1sf2wCtsWMlXaBLT8NiT8HyNAZPm2PwQ65Way88pkHdlLhnZvbF80Nc33P31smi+I
 ws1iiQyx7tZG76XCCU43Bd6t+RxPfM6PPH6XTfqdiGr6QOp/Ot5Hzxu/nohEVbJXZfAP
 k6Tq20wVu0eqD/y8iJ35t8IqRr9Xfy/p3f6UxCDiJ7N7sdZTBpJBPdLLCrPGqzR5wsPA
 RW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NRARNgi6yltPpesl7Da869Def6pOC6MvRH+ZwCzHtA0=;
 b=aLp0j6xcJI3yJnzrx+iTTAEYkLnv78+cYxfU/39IUObWpPZcDEM/3FvdimfHh7ddf3
 z55tsdseyDlkqbwo3/+51QcGJlSguDezq13akKFtJ6/mqhsPT55IiBk8aMDLbPLVqrXp
 fE69ke4bLBVCGPR4wpr5eODO1ax10CWhZM1ft+OJ0bm5BaBSu+tK/0eEU6y+HG6HGmlV
 LvBawphxb3LiDKnbX98ieoCXNHy5qSDJUmss+LOZ6AtLzaTT7GEImdWhkPXEsdke3vmz
 BMbOjEAEsbnBtg4yrlpb0jzONoMdBt2coEJVYBj4o5F7wUHU0M/Gv2WuMLEQaBiUsJA6
 GzWA==
X-Gm-Message-State: AGi0PuY1X7qP+LoMHi88r06kT4vJhue1AfEYMacDvmL0NRnKIFaXKsRe
 ziGZHPG6Wpna1HbcEvBUP7hTFBAZ3BY=
X-Google-Smtp-Source: APiQypKQjBWuGnzriY4rY2pKP4lrsDZKJUNwxCF3wAzlQgzUPsj2/B+UiNeUj6ollil0yVkul3QjfQ==
X-Received: by 2002:a19:c78d:: with SMTP id
 x135mr15866950lff.151.1588011421336; 
 Mon, 27 Apr 2020 11:17:01 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id y25sm11861495lfy.59.2020.04.27.11.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 11:17:00 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 08/11] hw/arm: versal: Add support for SD
Date: Mon, 27 Apr 2020 20:16:46 +0200
Message-Id: <20200427181649.26851-9-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427181649.26851-1-edgar.iglesias@gmail.com>
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::143
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add support for SD.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/arm/xlnx-versal.c         | 31 +++++++++++++++++++++++++++++++
 include/hw/arm/xlnx-versal.h | 12 ++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index c8a296e2e0..e263bdf77a 100644
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
 
diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 426b66449d..e11693e29d 100644
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
-- 
2.20.1


