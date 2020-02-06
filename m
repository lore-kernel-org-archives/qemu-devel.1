Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F6EC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C3920661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEmQYqv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C3920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izW1d-0001cs-GZ
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:32:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVob-00015k-Jh
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoa-000405-8T
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:45 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46308)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoa-0003t7-1I; Wed, 05 Feb 2020 20:18:44 -0500
Received: by mail-wr1-x443.google.com with SMTP id z7so5086824wrl.13;
 Wed, 05 Feb 2020 17:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8Iprr4A0vBZTEX9NcyGJBQBnH/tFZPAN6KVSAGt3jwY=;
 b=FEmQYqv2bA56jiWhJU27uqqcKxszU/7wHOzJi6t4iFkhiqXaIS0EV0wcUYXswtJoTe
 5sFjQYAVpxNPLlQ370W0wFQmtAErNoCNVT8daRzF8QjECcHQEETdB/k1fAG6y2K6b7SL
 GyVnqTLKOLIWJJvzAApBR67w7QFQ5gT9tgiRp45MX1ij7WkWUfHoX8dkXceMm23tP/7L
 Bqcqj29xKxwNliarSxoEV3qFyfZYExV6FY9LN+wahO0VcrZiZ3oyrDrcVy4lj3upYkZh
 ImHkF82W3xYStdjMEILKCBSCYSkmySKdfnJHObi+iMZiNqmBnpxAhmwZ3uh3ElitKrhY
 vU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8Iprr4A0vBZTEX9NcyGJBQBnH/tFZPAN6KVSAGt3jwY=;
 b=hdNodpmtCES6Z9G1n7SShHUmOUQzIQ8CN+e4kR/KUjmMHeEcPpdfw8EhGsf1K6Um9p
 +8FK5r/j3xWOhIfHIClFZwPxSzPCGtSZUxu8FhUgcUFXndXjIYsT1MXZiOyPUQF9++6v
 6nbllAMXHAW5EjmXSIW/GuQKX5wYnn0z0MZxnoKn45qUgAXEUpzzsSsDKscrCI9RHS+y
 hQXgypPcv0mlcfr8Q3H1OXgbYXNGiC/4IhRZAsOmwUv0awSKhW724CDkD/WNn5V2z7Ms
 8EGAfBb/Wy2ZMBHy/deciKalGAoknCY2FuaFaAnyAvQ54i7bTsxf539TkSteNvXn9/Zj
 g3Xg==
X-Gm-Message-State: APjAAAXckGuuKzv/9KCms3avwwPMbg1KgpAFDtLmrHInl+yzV8+0WAbL
 a2k1YYu5bG/ANb4k9cl8JRqOyz4i
X-Google-Smtp-Source: APXvYqw7RXUgbTsnjtdeksf+sCPmx41u1w8MMeryx/ZyGIu9AFzaqRzIEqcSfL7T1FwXMXHV/+z7GQ==
X-Received: by 2002:adf:f0ca:: with SMTP id x10mr317731wro.423.1580951921875; 
 Wed, 05 Feb 2020 17:18:41 -0800 (PST)
Received: from localhost.localdomain (2.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.2])
 by smtp.gmail.com with ESMTPSA id w13sm2053526wru.38.2020.02.05.17.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 17:18:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 20/30] hw/arm/raspi: Add the Raspberry Pi Zero machine
Date: Thu,  6 Feb 2020 02:17:46 +0100
Message-Id: <20200206011756.2413-21-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200206011756.2413-1-f4bug@amsat.org>
References: <20200206011756.2413-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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
---
 hw/arm/raspi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 4f7e5ecfab..0d1f15e08c 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -88,7 +88,7 @@ static int board_version(uint32_t board_rev)
 static const char *board_soc_type(uint32_t board_rev)
 {
     static const char *soc_types[] = {
-        NULL, TYPE_BCM2836, TYPE_BCM2837,
+        TYPE_BCM2835, TYPE_BCM2836, TYPE_BCM2837,
     };
     int proc_id = board_processor_id(board_rev);
 
@@ -103,7 +103,7 @@ static const char *board_soc_type(uint32_t board_rev)
 static int cores_count(uint32_t board_rev)
 {
     static const int soc_cores_count[] = {
-        0, BCM283X_NCPUS, BCM283X_NCPUS,
+        1, BCM283X_NCPUS, BCM283X_NCPUS,
     };
     int proc_id = board_processor_id(board_rev);
 
@@ -330,6 +330,11 @@ static void raspi_machine_class_init(ObjectClass *oc, void *data)
 
 static const TypeInfo raspi_machine_types[] = {
     {
+        .name           = MACHINE_TYPE_NAME("raspi0"),
+        .parent         = TYPE_RASPI_MACHINE,
+        .class_init     = raspi_machine_class_init,
+        .class_data     = (void *)0x9000c1,
+    }, {
         .name           = MACHINE_TYPE_NAME("raspi2"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi_machine_class_init,
-- 
2.21.1


