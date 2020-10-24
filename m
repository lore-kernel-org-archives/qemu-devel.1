Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72914C5517A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 17:12:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14B552083B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 17:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfGvL36i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B552083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWN5t-0003NJ-62
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 13:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWMvl-00088P-OO; Sat, 24 Oct 2020 13:02:13 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:54978)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWMvj-0005kH-RW; Sat, 24 Oct 2020 13:02:13 -0400
Received: by mail-wm1-x335.google.com with SMTP id w23so4616210wmi.4;
 Sat, 24 Oct 2020 10:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cuBUbDkqPu7YN9qL1F67Qvxpg+vH+NzaO82nHRsjbP8=;
 b=TfGvL36iVj4ewkGzPw2CN8ilyExWJPmYDd/PL5yYUsBzMoToxRVUfsRr8x58AG/HmJ
 UfrhOUM8wCOhp++v0nzVlBWD8E/qf6uWQ5Rm8iW054GrFKffeH7yx/i89hZYHk2C4Gfl
 rd4CPkux6Y12CmLyGGj8RUxzyQ15u81pnTzp0D4G2uOiJYuzIOivsDNvXfyJq2kqcmX2
 +fz1esr1Bq8D6OA+nhTO+ZXgtlvQXb37SYQyYGlHbkIzekCmDfpioKJ8CS4Uxzy5Tars
 /s4jj2AQLqgyAC/b8lKsrBTB97MfcldSpOOyynt5JBzhqyPKKsozvvEYJkE/rXBZRp8J
 C46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cuBUbDkqPu7YN9qL1F67Qvxpg+vH+NzaO82nHRsjbP8=;
 b=kXFz/fHnq3BHNBmPuvTWchh2V4n/+2BbuauY0H//UePIaH+IOxeNNL1I4mxjromG0r
 XnlptC+qC08ZTUTQ/cQ+u0gZ+njHX/cswCXobVLQYqGpFAkiQJ0fSmro4EPJVGiohcIU
 /aNMMGN4+Utf/HOlgxhrZe6G78zpcczxMEs17LUeI5oGjpkaI5q36JvXXHSPOR0GHF7t
 RQx1ZqMgq909pCb3QLTwGThSFu4hBUhZigca7ep1h3ZLWXFNrwdsBl4ADtJP6E8ncCvn
 DQcr40H7Z/LAUOwWCDnobCOs58ds2cHJaRhYNMMaK5le+DtxdTbfSPvJkvo0Ydt1VTKY
 V7sw==
X-Gm-Message-State: AOAM531x/Sxz7QLoemuWNwoxE+cFf95x+hQDRacyRX0fQpVGDFpRD/6/
 D8EWVnJd4lf4MtpRw69b6Epz2H6WMEg=
X-Google-Smtp-Source: ABdhPJzrL2c75JeM9cRYXh4tnVGy8vjyqr9C4MfgdyxE7clIMigSZjLzXAvti5Qgy3WwxTfmZqfj1w==
X-Received: by 2002:a1c:3243:: with SMTP id y64mr7692111wmy.175.1603558929862; 
 Sat, 24 Oct 2020 10:02:09 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id g5sm10992116wmi.4.2020.10.24.10.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2020 10:02:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 8/9] hw/arm/raspi: Add the Raspberry Pi Zero machine
Date: Sat, 24 Oct 2020 19:01:26 +0200
Message-Id: <20201024170127.3592182-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201024170127.3592182-1-f4bug@amsat.org>
References: <20201024170127.3592182-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x335.google.com
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
 Igor Mammedov <imammedo@redhat.com>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
2.26.2


