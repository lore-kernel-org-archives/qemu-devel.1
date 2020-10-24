Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1469C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 17:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A20E2085B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 17:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKyBC7RE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A20E2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWN4l-0001i5-Cp
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 13:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWMvg-0007ub-Jx; Sat, 24 Oct 2020 13:02:08 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:41157)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWMve-0005jn-U8; Sat, 24 Oct 2020 13:02:08 -0400
Received: by mail-wr1-x432.google.com with SMTP id s9so6435889wro.8;
 Sat, 24 Oct 2020 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m75cLTEX515fIbNdb79QZlfceNwgYpGASQPS+c8k3IM=;
 b=XKyBC7RECN1jZrtxNWM0gwVfdMbuYo9nOgsytRJmXLv51FKuI5jFY1ncmmCEDR0ZDt
 DOIEHhnRB41ubHiygsBZ91/jN/RhwrXpzYBnocWtVQIFhcQqezpZjdEbLyM6wCFI+KzI
 BSzcXqaeW7IHudQf17AeZFymA1icRFC3/QZXRLruXsOChb0eenqvLBOb8jK34ybKcy6Q
 Zo/nZchBqXxwOnJyi3/V3R+Dqi83+u1ip73spexDp/87RQ+EASAjR9LFxOJdtkw0zQk0
 1CJPm3Moy8fCk2DHaWNrOI4UCg4djydzHbJHQnvMRbpfuuUf0YTBUynWTw5RlIEXcxT2
 5yJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=m75cLTEX515fIbNdb79QZlfceNwgYpGASQPS+c8k3IM=;
 b=Zu41jlJScdOqJsZKlTK2j1Es7EFVKBf+F41SBC8CDCTVhJ8W1kB9hOKjHuxAK7qhU2
 /9iTmOrX6tUpj3ELNCizR0sVql0lb4C/494rcNYhU89c84Zr4ZORQ2GEUvW10FW4Qbec
 hUVjKSK0YXiCE7m9bH4TAUQuhdRtu0UNIChNS1y1JHjRMau0q2lykeSu3QNYTDVAJu/a
 wq72TUYUrVrELKYHdas4bItVE3CEg6wVTjyOhTC3Fa5Tfx/hr3rUBnH9U7zQZMmI033O
 kZiZ1PidZ7Bef07nCKAiDKQMO9D15ueZpHqqsfQ/mQXr/jD9yYjbrqNvkBGJoA/FmiGc
 S28A==
X-Gm-Message-State: AOAM533BicPj/Ux+u+bTLSC3jsta64yFzmdbXvUQzSQ+0/xaw1vO5eDm
 FAXYGoS9MQTzQUpWq9dyJXCePdC7D9o=
X-Google-Smtp-Source: ABdhPJxthUAS7L7EYGYmQSBTTnrv/L64pg1SDcZhqscnTlRRb5OVLmPgEXOwlNVjm1jBDEZ+VaMUJg==
X-Received: by 2002:adf:f6cc:: with SMTP id y12mr8566792wrp.107.1603558925151; 
 Sat, 24 Oct 2020 10:02:05 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id u202sm12808190wmu.23.2020.10.24.10.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2020 10:02:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 7/9] hw/arm/raspi: Add the Raspberry Pi A+ machine
Date: Sat, 24 Oct 2020 19:01:25 +0200
Message-Id: <20201024170127.3592182-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201024170127.3592182-1-f4bug@amsat.org>
References: <20201024170127.3592182-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x432.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Pi A is almost the first machine released.
It uses a BCM2835 SoC which includes a ARMv6Z core.

Example booting the machine using content from [*]
(we use the device tree from the B model):

  $ qemu-system-arm -M raspi1ap -serial stdio \
      -kernel raspberrypi/firmware/boot/kernel.img \
      -dtb raspberrypi/firmware/boot/bcm2708-rpi-b-plus.dtb \
      -append 'earlycon=pl011,0x20201000 console=ttyAMA0'
  [    0.000000] Booting Linux on physical CPU 0x0
  [    0.000000] Linux version 4.19.118+ (dom@buildbot) (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1311 Mon Apr 27 14:16:15 BST 2020
  [    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7 (ARMv7), cr=00c5387d
  [    0.000000] CPU: VIPT aliasing data cache, unknown instruction cache
  [    0.000000] OF: fdt: Machine model: Raspberry Pi Model B+
  ...

[*] http://archive.raspberrypi.org/debian/pool/main/r/raspberrypi-firmware/raspberrypi-kernel_1.20200512-2_armhf.deb

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 30fafa59ecb..79fdd354603 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -319,6 +319,15 @@ static void raspi_machine_class_common_init(MachineClass *mc,
     mc->default_ram_id = "ram";
 };
 
+static void raspi1ap_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
+
+    rmc->board_rev = 0x900021; /* Revision 1.1 */
+    raspi_machine_class_common_init(mc, rmc->board_rev);
+};
+
 static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -343,6 +352,10 @@ static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
 
 static const TypeInfo raspi_machine_types[] = {
     {
+        .name           = MACHINE_TYPE_NAME("raspi1ap"),
+        .parent         = TYPE_RASPI_MACHINE,
+        .class_init     = raspi1ap_machine_class_init,
+    }, {
         .name           = MACHINE_TYPE_NAME("raspi2b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi2b_machine_class_init,
-- 
2.26.2


