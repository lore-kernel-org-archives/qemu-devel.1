Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D39FC3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 178A620661
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owdrG602"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178A620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXdL-0003bw-At
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:03:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iyXaA-0008Ct-Df
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:59:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iyXa9-0007bs-7e
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:59:50 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33561)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iyXa9-0007bF-1V; Mon, 03 Feb 2020 03:59:49 -0500
Received: by mail-wm1-x341.google.com with SMTP id m10so13809352wmc.0;
 Mon, 03 Feb 2020 00:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=McmqHb8ZIQwdrf/h9Ux5lHwfQS28gH0LN86W4pPo+uk=;
 b=owdrG602dn0k3raB28tmGoosiKs3/9yKbmulinp149Si0LAYfR8QAnbenmLtbBdsuQ
 7kJGCbO30+oCtRp+TFtig4qTGIYSGn+t8l8z775enqTIBNjy2XOCMsaI6vofXRN2vPBR
 j88tWK9miuMltDYiU7zzIOAE6d8IXIipt64acLrOHjrF1qI2x4tTB1HtNFY6hZpoMhaX
 QQGLBdIeSCqS80DEwuZfaVR+EQ+3bXgJ233D3CL56W4nG/IzSx7PNpj9dzpJE/BSh9VP
 sgeRbhOeWBc+3CSIPpalKJUN6i0cMGpSloB/leMx+6H81R5Z2CoxEwDKtxztguZmTFQT
 oM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=McmqHb8ZIQwdrf/h9Ux5lHwfQS28gH0LN86W4pPo+uk=;
 b=LoaElKHOCXldh7XbQ+ElSD39Uck/5BLEI0kUSEZlrt2hcEsTdEBomSjOFpd+BUQ/Wm
 8Ups8eocxIcoJvyxPnmDbLz9DMbZyVp6LbyYz7JhDRB3q1WJ6VovFM8xnu+hrB+OVRsD
 Kntiw6Kw70JMWqe7nF32rdBwF4Uq9XaNWCmvx+SMZaOm6+qVGPBTib5p/mC0CeS8cNJR
 6zV6ID0cccU69i466Fo91eevefnJSo4BmLti8AzIZvittmVSyiEnSubDq1m0UAyy7PjM
 carg07//JKz+GbSObDq77oAxFXldcyva5QvXAZShiFVoylHITVXzzP7DmF4bP3m5cRtP
 vXxA==
X-Gm-Message-State: APjAAAXJvoohfl9fPNkdvFK4GveHlLFrTqvCyCo5FLvhWQCF419WcT4Q
 DleIeGk2y1bSluBBJZfWnrCwRVky
X-Google-Smtp-Source: APXvYqzu7Hf9I3Ah2KFvjHPb3c73acvX/Zxip0zFpuKHv5Mgc+dlduI3Lf+ulAUpbGh271qIvDKscw==
X-Received: by 2002:a1c:f003:: with SMTP id a3mr28570948wmb.41.1580720387807; 
 Mon, 03 Feb 2020 00:59:47 -0800 (PST)
Received: from localhost.localdomain (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id j5sm10029678wrw.24.2020.02.03.00.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 00:59:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [NOTFORMERGE PATCH 2/2] RFC: hw/arm/raspi: Add the Raspberry Pi Zero
 machine
Date: Mon,  3 Feb 2020 09:59:42 +0100
Message-Id: <20200203085942.19826-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200203085942.19826-1-f4bug@amsat.org>
References: <20200203085942.19826-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a Raspberry Pi Zero machine.

  $ qemu-system-arm -M raspi0 -serial stdio \
      -kernel raspberrypi/firmware/boot/kernel.img \
      -dtb raspberrypi/firmware/boot/bcm2708-rpi-zero-w.dtb \
      -append 'printk.time=0 earlycon=pl011,0x20201000 console=ttyAMA0'
  [    0.000000] Booting Linux on physical CPU 0x0
  [    0.000000] Linux version 4.19.69+ (dom@buildbot) (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1261 Tue Sep 3 20:21:01 BST 2019
  [    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7 (ARMv7), cr=00c5387d
  [    0.000000] CPU: VIPT aliasing data cache, unknown instruction cache
  [    0.000000] OF: fdt: Machine model: Raspberry Pi Zero W
  [    0.000000] earlycon: pl11 at MMIO 0x20201000 (options '')
  [    0.000000] bootconsole [pl11] enabled
  [    0.000000] Memory policy: Data cache writeback
  [    0.000000] cma: Reserved 8 MiB at 0x1b800000
  [    0.000000] random: get_random_bytes called from start_kernel+0x8c/0x49c with crng_init=0
  [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 113680
  [    0.000000] Kernel command line: printk.time=0 earlycon=pl011,0x20201000 console=ttyAMA0 root=/dev/mmcblk0 rootwait
  Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
  Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
  Memory: 434380K/458752K available (6971K kernel code, 635K rwdata, 2080K rodata, 464K init, 797K bss, 16180K reserved, 8192K cma-reserved)
  Virtual kernel memory layout:
      vector  : 0xffff0000 - 0xffff1000   (   4 kB)
      fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
      vmalloc : 0xdc800000 - 0xff800000   ( 560 MB)
      lowmem  : 0xc0000000 - 0xdc000000   ( 448 MB)
      modules : 0xbf000000 - 0xc0000000   (  16 MB)
        .text : 0x(ptrval) - 0x(ptrval)   (6973 kB)
        .init : 0x(ptrval) - 0x(ptrval)   ( 464 kB)
        .data : 0x(ptrval) - 0x(ptrval)   ( 636 kB)
         .bss : 0x(ptrval) - 0x(ptrval)   ( 798 kB)
  SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
  ftrace: allocating 25193 entries in 74 pages
  NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
  sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps every 2147483647500ns
  clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275 ns
  bcm2835: system timer (irq = 27)
  Console: colour dummy device 80x30
  ...

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
TODO: Add acceptance test

 hw/arm/raspi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index aff5d57261..f2496a5590 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -33,6 +33,7 @@
 #define MACH_TYPE_BCM2708   3138 /* Linux board IDs */
 
 enum BoardIdChip {
+    C_BCM2835 = 0,
     C_BCM2836 = 1,
     C_BCM2837 = 2,
 };
@@ -41,6 +42,7 @@ static const struct {
     const char *soc_name;
     int cores_count;
 } soc_config[] = {
+    [C_BCM2835] = {TYPE_BCM2835, 1},
     [C_BCM2836] = {TYPE_BCM2836, BCM283X_NCPUS},
     [C_BCM2837] = {TYPE_BCM2837, BCM283X_NCPUS},
 };
@@ -80,6 +82,11 @@ typedef struct RaspiMachineClass {
      OBJECT_GET_CLASS(RaspiMachineClass, (obj), TYPE_RASPI_MACHINE)
 
 static const RaspiBoardInfo raspi_boards[] = {
+    {
+        .name = MACHINE_TYPE_NAME("raspi0"),
+        .desc = "Raspberry Pi Zero W",
+        .board_rev = 0x9000c1,
+    },
     {
         .name = MACHINE_TYPE_NAME("raspi2"),
         .desc = "Raspberry Pi 2B",
-- 
2.21.1


