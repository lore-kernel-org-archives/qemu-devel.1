Return-Path: <SRS0=rFyn=Y2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DA7CA9EC7
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 21:46:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3BB420862
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 21:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BB420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iR1Dv-00034k-1w
	for qemu-devel@archiver.kernel.org; Sat, 02 Nov 2019 17:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iR1AA-0001Di-8E
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 17:42:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iR1A7-0006iY-U6
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 17:42:25 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:47519)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iR1A7-0006XK-KZ
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 17:42:23 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MXGes-1iSXrk3dSo-00YjsH; Sat, 02 Nov 2019 22:42:15 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] q800: fix I/O memory map
Date: Sat,  2 Nov 2019 22:42:09 +0100
Message-Id: <20191102214209.26058-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eBsbXp97o0kr4DoTJz7q6toXhb8eHaB1oHIdt2IpUCGhWItHUVt
 xbTY2aQrJc2edi0y0F/aaQxzDmQgXy+AeAIlXL1ePtW7Toi7/YodKOu4QdtuaQev5eIMVgO
 7PomFpF3XYsWQxjXe3JphpX9wrMI4aC810ck3WT8X14lOa3SLv+tzev+4Ua/1j/aiJnYL9E
 3Ln4v6yoy50N77keOEzNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YQoo03qgpzg=:SZVdlQ1G4wur5GeXr53vsa
 wWUt/nOIrKnLh+vielJ5hH6xpffAGvv50bTLaH+Ls5cXoOeLAbs5r+dZLJ5RSa8j4a75dVaTi
 IfoCUFGw615VBnlmTws+1l/aem0S+0HMQbGaOXtyEh0t2vjo4AY2+Mm/zuC9fKsR69satM8Vj
 fGUl1VWw2u5EHEsP3vyYfFd8KJq7imqYVRUrJW4BZ7XtW/PKttFdIh7iN6Y3cn/TZaYp1DDxj
 cJvZ1/Uo6Up4c+JV0ljsM4srJgJZjq4FbOTZQGCOe6cod7SGG9KxXftCRAQYqqzSexA5rG3pY
 uY9kDeyl//g9Blg+TEmFU4sHdkHnOKFwxmKAR+dLlwZFNzz8ws9t4M2y/tbWKUBOYAdTDei0T
 LJPcf3XhS6CrsWiaq883eoHsQxng/28ZZMxjcuxYwwwpmw0LzfozANMdZCdASLLFbBZfvKl6W
 5Tt+SQYE/M70Wn8xCgMHsnD49jB0ZVVLf2nw1C9tXIgx9g1PRsvMr8JY4gUm3alXhPfRatVzG
 EeVWInOckmwVvNBBO0/QfSMMjtjUoqJNvnPPXk1hDBZCs/xfKmUqcrYSP3yT/4HxKTjcUmmqS
 1zSwm9D+P58H4TKxkDptVgWrh2bTvqnt54vnwHamoqdS9+5e+4oukAzZm07u8Xg4s9xy41sdU
 s1o3kb7BifDBCDBcsgRmtjPNdPdVxL/k9evFlHEAs73bWz8/Z5EG07wp3KZCiqzWe+nMVuzdY
 c3p0m/VymuP6E1KJ2ekxmotO5J+HL1izYbGyW37hDHiY3+L3y3wqPuJUCaFt/MRz9g/lwHk2g
 FiadbTL6VD2MMkHe9/6xQTCLb64xFBfoMihrqjNKM1ttB5dBWF9z9Z5PjVTNRTwbSJFmtxhUz
 Lc42bn220tHb6zfJsxjw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.131
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Linux kernel 5.4 will introduce a new memory map for SWIM device.
(aee6bff1c325 ("m68k: mac: Revisit floppy disc controller base addresses"))

Until this release all MMIO are mapped between 0x50f00000 and 0x50f40000,
but it appears that for real hardware 0x50f00000 is not the base address:
the MMIO region spans 0x50000000 through 0x60000000, and 0x50040000 through
0x54000000 is repeated images of 0x50000000 to 0x50040000.

Fixed: 04e7ca8d0f ("hw/m68k: define Macintosh Quadra 800")
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---

Notes:
    v2: add some constant definitions
        allocate a bloc of memory to stores all I/O MemoryRegion

 hw/m68k/q800.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 2b4842f8c6..822bd13d36 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -60,14 +60,19 @@
 #define MACH_MAC        3
 #define Q800_MAC_CPU_ID 2
 
-#define VIA_BASE              0x50f00000
-#define SONIC_PROM_BASE       0x50f08000
-#define SONIC_BASE            0x50f0a000
-#define SCC_BASE              0x50f0c020
-#define ESP_BASE              0x50f10000
-#define ESP_PDMA              0x50f10100
-#define ASC_BASE              0x50F14000
-#define SWIM_BASE             0x50F1E000
+#define IO_BASE               0x50000000
+#define IO_SLICE              0x00040000
+#define IO_SIZE               0x04000000
+
+#define VIA_BASE              (IO_BASE + 0x00000)
+#define SONIC_PROM_BASE       (IO_BASE + 0x08000)
+#define SONIC_BASE            (IO_BASE + 0x0a000)
+#define SCC_BASE              (IO_BASE + 0x0c020)
+#define ESP_BASE              (IO_BASE + 0x10000)
+#define ESP_PDMA              (IO_BASE + 0x10100)
+#define ASC_BASE              (IO_BASE + 0x14000)
+#define SWIM_BASE             (IO_BASE + 0x1E000)
+
 #define NUBUS_SUPER_SLOT_BASE 0x60000000
 #define NUBUS_SLOT_BASE       0xf0000000
 
@@ -135,6 +140,9 @@ static void q800_init(MachineState *machine)
     int32_t initrd_size;
     MemoryRegion *rom;
     MemoryRegion *ram;
+    MemoryRegion *io;
+    const int io_slice_nb = (IO_SIZE / IO_SLICE) - 1;
+    int i;
     ram_addr_t ram_size = machine->ram_size;
     const char *kernel_filename = machine->kernel_filename;
     const char *initrd_filename = machine->initrd_filename;
@@ -163,10 +171,26 @@ static void q800_init(MachineState *machine)
     cpu = M68K_CPU(cpu_create(machine->cpu_type));
     qemu_register_reset(main_cpu_reset, cpu);
 
+    /* RAM */
     ram = g_malloc(sizeof(*ram));
     memory_region_init_ram(ram, NULL, "m68k_mac.ram", ram_size, &error_abort);
     memory_region_add_subregion(get_system_memory(), 0, ram);
 
+    /*
+     * Memory from IO_BASE to IO_BASE + IO_SLICE is repeated
+     * from IO_BASE + IO_SLICE to IO_BASE + IO_SIZE
+     */
+    io = g_new(MemoryRegion, io_slice_nb);
+    for (i = 0; i < io_slice_nb; i++) {
+        char *name = g_strdup_printf("mac_m68k.io[%d]", i + 1);
+
+        memory_region_init_alias(io + i, NULL, name, get_system_memory(),
+                                 IO_BASE, IO_SLICE);
+        memory_region_add_subregion(get_system_memory(),
+                                    IO_BASE + (i + 1) * IO_SLICE, io + i);
+        g_free(name);
+    }
+
     /* IRQ Glue */
 
     irq = g_new0(GLUEState, 1);
-- 
2.21.0


