Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517BEC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 06:16:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 276DE206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 06:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276DE206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxlZw-0008LP-CQ
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 02:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1jxlYZ-0006zS-Bn
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 02:15:15 -0400
Received: from mail.ispras.ru ([83.149.199.84]:53694)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1jxlYX-0001fC-CK
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 02:15:15 -0400
Received: from [127.0.1.1] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 86F7840A92BC;
 Tue, 21 Jul 2020 06:15:11 +0000 (UTC)
Subject: [PATCH v2 2/2] hw/arm: remove exit(1) in case of missing ROM
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
To: qemu-devel@nongnu.org
Date: Tue, 21 Jul 2020 09:15:11 +0300
Message-ID: <159531211130.24117.1461702940326067827.stgit@pasha-ThinkPad-X280>
In-Reply-To: <159531210010.24117.10018704762356020189.stgit@pasha-ThinkPad-X280>
References: <159531210010.24117.10018704762356020189.stgit@pasha-ThinkPad-X280>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 02:15:01
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
 aleksandar.qemu.devel@gmail.com, antonynpavlov@gmail.com, chenhc@lemote.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch updates ARM-based machines to allow starting them without ROM.
In this case CPU starts to execute instructions from the empty memory,
but QEMU allows introspecting the machine configuration.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>

--

v2:
 - useless error reports were dropped (suggested by Peter Maydell)
---
 hw/arm/digic_boards.c |    8 ++++++--
 hw/arm/gumstix.c      |   12 ------------
 hw/arm/omap_sx1.c     |    5 -----
 hw/arm/palm.c         |    8 +-------
 4 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index d5524d3e72..4f39a001bb 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -101,8 +101,12 @@ static void digic_load_rom(DigicState *s, hwaddr addr,
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
index 3a4bc332c4..fb9fd6ab9c 100644
--- a/hw/arm/gumstix.c
+++ b/hw/arm/gumstix.c
@@ -59,12 +59,6 @@ static void connex_init(MachineState *machine)
     cpu = pxa255_init(address_space_mem, connex_ram);
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
-    if (!dinfo && !qtest_enabled()) {
-        error_report("A flash image must be given with the "
-                     "'pflash' parameter");
-        exit(1);
-    }
-
     if (!pflash_cfi01_register(0x00000000, "connext.rom", connex_rom,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                                sector_len, 2, 0, 0, 0, 0, 0)) {
@@ -89,12 +83,6 @@ static void verdex_init(MachineState *machine)
     cpu = pxa270_init(address_space_mem, verdex_ram, machine->cpu_type);
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
-    if (!dinfo && !qtest_enabled()) {
-        error_report("A flash image must be given with the "
-                     "'pflash' parameter");
-        exit(1);
-    }
-
     if (!pflash_cfi01_register(0x00000000, "verdex.rom", verdex_rom,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                                sector_len, 2, 0, 0, 0, 0, 0)) {
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index 57829b3744..ea3236cfb7 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -190,11 +190,6 @@ static void sx1_init(MachineState *machine, const int version)
                                 OMAP_CS1_BASE, &cs[1]);
     }
 
-    if (!machine->kernel_filename && !fl_idx && !qtest_enabled()) {
-        error_report("Kernel or Flash image must be specified");
-        exit(1);
-    }
-
     /* Load the kernel.  */
     arm_load_kernel(mpu->cpu, machine, &sx1_binfo);
 
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index e7bc9ea4c6..8225c252c4 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -231,7 +231,7 @@ static void palmte_init(MachineState *machine)
     static uint32_t cs1val = 0x0000e1a0;
     static uint32_t cs2val = 0x0000e1a0;
     static uint32_t cs3val = 0xe1a0e1a0;
-    int rom_size, rom_loaded = 0;
+    int rom_size;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     MemoryRegion *flash = g_new(MemoryRegion, 1);
     MemoryRegion *cs = g_new(MemoryRegion, 4);
@@ -284,7 +284,6 @@ static void palmte_init(MachineState *machine)
         if (rom_size > 0) {
             rom_size = load_image_targphys(option_rom[0].name, OMAP_CS0_BASE,
                                            flash_size);
-            rom_loaded = 1;
         }
         if (rom_size < 0) {
             fprintf(stderr, "%s: error loading '%s'\n",
@@ -292,11 +291,6 @@ static void palmte_init(MachineState *machine)
         }
     }
 
-    if (!rom_loaded && !machine->kernel_filename && !qtest_enabled()) {
-        fprintf(stderr, "Kernel or ROM image must be specified\n");
-        exit(1);
-    }
-
     /* Load the kernel.  */
     arm_load_kernel(mpu->cpu, machine, &palmte_binfo);
 }


