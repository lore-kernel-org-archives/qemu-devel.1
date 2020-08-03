Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CB5C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 10:58:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F812064B
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 10:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/N5clIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F812064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2YAo-0004a7-9E
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 06:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k2Y9I-0002Vf-OJ; Mon, 03 Aug 2020 06:56:56 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41697)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k2Y9H-000271-3f; Mon, 03 Aug 2020 06:56:56 -0400
Received: by mail-wr1-x441.google.com with SMTP id r2so28687911wrs.8;
 Mon, 03 Aug 2020 03:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g3DyF6kevoJjleeMCTdWs3EQHtJ+0mrixjxdzUsE41I=;
 b=V/N5clIh/9GQ2oVuu4ZfmxUKRHvWV5zfqJmnHJW0O4cQqR2Az4CkEbgxAqSZIXQ9CJ
 oPojMbd7Nx7wdjLZxI0hauMwQz2TbbYOR3DTIsNqDbWFx1QmBktVymFOQGhojZDOPoSV
 nLT3njdKyqDWkKNopRDP9HZ4HlvemtOg8Q3NJClHEcwNuCd23CHlLPiQiFKkM15BRyUA
 oz0LXWDd2T0mCmKsOMqfkkEGTv728Z4zrUWLRKPJqq71WoMYm3DXxdlPxzx/WYZMq6Ty
 iFQ0OvycigAW2F5o8deg+IdB2VZPqh79ge201xforVpJ8zuPaYAI+5XBomeqqxRYeNT5
 vlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=g3DyF6kevoJjleeMCTdWs3EQHtJ+0mrixjxdzUsE41I=;
 b=q/AupQFdNAP3ZV5V2TZ00jZHh/e/x9HH6a6l+nmkz+MqkSqLQPLBsHol/Cv6qLZPNK
 qy2jzs+d1LTUQ0CnI5d3/MQkrK/IbiFRkBd7iM1SYiqf8dAytgSUYL6L5YnqFx3QjDYW
 qp7anx3CgyLnXJPFB9EUseArzysUYI/LaM0F23wDA0dw1hC6p9HqeqKQwH45vaK64MA+
 f6TejjdmkIiE91dednUpZN9FwK/uztkNiRcKw02CqzRrDZHgU2wFWFwKesDQob5MMW0S
 V2Qw6vshd+hiXHPWwOBQ53U6p6fia0VHE5eIrxPQDmaSQd9i+tUU8A2RJIdBNvEXEpeG
 GTrQ==
X-Gm-Message-State: AOAM532pLavVlEhZmPywQKkE6PhkZGMIYVP6027VccB2koB+qPmq6Xqv
 AegV3+WTmgwi2tZjTasJn58Z03hw
X-Google-Smtp-Source: ABdhPJyocIobe2jyOD/98PsIhsEsK+M18uvpiRyQArLj3jqiakyn1LXLwk9MLuXhVqdvjOARgAJeBA==
X-Received: by 2002:a5d:6910:: with SMTP id t16mr15577591wru.178.1596452212964; 
 Mon, 03 Aug 2020 03:56:52 -0700 (PDT)
Received: from localhost.localdomain (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id z11sm23103477wrw.93.2020.08.03.03.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 03:56:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1? 2/4] hw/arm/xilinx_zynq: Call qdev_connect_clock_in()
 before DeviceRealize
Date: Mon,  3 Aug 2020 12:56:45 +0200
Message-Id: <20200803105647.22223-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200803105647.22223-1-f4bug@amsat.org>
References: <20200803105647.22223-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Clock canonical name is set in device_set_realized (see the block
added to hw/core/qdev.c in commit 0e6934f264).
If we connect a clock after the device is realized, this code is
not executed. This is currently not a problem as this name is only
used for trace events, however this disrupt tracing.

Fix by calling qdev_connect_clock_in() before realizing.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/xilinx_zynq.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index cf6d9757b5..969ef0727c 100644
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
2.21.3


