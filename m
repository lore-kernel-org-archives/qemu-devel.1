Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E32C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:58:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51888222C2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFVVD+TE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51888222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Yqj-0004AT-Gs
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:58:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkT-0000ZM-5s
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkN-0006PQ-Fe
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:35 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:37846)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkN-0006Lh-8J
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:31 -0500
Received: by mail-wm1-x332.google.com with SMTP id a6so2846981wme.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xKyFQRP3bJb75Dnq/YP4ZyRkBptFTYb9d0ubWP46zn8=;
 b=IFVVD+TEbKfPlZfxyWNvRd1k4xn603BE7lIbUQoedhq1LbX+wWLDQmmPynsOJPZSIw
 jHj0GhlkgRNMpBXFRNVG8LmbYjh/mgQKowKTHPomN+8qqwbAlMyTWTd5B5toREncidQb
 u7OZZKS7mvcQ6Z+S7hjNE68s3ghqZG++eCQUTqOHbKvTd/Fmzv86+Gr0buEvwZdB6I/x
 OIOhESPkW0L6TS3J9ioEzAf/fl3atYnT45Fw7A7t/PtPMeAgrUY0nIAsrv8tNtHQUEjq
 xoKmCRKcvq8T3YC2mQ7DjKmgpItNgEe5c+/QwS0+S2uvvfTGvAHZHqSMDCy60aUVGf0Y
 /cyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=xKyFQRP3bJb75Dnq/YP4ZyRkBptFTYb9d0ubWP46zn8=;
 b=ElMKE9uaC8CnQyjo+1PZBK9KYiCK19MIlpdUhP+SnahK6LuTugx+egvLc3SdXZ5V4n
 aS4H6x2rZ4Q/jBi0/lBBg/ILj4I6MOVGJ9yMs/oNl1kb/SPaOiPQ91Zy3meM7JjA7HPH
 Rkhrk//Q6hV5GTZHDvr8NXgCmXQXRdH6H3nLdqjV+x+pejVprYPXXwXunQfu1tYUQpGB
 qD8Xttgk1NjQgJGy80+GvUQ+AKRiQId+c77ue/6NX/ZeS9U4x+86hVwJ4FY84t2YZRAD
 9I7Q76pz9p6OHAcCjprZRcg5xl6J9zniRXWQjMbZ2o7iBjwvW0fZfhVYqJwp94diW06t
 a3bw==
X-Gm-Message-State: APjAAAWnZWN6dIp/LKQ3Aj9aHvip5J5Yze6g9MFPlfO7fBUCPeL0UcFy
 UfGCoBWmqhF9kkSx4I3XfPq9LZUy
X-Google-Smtp-Source: APXvYqwFfSSEpmifAtbEMKmGtq84q8txT7mFbPzfkZcEARW1b4HDfrxlLUKpk0GKa6mvSyu+44+Kpg==
X-Received: by 2002:a1c:a553:: with SMTP id o80mr4843089wme.94.1582631490014; 
 Tue, 25 Feb 2020 03:51:30 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 025/136] arm/nseries: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:15 +0100
Message-Id: <1582631466-13880-25-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

memory_region_allocate_system_memory() API is going away, so
replace it with memdev allocated MemoryRegion. The later is
initialized by generic code, so board only needs to opt in
to memdev scheme by providing
  MachineClass::default_ram_id
and using MachineState::ram instead of manually initializing
RAM memory region.

PS:
 while at it add check for user supplied RAM size and error
 out if it mismatches board expected value.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-26-imammedo@redhat.com>
---
 hw/arm/nseries.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 3fd196f..eae800b 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -47,7 +47,6 @@
 
 /* Nokia N8x0 support */
 struct n800_s {
-    MemoryRegion sdram;
     struct omap_mpu_state_s *mpu;
 
     struct rfbi_chip_s blizzard;
@@ -1311,13 +1310,19 @@ static void n8x0_init(MachineState *machine,
                       struct arm_boot_info *binfo, int model)
 {
     struct n800_s *s = (struct n800_s *) g_malloc0(sizeof(*s));
-    uint64_t sdram_size = binfo->ram_size;
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
 
-    memory_region_allocate_system_memory(&s->sdram, NULL, "omap2.dram",
-                                         sdram_size);
-    memory_region_add_subregion(get_system_memory(), OMAP2_Q2_BASE, &s->sdram);
+    if (machine->ram_size != mc->default_ram_size) {
+        char *sz = size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
+    }
+
+    memory_region_add_subregion(get_system_memory(), OMAP2_Q2_BASE,
+                                machine->ram);
 
-    s->mpu = omap2420_mpu_init(&s->sdram, machine->cpu_type);
+    s->mpu = omap2420_mpu_init(machine->ram, machine->cpu_type);
 
     /* Setup peripherals
      *
@@ -1383,9 +1388,8 @@ static void n8x0_init(MachineState *machine,
          *
          * The code above is for loading the `zImage' file from Nokia
          * images.  */
-        load_image_targphys(option_rom[0].name,
-                            OMAP2_Q2_BASE + 0x400000,
-                            sdram_size - 0x400000);
+        load_image_targphys(option_rom[0].name, OMAP2_Q2_BASE + 0x400000,
+                            machine->ram_size - 0x400000);
 
         n800_setup_nolo_tags(nolo_tags);
         cpu_physical_memory_write(OMAP2_SRAM_BASE, nolo_tags, 0x10000);
@@ -1395,16 +1399,12 @@ static void n8x0_init(MachineState *machine,
 
 static struct arm_boot_info n800_binfo = {
     .loader_start = OMAP2_Q2_BASE,
-    /* Actually two chips of 0x4000000 bytes each */
-    .ram_size = 0x08000000,
     .board_id = 0x4f7,
     .atag_board = n800_atag_setup,
 };
 
 static struct arm_boot_info n810_binfo = {
     .loader_start = OMAP2_Q2_BASE,
-    /* Actually two chips of 0x4000000 bytes each */
-    .ram_size = 0x08000000,
     /* 0x60c and 0x6bf (WiMAX Edition) have been assigned but are not
      * used by some older versions of the bootloader and 5555 is used
      * instead (including versions that shipped with many devices).  */
@@ -1431,6 +1431,9 @@ static void n800_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "";
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm1136-r2");
+    /* Actually two chips of 0x4000000 bytes each */
+    mc->default_ram_size = 0x08000000;
+    mc->default_ram_id = "omap2.dram";
 }
 
 static const TypeInfo n800_type = {
@@ -1448,6 +1451,9 @@ static void n810_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "";
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm1136-r2");
+    /* Actually two chips of 0x4000000 bytes each */
+    mc->default_ram_size = 0x08000000;
+    mc->default_ram_id = "omap2.dram";
 }
 
 static const TypeInfo n810_type = {
-- 
1.8.3.1



