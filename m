Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7939C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:41:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7564F2075B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HuXnaY6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7564F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaPy-0008Fs-Hu
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHo-00007i-B5
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:28 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52652)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHn-0000r8-2m
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:28 -0400
Received: by mail-wm1-x343.google.com with SMTP id 188so8222483wmc.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=yAm+X6LwZsg/LS8zarCIG4F8biyOYqPggWmduB/wNPw=;
 b=HuXnaY6vFoD1S/P7Z+cQr0xpjr55nHpijyROnz7XOwHmQIn42VF9szlh2cdCW4/jkv
 hHzO0W4gDYJamOF2J+bKjGuK4tDuaLEk5CduD+M0/WVNLPJJn6wa7Qhpi5M68p4AXwKc
 E1pFY6z46lI1fF0fT/zObNisVU2LeITVL4juHIaS3OcUAJqKh19pvN8eB9qNinhpNEG+
 IzrAF/ssU6Bo2T+xNold6H3DZ4B6oq/t/J/Ay2P7hgCb/vzFJPzNVFRZvWoVjhyUSfAk
 PhsaqoyWG9d2m1Oi1A+raGUNFkO09CiJVHlKvUvZCXOc+roUKR69SYcpTys8GLNfFUPW
 UEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yAm+X6LwZsg/LS8zarCIG4F8biyOYqPggWmduB/wNPw=;
 b=umAwb5SFb50mbfHhFs/t7aO2RCGQtRrTJO+P+cY2YEu7r9V1DrrnXjzdTdrrooqxOI
 gBIqvLhOUzOqvNFUz7eQya87N8WvoIcOwYQDv/mT2qcFqqTO4YO+7GyihNNuyV4XYcbl
 hhAem8WJMPaZg16hVlCjv4ubCrcEa6mMDW1y612lYA+6nyxCAJei71MSXFzQQD2RjrV6
 7wpKJL+XnSvlq6QyrTx33rGf+IjwbBKSM5ict7BuN4gRGs0NDTpyc5Maz7u76mS8GXB8
 WaRigIpdA5rgGHkMKnVb+4CYaL96dzcI17944+8DDxeTUJ1qXgD8oYffWIE7G7S8+i0Y
 2yKA==
X-Gm-Message-State: AGi0PuaR5PTFwRm/hcF2MLfVU+4XDRiVO7dvSHGRj0XNthM756hTDziu
 Y/aNzsqBSUstBdIV25zhPtbjCFrogbDHcw==
X-Google-Smtp-Source: APiQypKIeOe2qsVsMH4l2HmxfMlyiQs5P4CCIFcpKRBovyjDUAxUxpSUjh+1m3ilQ/zvhCA2HFiliw==
X-Received: by 2002:a1c:44b:: with SMTP id 72mr14130561wme.58.1588595605434;
 Mon, 04 May 2020 05:33:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/39] hw/arm: versal: Embed the UARTs into the SoC type
Date: Mon,  4 May 2020 13:32:42 +0100
Message-Id: <20200504123309.3808-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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

Embed the UARTs into the SoC type.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20200427181649.26851-5-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h |  3 ++-
 hw/arm/xlnx-versal.c         | 12 ++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 6c0a692b2fd..a3dfd064b3c 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -15,6 +15,7 @@
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
 #include "hw/intc/arm_gicv3.h"
+#include "hw/char/pl011.h"
 
 #define TYPE_XLNX_VERSAL "xlnx-versal"
 #define XLNX_VERSAL(obj) OBJECT_CHECK(Versal, (obj), TYPE_XLNX_VERSAL)
@@ -49,7 +50,7 @@ typedef struct Versal {
         MemoryRegion mr_ocm;
 
         struct {
-            SysBusDevice *uart[XLNX_VERSAL_NR_UARTS];
+            PL011State uart[XLNX_VERSAL_NR_UARTS];
             SysBusDevice *gem[XLNX_VERSAL_NR_GEMS];
             SysBusDevice *adma[XLNX_VERSAL_NR_ADMAS];
         } iou;
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index cc696e44c06..dbde03b7e69 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -21,7 +21,6 @@
 #include "kvm_arm.h"
 #include "hw/misc/unimp.h"
 #include "hw/arm/xlnx-versal.h"
-#include "hw/char/pl011.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define GEM_REVISION        0x40070106
@@ -144,16 +143,17 @@ static void versal_create_uarts(Versal *s, qemu_irq *pic)
         DeviceState *dev;
         MemoryRegion *mr;
 
-        dev = qdev_create(NULL, TYPE_PL011);
-        s->lpd.iou.uart[i] = SYS_BUS_DEVICE(dev);
+        sysbus_init_child_obj(OBJECT(s), name,
+                              &s->lpd.iou.uart[i], sizeof(s->lpd.iou.uart[i]),
+                              TYPE_PL011);
+        dev = DEVICE(&s->lpd.iou.uart[i]);
         qdev_prop_set_chr(dev, "chardev", serial_hd(i));
-        object_property_add_child(OBJECT(s), name, OBJECT(dev), &error_fatal);
         qdev_init_nofail(dev);
 
-        mr = sysbus_mmio_get_region(s->lpd.iou.uart[i], 0);
+        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
         memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
 
-        sysbus_connect_irq(s->lpd.iou.uart[i], 0, pic[irqs[i]]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irqs[i]]);
         g_free(name);
     }
 }
-- 
2.20.1


