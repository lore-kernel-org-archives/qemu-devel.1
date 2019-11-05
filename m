Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC62C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6723421882
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6723421882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS3F8-0004Cm-IK
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 13:07:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iS3E8-0003ME-So
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:06:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iS3E7-0002WN-M9
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:06:48 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:43167)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iS3E7-0002W7-D8
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:06:47 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MEC8L-1ibe8C1Ezl-00AGdq; Tue, 05 Nov 2019 19:06:41 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] q800: fix I/O memory map
Date: Tue,  5 Nov 2019 19:06:37 +0100
Message-Id: <20191105180637.26020-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105180637.26020-1-laurent@vivier.eu>
References: <20191105180637.26020-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HCNinvCbx+2Eu0sVlxe84ltpZcLCN9trZg0EMhoUwUpQTyChEzS
 lYzArJr2ASQr0tDy9VQoYCymR8KwwjS6VFOxalaJssVhTbLRMaLplucUAVfUAKczud/ggiM
 QqV3+MogKlc8GjWo8doa4LVNR4FY+ggVYefbq/qPEeGm7emC4ZN358HKq9s1QltfPGzONSa
 rfFphjjwWLmV4TbuSsMnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FC/ziqsac3Q=:XfJuYDU1ZIv2D317zCyLWp
 1h4HHJU5mtRCPn5NGIL3/Kxo79IM/P72u/7PC5r7926OG6Ca9ljZcklrpZMQ89G2S0doXccMP
 v3dq3IWRtTYNope38Fpy655q0nlzAPquNdmnRB2O4jWFCPPW/K4l/f4psvCcREOkonecDOLlW
 p1NMoJfhL2IV2rkx7n2EaYD055FRn9EdQtKN7WbY/39y120tRfmigHA//ulRqYtN+6Ru8eqiE
 mLpBRRqDEXH5fvNGzMAGi5lL4H+CTKIIrhBmYNF/4gWqxp1ToVFg4bjbI6PGVjI6jWpCpk4pq
 JWyeX0kSvidsNyBpQaVBBeg54VZG9qJxd/w98gjPpiP3VgfBv6KvTzL3cxkAet/n4s1ffGnE5
 Jde3iaoIpVB3UfKrbbCU5/LfWO/DBlP/q+LeaH1DIHryJ3adz4ElLlRHRYtkivtwYFix+8oIi
 gqbDIEmvx58OnXV3FnC6rRk2cl+BvF4L+0SUqnAyv77vtM9VGpBVW75YSS10izmC1mbsmaeYb
 PGhsd57BfNlY/rGEif1BqmTP3Y+BZwHM/9yQP/9JQBYmorD0AfBSj6MEhvUPQBEbI2jZjALuK
 Y5kdlfj+hx/Ow6QM0ZLxfUQoi9QDsrY2F415Z1nABKLulo258QzjXqMNYpHza2Vxnd/TTliRm
 p1mcAZN20IuwFI359p+ncVtKdDUBfHDs8WKdxK/fwdDGCzHn4J5cV72Jg0wwoQx4j90xeXEEy
 8GinB7d1qRzDwfNV3YfrbWa4mh4BQeQ45BeggzBz2aTmenX8O8+IOFc3iRfDXUjGics9oIfuv
 +Jz+VsaXRaeMsBg4t0Gf8Hs8UhyRKjvGR6qUa5NJqqyqNlpANANoWM4fhvWC5gimfGplfnvxA
 4yc3QAc4zit86W5/Oe+Jtm/z8babWLckjfRt55qAo=
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191104101513.29518-1-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
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


