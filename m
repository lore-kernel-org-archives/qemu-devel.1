Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB062C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 16:04:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85BAE20773
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 16:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85BAE20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUBAQ-0007It-Mj
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 12:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kUB6c-0002q0-Bk; Sun, 18 Oct 2020 12:00:24 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:60416
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kUB6a-0004Vc-4S; Sun, 18 Oct 2020 12:00:21 -0400
Received: from host86-148-246-80.range86-148.btcentralplus.com
 ([86.148.246.80] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kUB6a-0001FH-8R; Sun, 18 Oct 2020 17:00:23 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au, atar4qemu@gmail.com
Date: Sun, 18 Oct 2020 16:59:16 +0100
Message-Id: <20201018155919.21200-11-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201018155919.21200-1-mark.cave-ayland@ilande.co.uk>
References: <20201018155919.21200-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.148.246.80
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 10/13] mac_newworld: Allow loading binary ROM image
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: BALATON Zoltan <balaton@eik.bme.hu>

Fall back to load binary ROM image if loading ELF fails. This also
moves PROM_BASE and PROM_SIZE defines to board as these are matching
the ROM size and address on this board and removes the now unused
PROM_ADDR and BIOS_SIZE defines from common mac.h.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <4d58ffe7645a0c746c8fed6aa8775c0867b624e0.1602805637.git.balaton@eik.bme.hu>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ppc/mac.h          |  2 --
 hw/ppc/mac_newworld.c | 22 ++++++++++++++--------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index f3976b9a45..22c8408078 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -39,10 +39,8 @@
 /* SMP is not enabled, for now */
 #define MAX_CPUS 1
 
-#define BIOS_SIZE        (1 * MiB)
 #define NVRAM_SIZE        0x2000
 #define PROM_FILENAME    "openbios-ppc"
-#define PROM_ADDR         0xfff00000
 
 #define KERNEL_LOAD_ADDR 0x01000000
 #define KERNEL_GAP       0x00100000
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 7a8dc09c8d..f9a1cc8944 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -82,6 +82,8 @@
 
 #define NDRV_VGA_FILENAME "qemu_vga.ndrv"
 
+#define PROM_BASE 0xfff00000
+#define PROM_SIZE (1 * MiB)
 
 static void fw_cfg_boot_set(void *opaque, const char *boot_device,
                             Error **errp)
@@ -100,7 +102,7 @@ static void ppc_core99_reset(void *opaque)
 
     cpu_reset(CPU(cpu));
     /* 970 CPUs want to get their initial IP as part of their boot protocol */
-    cpu->env.nip = PROM_ADDR + 0x100;
+    cpu->env.nip = PROM_BASE + 0x100;
 }
 
 /* PowerPC Mac99 hardware initialisation */
@@ -154,25 +156,29 @@ static void ppc_core99_init(MachineState *machine)
     /* allocate RAM */
     memory_region_add_subregion(get_system_memory(), 0, machine->ram);
 
-    /* allocate and load BIOS */
-    memory_region_init_rom(bios, NULL, "ppc_core99.bios", BIOS_SIZE,
+    /* allocate and load firmware ROM */
+    memory_region_init_rom(bios, NULL, "ppc_core99.bios", PROM_SIZE,
                            &error_fatal);
+    memory_region_add_subregion(get_system_memory(), PROM_BASE, bios);
 
-    if (bios_name == NULL)
+    if (!bios_name) {
         bios_name = PROM_FILENAME;
+    }
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
-    memory_region_add_subregion(get_system_memory(), PROM_ADDR, bios);
-
-    /* Load OpenBIOS (ELF) */
     if (filename) {
+        /* Load OpenBIOS (ELF) */
         bios_size = load_elf(filename, NULL, NULL, NULL, NULL,
                              NULL, NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);
 
+        if (bios_size <= 0) {
+            /* or load binary ROM image */
+            bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE);
+        }
         g_free(filename);
     } else {
         bios_size = -1;
     }
-    if (bios_size < 0 || bios_size > BIOS_SIZE) {
+    if (bios_size < 0 || bios_size > PROM_SIZE) {
         error_report("could not load PowerPC bios '%s'", bios_name);
         exit(1);
     }
-- 
2.20.1


