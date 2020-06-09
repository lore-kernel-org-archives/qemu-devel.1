Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE5FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C12D2074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPYkQZGQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C12D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiYqs-0005Ps-Il
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 03:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkG-00047l-2U
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:28 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33139)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkF-0007XD-Ao
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:27 -0400
Received: by mail-wr1-x441.google.com with SMTP id l11so20081038wru.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 00:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eos1WJYtuH+j1S1wUpCIWosKP33E+t99Sgm1VOZwc6c=;
 b=CPYkQZGQj7J+btW5HYGhY0jUEJyiIabxf4hgCcCEtoWcv8s1i4XAFYKBtZBYjngbKy
 38B8K7MF78ayml029JnH1uzqxeTIaTPic3COCCZnCDlkLHFml73r3XhczuIUw5h2FsUS
 WXVXTwebPSgpmDqb8Bg0xY5jvEeOxZFDHRL+ICZJPdY5szPbJFpJfDGe70BNJI/JwNoo
 LBbL+6uoD7R3en/wnCur3vmvv4qlxwVv9jI6DzkI4rTLkw7bqxhQMiZ3C7Vp3Mlhz4dx
 QzkTnKfCLRcqHq6y8Kxig2SlhTex2aF7C2JgPNcThOUsRbiSJiR/6S2iRA9f3C0/LqMF
 2aTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=eos1WJYtuH+j1S1wUpCIWosKP33E+t99Sgm1VOZwc6c=;
 b=ZvY2UZUs6b19BqCaJYnUbLxwD33V6/lShiHcHa50Luy5m9sdSk9K+bKH+bdByzNYCb
 rbpuHOrSkE0Y8uzl1a/9uSeDk+pG64l5fOxQtuMQu1ZyDfbBYk7vCvs0c7Iq7VRMVSht
 7hzvMZpfvGBtujoaXR21VsVI0T4qO8PmaKv+cQ+5qUCVRZYHWs2s+nRq9M1liWh65rff
 gpBrrmUb51Rn0RM/0wVua4zKhZ5W5G0xQqNt01irn0eCx0nBTK93538BkjlEWzVqr8D/
 42wI25YLrSRHr3oiguXAD38oCO3eED2Kskosg0rfkAYggRKYRE0VuXnhKH8tj1rvrfu6
 1A+Q==
X-Gm-Message-State: AOAM531c/liOhr0kU4WriXRYECCx1iehSYJydAJ+0tmvBRIeEiPP+GhX
 6cbkhxJ3IGWSXGxvY/Q8njin+usM
X-Google-Smtp-Source: ABdhPJxWBes8rekotyittBo4qWr+y1X+ByU0YTWgGM7wWCofXWIMWCdKTUsSmVFhKMksdm5n1FUHxA==
X-Received: by 2002:a5d:61d0:: with SMTP id q16mr3045561wrv.182.1591687945500; 
 Tue, 09 Jun 2020 00:32:25 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id m3sm2036192wmc.0.2020.06.09.00.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 00:32:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/16] hw/sparc/leon3: Map the UART device unconditionally
Date: Tue,  9 Jun 2020 09:32:06 +0200
Message-Id: <20200609073214.14079-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200609073214.14079-1-f4bug@amsat.org>
References: <20200609073214.14079-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The UART is present on the chipset regardless there is a
character device connected to it. Map it unconditionally.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Message-Id: <20200608172144.20461-2-f4bug@amsat.org>
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


