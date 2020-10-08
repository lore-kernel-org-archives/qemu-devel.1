Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16D0C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 02:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A56020B1F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 02:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oZX09gio"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A56020B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQLtl-0007Pg-8V
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 22:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kQLsg-0005xk-Fk
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 22:42:10 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:38758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kQLse-0006tt-Q9
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 22:42:10 -0400
Received: by mail-qt1-x844.google.com with SMTP id q26so3911241qtb.5
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 19:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=S2Iy8pepTnlMACsozQ/NKopOYTXME8B9rCZZ8IS6SeA=;
 b=oZX09giotNyejoWb2DdyEt7/E90dRjUTvAFp7QuGNip1gNeWwxRxPZ9rCPkp8v/gpJ
 oShsWQEbmUraIu/cuvplfgsCOsgG+Xp/bAcDapfhh+krY0GORU8dYdfOjQ33pA2gNsf2
 t+VohewVHrRUtAKtHDnezxe1ZUDKUW4MLfc0RSjElXk9t4vhHUm/ssxcL5EYcEyOGq4N
 amJabMfpZwikIIQIjWOn5Ontx95Zjh64esaViIZnI07OLcqkT1KsKmQNNCsUR0mO89Wc
 RTxcMN02pf5xBppiUznTcteTxZim/KpE5D+mzzc/lqK2oHCZJZ7mZ8/wColFCV4ewwEs
 q/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=S2Iy8pepTnlMACsozQ/NKopOYTXME8B9rCZZ8IS6SeA=;
 b=tQRyowv/RiWGdqxJ1BWwD6hfVS61BSzevORl2M8AomvNP7swC930yA+naY04yo7HDM
 a5EGY3Sf2V1YJBvB+5OrxeqCJB7fjCR3E9nVzNfocQ/3RgI1rEAPtLRA3ykr9Z+ctHv2
 f0maScUviaUeXC1Oicu8Jh6MXrOPfYw+h8TDQgnLXeHD6Kx1ujYsRo1fBMx/ql4iaAec
 MNVKfITscKYRARIAdZYQvW7FJkarkv1huw/AoNoYMy4hk6WmWld9u1aLbvNsB2Vc8SH7
 OqDlFWRU4csq3b19RkxDtjKxMFiW8dgBbfy1KdaK36BPdiMKaAPAiwECfq/WZ1IaUBZj
 En2A==
X-Gm-Message-State: AOAM533otnSctAdLn3uwZ54082z2LHYnxISiYcVWjZYalXUsynOyQtYB
 JmL2mArC7sIzn1AmAsAvnXka8A==
X-Google-Smtp-Source: ABdhPJxPdDjZnHbqu5gYp2A88LGKzDhlhsNFSThW3owwANndTZ79XlM+q2q/F5iefVVsnZgn8fTRXQ==
X-Received: by 2002:aed:2fa1:: with SMTP id m30mr5462614qtd.273.1602124927815; 
 Wed, 07 Oct 2020 19:42:07 -0700 (PDT)
Received: from master.ht.home ([2607:fea8:e2a0:e950::d884])
 by smtp.googlemail.com with ESMTPSA id m3sm3005031qkh.10.2020.10.07.19.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 19:42:07 -0700 (PDT)
From: Shashi Mallela <shashi.mallela@linaro.org>
To: peter.maydell@linaro.org,
	leif@nuviainc.com,
	rad@semihalf.com
Subject: [PATCH v3 2/2] hw/arm/sbsa-ref: add SBSA watchdog device
Date: Wed,  7 Oct 2020 22:42:03 -0400
Message-Id: <20201008024203.112303-3-shashi.mallela@linaro.org>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201008024203.112303-1-shashi.mallela@linaro.org>
References: <20201008024203.112303-1-shashi.mallela@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=shashi.mallela@linaro.org; helo=mail-qt1-x844.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 hw/arm/sbsa-ref.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 9c3a893bedfd..1e6ef124924c 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -40,6 +40,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/usb.h"
 #include "hw/char/pl011.h"
+#include "hw/watchdog/wdt_sbsa_gwdt.h"
 #include "net/net.h"
 #include "qom/object.h"
 
@@ -64,6 +65,9 @@ enum {
     SBSA_GIC_DIST,
     SBSA_GIC_REDIST,
     SBSA_SECURE_EC,
+    SBSA_GWDT,
+    SBSA_GWDT_REFRESH,
+    SBSA_GWDT_CONTROL,
     SBSA_SMMU,
     SBSA_UART,
     SBSA_RTC,
@@ -104,6 +108,8 @@ static const MemMapEntry sbsa_ref_memmap[] = {
     [SBSA_GIC_DIST] =           { 0x40060000, 0x00010000 },
     [SBSA_GIC_REDIST] =         { 0x40080000, 0x04000000 },
     [SBSA_SECURE_EC] =          { 0x50000000, 0x00001000 },
+    [SBSA_GWDT_REFRESH] =       { 0x50010000, 0x00001000 },
+    [SBSA_GWDT_CONTROL] =       { 0x50011000, 0x00001000 },
     [SBSA_UART] =               { 0x60000000, 0x00001000 },
     [SBSA_RTC] =                { 0x60010000, 0x00001000 },
     [SBSA_GPIO] =               { 0x60020000, 0x00001000 },
@@ -133,6 +139,7 @@ static const int sbsa_ref_irqmap[] = {
     [SBSA_SECURE_UART_MM] = 9,
     [SBSA_AHCI] = 10,
     [SBSA_EHCI] = 11,
+    [SBSA_GWDT] = 12,
 };
 
 static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
@@ -141,6 +148,26 @@ static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
     return arm_cpu_mp_affinity(idx, clustersz);
 }
 
+static void create_wdt_fdt(SBSAMachineState *sms)
+{
+    char *nodename;
+    const char compat[] = "arm,sbsa-gwdt";
+
+    hwaddr rbase = sbsa_ref_memmap[SBSA_GWDT_REFRESH].base;
+    hwaddr cbase = sbsa_ref_memmap[SBSA_GWDT_CONTROL].base;
+
+    nodename = g_strdup_printf("/watchdog@%" PRIx64, rbase);
+    qemu_fdt_add_subnode(sms->fdt, nodename);
+
+    qemu_fdt_setprop(sms->fdt, nodename, "compatible",
+                             compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(sms->fdt, nodename, "reg",
+                                 2, rbase, 2, SBSA_GWDT_RMMIO_SIZE,
+                                 2, cbase, 2, SBSA_GWDT_CMMIO_SIZE);
+    qemu_fdt_setprop_cell(sms->fdt, nodename, "timeout-sec", 30);
+    g_free(nodename);
+}
+
 /*
  * Firmware on this machine only uses ACPI table to load OS, these limited
  * device tree nodes are just to let firmware know the info which varies from
@@ -219,6 +246,7 @@ static void create_fdt(SBSAMachineState *sms)
 
         g_free(nodename);
     }
+    create_wdt_fdt(sms);
 }
 
 #define SBSA_FLASH_SECTOR_SIZE (256 * KiB)
@@ -447,6 +475,20 @@ static void create_rtc(const SBSAMachineState *sms)
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
@@ -730,6 +772,8 @@ static void sbsa_ref_init(MachineState *machine)
 
     create_rtc(sms);
 
+    create_wdt(sms);
+
     create_gpio(sms);
 
     create_ahci(sms);
-- 
2.18.4


