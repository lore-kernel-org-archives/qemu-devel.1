Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB852C3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:32:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C17207FD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jNfvHeqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C17207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tPv-0004Cd-S5
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:32:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tOs-0003B3-Qk
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tOr-00024g-Ea
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:06 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:43398)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tOr-00022a-85
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:05 -0500
Received: by mail-wr1-x42c.google.com with SMTP id v9so1191575wrf.10
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ElBYJtmzlxhrgNMoiYtNokYMz79Cy1FhYV1DNGkLZoc=;
 b=jNfvHeqZtux8ygKrbnRTdYn0mQE+kPK7AE7MGx2yHxGpvNX7paSIARQ/6GOAAJwNTy
 Jji4kex6IRnzkc7QnotrGVsezuY3hXxG1euc8TqnOUf3Yu3jzwm2pgOrpN7wGrivhwut
 hgidYgaOJRw4PjSBf7FsHeoYo0bTV/aXRo33bpWCd/cWAsFUgWUENI5izg9RRdJRMyz8
 07SNHEDb/CAxPENw1+WvDbeKhi89HGnYHVKEuEtYhd6ct0qVARtFiZ5W/OoeanzNB/Dy
 hHl6ttKia4PMYzMnSB7naQrEcYDxgF7x4cFKjTWmKhn8b0wjHpvBezHl80lp8R3XO/wK
 LDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ElBYJtmzlxhrgNMoiYtNokYMz79Cy1FhYV1DNGkLZoc=;
 b=D4SKqwM+xthwV6TBay3FPcBNLhuLhp9Vx4ADyzUaReeDoyZrJr1OVEalhMkr7UWEhK
 y1GERf0bKgtEYbSN/U8u/jdlUAdDuTCs/XOJ7rsMW+0ZmTvWe3dQMSmuoKuPmdSYcL+Q
 ekWyjpeHTgTR+HlWoUHkEP2emD9cUQpPCj1xJ4Tqg2oqlM32YDLv0vjok/rXnMD/GI3t
 PuNOqLEwUxnw8lXuLNVu3uSyfUdGMK89/8Bdb6fJ8W2hVpWKTg2Gw6sNhMUJxng8FnPS
 DRBS52dIKtwcBllGFgmPw6dRVwllIXN1SEIBeN+xRzHrPmrd78UKi7Cpd2l7OK4BmusS
 7PYg==
X-Gm-Message-State: ANhLgQ3MzhI3UieoOxB/D7wHoDhZOe7bIo118IjoE8CTsZGNfpPm+p4E
 DiJrh87CtuOBaSCaQTMjURoo4KS1kzwobg==
X-Google-Smtp-Source: ADFU+vtxEJQ8KWl81dGZnJqCqfAX3dq9MnPi6+zpPeYEiC5YmZufjVC0TF0gK3g5fkwccQrrmN7yOA==
X-Received: by 2002:a5d:56c9:: with SMTP id m9mr10477603wrw.289.1583425863859; 
 Thu, 05 Mar 2020 08:31:03 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:03 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/37] hw/arm: versal: Add support for the LPD ADMAs
Date: Thu,  5 Mar 2020 16:30:24 +0000
Message-Id: <20200305163100.22912-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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

Add support for the Versal LPD ADMAs.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h |  6 ++++++
 hw/arm/xlnx-versal.c         | 24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index d844c4ffe47..6c0a692b2fd 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -22,6 +22,7 @@
 #define XLNX_VERSAL_NR_ACPUS   2
 #define XLNX_VERSAL_NR_UARTS   2
 #define XLNX_VERSAL_NR_GEMS    2
+#define XLNX_VERSAL_NR_ADMAS   8
 #define XLNX_VERSAL_NR_IRQS    192
 
 typedef struct Versal {
@@ -50,6 +51,7 @@ typedef struct Versal {
         struct {
             SysBusDevice *uart[XLNX_VERSAL_NR_UARTS];
             SysBusDevice *gem[XLNX_VERSAL_NR_GEMS];
+            SysBusDevice *adma[XLNX_VERSAL_NR_ADMAS];
         } iou;
     } lpd;
 
@@ -74,6 +76,7 @@ typedef struct Versal {
 #define VERSAL_GEM0_WAKE_IRQ_0     57
 #define VERSAL_GEM1_IRQ_0          58
 #define VERSAL_GEM1_WAKE_IRQ_0     59
+#define VERSAL_ADMA_IRQ_0          60
 
 /* Architecturally reserved IRQs suitable for virtualization.  */
 #define VERSAL_RSVD_IRQ_FIRST 111
@@ -96,6 +99,9 @@ typedef struct Versal {
 #define MM_GEM1                     0xff0d0000U
 #define MM_GEM1_SIZE                0x10000
 
+#define MM_ADMA_CH0                 0xffa80000U
+#define MM_ADMA_CH0_SIZE            0x10000
+
 #define MM_OCM                      0xfffc0000U
 #define MM_OCM_SIZE                 0x40000
 
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 403fc7b8814..cb0122a3a68 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -194,6 +194,29 @@ static void versal_create_gems(Versal *s, qemu_irq *pic)
     }
 }
 
+static void versal_create_admas(Versal *s, qemu_irq *pic)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.adma); i++) {
+        char *name = g_strdup_printf("adma%d", i);
+        DeviceState *dev;
+        MemoryRegion *mr;
+
+        dev = qdev_create(NULL, "xlnx.zdma");
+        s->lpd.iou.adma[i] = SYS_BUS_DEVICE(dev);
+        object_property_add_child(OBJECT(s), name, OBJECT(dev), &error_fatal);
+        qdev_init_nofail(dev);
+
+        mr = sysbus_mmio_get_region(s->lpd.iou.adma[i], 0);
+        memory_region_add_subregion(&s->mr_ps,
+                                    MM_ADMA_CH0 + i * MM_ADMA_CH0_SIZE, mr);
+
+        sysbus_connect_irq(s->lpd.iou.adma[i], 0, pic[VERSAL_ADMA_IRQ_0 + i]);
+        g_free(name);
+    }
+}
+
 /* This takes the board allocated linear DDR memory and creates aliases
  * for each split DDR range/aperture on the Versal address map.
  */
@@ -275,6 +298,7 @@ static void versal_realize(DeviceState *dev, Error **errp)
     versal_create_apu_gic(s, pic);
     versal_create_uarts(s, pic);
     versal_create_gems(s, pic);
+    versal_create_admas(s, pic);
     versal_map_ddr(s);
     versal_unimp(s);
 
-- 
2.20.1


