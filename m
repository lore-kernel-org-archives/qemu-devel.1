Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98938C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C94620715
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C94620715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioq3T-0001Ms-Gv
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iootI-0001RT-6Y
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:27:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iootG-0003NR-K6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:27:23 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:59845)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iootG-0003Mu-Aa
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:27:22 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MOi1H-1j41zE1AY3-00Q8pI; Tue, 07 Jan 2020 14:27:19 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 3/4] q800: implement mac rom reset function for BIOS-less mode
Date: Tue,  7 Jan 2020 14:27:14 +0100
Message-Id: <20200107132715.722101-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107132715.722101-1-laurent@vivier.eu>
References: <20200107132715.722101-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ruiixvM/g2wpHv9nuJ8npVJ9Xn9/pNYvZ35CKwSulzKBhkGoLAJ
 WNjETZ4dSkwKm0ks39yM1cq0TzfBZ0dyRonRkmtTU1h+Y4+TPOj9ghoLYTt3NQh8VN7nqbZ
 cfs6B9lnDBH1OaAnR1OyvzVkAq5lmQMhHlLUkiHkAgWLisyAUUvkukWOeNxmu8GVhMmiUPt
 UxUfkhmt4zCDVmMET4N3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4KB2AEvc450=:H5kxfQStNUC8QUigOrvnF+
 qyLl/VLovA+eMT2krwadYbc6P8/b9Pf07GvI23jHDdL3AmvkW5xVgqVnwc0VjPSVUMCM6FsE1
 YTTm3ZwVmS56h9kzajDYeJlqOObgaDvplH8QGU8HoWZ95pkfaeI1d8xvT1Tfb3Dm2Pfih2exI
 U1OSklnZ/uZKA0P4NlKu+Q3Gct+8hBZseM+2NlNn1k5vUaCrhCWH9sM9Edkj+A4BuwbdyMTkD
 iiHbV9E9d5D+ErRKrcN0NB+Pc1IRFJ1V7zUGQOoqUbUE036w77pX0TUeYzwoQO3NPVG8STGXC
 jIFUcrNckdUQJpvFp1iy0Zzbi6MqxTBxVIbfBTHGP20Lx00Zg7wIy6DrD3JgfHZAbZYbJt/b9
 SZVcM/8EZ7i5YWjsgNoZZpta9XZPhE+0lPgFy7qTmQCXAPZNhTdCPj0QHFWIYgU9vuZ62bIwY
 DjbzFOeGM7+r4lPqOhQsqmJ+2m03qt2NqByfMXYWu49xMkFPbGXVz7l51QHBOv1uih+SGblhO
 fNiKrDn3hPHHgJ00H7FCClez+dw1XoOstdodcd/DrE6BPCccT2hBYw+TmOsjVHpOSwG9sxWOG
 eW9ITEr0l6IvbnqfAkyHizu6lu0fCEs9fq2SXzPxYHJHnlvLiVz2Dhshb1nA/Xk8Z+Z/Nd4GU
 Yj86chAglCE/56ii56P7DRDI9fKHp9s4bEdZZ5a75wVebIWZlBbDpzs6zmiKJKDq/iWYj37i+
 b8VGzUflW4O2xnHGvLXkAa/LKvAp0wDANrEZXtMLjqi4ZAbKeHsrHcRbZ3pQhS58jdVUEsndQ
 4sg/U2wyKScPa65J8nkhbophsUns570UDV6q+rvRC4EDdOEoh7RJIeKZExEHK0BYaeiQfEJC2
 AAuMBSMRP70fuirvTT3A==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.133
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
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

On Linux, calling `reboot(RB_AUTOBOOT);` will result in
arch/m68k/mac/misc.c's mac_reset function being called. That in turn
looks at the rombase (or uses 0x40800000 is there's no rombase), adds
0xa, and jumps to that address. At the moment, there's nothing there, so
the kernel just crashes when trying to reboot. So, this commit adds a
very simple implementation at that location, which just writes to via2
to power down. We also correct the value of ROMBASE while we're at it.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200102120150.281082-1-Jason@zx2c4.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 0c445c74bf..0e5a08f993 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -47,7 +47,7 @@
 #include "sysemu/runstate.h"
 #include "sysemu/reset.h"
 
-#define MACROM_ADDR     0x40000000
+#define MACROM_ADDR     0x40800000
 #define MACROM_SIZE     0x00100000
 
 #define MACROM_FILENAME "MacROM.bin"
@@ -128,6 +128,27 @@ static void main_cpu_reset(void *opaque)
     cpu->env.pc = ldl_phys(cs->as, 4);
 }
 
+static uint8_t fake_mac_rom[] = {
+    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+
+    /* offset: 0xa - mac_reset */
+
+    /* via2[vDirB] |= VIA2B_vPower */
+    0x20, 0x7C, 0x50, 0xF0, 0x24, 0x00, /* moveal VIA2_BASE+vDirB,%a0 */
+    0x10, 0x10,                         /* moveb %a0@,%d0 */
+    0x00, 0x00, 0x00, 0x04,             /* orib #4,%d0 */
+    0x10, 0x80,                         /* moveb %d0,%a0@ */
+
+    /* via2[vBufB] &= ~VIA2B_vPower */
+    0x20, 0x7C, 0x50, 0xF0, 0x20, 0x00, /* moveal VIA2_BASE+vBufB,%a0 */
+    0x10, 0x10,                         /* moveb %a0@,%d0 */
+    0x02, 0x00, 0xFF, 0xFB,             /* andib #-5,%d0 */
+    0x10, 0x80,                         /* moveb %d0,%a0@ */
+
+    /* while (true) ; */
+    0x60, 0xFE                          /* bras [self] */
+};
+
 static void q800_init(MachineState *machine)
 {
     M68kCPU *cpu = NULL;
@@ -346,6 +367,12 @@ static void q800_init(MachineState *machine)
                   (graphic_width * graphic_depth + 7) / 8);
         BOOTINFO1(cs->as, parameters_base, BI_MAC_SCCBASE, SCC_BASE);
 
+        rom = g_malloc(sizeof(*rom));
+        memory_region_init_ram_ptr(rom, NULL, "m68k_fake_mac.rom",
+                                   sizeof(fake_mac_rom), fake_mac_rom);
+        memory_region_set_readonly(rom, true);
+        memory_region_add_subregion(get_system_memory(), MACROM_ADDR, rom);
+
         if (kernel_cmdline) {
             BOOTINFOSTR(cs->as, parameters_base, BI_COMMAND_LINE,
                         kernel_cmdline);
-- 
2.24.1


