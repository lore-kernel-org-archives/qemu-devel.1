Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93939C4BA06
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 03:18:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6033824672
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 03:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxqWc6eq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6033824672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j79hA-0000Uk-Jd
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 22:18:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1j79gP-0007ux-Jy
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 22:17:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1j79gO-0003QU-G2
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 22:17:53 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:40777)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1j79gO-0003OJ-8q; Wed, 26 Feb 2020 22:17:52 -0500
Received: by mail-lj1-x243.google.com with SMTP id 143so1474800ljj.7;
 Wed, 26 Feb 2020 19:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=omqTFTu+qINNVRrQ0hgXY5Qb04TvdzoxDE5V+PXlLMs=;
 b=DxqWc6eqRVj2+DzM+VQYfasbcUT3aDE4zTAd60arnk/2B0HqtOK/5Ll3+PHD5Zf5wo
 vYh0vI6OUE5XJ2Hxce/RSHgNq6+RYHmMEqB15zTLc4BWn7qh956fmNwJA4IWkntfE9lh
 J9ovzPhySV0PztqNeQj5e/X22TMxoATuMfP+amN7ohvU8oNTNEu/DH/qyMIkzi6+ym7I
 VbwXUmoXzYAGW6JnwluaNLNgEwEzqLqy6oJVT3qFEMopIkbyvjJuZ/Q5Q+BKRnfbHSyz
 MQpP84ODKxrfKWdDKy+RML72MR/IHIPHB4EvB2qFuwLIWd46PXjmCXy3xQoAxRLejGuM
 uHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=omqTFTu+qINNVRrQ0hgXY5Qb04TvdzoxDE5V+PXlLMs=;
 b=CZUJXVqd1tJ285umpgCMZccbLEMBTrBwW5OMrQj9pMMNa1bievP63Q/A3970YSsCTN
 15AdTETHetm1tZuwHf3DbaiLCxue6XtfcT5ndsEzj0kCxCfgXzxr0U1CJbZItOyhV+pK
 YL7BS6dmtf96/DHrCTIuuyu7qD2JAelzuz3fsIz/VvGIpoNjW6sgNyAVQ3tD0HGp0gQ7
 of6eUYH1n377RYrRtRDqaDummv5SpX2JGpjxk94/Rd86AMeb9W9ZXi4iIKGbcG0zPNsY
 tCdk1iQl/5JZMz10Az6Vh4bU+3yPp3LR4QO1R1P40gJceU3KK91jI7xJ+q9MyOBPZlwd
 Ap3A==
X-Gm-Message-State: ANhLgQ1aarViYBWh/onMoiU/6BxJaJozh0Xr5242FRUx9qw/XnpsvDfC
 Siqss4ziyVTmm8rM9FTKX2NsNbn0wb3vAA==
X-Google-Smtp-Source: ADFU+vt7eaqVtqadKqzqDTJW/hcfAPfflg8YHsOLceQui3dlITuuM8ZJ9H8yi8Z7ADSSAf6q7orazQ==
X-Received: by 2002:a05:651c:1049:: with SMTP id
 x9mr1347752ljm.233.1582773470222; 
 Wed, 26 Feb 2020 19:17:50 -0800 (PST)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id 23sm2178619ljw.31.2020.02.26.19.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 19:17:49 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/2] hw/arm: versal: Add support for the LPD ADMAs
Date: Thu, 27 Feb 2020 16:44:23 +0100
Message-Id: <20200227154424.6849-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200227154424.6849-1-edgar.iglesias@gmail.com>
References: <20200227154424.6849-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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

Add support for the Versal LPD ADMAs.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/arm/xlnx-versal.c         | 24 ++++++++++++++++++++++++
 include/hw/arm/xlnx-versal.h |  6 ++++++
 2 files changed, 30 insertions(+)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 1cf3daaf4f..f9beba07ed 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -193,6 +193,29 @@ static void versal_create_gems(Versal *s, qemu_irq *pic)
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
@@ -274,6 +297,7 @@ static void versal_realize(DeviceState *dev, Error **errp)
     versal_create_apu_gic(s, pic);
     versal_create_uarts(s, pic);
     versal_create_gems(s, pic);
+    versal_create_admas(s, pic);
     versal_map_ddr(s);
     versal_unimp(s);
 
diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index d844c4ffe4..6c0a692b2f 100644
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
 
-- 
2.20.1


