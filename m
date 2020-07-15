Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716C1C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 10:20:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 483EC205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 10:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483EC205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jveWW-0000rQ-Ia
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 06:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1jveVV-0007jX-8t
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 06:19:21 -0400
Received: from mail.ispras.ru ([83.149.199.84]:49916)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1jveVT-0007Mu-HM
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 06:19:21 -0400
Received: from [127.0.1.1] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id ADE0E4089EFB;
 Wed, 15 Jul 2020 10:19:17 +0000 (UTC)
Subject: [PATCH 2/2] hw/arm: remove exit(1) in case of missing ROM
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
To: qemu-devel@nongnu.org
Date: Wed, 15 Jul 2020 13:19:17 +0300
Message-ID: <159480835744.15819.10383908697966018668.stgit@pasha-ThinkPad-X280>
In-Reply-To: <159480834629.15819.10175861928294983612.stgit@pasha-ThinkPad-X280>
References: <159480834629.15819.10175861928294983612.stgit@pasha-ThinkPad-X280>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 06:19:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, pavel.dovgalyuk@ispras.ru, f4bug@amsat.org,
 jiaxun.yang@flygoat.com, aleksandar.qemu.devel@gmail.com,
 antonynpavlov@gmail.com, chenhc@lemote.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch updates ARM-based machines to allow starting them without ROM.
In this case CPU starts to execute instructions from the empty memory,
but QEMU allows introspecting the machine configuration.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
---
 0 files changed

diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index b6452d918c..dbad63ffa2 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -102,8 +102,12 @@ static void digic_load_rom(DigicState *s, hwaddr addr,
         char *fn = qemu_find_file(QEMU_FILE_TYPE_BIOS, filename);
 
         if (!fn) {
-            error_report("Couldn't find rom image '%s'.", filename);
-            exit(1);
+            if (bios_name) {
+                error_report("Couldn't find rom image '%s'.", filename);
+                exit(1);
+            } else {
+                return;
+            }
         }
 
         rom_size = load_image_targphys(fn, addr, max_size);
diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
index 3a4bc332c4..a74bb5e27c 100644
--- a/hw/arm/gumstix.c
+++ b/hw/arm/gumstix.c
@@ -60,9 +60,8 @@ static void connex_init(MachineState *machine)
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
     if (!dinfo && !qtest_enabled()) {
-        error_report("A flash image must be given with the "
-                     "'pflash' parameter");
-        exit(1);
+        warn_report("A flash image must be given with the "
+                    "'pflash' parameter");
     }
 
     if (!pflash_cfi01_register(0x00000000, "connext.rom", connex_rom,
@@ -90,9 +89,8 @@ static void verdex_init(MachineState *machine)
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
     if (!dinfo && !qtest_enabled()) {
-        error_report("A flash image must be given with the "
-                     "'pflash' parameter");
-        exit(1);
+        warn_report("A flash image must be given with the "
+                    "'pflash' parameter");
     }
 
     if (!pflash_cfi01_register(0x00000000, "verdex.rom", verdex_rom,
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index 57829b3744..c0ed3d93e9 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -191,13 +191,12 @@ static void sx1_init(MachineState *machine, const int version)
     }
 
     if (!machine->kernel_filename && !fl_idx && !qtest_enabled()) {
-        error_report("Kernel or Flash image must be specified");
-        exit(1);
+        warn_report("Kernel or Flash image must be specified");
+    } else {
+        /* Load the kernel.  */
+        arm_load_kernel(mpu->cpu, machine, &sx1_binfo);
     }
 
-    /* Load the kernel.  */
-    arm_load_kernel(mpu->cpu, machine, &sx1_binfo);
-
     /* TODO: fix next line */
     //~ qemu_console_resize(ds, 640, 480);
 }
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index 97ca105d29..d4f4a8d07a 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -257,12 +257,11 @@ static void palmte_init(MachineState *machine)
     }
 
     if (!rom_loaded && !machine->kernel_filename && !qtest_enabled()) {
-        fprintf(stderr, "Kernel or ROM image must be specified\n");
-        exit(1);
+        warn_report("Kernel or ROM image must be specified");
+    } else {
+        /* Load the kernel.  */
+        arm_load_kernel(mpu->cpu, machine, &palmte_binfo);
     }
-
-    /* Load the kernel.  */
-    arm_load_kernel(mpu->cpu, machine, &palmte_binfo);
 }
 
 static void palmte_machine_init(MachineClass *mc)


