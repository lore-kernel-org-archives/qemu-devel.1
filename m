Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3454EC388F7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 19:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B56ED20885
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 19:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdB0wLKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56ED20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbU15-0001At-Iz
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 14:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbTyi-0007oz-Nl; Sat, 07 Nov 2020 14:34:24 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:43016)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbTyh-0008Lx-AL; Sat, 07 Nov 2020 14:34:24 -0500
Received: by mail-wr1-x42b.google.com with SMTP id g12so4697549wrp.10;
 Sat, 07 Nov 2020 11:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fKsrMZT7rwVP28hdVbSgf4KB1wxqgtIDtqrq9k+6yOg=;
 b=bdB0wLKgKeqQNIQWXtCwfxg1gRxWg1QTDuCX11JRwSWkFIYr/dr1dIC+drPY/xei9a
 z5jMV5Zf4qVe7aHs9brt5EQuovfZTNU1c0Me3p2xIUsTA+g8F3RMX11ZBbv24QONyTeF
 iWnGH0Fks2RGIQFxY4UN9CIWoyPChP080+ifu9seF+cUiiINqX+sO/sR1LOEn9x+aH1y
 meKSpCFTCispE+K2uKlgGT9lAmsy3qpJts942n0i6hw/tlIKutBysZhlS/DsGHCLYoiM
 KRRgkAjcq+oK4elsdqjnGbp+ZNpE/+txBkoRm0gN2CD2SCZka5ZHTyeaB07X13eoYw2E
 7RGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fKsrMZT7rwVP28hdVbSgf4KB1wxqgtIDtqrq9k+6yOg=;
 b=ILorpAmArmjxH858kxfDcH8nmGUG/0ExT39gHUO1jSQ80/eGGe7yhItJW/J1s4W0dv
 GvuZhyMW7N7iVtOrZYFETqV+pBoFjh6V1/dvdDtPfT0fw+XVK96Fug0wJndtwpJO3QFj
 1Rr7+qVetvK5Z+0SawB/dWhHNdfFImlf7UClatgZ7wEKVOFq1U42BCkG3B3R9v9CBqbh
 2sYwvehdMc+e5V6ITU0cWfN76/Av5LJhPFYDIGxVj65zfg7BfASuXbshkrWVYTSy3aRS
 dOl1k6ZNYnZntdYTbijho2B9TXlDAWSjBPJRNNCLrFDh/jMcsVG+abbeUoG9uQfwKhok
 lMMw==
X-Gm-Message-State: AOAM531blyOoJgNyfX/2BSYTt3TKfvIbTD/1B6A4ufPokfe1uYwyvtWO
 sOisfl1czwIfp0m5RfSf3MBFwh8fRfA=
X-Google-Smtp-Source: ABdhPJwwikaMv1Qr6vOhyqDRqJ5dAUeehdtfcgLBy+JiEJAemb4vfeOaaHm8DYKavH6jayxB/sJ9Jg==
X-Received: by 2002:adf:f349:: with SMTP id e9mr9194611wrp.110.1604777661433; 
 Sat, 07 Nov 2020 11:34:21 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id f7sm8132808wrx.64.2020.11.07.11.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2020 11:34:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 3/5] hw/arm/nseries: Remove invalid/unnecessary
 n8x0_uart_setup()
Date: Sat,  7 Nov 2020 20:34:01 +0100
Message-Id: <20201107193403.436146-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201107193403.436146-1-f4bug@amsat.org>
References: <20201107193403.436146-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

omap2420_mpu_init() introduced in commit 827df9f3c5f ("Add basic
OMAP2 chip support") takes care of creating the 3 UARTs.

Then commit 58a26b477e9 ("Emulate a serial bluetooth HCI with H4+
extensions and attach to n8x0's UART") added n8x0_uart_setup()
which create the UART and connects it to an IRQ output,
overwritting the existing peripheral and its IRQ connection.
This is incorrect.

Fortunately we don't need to fix this, because commit 6da68df7f9b
("hw/arm/nseries: Replace the bluetooth chardev with a "null"
chardev") removed the use of this peripheral. We can simply
remove the code.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/nseries.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 76fd7fe9854..6215c18d627 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -789,16 +789,6 @@ static void n8x0_cbus_setup(struct n800_s *s)
     cbus_attach(cbus, s->tahvo = tahvo_init(tahvo_irq, 1));
 }
 
-static void n8x0_uart_setup(struct n800_s *s)
-{
-    Chardev *radio = qemu_chr_new("bt-dummy-uart", "null", NULL);
-    /*
-     * Note: We used to connect N8X0_BT_RESET_GPIO and N8X0_BT_WKUP_GPIO
-     * here, but this code has been removed with the bluetooth backend.
-     */
-    omap_uart_attach(s->mpu->uart[BT_UART], radio);
-}
-
 static void n8x0_usb_setup(struct n800_s *s)
 {
     SysBusDevice *dev;
@@ -1362,7 +1352,6 @@ static void n8x0_init(MachineState *machine,
     n8x0_spi_setup(s);
     n8x0_dss_setup(s);
     n8x0_cbus_setup(s);
-    n8x0_uart_setup(s);
     if (machine_usb(machine)) {
         n8x0_usb_setup(s);
     }
-- 
2.26.2


