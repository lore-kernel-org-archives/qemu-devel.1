Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C99C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 217AA2075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="It5A2zsi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217AA2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBakM-0002Ex-Cl
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacZ-0004Cm-H0
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:31 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacX-0004GD-Pw
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:31 -0400
Received: by mail-wr1-x441.google.com with SMTP id b18so625817wrs.7
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=QneDUKNU30eWTVWkf0ncfUwv6iQnAySEq2QxFphzkOo=;
 b=It5A2zsinTjHvdeXlGShWPDOWvd0w1b4qX411g0Qc92zEqEEoDRXbffXvzcWgcGc4j
 Gq0SkcupAyWp6/lbnFQrdI6IksTVCxjWW/FURMp5B461mzgS14RL7qLoX8n1b/gF9lHM
 ctfwf4F1ZOZaOI2JOcA+fhMYa3Q5C82/wttVGVr2UKudttiKL52lIhzMFgMwYlIdk2/T
 Pa7O+4nCOOtFdxXvBV5aLtqBpcPhV5gn0GwGLhF7RJau05s2nKn1dfYfyO/tda2UpSga
 nKpxNPJgaj9GO0/134PkPDeonr55XKX4Fx4+KeBz3AyNYXEgl4OqOjptOU32LBkxNEEJ
 LBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QneDUKNU30eWTVWkf0ncfUwv6iQnAySEq2QxFphzkOo=;
 b=gfe5Ori2BQXNxwYDC20APoRgiAv1fI/H3vFYQ3WIXXnjwV2zCCj5eGZbi6a3aZecS6
 Jd6bySPyWvzvBo40ZngxrCIFM+i5jsIAWLPntt7HUVyiXMLxCks+2T8T7oL63uzvGHkx
 7fZO6KTeOXShP0H4lmYw7FPZ9DDF1EBr+adO19c/XTYsEr1k2T4UOhqnd+r89UOuzyea
 5pTCSUdX8NdEMDKT4c/9Xw4JCcfeBRth1/VUp+fh05N9xPIuX+QUvrcsyHvQ9me24lQO
 wHfCrKY4j+f/NF6zYFlQXzU0G+UsEc6PtiXcUcQP+3Ck3o2ppsQdunwSvfuPKcwgtmr0
 QHMg==
X-Gm-Message-State: AOAM530PAQWOZBHES0lbIpvFj9HOundjZu5buYoGqM+JzFupTpoHQLDC
 C0UwoG7FBZGZ5HcOlHipMZ1Hc7Rty3fxlMNl
X-Google-Smtp-Source: ABdhPJyPMOemvPdmxwKbXLLLcbBgPXRltWmXOGHAg7PVGVfJPS+VXA7pb3cyQ9LJrBxlJpZTzj9Txw==
X-Received: by 2002:a5d:6910:: with SMTP id t16mr691788wru.178.1598606668153; 
 Fri, 28 Aug 2020 02:24:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/35] hw/arm/xilinx_zynq: Uninline cadence_uart_create()
Date: Fri, 28 Aug 2020 10:23:49 +0100
Message-Id: <20200828092413.22206-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

As we want to call qdev_connect_clock_in() before the device
is realized, we need to uninline cadence_uart_create() first.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200803105647.22223-2-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/char/cadence_uart.h | 17 -----------------
 hw/arm/xilinx_zynq.c           | 14 ++++++++++++--
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/include/hw/char/cadence_uart.h b/include/hw/char/cadence_uart.h
index ed7b58d31d4..dabc49ea4fe 100644
--- a/include/hw/char/cadence_uart.h
+++ b/include/hw/char/cadence_uart.h
@@ -53,21 +53,4 @@ typedef struct {
     Clock *refclk;
 } CadenceUARTState;
 
-static inline DeviceState *cadence_uart_create(hwaddr addr,
-                                        qemu_irq irq,
-                                        Chardev *chr)
-{
-    DeviceState *dev;
-    SysBusDevice *s;
-
-    dev = qdev_new(TYPE_CADENCE_UART);
-    s = SYS_BUS_DEVICE(dev);
-    qdev_prop_set_chr(dev, "chardev", chr);
-    sysbus_realize_and_unref(s, &error_fatal);
-    sysbus_mmio_map(s, 0, addr);
-    sysbus_connect_irq(s, 0, irq);
-
-    return dev;
-}
-
 #endif
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 32aa7323d9a..cf6d9757b57 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -254,10 +254,20 @@ static void zynq_init(MachineState *machine)
     sysbus_create_simple(TYPE_CHIPIDEA, 0xE0002000, pic[53 - IRQ_OFFSET]);
     sysbus_create_simple(TYPE_CHIPIDEA, 0xE0003000, pic[76 - IRQ_OFFSET]);
 
-    dev = cadence_uart_create(0xE0000000, pic[59 - IRQ_OFFSET], serial_hd(0));
+    dev = qdev_new(TYPE_CADENCE_UART);
+    busdev = SYS_BUS_DEVICE(dev);
+    qdev_prop_set_chr(dev, "chardev", serial_hd(0));
+    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_mmio_map(busdev, 0, 0xE0000000);
+    sysbus_connect_irq(busdev, 0, pic[59 - IRQ_OFFSET]);
     qdev_connect_clock_in(dev, "refclk",
                           qdev_get_clock_out(slcr, "uart0_ref_clk"));
-    dev = cadence_uart_create(0xE0001000, pic[82 - IRQ_OFFSET], serial_hd(1));
+    dev = qdev_new(TYPE_CADENCE_UART);
+    busdev = SYS_BUS_DEVICE(dev);
+    qdev_prop_set_chr(dev, "chardev", serial_hd(1));
+    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_mmio_map(busdev, 0, 0xE0001000);
+    sysbus_connect_irq(busdev, 0, pic[82 - IRQ_OFFSET]);
     qdev_connect_clock_in(dev, "refclk",
                           qdev_get_clock_out(slcr, "uart1_ref_clk"));
 
-- 
2.20.1


