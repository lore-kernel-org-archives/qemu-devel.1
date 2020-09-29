Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0812C4741F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 18:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4233E21548
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 18:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o+VlDJDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4233E21548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNK4Q-00020p-Vc
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 14:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kNJz7-0006nq-Fp
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 14:04:17 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:42026)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kNJz5-0001Li-5c
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 14:04:17 -0400
Received: by mail-qt1-x844.google.com with SMTP id y11so4306667qtn.9
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 11:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=M/DFtl07DbniPTffKuqIPeshFScMcLoVhHYnqUvbx0k=;
 b=o+VlDJDv+CVV7igLMurV+r2w1NuRvw4jHycHXU4fcMb4ermk2hgukvraImNbxLZbCZ
 1DMYb5Kqgo6Y/CimanLqEtuk3GCELwHvMDu/M2YxqwF9EU4XHLeyNymgXPqnpKsXZGXO
 BqhHAG1maStFn4SM4EGGG/qMtRrNOFOP9mL1E8nHjH/5RL8CdGkgOblKkpjGy60q8PFu
 d+4ZvxJ5ZE0c5FMJx63dF6CY7xAZmEIs3fd6VMyQT7vapuvZitVExu7vCs2LEo4xyNe3
 lfcXnUyrudBgXx95RrIsj4lhAENWXZFVNAFzWYODVWygKUlMp0M38V5yuSe5KCPCHOvY
 HVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=M/DFtl07DbniPTffKuqIPeshFScMcLoVhHYnqUvbx0k=;
 b=QhZDQmQyAgWGDOB8b0fDhg9KLlKflPOwAiH2R7QmGMkaj3XLG0r0FrCjC+v2hBFOt4
 I6M23pGdq+JT5bCl8G54Xpd3zYNRAbsoEfP5kwOVPXCa9kfZsJN+Af+YlgT6C2aUXJaH
 QfqSrn2z3fhvVqn1Xie0AbHTgs4dEdwuKTV6Y70JrwV05ng1oRbP91qH4QBu0/y+DtB2
 g6+RvXgQjNmUZ37Srm7ph4EyCx3KBjSQrsvY8gNx5z/IfmRtVF43xHV7E7PlFvFC5rEn
 jirQPfRIulRD663kIVzcgsy4J8taoekktEOhXA2fXWqF1ehpoUL674nhoPQ0aH9jp/6o
 HqYA==
X-Gm-Message-State: AOAM530Gx3Op22Du2Ts7OYcDi2afhglFqFw/Kv+xt3UHK9RRjSlvWyhX
 60dih+aR+npP0k2MUAbteP0MOA==
X-Google-Smtp-Source: ABdhPJzkhP/+ERtdIEwNc5rSv3aCO2SoenOG0bw2EPoZAewFJH7Q8vks0Cfd3McO2qtPBLtxywxEQw==
X-Received: by 2002:ac8:748d:: with SMTP id v13mr4563099qtq.301.1601402654213; 
 Tue, 29 Sep 2020 11:04:14 -0700 (PDT)
Received: from master.hitronhub.home ([2607:fea8:e2a0:e950::661])
 by smtp.googlemail.com with ESMTPSA id n7sm6600337qtf.27.2020.09.29.11.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 11:04:13 -0700 (PDT)
From: Shashi Mallela <shashi.mallela@linaro.org>
To: peter.maydell@linaro.org,
	leif@nuviainc.com,
	rad@semihalf.com
Subject: [PATCH v2 2/2] hw/arm/sbsa-ref: add SBSA watchdog device
Date: Tue, 29 Sep 2020 14:04:10 -0400
Message-Id: <20200929180410.33058-3-shashi.mallela@linaro.org>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200929180410.33058-1-shashi.mallela@linaro.org>
References: <20200929180410.33058-1-shashi.mallela@linaro.org>
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
 hw/arm/sbsa-ref.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 257ada942550..99a16f3c93ba 100644
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
@@ -109,6 +113,8 @@ static const MemMapEntry sbsa_ref_memmap[] = {
     [SBSA_GIC_DIST] =           { 0x40060000, 0x00010000 },
     [SBSA_GIC_REDIST] =         { 0x40080000, 0x04000000 },
     [SBSA_SECURE_EC] =          { 0x50000000, 0x00001000 },
+    [SBSA_GWDT_REFRESH] =       { 0x50010000, 0x00001000 },
+    [SBSA_GWDT_CONTROL] =       { 0x50011000, 0x00001000 },
     [SBSA_UART] =               { 0x60000000, 0x00001000 },
     [SBSA_RTC] =                { 0x60010000, 0x00001000 },
     [SBSA_GPIO] =               { 0x60020000, 0x00001000 },
@@ -138,6 +144,7 @@ static const int sbsa_ref_irqmap[] = {
     [SBSA_SECURE_UART_MM] = 9,
     [SBSA_AHCI] = 10,
     [SBSA_EHCI] = 11,
+    [SBSA_GWDT] = 12,
 };
 
 static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
@@ -452,6 +459,20 @@ static void create_rtc(const SBSAMachineState *sms)
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
@@ -735,6 +756,8 @@ static void sbsa_ref_init(MachineState *machine)
 
     create_rtc(sms);
 
+    create_wdt(sms);
+
     create_gpio(sms);
 
     create_ahci(sms);
-- 
2.18.4


