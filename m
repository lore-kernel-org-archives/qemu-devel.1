Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE70BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:18:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E80624910
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ONglAIWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E80624910
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSM4O-0007rH-DV
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 11:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kSM2Z-000698-FT
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:16:39 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:43358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kSM2X-0000BV-6O
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:16:39 -0400
Received: by mail-qt1-x841.google.com with SMTP id e6so130729qtw.10
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 08:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=it2mshTNIXoFp9WiwmrCTKmpiiTPTprast5n2192OiQ=;
 b=ONglAIWJN2PsixZMD6H3fnRyZCSsV6LFmiTsqyJnYS4mCwCySk3aWKcFt3iYcKC5HK
 b468fIa4Z25OEBcOfXeR30ziTK2iQdy5VhBKxZ0d3ceIxz9NgvPdI3mUQmI5w3AB2pzc
 VuPeFARug87MDYJR73Pq7xFgKzA2WLzRjheLAwhjgv00O9eYaT0xg3cvTWH5npkeHs2K
 IUqcRQ39hBvPbaZXcRjlx1TXoNCzNDRlfxbne2t6iPnB18Vlo8MjuhA1RA6bfEUrheJq
 X3Gh8WxRAW3UmNT6Qu2xxvoJF6oKifIQwQKKzNOwAXCOdOmsgiCULSxhUrwqb1rQw69B
 oH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=it2mshTNIXoFp9WiwmrCTKmpiiTPTprast5n2192OiQ=;
 b=JbmeGvIpvxsNhuujXbfdip4i/NvCP8cOg9r6prHfG48G78rYhCniBcIFSarpazP/n5
 QycGPJ16sNrfK5MFZuBfWd4dBcZLz11XGIzxtG/hymsoHfWLTzYWvs/MHNi3oHPxpQjG
 id7gQ2VR2PrhkoTImTDho9wtJiOI/unCRfSdJA0WD0JFXV2Mjyjg1vH5GNXNX2OeQvKY
 X3dmtESBkdeEUKzN9J09og9QDiJFgIGtdThy7PNA2M07pZNBGtqgrpMSzdpstQ/8dAsE
 0V5SKcFXzPBZUr+KvIKUYQtRj6noTmVP8+VtQzO/DC1lFtEOU5svji9cwxlrHlnw+YXz
 Ujzg==
X-Gm-Message-State: AOAM531EoZGP4+my4nbtwbJ41SGXOcex0NXVoZUWEEwJapeTFjKMCg2X
 bMTN0xOxrXYOfNogN5UcFv+fmQ==
X-Google-Smtp-Source: ABdhPJxK0LUSbq0jaGSK5Dwx4Uk24C3e8wgu87Yy+omKikC/+fnjuz7CbDVibdetZt95Lx0xmMihvA==
X-Received: by 2002:ac8:1a6f:: with SMTP id q44mr154792qtk.136.1602602195827; 
 Tue, 13 Oct 2020 08:16:35 -0700 (PDT)
Received: from master.ht.home ([2607:fea8:e2a0:e950::5917])
 by smtp.googlemail.com with ESMTPSA id g20sm55604qtq.51.2020.10.13.08.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 08:16:35 -0700 (PDT)
From: Shashi Mallela <shashi.mallela@linaro.org>
To: peter.maydell@linaro.org,
	leif@nuviainc.com,
	rad@semihalf.com
Subject: [PATCH v5 2/2] hw/arm/sbsa-ref: add SBSA watchdog device
Date: Tue, 13 Oct 2020 11:16:31 -0400
Message-Id: <20201013151631.30678-3-shashi.mallela@linaro.org>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201013151631.30678-1-shashi.mallela@linaro.org>
References: <20201013151631.30678-1-shashi.mallela@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::841;
 envelope-from=shashi.mallela@linaro.org; helo=mail-qt1-x841.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Included the newly implemented SBSA generic watchdog device model into
SBSA platform

Signed-off-by: Shashi Mallela <shashi.mallela@linaro.org>
---
 hw/arm/sbsa-ref.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 9c3a893bedfd..97ed41607119 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -30,6 +30,7 @@
 #include "exec/hwaddr.h"
 #include "kvm_arm.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/fdt.h"
 #include "hw/block/flash.h"
 #include "hw/boards.h"
 #include "hw/ide/internal.h"
@@ -40,6 +41,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/usb.h"
 #include "hw/char/pl011.h"
+#include "hw/watchdog/wdt_sbsa_gwdt.h"
 #include "net/net.h"
 #include "qom/object.h"
 
