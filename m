Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99871C4CECD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F0120775
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9kYsAVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F0120775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT8QM-0002vy-Fv
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 14:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jT8JR-0000EA-O8
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jT8JR-0005J6-9t
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:17:01 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:40650)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jT8JQ-0005Hx-S4; Mon, 27 Apr 2020 14:17:00 -0400
Received: by mail-lj1-x243.google.com with SMTP id y4so18658652ljn.7;
 Mon, 27 Apr 2020 11:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GPC7muRhlUGu2WX8H12OYbV9Y7LEMhxX59INi0Q7t54=;
 b=U9kYsAVVwzkiI1exgIr0cy8osthl3OdGielMlmp0Vht9kBiTJugNpsF7HJCJFwdWR5
 rfSAXPrDafPlelWD8B6Ho1u24R9HBM575eTV0aOlFZZO5e0b1OMLMM4BNnWFm5yfvZVM
 NF0jksQEgMdmUoiX93nP5hx7XPZu5RafE7cF5cgAv8b3HcAhU+fHwpHMOSc3AxRlQCAc
 Xu+g14ilWTXaq2XBkYumAQK9COn6Upp/rWZciZQTezpz8fTRv8YAgExIRzM67uLzuFmV
 DRtEMg+A4B31LDx5nEGRTgQdn7V4wwKgYPkyJt42Oy5hZqGHv/E+bJ1sCGuJ/9G4Mt/A
 50Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GPC7muRhlUGu2WX8H12OYbV9Y7LEMhxX59INi0Q7t54=;
 b=ZXB19sUEdy1CXHSFEIesplEjxVz3mL4fS7VcIot9JE8hDk0tCzt36dTJe1P4pdy/ll
 n4M/NM8ApfFaC57/FDxnDP1IEQ92XS399lx+aRWrw1DtPNKVxPRQVdrjj6xeXO9OLNPJ
 yreX2asWsRJxfIDPPIuGRPkHj/DqFeJt8vCGknsn4RYluHMtVfUT/bgA930ncG6W8mmZ
 9E7c6s4uranhGC/D/CXpH1Dm5rTPeCvK0AtSJdf06K/LXT5shg9LGvFVrvmoipUofxav
 o/+bBR9TeYr8yTXTClQ4pv1IwMQYGR+RwfhHDQeRjBStroG6r0YiIVoOU7adi7HeKwx/
 OtnA==
X-Gm-Message-State: AGi0PuYt1YS7kXSRjWznKlWqyaLFLaTC57kwfUi5Qrrj2JSlhTNSl+ud
 Sq7aBHWNiUEFuyAEKv15fP3kkeLxHZc=
X-Google-Smtp-Source: APiQypJCaBHkW8FZ1HPMuZz1uaC5LffyzFBjah6EV8gQQsoDf1n+DSYzPJSAfFLTRhvUcFNdsnLaGg==
X-Received: by 2002:a2e:8999:: with SMTP id c25mr15312182lji.73.1588011418770; 
 Mon, 27 Apr 2020 11:16:58 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id q19sm10470021ljj.84.2020.04.27.11.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 11:16:58 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 06/11] hw/arm: versal: Embedd the ADMAs into the SoC type
Date: Mon, 27 Apr 2020 20:16:44 +0200
Message-Id: <20200427181649.26851-7-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427181649.26851-1-edgar.iglesias@gmail.com>
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::243
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

Embedd the ADMAs into the SoC type.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/arm/xlnx-versal.c         | 14 +++++++-------
 include/hw/arm/xlnx-versal.h |  3 ++-
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index e424aa789e..ebd2dc51be 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -203,18 +203,18 @@ static void versal_create_admas(Versal *s, qemu_irq *pic)
         DeviceState *dev;
         MemoryRegion *mr;
 
-        dev = qdev_create(NULL, "xlnx.zdma");
-        s->lpd.iou.adma[i] = SYS_BUS_DEVICE(dev);
-        object_property_set_int(OBJECT(s->lpd.iou.adma[i]), 128, "bus-width",
-                                &error_abort);
-        object_property_add_child(OBJECT(s), name, OBJECT(dev), &error_fatal);
+        sysbus_init_child_obj(OBJECT(s), name,
+                              &s->lpd.iou.adma[i], sizeof(s->lpd.iou.adma[i]),
+                              TYPE_XLNX_ZDMA);
+        dev = DEVICE(&s->lpd.iou.adma[i]);
+        object_property_set_int(OBJECT(dev), 128, "bus-width", &error_abort);
         qdev_init_nofail(dev);
 
-        mr = sysbus_mmio_get_region(s->lpd.iou.adma[i], 0);
+        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
         memory_region_add_subregion(&s->mr_ps,
                                     MM_ADMA_CH0 + i * MM_ADMA_CH0_SIZE, mr);
 
-        sysbus_connect_irq(s->lpd.iou.adma[i], 0, pic[VERSAL_ADMA_IRQ_0 + i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[VERSAL_ADMA_IRQ_0 + i]);
         g_free(name);
     }
 }
diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 01da736a5b..94b7826fd4 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -16,6 +16,7 @@
 #include "hw/arm/boot.h"
 #include "hw/intc/arm_gicv3.h"
 #include "hw/char/pl011.h"
+#include "hw/dma/xlnx-zdma.h"
 #include "hw/net/cadence_gem.h"
 
 #define TYPE_XLNX_VERSAL "xlnx-versal"
@@ -53,7 +54,7 @@ typedef struct Versal {
         struct {
             PL011State uart[XLNX_VERSAL_NR_UARTS];
             CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
-            SysBusDevice *adma[XLNX_VERSAL_NR_ADMAS];
+            XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
         } iou;
     } lpd;
 
-- 
2.20.1


