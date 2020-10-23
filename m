Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466E9C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:37:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0D57208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZLJp6A6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D57208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW04U-0007aw-Jj
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kVzV7-0007C1-ES
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:01:09 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:40811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kVzV3-0005wV-Ti
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:01:09 -0400
Received: by mail-qt1-x842.google.com with SMTP id m9so1292391qth.7
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 09:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4X/BP8ZUdTbCxIFY7FzIpRhi0kUvXh7zLhkAzEKUY6w=;
 b=ZLJp6A6a3TGFwdYqbx6ie3gVn2+jZcwsASR/ljfrAHv+gs1KYg0JNtl2oDuOymQyFF
 2/eDX2darIxQbIYjl6s7o4/MoyNDFT14q3pYmekF/shUu3yEelye5dISWIWZDvCd7A29
 GezMqLQ0FRvI+LvrlgGE9pPEDaz2nO3KHqjjNoXiOSaB67YLs55vg+0vGYV+QokY1gxs
 +0pdslL7GesK/d/0B95xESL/UlalG0DmyWyA9y0AOiwY9iBMShzbd1S6/Ma5xLkAnHb0
 p+p18nr3Gg/FjQPxr4X2l6uiOgMa1E0tl2y8v1cMqfMZIeCWxxZ9gkjeBcr9ZatiF0kW
 TZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4X/BP8ZUdTbCxIFY7FzIpRhi0kUvXh7zLhkAzEKUY6w=;
 b=Cr3Dw1fjiy2u9fyNJIeraQIqS68mBuzKBH2QF0Y72bWq9uzmacfwsR5AROWu1XmtAe
 LZsYZ+p3xo+/m4p8YiNfA0W8zWt9eFMf4UC6vsgB6pugHqe/D0lCSJXZ7uOFOWGe/ZgH
 qkeesD1XXrMW/GJDVD6RsNVH6UaG7hrEkDiQwlYxUksudjOMOHSpzqiGrS7wHK6b4jVu
 qMsnGdafgMCnsrtRc+KLS5+AFz40XF9xML2O8Aatqtmwi/K9qeWg6FxDUVpElA8kwLYl
 +RTAeQdJczxlSuL5pGr1+Y+J5AhLwbgX8x42k0eWwy6g8qMreQMH3jsfI1Dr5WotvNOM
 L1lw==
X-Gm-Message-State: AOAM532DgFRtswhJFdpDXwyHRysWKzHUMJWdD8MOMxg9oMnLSH6qDbcr
 XNkdLEUYk18Wl5ZVX5+xttxDkg==
X-Google-Smtp-Source: ABdhPJx35utZ4D3DQ9sNjus0s8NcvbrTyaKTZPjJPUrzFiy5igXj7vTbS+nQ2Fbecb2hKbpcO/7oAA==
X-Received: by 2002:ac8:4e23:: with SMTP id d3mr2830280qtw.304.1603468861169; 
 Fri, 23 Oct 2020 09:01:01 -0700 (PDT)
Received: from localhost.localdomain
 (stsvon1503w-lp130-06-174-91-97-36.dsl.bell.ca. [174.91.97.36])
 by smtp.googlemail.com with ESMTPSA id k16sm1144957qtu.45.2020.10.23.09.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 09:01:00 -0700 (PDT)
From: Shashi Mallela <shashi.mallela@linaro.org>
To: peter.maydell@linaro.org,
	leif@nuviainc.com,
	rad@semihalf.com
Subject: [PATCH v7 2/2] hw/arm/sbsa-ref: add SBSA watchdog device
Date: Fri, 23 Oct 2020 12:00:57 -0400
Message-Id: <20201023160057.21543-3-shashi.mallela@linaro.org>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201023160057.21543-1-shashi.mallela@linaro.org>
References: <20201023160057.21543-1-shashi.mallela@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=shashi.mallela@linaro.org; helo=mail-qt1-x842.google.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sbsa-ref.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 01863510d0f5..7d9e180c0db0 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -40,6 +40,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/usb.h"
 #include "hw/char/pl011.h"
+#include "hw/watchdog/sbsa_gwdt.h"
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
@@ -134,6 +140,7 @@ static const int sbsa_ref_irqmap[] = {
     [SBSA_AHCI] = 10,
     [SBSA_EHCI] = 11,
     [SBSA_SMMU] = 12, /* ... to 15 */
+    [SBSA_GWDT] = 16,
 };
 
 static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
@@ -448,6 +455,20 @@ static void create_rtc(const SBSAMachineState *sms)
     sysbus_create_simple("pl031", base, qdev_get_gpio_in(sms->gic, irq));
 }
 
+static void create_wdt(const SBSAMachineState *sms)
+{
+    hwaddr rbase = sbsa_ref_memmap[SBSA_GWDT_REFRESH].base;
+    hwaddr cbase = sbsa_ref_memmap[SBSA_GWDT_CONTROL].base;
+    DeviceState *dev = qdev_new(TYPE_WDT_SBSA);
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
@@ -731,6 +752,8 @@ static void sbsa_ref_init(MachineState *machine)
 
     create_rtc(sms);
 
+    create_wdt(sms);
+
     create_gpio(sms);
 
     create_ahci(sms);
-- 
2.18.4


