Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29B0C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7108D2082F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqbEuxRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7108D2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j331D-0003ml-Mo
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 14:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j32v7-0000E4-Gm
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:16:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j32v6-0004Mf-1U
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:16:05 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:42712)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j32v4-0004LL-Js; Sat, 15 Feb 2020 14:16:03 -0500
Received: by mail-wr1-x431.google.com with SMTP id k11so14896084wrd.9;
 Sat, 15 Feb 2020 11:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=88Tqih529rt0JjN1YPcl+750nRn5ZaRFbIYERfB8Npc=;
 b=VqbEuxRaSGhSUAbWBLMzvD+ud+0+p2LKq4P0OTumix+LvglP7hgmXzf5KqK/PDgTCA
 ewZFL7eeEWZXoS9aLPjPIzEcoJb6GONaO/PT1ouh90wsHVhjI2XyBtr0htqVnuYkTy8m
 xrSqU+L+O6c/YZ4fhp/uTz77VfTrTBr/HK3MvBs+DjmyAYBXzgcKuWketmCzaJ81Dzsj
 0K7linbQJISqJ48NIXbyB67ni7i83+tS8GKviptAzeZsEmTHHanhfmEJb+NKQrhd+KAv
 vsUeV4Pnj4WgHnBmu3WTrS07yJE//PdxYRh+NEDsSCftwh0IVk+/TAip2po6Agy/R5hJ
 SI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=88Tqih529rt0JjN1YPcl+750nRn5ZaRFbIYERfB8Npc=;
 b=W+hexHsXrD8hcOGZucATJS5tYlMjKM9eaMR2V23U+lkQnvsfORBU3b83ZO6jp6PHbU
 j+TudcIc60haVvvy6+cwUVAucpKOXLhczInk3XNFTF9GqdMV0ekjdTwolqBkTsCmN8CR
 vUjfsEkf/rw7j3gQqkUh/BPn6lzK8yRac7igog/7pjRsFNAKDH4qUUlJnUaIOxind9ss
 SkeXWgIh9UTUxVO1g4xnN4zslT8KjU6f5ADJPTkGLkMm0pmuH8dhViGfo8Hcy+Gheinn
 z5c5ugERkXchEd+KI7TZfkJcEHlskl0ts3RpOFTXkThkg3rVRkZkMo55HY441mvplo6k
 K/bA==
X-Gm-Message-State: APjAAAW3FEH4nmHhDAhJktd+Yrr+WoiJM/mvo0eH6cRPncyUMXYL0VDo
 ICXFWDlKSHwY1faO6xCoDP2Iae1nwYg=
X-Google-Smtp-Source: APXvYqx4N48Umzf3kDx6S/6NEWOR1biFaR9Km8WUoPf8ZvXa/zmx3bmdzPQueNtWewd+6yHWs70/ZQ==
X-Received: by 2002:adf:f507:: with SMTP id q7mr11100951wro.384.1581794161370; 
 Sat, 15 Feb 2020 11:16:01 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id o9sm9678605wrw.20.2020.02.15.11.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 11:16:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/12] hw/arm/raspi: Add the Raspberry Pi B+ machine
Date: Sat, 15 Feb 2020 20:15:42 +0100
Message-Id: <20200215191543.3235-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200215191543.3235-1-f4bug@amsat.org>
References: <20200215191543.3235-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  $ qemu-system-arm -M raspi1 -serial stdio \
      -kernel raspberrypi/firmware/boot/kernel.img \
      -dtb raspberrypi/firmware/boot/bcm2708-rpi-b.dtb \
      -append 'printk.time=0 earlycon=pl011,0x20201000 console=ttyAMA0'
  [    0.000000] Booting Linux on physical CPU 0x0
  [    0.000000] Linux version 4.19.69+ (dom@buildbot) (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1261 Tue Sep 3 20:21:01 BST 2019
  [    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7 (ARMv7), cr=00c5387d
  [    0.000000] CPU: VIPT aliasing data cache, unknown instruction cache
  [    0.000000] OF: fdt: Machine model: Raspberry Pi Model B
  [    0.000000] earlycon: pl11 at MMIO 0x20201000 (options '')
  [    0.000000] bootconsole [pl11] enabled
  [    0.000000] Memory policy: Data cache writeback
  [    0.000000] cma: Reserved 8 MiB at 0x1b800000
  [    0.000000] random: get_random_bytes called from start_kernel+0x8c/0x49c with crng_init=0
  [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 113680
  [    0.000000] Kernel command line: printk.time=0 earlycon=pl011,0x20201000 console=ttyAMA0
  Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
  Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
  Memory: 434380K/458752K available (6971K kernel code, 635K rwdata, 2080K rodata, 464K init, 797K bss, 16180K reserved, 8192K cma-reserved)
  ...

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 6db2bf5bbe..7f7d0ee926 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -324,6 +324,15 @@ static void raspi_machine_class_common_init(MachineClass *mc,
     mc->default_ram_size = board_ram_size(board_rev);
 };
 
+static void raspi1_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
+
+    rmc->board_rev = 0x900032;
+    raspi_machine_class_common_init(mc, rmc->board_rev);
+};
+
 static void raspi2_machine_class_init(ObjectClass *oc, void *data)
 {
     RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
@@ -344,6 +353,10 @@ static void raspi3_machine_class_init(ObjectClass *oc, void *data)
 
 static const TypeInfo raspi_machine_types[] = {
     {
+        .name           = MACHINE_TYPE_NAME("raspi1"),
+        .parent         = TYPE_RASPI_MACHINE,
+        .class_init     = raspi1_machine_class_init,
+    }, {
         .name           = MACHINE_TYPE_NAME("raspi2"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi2_machine_class_init,
-- 
2.21.1


