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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6DEC4CECD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6267120775
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WE8DSgg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6267120775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT8Nh-0006tf-7u
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 14:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jT8JQ-0000Cj-UQ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jT8JQ-0005IU-9o
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:17:00 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:39544)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jT8JP-0005Go-R3; Mon, 27 Apr 2020 14:16:59 -0400
Received: by mail-lf1-x143.google.com with SMTP id m2so14650774lfo.6;
 Mon, 27 Apr 2020 11:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oYg0p7yIA5Q+LdFqQOmOfFVMNdiWwqxadXv/IQdk82Y=;
 b=WE8DSgg9rcyPADcw0U1j9JhhLAZreOKD+Ryw5VHQNJeDkvzcE90UKsbyk7Ve+HFgew
 0WOhazCvHcZPBhe8hZqpegukdK1b+J10LUMRVSIFvOdvnxUg4JmsW4CWZiL7WyenGUUi
 UzKdoLWz8YJu9BURvGCIAyfg6//NCD4rt+HYTI0b5PG980nHOtmM8R6FHKaOB3rl7BDp
 7IBSQXJCyPID6uKijuUNleWq/cm5TH8M3NlCfqVGnhxh8JwWuBVLxPHazV0FDyZHYgzw
 oenqCVFmgTkLRLrVuaJQDlgzvvMnMakkb2pQvRAYbb0FSvjqZZfqvzKgnMioPrJAD4gF
 yubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oYg0p7yIA5Q+LdFqQOmOfFVMNdiWwqxadXv/IQdk82Y=;
 b=E1bemyncDIGNYp1fecUuu8KHbwWXH9UpgOTTse3qj6w2AJdtNgHxMTzzy9QyBYSwIH
 eWMGMN8EU5emk/TeI1yfzafAAQMh1kkQVlu8FiVvK0uKqGRoNrK4m9oJvbg/RVGMlGdJ
 4CTmtFPXfXKEFMJN3GDx6blQxMuhrw4whRCLnUDcfZknNQJ3zw9OPP8zTfnQ3eFNM+IL
 ZDuzfBilFNrYcSI64ogD3UnUGUop91YJo3N3ghnuYpdvgB9uahHMFhcVHtWMLyVl4xMM
 MfRrK4Ta+w5PgrZ5C+7wpYwg3DhLp9MyCuzoxN8SkJ20UVGzSY7LEGPVbSjCNLFA7Z9b
 m5Xw==
X-Gm-Message-State: AGi0PuYoXvaGtdLXx43VMVz10GYMYsugym1W+X3Fzi87HABIEFf9iuRq
 +mlpnDFStt4QvZ+LmY58coXyghHSktw=
X-Google-Smtp-Source: APiQypI84T6X9VnPIiU6c0BDHMR2aMzncIGGJ0ktdLoz49ahyeoEpbBIIdReRSynQXNMcrwUAY4k1A==
X-Received: by 2002:ac2:5235:: with SMTP id i21mr16175430lfl.73.1588011417644; 
 Mon, 27 Apr 2020 11:16:57 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id m5sm11803304lfb.56.2020.04.27.11.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 11:16:56 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 05/11] hw/arm: versal: Embedd the GEMs into the SoC type
Date: Mon, 27 Apr 2020 20:16:43 +0200
Message-Id: <20200427181649.26851-6-edgar.iglesias@gmail.com>
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

Embedd the GEMs into the SoC type.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/arm/xlnx-versal.c         | 15 ++++++++-------
 include/hw/arm/xlnx-versal.h |  3 ++-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index dbde03b7e6..e424aa789e 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -170,25 +170,26 @@ static void versal_create_gems(Versal *s, qemu_irq *pic)
         DeviceState *dev;
         MemoryRegion *mr;
 
-        dev = qdev_create(NULL, "cadence_gem");
-        s->lpd.iou.gem[i] = SYS_BUS_DEVICE(dev);
-        object_property_add_child(OBJECT(s), name, OBJECT(dev), &error_fatal);
+        sysbus_init_child_obj(OBJECT(s), name,
+                              &s->lpd.iou.gem[i], sizeof(s->lpd.iou.gem[i]),
+                              TYPE_CADENCE_GEM);
+        dev = DEVICE(&s->lpd.iou.gem[i]);
         if (nd->used) {
             qemu_check_nic_model(nd, "cadence_gem");
             qdev_set_nic_properties(dev, nd);
         }
-        object_property_set_int(OBJECT(s->lpd.iou.gem[i]),
+        object_property_set_int(OBJECT(dev),
                                 2, "num-priority-queues",
                                 &error_abort);
-        object_property_set_link(OBJECT(s->lpd.iou.gem[i]),
+        object_property_set_link(OBJECT(dev),
                                  OBJECT(&s->mr_ps), "dma",
                                  &error_abort);
         qdev_init_nofail(dev);
 
-        mr = sysbus_mmio_get_region(s->lpd.iou.gem[i], 0);
+        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
         memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
 
-        sysbus_connect_irq(s->lpd.iou.gem[i], 0, pic[irqs[i]]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irqs[i]]);
         g_free(name);
     }
 }
diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index a3dfd064b3..01da736a5b 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -16,6 +16,7 @@
 #include "hw/arm/boot.h"
 #include "hw/intc/arm_gicv3.h"
 #include "hw/char/pl011.h"
+#include "hw/net/cadence_gem.h"
 
 #define TYPE_XLNX_VERSAL "xlnx-versal"
 #define XLNX_VERSAL(obj) OBJECT_CHECK(Versal, (obj), TYPE_XLNX_VERSAL)
@@ -51,7 +52,7 @@ typedef struct Versal {
 
         struct {
             PL011State uart[XLNX_VERSAL_NR_UARTS];
-            SysBusDevice *gem[XLNX_VERSAL_NR_GEMS];
+            CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
             SysBusDevice *adma[XLNX_VERSAL_NR_ADMAS];
         } iou;
     } lpd;
-- 
2.20.1


