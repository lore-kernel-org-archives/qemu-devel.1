Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD88CA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 10:17:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F572086D
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 10:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F572086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ7WV-0000Md-3b
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 06:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iQ7JM-0005j1-8p
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 06:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iQ7JB-00027H-Jn
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 06:04:06 -0400
Received: from [212.227.126.130] (port=48979 helo=mout.kundenserver.de)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iQ7JA-0001vJ-UB
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 06:04:01 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M42fA-1iQ7Iu3YVE-0003nD; Thu, 31 Oct 2019 11:03:45 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [RFC] q800: fix I/O memory map
Date: Thu, 31 Oct 2019 11:03:41 +0100
Message-Id: <20191031100341.3827-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LCvh/wl4E8R8NRQrmruAcYXFftVdFML1Y2h+lO/aGdTuVkazI6P
 a3qX8sJNnKbac5kOWB7xXjbQP4NtrK86gqjppI4OraOc8nwyjUosNhBufegjr5m48wROBxD
 e4QIQRfYVa5X9Ul5zFYwMe01gU2g12HnS3w3ISL2moRoQbicqVDY+pJ/038kHYgCzwJFPCx
 /htwKOsUn1hfb7HydPMSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gn6K3d3YBpc=:bnAZyVeKxW0XwTtgVNq4vJ
 RI/hOqSvsvnFzO+1NJFtpjL4pj6qKzs7++J6w+52hxaBB9u1MdUJ7zZlZ7tj2OG29+dutSVDF
 zidDcz0tX1+7Lh71i0eKWp+IXeBmCcMUeKLJ4TBOS2eg0CALw0QqS/cvCLgg4xt0Az66rFEEg
 FobIyJxqBs2Zf206BFZV/dsHQchok2IIogJ31e5thhJf5MNHr4VvvF41QhiBjjRFS4NxaUcSW
 CPwFLCP8Ini7mvcU9xc1/1uZNKYhIpM1WSsriEi87As8F8PXD7godEu7oElPDn2WCOZp47YyY
 zQIdIbyWu7iP85e/ZcO9T8tivXfGnfBwfxzpu5SufINMyPru/f8SwbqfQpKJ/1SZ7GxEcaJNX
 T6DakFeBYXxXhg6nDPI+uh6oeLeaRw8ykBFD33Gc50MdnwkegkEMiROWNAy0cURg/fJ2FpKOC
 FFV1OfFtQkZTRM+0JHVGMRAenQ3RYMxWH6TngWY8lOFJttH8pKWPGHTNndhLJ5xdGz4YnJ+zV
 sfubN0QU2wvZxNJGEqhNmiwa+7xE99PdKeSM0h9bGvNmzOK6Z9LDURyNjaIgRtYq9S6Ok4Jaz
 b6qvnotP0mfqBixeI/nKPZHnENGdFHAxDQNMwiKeEUat7m7BwKGNOxRSxZhS9gAHyoPLZ7F3J
 FqwQyRY5kJCgXwAM2uDvcRpYcP4dDqaGqfnX2GZT3v871CJZ1Ladj7Ro/CFY7NCSuJW2UTWdA
 GbHp+UXeuACTCXYdEj5kfcx/Fr7ebxtTSv2eCkZGHd4kervxHIPDXRWJNoC02gsMcb/KjycGM
 KHQ6+Yr6GcDDh8r49zpn1ribeiPJQBwn79GCXsnx3zHrED7vyFsaBcqrv+naIBte8oGJ8wIBh
 iYSvQpDqU0Ql0Hhj38Uw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.130
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
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
 hw/m68k/q800.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 2b4842f8c6..8122e7c612 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -60,14 +60,14 @@
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
+#define VIA_BASE              0x50000000
+#define SONIC_PROM_BASE       0x50008000
+#define SONIC_BASE            0x5000a000
+#define SCC_BASE              0x5000c020
+#define ESP_BASE              0x50010000
+#define ESP_PDMA              0x50010100
+#define ASC_BASE              0x50014000
+#define SWIM_BASE             0x5001E000
 #define NUBUS_SUPER_SLOT_BASE 0x60000000
 #define NUBUS_SLOT_BASE       0xf0000000
 
@@ -135,6 +135,7 @@ static void q800_init(MachineState *machine)
     int32_t initrd_size;
     MemoryRegion *rom;
     MemoryRegion *ram;
+    int i;
     ram_addr_t ram_size = machine->ram_size;
     const char *kernel_filename = machine->kernel_filename;
     const char *initrd_filename = machine->initrd_filename;
@@ -163,10 +164,26 @@ static void q800_init(MachineState *machine)
     cpu = M68K_CPU(cpu_create(machine->cpu_type));
     qemu_register_reset(main_cpu_reset, cpu);
 
+    /* RAM */
     ram = g_malloc(sizeof(*ram));
     memory_region_init_ram(ram, NULL, "m68k_mac.ram", ram_size, &error_abort);
     memory_region_add_subregion(get_system_memory(), 0, ram);
 
+    /*
+     * Memory from VIA_BASE to VIA_BASE + 0x40000 is repeated
+     * from VIA_BASE + 0x40000 to VIA_BASE + 0x4000000
+     */
+    for (i = 1; i < 256; i++) {
+        MemoryRegion *io = g_malloc(sizeof(*io));
+        char *name = g_strdup_printf("mac_m68k.io[%d]", i);
+
+        memory_region_init_alias(io, NULL, name, get_system_memory(),
+                                 VIA_BASE, 0x40000);
+        memory_region_add_subregion(get_system_memory(),
+                                    VIA_BASE + i * 0x40000, io);
+        g_free(name);
+    }
+
     /* IRQ Glue */
 
     irq = g_new0(GLUEState, 1);
-- 
2.21.0


