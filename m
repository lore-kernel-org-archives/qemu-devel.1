Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CA3C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDF1C208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGqh4KVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF1C208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBagh-0003mm-2i
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBaca-0004Ge-ST
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:32 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51189)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacZ-0004Go-3I
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:32 -0400
Received: by mail-wm1-x341.google.com with SMTP id t2so305498wma.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=sVGSILwjDAqupuQyroGQhqDaeoRzPGgJv2uj9s/0pFg=;
 b=iGqh4KVXZ+GtAQjEr3VDEhZr91a75/ea7Xz3ndy9lxmV7QhL7UImBQvuAwRyn1F42k
 unDdhS8yejqw4q2DFAdiQm++NfmNZcW0oUTt/FDQyLPqY8+VSwQpySYetgHJHhlycqbr
 UnKj3043Yq53jgYJpXCoNV2L9tF6XJLKFZngHHfV5l/ALX5w0AW14KYOPtMUpyf3uoOn
 U+xS5lMbI/n3SiwLWLJxEj9+kSuDZHwX4DLc3lPB8IxS+94pdQEfNpAbl0+w4V/sZbDU
 ohsXLhhA+XY3q78wWd2LgSzWTJBdKg+hb+UXirGx2SaC3G5dkyjloKWab1I4JDDm4Ple
 b4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sVGSILwjDAqupuQyroGQhqDaeoRzPGgJv2uj9s/0pFg=;
 b=NUfNhWsq7LiDTOv+hVal/T158AFwdGSS/yXu7zY7MVXfSNoct+Dy2oJoadh4wNBo8D
 GH1j8tqk3gLA2D4BNR5/NZyZ4kh4vqLV06k9NsHl6bNsKjEZ7TXEMddyJTuo3LOyrq8X
 b8vocxO3KCBdY+LXwqcgzHnb3hNbPJ2myTO2gIEG1f8Ux3prXWX5ZANwG6+RPcaexLlS
 d/fBQL86P7KfSijgAalr9JhG0q/nObNU8VhFOwIuKvBbPHqnMrzGIjt+vLWlqzJZJ5fP
 gKPtOVMGAg3RCtxDXUaouMONODfgvZ/qPx/echDbduNuTY7jWVpGrZ1eb79qZIZLCXdo
 5ydQ==
X-Gm-Message-State: AOAM532wKXoRUkVOQU+r9UhU69nAVYGu6eSIOFxuvWEMP0UZ8e6r9QqH
 mVycKpI/0Lk0/mWS1c5uRJDNzRW54iPKd2T8
X-Google-Smtp-Source: ABdhPJypYfrekDYkV+evP9pqZKl5lgVoZypiRMzsr209x971Z36d0UbykMhD8uMdQyR12qLp6/O6nA==
X-Received: by 2002:a7b:c00c:: with SMTP id c12mr781842wmb.54.1598606669370;
 Fri, 28 Aug 2020 02:24:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/35] hw/arm/xilinx_zynq: Call qdev_connect_clock_in() before
 DeviceRealize
Date: Fri, 28 Aug 2020 10:23:50 +0100
Message-Id: <20200828092413.22206-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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

Clock canonical name is set in device_set_realized (see the block
added to hw/core/qdev.c in commit 0e6934f264).
If we connect a clock after the device is realized, this code is
not executed. This is currently not a problem as this name is only
used for trace events, however this disrupt tracing.

Fix by calling qdev_connect_clock_in() before realizing.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200803105647.22223-3-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xilinx_zynq.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index cf6d9757b57..969ef0727cc 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -222,18 +222,18 @@ static void zynq_init(MachineState *machine)
                           1, 0x0066, 0x0022, 0x0000, 0x0000, 0x0555, 0x2aa,
                           0);
 
-    /* Create slcr, keep a pointer to connect clocks */
-    slcr = qdev_new("xilinx,zynq_slcr");
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(slcr), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);
-
     /* Create the main clock source, and feed slcr with it */
     zynq_machine->ps_clk = CLOCK(object_new(TYPE_CLOCK));
     object_property_add_child(OBJECT(zynq_machine), "ps_clk",
                               OBJECT(zynq_machine->ps_clk));
     object_unref(OBJECT(zynq_machine->ps_clk));
     clock_set_hz(zynq_machine->ps_clk, PS_CLK_FREQUENCY);
+
+    /* Create slcr, keep a pointer to connect clocks */
+    slcr = qdev_new("xilinx,zynq_slcr");
     qdev_connect_clock_in(slcr, "ps_clk", zynq_machine->ps_clk);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(slcr), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);
 
     dev = qdev_new(TYPE_A9MPCORE_PRIV);
     qdev_prop_set_uint32(dev, "num-cpu", 1);
@@ -257,19 +257,19 @@ static void zynq_init(MachineState *machine)
     dev = qdev_new(TYPE_CADENCE_UART);
     busdev = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", serial_hd(0));
+    qdev_connect_clock_in(dev, "refclk",
+                          qdev_get_clock_out(slcr, "uart0_ref_clk"));
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0xE0000000);
     sysbus_connect_irq(busdev, 0, pic[59 - IRQ_OFFSET]);
-    qdev_connect_clock_in(dev, "refclk",
-                          qdev_get_clock_out(slcr, "uart0_ref_clk"));
     dev = qdev_new(TYPE_CADENCE_UART);
     busdev = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", serial_hd(1));
+    qdev_connect_clock_in(dev, "refclk",
+                          qdev_get_clock_out(slcr, "uart1_ref_clk"));
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0xE0001000);
     sysbus_connect_irq(busdev, 0, pic[82 - IRQ_OFFSET]);
-    qdev_connect_clock_in(dev, "refclk",
-                          qdev_get_clock_out(slcr, "uart1_ref_clk"));
 
     sysbus_create_varargs("cadence_ttc", 0xF8001000,
             pic[42-IRQ_OFFSET], pic[43-IRQ_OFFSET], pic[44-IRQ_OFFSET], NULL);
-- 
2.20.1


