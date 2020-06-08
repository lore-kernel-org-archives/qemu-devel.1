Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC19C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:24:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A6BF20885
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfff8J8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6BF20885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiLVM-0006IC-QJ
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 13:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiLT6-0003ms-Tg
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 13:21:52 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiLT5-0005sv-Sz
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 13:21:52 -0400
Received: by mail-wm1-x342.google.com with SMTP id r15so299360wmh.5
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 10:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+fdixkd1kovppyuOu9Vk3C+grgh/kkvSWD8CAVFYEj0=;
 b=mfff8J8hriNm6BZwxJb000itD+rK2zQDir548m/ad2toHrBb4LsMpNOT2UHkPfTVS5
 Rv+srPo7b8sYY4UgsL5hPnRcbCLKwFTMRmCFmyFCsGrKA59lcZyh89JCfF9lR7Zzn/sh
 Oeasal7CjESNTzyFghmsnc9t4haefBG6kJ71kGXcmjiTphlniPvXy4MWipbkuwkh0Up1
 ehlZhJiFTBG3LkEgjxsR2BhLnX37geN+2exqkJr5NQuYU46Gzw4cjp8UdKESb/JmPXIK
 1uTWemjxV7C0GzMe4yNXhv0ePiYEq/uQzplA7bDLh8TmTwe7Y8PvQNkoAeNWYXxJsaEi
 4olQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+fdixkd1kovppyuOu9Vk3C+grgh/kkvSWD8CAVFYEj0=;
 b=TwfghAXaFP8JBC6RbkAEBds02YYCFOac8U3iuzDowF7gaugntmwMuxFwOiJQRsrJQ3
 lGvn7nu2pjFO1D3YOxHHMMTa7DaEMTfYETuwF+0dp4tgjTQSfa2x79WKHGpgLn73J3Dd
 VZRk5etDptfgHHcBgN5Tscdsm7ar2VpV2LQQOHdD7vPwzEJc0P04h7dHpQ2lkV18LPve
 W72hpnf7majKC7vqIjTM+aY1yVvWjLmSPZl5ZlKN0GwA8Hk6WPUNB506ax+NJci0H9ll
 U3bDlvTOXzeeMqJuMwzxssbDRz+XU62KZA7CY1tavPo2VHq6GlOYdIOA1pFq4u9xS+6X
 RsKQ==
X-Gm-Message-State: AOAM531Y1DGE1Tln3d1RZQviHsWMjiwL0D71EMqRZv5lcyDjy5K+pEzT
 CKHmCP2EjSrQUyl0U4Ey+U+XY/dj
X-Google-Smtp-Source: ABdhPJyQMhmq/Tp64NZrGmlpX8bBo7bMGcg2zblVSxIZ+iQpvYTd9wjsZbPQssd7sJ8pP6ONM3JSnA==
X-Received: by 2002:a7b:c40e:: with SMTP id k14mr367222wmi.59.1591636907031;
 Mon, 08 Jun 2020 10:21:47 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id n23sm223618wmc.0.2020.06.08.10.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 10:21:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] hw/sparc/leon3: Map the UART device unconditionally
Date: Mon,  8 Jun 2020 19:21:42 +0200
Message-Id: <20200608172144.20461-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608172144.20461-1-f4bug@amsat.org>
References: <20200608172144.20461-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The UART is present on the chipset regardless there is a
character device connected to it. Map it unconditionally.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sparc/leon3.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 8f024dab7b..cc55117dec 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -339,16 +339,14 @@ static void leon3_generic_hw_init(MachineState *machine)
                             0, LEON3_TIMER_IRQ, GRLIB_APBIO_AREA);
 
     /* Allocate uart */
-    if (serial_hd(0)) {
-        dev = qdev_create(NULL, TYPE_GRLIB_APB_UART);
-        qdev_prop_set_chr(dev, "chrdev", serial_hd(0));
-        qdev_init_nofail(dev);
-        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_UART_OFFSET);
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, cpu_irqs[LEON3_UART_IRQ]);
-        grlib_apb_pnp_add_entry(apb_pnp, LEON3_UART_OFFSET, 0xFFF,
-                                GRLIB_VENDOR_GAISLER, GRLIB_APBUART_DEV, 1,
-                                LEON3_UART_IRQ, GRLIB_APBIO_AREA);
-    }
+    dev = qdev_create(NULL, TYPE_GRLIB_APB_UART);
+    qdev_prop_set_chr(dev, "chrdev", serial_hd(0));
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_UART_OFFSET);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, cpu_irqs[LEON3_UART_IRQ]);
+    grlib_apb_pnp_add_entry(apb_pnp, LEON3_UART_OFFSET, 0xFFF,
+                            GRLIB_VENDOR_GAISLER, GRLIB_APBUART_DEV, 1,
+                            LEON3_UART_IRQ, GRLIB_APBIO_AREA);
 }
 
 static void leon3_generic_machine_init(MachineClass *mc)
-- 
2.21.3


