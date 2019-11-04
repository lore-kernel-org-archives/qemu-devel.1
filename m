Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A8DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 10:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE60A21744
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 10:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE60A21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRZP9-00032S-8J
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 05:16:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iRZOM-0002U1-FB
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 05:15:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iRZOL-0001wo-BI
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 05:15:22 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:35705)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iRZOL-0001wN-27
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 05:15:21 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MIMT4-1iDDu43Oey-00EIwv; Mon, 04 Nov 2019 11:15:16 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] q800: fix I/O memory map
Date: Mon,  4 Nov 2019 11:15:13 +0100
Message-Id: <20191104101513.29518-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:F7qg0IN3IhyZGC1NwtXA41qiH2Rr2K1SGN+85Ci+FkUI1ta2Tie
 K6s2LaKP4dhPfN/3zPJHa9MIzcbQ9zpJhD1+Oy31Rf+PRQRVPI9QKwo8clSBW/ZUSW94/2U
 C8AhFmJGFHj932vMMJCjBRCe4WyBmODl1W0TNGB0RP9TxH5C5ldKHVeDh5C8+Ex4/crq1aX
 xV5JLcT6cnIyjvVQYzdKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M1aBbkOmeO4=:AuM65+MTOzGUqH7uB6+gXh
 fMZ8Pr//a5o4f/3JvIYeLvY8/Q3jtDh4eHTdNOTSVMG4Oi+oVNcSSRWEHxlMv8eKk553y9Po0
 4WU8c/ePI7CwuBEaGLmbCNdxcFUltR3Nt6JunI7sSMLzAMtKwp5bFiuMO293tmEEdkgTcwN0U
 R6FcEBCyECe4kEFzwTqD/Qk2aCgLrRtuPyusWr2df9UAlHr+usvvimJyi/gbxh19FCTZrTEf9
 0YVI84jUMoQA4dLqTFUlfNEikkqIIXJ+cjewGH0I8cWhRuDUYVOLF1QcqWI4wB1oQl9RpWpKT
 S+a7PGO0XffbLTCNLVmJb+5nm6o5pQ9FJBZ3fnbRsNbxFL5UL1kP0WLIvfcaAx/G4ZcVynhEo
 qBKHZCywK1DD3Cqo4fwpql2JAQel3jaoRNQiuecN8k9iy5DmWOPFaycP7liNd6Dk48g6EstDe
 q8j/WCpwiYcvpj4J/D2iz2Bu6J7cJLEkESI2bdWEr0/lgrp11iAreX+8VxkPyhgDNdVWwBYVC
 rpslWQlfUr1/M3sDKc61ddaXs0u8IVqKz+U76aFxN6EgB0NgtFxf+AUfYtfqkGhpYOEZAEPAX
 D0fSa0STv7gajV5Nh1ycnPW8Oqg/w/qz/N6BfcweZCU1OA0BN2EKI0Fe6pRAU/uO0nd7crLZs
 Bl2DdnJE5ya4RDMaIYnYTknhhgQo5gIAxTSBJprYd4nN/3esyQCOtvxEtZF4DXaj9x+O7TPME
 aVAqPuNRGOOSp8ui36jQWMN5ZtnBKQqLcs4+GTHpN8LqAolx5+RrU3RYv0QtFyUW4Wm7JVot2
 bW6YZzvLqnIFaCMh/XI+h3LV1eg7nhnoNCg1LnKhrO69kTgM7kPlHx2eTw8w/yxWDoQXS5DuG
 SSdh4Qneq40vCtaGwsm6R1FY2JSAPwuXZhhOl7haY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.24
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/m68k/q800.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 2b4842f8c6..4ca8678007 100644
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
+        memory_region_init_alias(&io[i], NULL, name, get_system_memory(),
+                                 IO_BASE, IO_SLICE);
+        memory_region_add_subregion(get_system_memory(),
+                                    IO_BASE + (i + 1) * IO_SLICE, &io[i]);
+        g_free(name);
+    }
+
     /* IRQ Glue */
 
     irq = g_new0(GLUEState, 1);
-- 
2.21.0


