Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7327BC433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:58:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF8C622280
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h46BvoPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8C622280
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUFlV-00013Y-3o
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 16:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUFio-00062h-NY; Sun, 18 Oct 2020 16:56:06 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUFim-0003qF-V8; Sun, 18 Oct 2020 16:56:06 -0400
Received: by mail-wr1-x444.google.com with SMTP id t9so9132832wrq.11;
 Sun, 18 Oct 2020 13:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VqdKnd4Twgx8yICk/fUvLd4Y9zGgGTiuVIGMLYhnK2s=;
 b=h46BvoPMlVaL7Ekb8SrICZhfn7Z0J4A4005iNJgFfapG++dos2wR681FZOhgvEXZVH
 QDchDGE22IZMvpCjlpK3hNDTn5ybXd4llTJmFn7ojHneaAzk4HBw2iodXOreoGvky803
 kh4jJQROMomHf5triZkfh9MRBgQlTu3zzyTw7tnoZJHYIbWm2obehVngX9aL3vgq2JPO
 NUeuU9D/v29iH8srgSvVa8S4eB+f5btOS6hOFWi48RhwEEwH8xegHV1f07xWmZ9HKzkw
 vJqH34IqI5AXYbZW/BVF+u8jQWerkhW5LrjrELbEHeSUw5BPNxGHJophGAzbSv80iZpT
 hHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=VqdKnd4Twgx8yICk/fUvLd4Y9zGgGTiuVIGMLYhnK2s=;
 b=mCqhdlyT+UUar7RvXwNXUM7z7pflZcUljD9Wvxp/mknftYUQnfKKM8kQrXKIT0y51T
 kMmGSynQW0mYCMSp5nbHvmYhQNzJDbVdrW/DizdAUB9C3aBPnfmPa4+eTzETQ712rq6R
 aozZ5oUKacEMiu4daPH+ki6LWa5DZyIg7G32lbrdsv446rm9KAexLplV2AceVjn5iiyW
 Iv+NWJ0bOQya0kGmurIjZTl2/DbUsr/GlhGL1e8c5hhRKk3CzQlYK97yZNZTCrLelI3q
 epjrCanSQ5QVZe/pFJimuwDKe42z+OtK0XWxmCBA58Ecf0z/TS7i3S/x4tX3vGmhJrdd
 7Jew==
X-Gm-Message-State: AOAM530qQFFGaF/cfcXEymCM0LQa1c5um6aEJ6ahYlsrQfWXPJD8Afrf
 rTTmmciY0wbIhmKhwXpaFikB3xhx1/M=
X-Google-Smtp-Source: ABdhPJywO7sQ100/xbHnc+jGftLDSQUSlT/NI6jUs2/qYJ2jjAif4gI9cjvGJ/m3TzcrEJ/otUxtsA==
X-Received: by 2002:adf:9dd1:: with SMTP id q17mr16392270wre.317.1603054562540; 
 Sun, 18 Oct 2020 13:56:02 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id o194sm13453555wme.24.2020.10.18.13.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2020 13:56:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 2/3] hw/arm/raspi: Add the Raspberry Pi 4 model B
Date: Sun, 18 Oct 2020 22:55:50 +0200
Message-Id: <20201018205551.1537927-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201018205551.1537927-1-f4bug@amsat.org>
References: <20201018205551.1537927-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
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
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 Stewart Hildebrand <Stewart.Hildebrand@dornerworks.com>,
 Johnny Sun <psunjohnny@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add 2 variants of the raspi4:

- raspi4b1g:    Raspberry Pi 4B (revision 1.1, with 1 GiB of RAM)
- raspi4b2g     Raspberry Pi 4B (revision 1.2, with 2 GiB)

