Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0202BC47254
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:37:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB528206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fpH4/8wr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB528206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaLw-0000GZ-TN
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHr-0000Dm-C3
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:31 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:37748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHq-0000uc-AJ
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:31 -0400
Received: by mail-wm1-x32c.google.com with SMTP id z6so8835694wml.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=lnazISB2ygbNrgd87WVV5yJxpAw+zHWve8ESC0KSKAo=;
 b=fpH4/8wrT2HxZ8OE1UECJttT28a8aPIoBb+PUUTZLCvhQxM0DFEa4DdEiX12aX8AHu
 sEQv0VqLAvQnwxVKjygNJpJeYAu+gqcSGhtNkC4OxY257FMTieLpowDdC8t/YKfBJ0kU
 6kvK7l2k2M+LrLT9t2q4+69xAucbZLeWKAKolk4zKs6Qv0MKqv8QIwd7D9kfmh2KZxAo
 JUDDihNK8wul5TQK/EPr53gu1TUgTS+j3K4bajERaw/OHIrXJ8QYkIFZY9/3tKYphEKF
 fWnq9gyPZeAIE7GZxrNA6U+H4/yGlXdxeJ4pZTRyXsgIMhMWyQLCdgCdNScPQz58BDgn
 svpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lnazISB2ygbNrgd87WVV5yJxpAw+zHWve8ESC0KSKAo=;
 b=kP3XBUECOVFZuvWDEudGj0d7VhiyAdrGg9QCBmUr4ZBFofE/keHbcN066rNQMZvrB+
 v0H0mfQvrZxHFjw7Za4ZzOrkofKmX39Z+thN/fXa090y+f4JmTBfII5UdhS8yeBGs1oO
 g1d2J7BE5wuqpnrBSkbdMEpqVJqbzQ98Ccu8v7fHSHcaTMOKN1eDrSeK9tOfqK8eGlnT
 pmOw9vo3HlYGTC2bwMqgMAb69xE6zS9D4UYJ24LUG6KS4QgzXH4o5Ck+aS+qxdJ/7Co6
 6OmaLOidigituugIu8IflYvLLDjVyuWf2F5w2z8n7YIxdy2xts9cjfOnuApmIGVWVTjc
 SmCA==
X-Gm-Message-State: AGi0PuYYYIMR22GrWlb+a7DDs9mMWtAZK/foPaJGPOq75D6COqcMiqMl
 uysmwfMljaV5R1wFX+327NumuKbAp1m8LQ==
X-Google-Smtp-Source: APiQypJlUj0hYCrDgyBaOJFJvYch1Gqd8Whu6HVhsB0hY3WNz5OGbW3Y8yr/faiYrpN7nkacprSZBw==
X-Received: by 2002:a05:600c:2316:: with SMTP id
 22mr14033755wmo.164.1588595607587; 
 Mon, 04 May 2020 05:33:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/39] hw/arm: versal: Embed the ADMAs into the SoC type
Date: Mon,  4 May 2020 13:32:44 +0100
Message-Id: <20200504123309.3808-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Embed the ADMAs into the SoC type.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20200427181649.26851-7-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h |  3 ++-
 hw/arm/xlnx-versal.c         | 14 +++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 01da736a5b2..94b7826fd49 100644
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
 
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index e424aa789e3..ebd2dc51beb 100644
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
-- 
2.20.1


