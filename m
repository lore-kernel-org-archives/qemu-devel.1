Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0544C47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 652402073E
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TD+kVmoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 652402073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaRn-0003HC-Az
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHq-0000BF-Dn
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:30 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:38462)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHo-0000sZ-9x
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:29 -0400
Received: by mail-wr1-x42d.google.com with SMTP id x17so20700019wrt.5
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=H7Q0HbKnJYd5x/Hsj0Qn9RB+/KpzA8r2pgsAqpzc5CI=;
 b=TD+kVmoykMuKu7s5CmBhR7uys6eZiGpc8yIvrNLI0JkPTLblrvHFq7zLiesaD0Eulb
 PVOCDtkgvhOpWWyKdM8YuJmcMP9D8lGwVVlY7Ah8QzkgpmOChQkfXDzfFrhYaObbXoqA
 Z+duk3yXoOrLKTXKE5I5xNKj9LmqiFbhm0tkTYVQmT/9uKQ+ilI/njCZYAs99u7UCZE1
 0d0sECAIOjsxfvLV9qVD/DN+KcwvlNLPcxV+5+CctEW9awrGxUkMhTsiXRbJLS5HaP9h
 myQSV4l94KzgNOIjsN7pRcILFduNrV4nPM9b2PBBKk5PirIqyZAfpkHAdivHa8X4CckF
 3fXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H7Q0HbKnJYd5x/Hsj0Qn9RB+/KpzA8r2pgsAqpzc5CI=;
 b=Zw93QxTTkZ517Tet0H4l1vBRneBN/+RSOup/Kh26e771JeFikwtK+Nnq+f0cWrTpkg
 NuPcPHRmbX7pyRG3LCFKZoyrqv1JTtnbGTK8gyBqm4Iip7jeQFkVWAixOPbU+dMDdFlc
 x5P7gG0e27qsuNjYLkMoMUlHEeye/qFEpRlCSpIb5e5zGqlPBX/re4MgEj9yOLsYRLQI
 UAI7+Op3971VfMj+OG4bUbBs4LqJVZzcQcQlOphUYaCAt4kvJ9KIIvsNaEYPGs2IWcqp
 1hErBspspxXjNRjauboD0IpI+no9Rdn5YOWLaI0Ck8+fvVTzbuPyHYOL+Q7ll9DG6emj
 yw6w==
X-Gm-Message-State: AGi0Pub3B2h4hQYZYnYxEZqRbg+8GYhtVjzgm4W0vKhkoeUCfp9oFsWV
 OtJ3IfXJcH7j+KP5AF49a4uz6PZvdNbJOQ==
X-Google-Smtp-Source: APiQypL0bG04ZPnoikIQ+XkIAhmXoPidTD/IffLkGG/un670MI2dkCd4UayryWz8rKvh/7UK5P6XwA==
X-Received: by 2002:a5d:6cce:: with SMTP id c14mr18180895wrc.424.1588595606598; 
 Mon, 04 May 2020 05:33:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/39] hw/arm: versal: Embed the GEMs into the SoC type
Date: Mon,  4 May 2020 13:32:43 +0100
Message-Id: <20200504123309.3808-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

Embed the GEMs into the SoC type.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20200427181649.26851-6-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h |  3 ++-
 hw/arm/xlnx-versal.c         | 15 ++++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index a3dfd064b3c..01da736a5b2 100644
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
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index dbde03b7e69..e424aa789e3 100644
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
-- 
2.20.1