Example booting the 2GiB machine using content from [*]:

  $ qemu-system-aarch64 -M raspi4b2g -serial stdio \
      -kernel raspberrypi/firmware/boot/kernel8.img \
      -dtb raspberrypi/firmware/boot/bcm2711-rpi-4-b.dtb \
      -append 'printk.time=0 earlycon=pl011,0xfe201000 console=ttyAMA0'
  [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd083]
  [    0.000000] Linux version 5.4.51-v8+ (dom@buildbot) (gcc version 5.4.0 20160609 (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9)) #1333 SMP PREEMPT Mon Aug 10 16:58:35 BST 2020
  [    0.000000] Machine model: Raspberry Pi 4 Model B
  [    0.000000] earlycon: pl11 at MMIO 0x00000000fe201000 (options '')
  [    0.000000] printk: bootconsole [pl11] enabled
  [    0.000000] efi: Getting EFI parameters from FDT:
  [    0.000000] efi: UEFI not found.
  [    0.000000] Reserved memory: created CMA memory pool at 0x000000002c000000, size 64 MiB
  [    0.000000] OF: reserved mem: initialized node linux,cma, compatible id shared-dma-pool
  [    0.000000] Detected PIPT I-cache on CPU0
  [    0.000000] CPU features: detected: EL2 vector hardening
  [    0.000000] ARM_SMCCC_ARCH_WORKAROUND_1 missing from firmware
  [    0.000000] software IO TLB: mapped [mem 0x3bfff000-0x3ffff000] (64MB)
  [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
  [    0.000000] GIC: Using split EOI/Deactivate mode
  [    0.633289] smp: Bringing up secondary CPUs ...
  [    0.694226] Detected PIPT I-cache on CPU1
  [    0.699002] CPU1: Booted secondary processor 0x0000000001 [0x410fd083]
  [    0.782443] Detected PIPT I-cache on CPU2
  [    0.783511] CPU2: Booted secondary processor 0x0000000002 [0x410fd083]
  [    0.848854] Detected PIPT I-cache on CPU3
  [    0.850003] CPU3: Booted secondary processor 0x0000000003 [0x410fd083]
  [    0.857099] smp: Brought up 1 node, 4 CPUs
  [    0.863500] SMP: Total of 4 processors activated.
  [    0.865446] CPU features: detected: 32-bit EL0 Support
  [    0.866667] CPU features: detected: CRC32 instructions
  [    2.235648] CPU: All CPU(s) started at EL2
  ...

[*] http://archive.raspberrypi.org/debian/pool/main/r/raspberrypi-firmware/raspberrypi-kernel_1.20200512-2_armhf.deb

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 4ea200572ea..6a793766840 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -73,6 +73,7 @@ typedef enum RaspiProcessorId {
     PROCESSOR_ID_BCM2835 = 0,
     PROCESSOR_ID_BCM2836 = 1,
     PROCESSOR_ID_BCM2837 = 2,
+    PROCESSOR_ID_BCM2838 = 3,
 } RaspiProcessorId;
 
 static const struct {
@@ -82,6 +83,7 @@ static const struct {
     [PROCESSOR_ID_BCM2835] = {TYPE_BCM2835, 1},
     [PROCESSOR_ID_BCM2836] = {TYPE_BCM2836, BCM283X_NCPUS},
     [PROCESSOR_ID_BCM2837] = {TYPE_BCM2837, BCM283X_NCPUS},
+    [PROCESSOR_ID_BCM2838] = {TYPE_BCM2838, BCM283X_NCPUS},
 };
 
 static uint64_t board_ram_size(uint32_t board_rev)
@@ -366,6 +368,24 @@ static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
     rmc->board_rev = 0xa02082;
     raspi_machine_class_common_init(mc, rmc->board_rev);
 };
+
+static void raspi4b1g_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
+
+    rmc->board_rev = 0xa03111;
+    raspi_machine_class_common_init(mc, rmc->board_rev);
+};
+
+static void raspi4b2g_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
+
+    rmc->board_rev = 0xb03112;
+    raspi_machine_class_common_init(mc, rmc->board_rev);
+};
 #endif /* TARGET_AARCH64 */
 
 static const TypeInfo raspi_machine_types[] = {
@@ -390,6 +410,14 @@ static const TypeInfo raspi_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("raspi3b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3b_machine_class_init,
+    }, {
+        .name           = MACHINE_TYPE_NAME("raspi4b1g"),
+        .parent         = TYPE_RASPI_MACHINE,
+        .class_init     = raspi4b1g_machine_class_init,
+    }, {
+        .name           = MACHINE_TYPE_NAME("raspi4b2g"),
+        .parent         = TYPE_RASPI_MACHINE,
+        .class_init     = raspi4b2g_machine_class_init,
 #endif
     }, {
         .name           = TYPE_RASPI_MACHINE,
-- 
2.26.2