@@ -64,6 +66,9 @@ enum {
     SBSA_GIC_DIST,
     SBSA_GIC_REDIST,
     SBSA_SECURE_EC,
+    SBSA_GWDT,
+    SBSA_GWDT_REFRESH,
+    SBSA_GWDT_CONTROL,
     SBSA_SMMU,
     SBSA_UART,
     SBSA_RTC,
@@ -104,6 +109,8 @@ static const MemMapEntry sbsa_ref_memmap[] = {
     [SBSA_GIC_DIST] =           { 0x40060000, 0x00010000 },
     [SBSA_GIC_REDIST] =         { 0x40080000, 0x04000000 },
     [SBSA_SECURE_EC] =          { 0x50000000, 0x00001000 },
+    [SBSA_GWDT_REFRESH] =       { 0x50010000, 0x00001000 },
+    [SBSA_GWDT_CONTROL] =       { 0x50011000, 0x00001000 },
     [SBSA_UART] =               { 0x60000000, 0x00001000 },
     [SBSA_RTC] =                { 0x60010000, 0x00001000 },
     [SBSA_GPIO] =               { 0x60020000, 0x00001000 },
@@ -133,6 +140,8 @@ static const int sbsa_ref_irqmap[] = {
     [SBSA_SECURE_UART_MM] = 9,
     [SBSA_AHCI] = 10,
     [SBSA_EHCI] = 11,
+    [SBSA_SMMU] = 12, /* ... to 15 */
+    [SBSA_GWDT] = 16,
 };
 
 static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
@@ -141,6 +150,30 @@ static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
     return arm_cpu_mp_affinity(idx, clustersz);
 }
 
+static void create_wdt_fdt(SBSAMachineState *sms)
+{
+    char *nodename;
+    const char compat[] = "arm,sbsa-gwdt";
+
+    hwaddr rbase = sbsa_ref_memmap[SBSA_GWDT_REFRESH].base;
+    hwaddr cbase = sbsa_ref_memmap[SBSA_GWDT_CONTROL].base;
+    int irq = sbsa_ref_irqmap[SBSA_GWDT];
+
+    nodename = g_strdup_printf("/watchdog@%" PRIx64, rbase);
+    qemu_fdt_add_subnode(sms->fdt, nodename);
+
+    qemu_fdt_setprop(sms->fdt, nodename, "compatible",
+                             compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(sms->fdt, nodename, "reg",
+                                 2, rbase, 2, SBSA_GWDT_RMMIO_SIZE,
+                                 2, cbase, 2, SBSA_GWDT_CMMIO_SIZE);
+    qemu_fdt_setprop_cells(sms->fdt, nodename, "interrupts",
+                                GIC_FDT_IRQ_TYPE_PPI, irq,
+                                GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+    qemu_fdt_setprop_cell(sms->fdt, nodename, "timeout-sec", 30);
+    g_free(nodename);
+}
+
 /*
  * Firmware on this machine only uses ACPI table to load OS, these limited
  * device tree nodes are just to let firmware know the info which varies from
@@ -219,6 +252,7 @@ static void create_fdt(SBSAMachineState *sms)
 
         g_free(nodename);
     }
+    create_wdt_fdt(sms);
 }
 
 #define SBSA_FLASH_SECTOR_SIZE (256 * KiB)
@@ -447,6 +481,20 @@ static void create_rtc(const SBSAMachineState *sms)
     sysbus_create_simple("pl031", base, qdev_get_gpio_in(sms->gic, irq));
 }
 
+static void create_wdt(const SBSAMachineState *sms)
+{
+    hwaddr rbase = sbsa_ref_memmap[SBSA_GWDT_REFRESH].base;
+    hwaddr cbase = sbsa_ref_memmap[SBSA_GWDT_CONTROL].base;
+    DeviceState *dev = qdev_new(TYPE_WDT_SBSA_GWDT);
+    SysBusDevice *s = SYS_BUS_DEVICE(dev);
+    int irq = sbsa_ref_irqmap[SBSA_GWDT];
+
+    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_mmio_map(s, 0, rbase);
+    sysbus_mmio_map(s, 1, cbase);
+    sysbus_connect_irq(s, 0, qdev_get_gpio_in(sms->gic, irq));
+}
+
 static DeviceState *gpio_key_dev;
 static void sbsa_ref_powerdown_req(Notifier *n, void *opaque)
 {
@@ -730,6 +778,8 @@ static void sbsa_ref_init(MachineState *machine)
 
     create_rtc(sms);
 
+    create_wdt(sms);
+
     create_gpio(sms);
 
     create_ahci(sms);
-- 
2.18.4


