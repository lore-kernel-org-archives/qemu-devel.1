Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82D6C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 06:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45EC222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 06:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvFu+ye7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45EC222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2U7n-0004j4-RN
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 01:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j2U6y-0003Za-G1
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 01:06:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j2U6x-0002Jq-GS
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 01:06:00 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36453)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j2U6r-0002BZ-IC; Fri, 14 Feb 2020 01:05:53 -0500
Received: by mail-pg1-x544.google.com with SMTP id d9so4407184pgu.3;
 Thu, 13 Feb 2020 22:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=CO9n+aThyUL/A/k172mfiOBqY03htvAQsM9xqdmgfV0=;
 b=hvFu+ye7PtBgQuds0KdW4RaG7gKWvSJ45xYXdUMbirfxOwrmrypgCX0N/AnTbd946z
 7pIi1fu4HUpBiby11Sl62IYyoq3ECNSmFXH4h+gSOvjCq0PNDCHUApf/wWAUgDx2Snge
 Vm993oEhfEmHXO8tIe1kGhnD7/MCxDpq1AvSNyrZmcUSC3auRzfGkgcA5AVjlmYvYtYj
 ke7JVKVRvdnLdOEwm/k/qpEfFLZrUmKo3C/3Li9nOTQA47EpKgLpOga8GVoyff83xczN
 evoIDh6EslzRDbyF5p7LTNCdX9n80k4MXn56CtVU40Y2MtK+pZvfgW72Kc2mLYV//lbg
 h6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=CO9n+aThyUL/A/k172mfiOBqY03htvAQsM9xqdmgfV0=;
 b=ng7QDpHZf57M+hYxXubaUd2dYF82Jg4aeEpoulZWC+5vSld5t4IjTURjcGHw0smDI/
 OXvZHOJTu+dPOAyXNWlgyTX7iuivvKZRhCIeyILxTpUjRQprxCU2Z9EdkCL8Q8WA00Bi
 7KjlCMQm+Jq0+8NPq70SHl6S6UU6qi4kZ5DPAjDSj8yV/ru7wZUdGnlMcGq2PVeNN0ni
 UUPs7b7P0POSpSa+uuz2GMtTf/3Z/EkUOxV2qPV5RZnq/rWBdCykhqKcLd24vGXtIpnA
 rXDae6QWwskqVIB4P5d8JqrfSJYbVX1g0lVk1QaCFTQk/WeLfnXB4vp3Dklbva0PtpQR
 5tfA==
X-Gm-Message-State: APjAAAUP2dErBKzUs0qqlklaiGXyNzxO2dENsHu1wCZO+ehg8qnKMoZB
 BsOztBg/MFwy4QTSLIT8JOk=
X-Google-Smtp-Source: APXvYqw/fjxu5gxCJwCwqAHaRNCXA/BEbFnTEIXBgIV6EMjh0DTOsWTlDSxzc91BlqpFh10YWCk3Ew==
X-Received: by 2002:aa7:8101:: with SMTP id b1mr1779187pfi.105.1581660352172; 
 Thu, 13 Feb 2020 22:05:52 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id d14sm4805891pjz.12.2020.02.13.22.05.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 13 Feb 2020 22:05:51 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 1/2] hw/arm/xilinx_zynq: Fix USB port instantiation
Date: Thu, 13 Feb 2020 22:05:47 -0800
Message-Id: <20200214060548.24939-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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

USB ports must be instantiated as TYPE_CHIPIDEA to work.
Linux expects and checks various chipidea registers, which
do not exist with the basic ehci emulation.

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


