Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4CCC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:59:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A47F2076D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TJSOgrtq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A47F2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOZM-0006yh-Lc
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPp-0001iy-Lq
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:25 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:38478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPi-0004e0-0o
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:25 -0400
Received: by mail-wm1-x330.google.com with SMTP id l15so1100662wmi.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=OAIbVQqU/rgLJ5CpM5U+V3TPMTDATGut/KaTHqdShlA=;
 b=TJSOgrtq7QlxUyEIlNPbrh4fk6df4dDyvc9dlspiNzeGTtZRW01milgML737vp/GSX
 +TvP8z+b/LmpS6g+q2G+zzNbhFda3+m6wn4qPzlhteuDbkW0Yupau1qnVq9cRBzMlO31
 HSw7MDX+1vFVioc3+qDfgegoh1PNeQMNb600BH+xnT7Y7ut3Gwuenz7ZY7i9qeoYWgW4
 aaq3hDo0rlOF3WoUVJ4BWIYAQdKslT9FpaqZ8toVXM4uvBAQOKusHrWPdTySNK5+kcbY
 ZD4p/VEkR3iNcwP9m5Kmm/OYH+SHf1CFH7E728MD0biqO9Lat7xorvZmLlJSL8l6czjN
 s2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OAIbVQqU/rgLJ5CpM5U+V3TPMTDATGut/KaTHqdShlA=;
 b=EzXoWiWtz2RMO90HwPIBb79yCw0xoI+UqqHdlmb5AI9L7YX+LbM9DpHYBggqjMf7xf
 lRb2I64L45Iz6C0BEspoOtCNYxnBWNdmMeXe7HJVid6EQhrSdlptpVwh6ZPrOBetIbi8
 hXUq4FGFpIlCbXXjpcc/qNezPf4m4dxLqSwiCZG664ZjkXWPEMgNmWmMI7IjnUIOXAhm
 MgPCGtftfO7acYVGfx+S1PbQMSv+eQ/MdQ02pudryfkThCjYQa9e7sS8bu+cf2vuIuuI
 N3cGd9CrCP4mybRVEmKxqOtmP/Du+UedyOB5MpmNEYMfOChYGj61fuUHPKfxNyRQet+m
 qtKg==
X-Gm-Message-State: AOAM533ehECnZwftMSNvD7pcyeKsYu5Y1Rgg/temt8gJ3OkSbeERLhxu
 drXqrlPUoklD7ewyOoMyvD9XKqfcDq2oMw==
X-Google-Smtp-Source: ABdhPJySIloOD2DPJsKJYgQcy2VhKCET+bg5X2x9d8OuPJg4XbmyNERIfWvi2qHIYYgaj3i/xSyBIQ==
X-Received: by 2002:a1c:980a:: with SMTP id a10mr362220wme.103.1603799116011; 
 Tue, 27 Oct 2020 04:45:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.45.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:45:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/48] hw/arm/raspi: Add the Raspberry Pi Zero machine
Date: Tue, 27 Oct 2020 11:44:18 +0000
Message-Id: <20201027114438.17662-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Similarly to the Pi A, the Pi Zero uses a BCM2835 SoC (ARMv6Z core).

The only difference between the revision 1.2 and 1.3 is the latter
exposes a CSI camera connector. As we do not implement the Unicam
peripheral, there is no point in exposing a camera connector :)
Therefore we choose to model the 1.2 revision.

Example booting the machine using content from [*]:

  $ qemu-system-arm -M raspi0 -serial stdio \
      -kernel raspberrypi/firmware/boot/kernel.img \
      -dtb raspberrypi/firmware/boot/bcm2708-rpi-zero.dtb \
      -append 'printk.time=0 earlycon=pl011,0x20201000 console=ttyAMA0'
  [    0.000000] Booting Linux on physical CPU 0x0
  [    0.000000] Linux version 4.19.118+ (dom@buildbot) (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1311 Mon Apr 27 14:16:15 BST 2020
  [    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7 (ARMv7), cr=00c5387d
  [    0.000000] CPU: VIPT aliasing data cache, unknown instruction cache
  [    0.000000] OF: fdt: Machine model: Raspberry Pi Zero
  ...

[*] http://archive.raspberrypi.org/debian/pool/main/r/raspberrypi-firmware/raspberrypi-kernel_1.20200512-2_armhf.deb

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20201024170127.3592182-9-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 79fdd354603..0f5ea7e99b5 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -319,6 +319,15 @@ static void raspi_machine_class_common_init(MachineClass *mc,
     mc->default_ram_id = "ram";
 };
 
+static void raspi0_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
+
+    rmc->board_rev = 0x920092; /* Revision 1.2 */
+    raspi_machine_class_common_init(mc, rmc->board_rev);
+};
+
 static void raspi1ap_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -352,6 +361,10 @@ static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
 
 static const TypeInfo raspi_machine_types[] = {
     {
+        .name           = MACHINE_TYPE_NAME("raspi0"),
+        .parent         = TYPE_RASPI_MACHINE,
+        .class_init     = raspi0_machine_class_init,
+    }, {
         .name           = MACHINE_TYPE_NAME("raspi1ap"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi1ap_machine_class_init,
-- 
2.20.1


