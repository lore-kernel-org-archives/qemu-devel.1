Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B19C7114D
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 12:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9D0E2073A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 12:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2Q+x3li"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D0E2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2wVB-0005Nz-1s
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 07:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j2wUN-0004Fy-RU
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 07:24:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j2wUM-00010D-Qw
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 07:24:03 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35836)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j2wUJ-0000we-RR; Sat, 15 Feb 2020 07:23:59 -0500
Received: by mail-pl1-x644.google.com with SMTP id g6so4909847plt.2;
 Sat, 15 Feb 2020 04:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4NszvL0urm8S/oX71SBd+9Ua4RUUD2fm44zgx8hZW5Y=;
 b=i2Q+x3liBlwpKP/n/9FErT488f3JvWRO+QDx4+DvW5jlVcNFZl0IUp61ZcsmUtbLaW
 9eKRFzFEObSrWhnuQrgqRR61KeRpWBXkokMtMdZO1wav3ySf6KALiXThIkzqZ5o1ISl7
 HdXNnHRTxLzDj2AoRGOkEUmm5EG89t1TP31fEVzI8PUGhz1P70PXZ3vb++ubkHk0UX0Q
 A1bVs+3B64+iknsaOr5APbtFuu7TUXeTsQ3elcK87JvutKvzMWnkU8lAcUy/zZpoxG/E
 InvM7jlKcdURVO7Y3w0TykGtDSyv5Z/5kYkzmzYVUnSbdv4h+e0d5FkZzAYrEiAvNn2o
 KClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=4NszvL0urm8S/oX71SBd+9Ua4RUUD2fm44zgx8hZW5Y=;
 b=K+LhavfEqxAkijZaUKijE6zj2s8dm0PIUtAyPbCYh952bQZ76EFB5LC9wBatmFDGoZ
 tL79BDkvKsKNhQe1urWguWk64A8l3doC6nrTSNxAPRuoBPHaZalq43jMb/yGQiKxP3XY
 DSE+LGeOcVo7DHXrD9oP31E/pJIHH4y21hG9AnzlGmW5USABzUMwFIMCeTiyx1+hZs/d
 rjCkqYorcoSFQVoGCUS2de3T9Z1/wipj28gpxGCrz2VR489DsQjmRrx0IzlfnpgxF/FU
 Waf9KEYwE2C1SGwJRrudJ4mggxsuK09WVdPUs11ir61Vql09RMFgzvQGfV+XxqeD1Xl5
 Osfg==
X-Gm-Message-State: APjAAAWtlCUmi1628Rml04qJOyzsd3hcp3aOivcX7YHrkJu0w+NsgESm
 ZHLDdbB7M9w6A/32MwFraRg=
X-Google-Smtp-Source: APXvYqwmdlLhzX8CaMp9hugKw4Pm+wb1q0flir3H+YrZa3XwgkNCvx4EFQ3UcWf1nUYmm2nEhg/C/Q==
X-Received: by 2002:a17:902:9b93:: with SMTP id
 y19mr7816562plp.89.1581769439046; 
 Sat, 15 Feb 2020 04:23:59 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id a35sm10870038pgl.20.2020.02.15.04.23.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 15 Feb 2020 04:23:58 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 1/2] hw/arm/xilinx_zynq: Fix USB port instantiation
Date: Sat, 15 Feb 2020 04:23:53 -0800
Message-Id: <20200215122354.13706-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200215122354.13706-1-linux@roeck-us.net>
References: <20200215122354.13706-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

USB ports on Xilinx Zync must be instantiated as TYPE_CHIPIDEA to work.
Linux expects and checks various chipidea registers, which do not exist
with the basic ehci emulation. This patch series fixes the problem.

Without this patch, USB ports fail to instantiate under Linux.

ci_hdrc ci_hdrc.0: doesn't support host
ci_hdrc ci_hdrc.0: no supported roles

With this patch, USB ports are instantiated, and it is possible
to boot from USB drive.

ci_hdrc ci_hdrc.0: EHCI Host Controller
ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number 1
ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
usb 1-1: new full-speed USB device number 2 using ci_hdrc
usb 1-1: not running at top speed; connect to a high speed hub
usb 1-1: config 1 interface 0 altsetting 0 endpoint 0x81 has invalid maxpacket 512, setting to 64
usb 1-1: config 1 interface 0 altsetting 0 endpoint 0x2 has invalid maxpacket 512, setting to 64
usb-storage 1-1:1.0: USB Mass Storage device detected
scsi host0: usb-storage 1-1:1.0

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: No change

 hw/arm/xilinx_zynq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 3a0fa5b23f..b4a8b2f2c6 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -29,6 +29,7 @@
 #include "hw/loader.h"
 #include "hw/misc/zynq-xadc.h"
 #include "hw/ssi/ssi.h"
+#include "hw/usb/chipidea.h"
 #include "qemu/error-report.h"
 #include "hw/sd/sdhci.h"
 #include "hw/char/cadence_uart.h"
@@ -228,8 +229,8 @@ static void zynq_init(MachineState *machine)
     zynq_init_spi_flashes(0xE0007000, pic[81-IRQ_OFFSET], false);
     zynq_init_spi_flashes(0xE000D000, pic[51-IRQ_OFFSET], true);
 
-    sysbus_create_simple("xlnx,ps7-usb", 0xE0002000, pic[53-IRQ_OFFSET]);
-    sysbus_create_simple("xlnx,ps7-usb", 0xE0003000, pic[76-IRQ_OFFSET]);
+    sysbus_create_simple(TYPE_CHIPIDEA, 0xE0002000, pic[53 - IRQ_OFFSET]);
+    sysbus_create_simple(TYPE_CHIPIDEA, 0xE0003000, pic[76 - IRQ_OFFSET]);
 
     cadence_uart_create(0xE0000000, pic[59 - IRQ_OFFSET], serial_hd(0));
     cadence_uart_create(0xE0001000, pic[82 - IRQ_OFFSET], serial_hd(1));
-- 
2.17.1


