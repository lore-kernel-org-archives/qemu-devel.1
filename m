Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAE3C3A59F
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 07:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A24C42343A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 07:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24C42343A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3yAa-0005a7-Q1
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 03:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <th.huth@gmail.com>) id 1i3y4v-0000z0-Mb
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 03:45:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1i3y4r-0005m0-Se
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 03:45:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41116)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1i3y4p-0005Xc-Sf
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 03:45:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id j16so9035953wrr.8
 for <qemu-devel@nongnu.org>; Sat, 31 Aug 2019 00:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QYgUvif6FhA4AfOnyb8G0c1uRBzyi6qKk/mZjjHm82o=;
 b=Mr54KzNNeVp912YZuzzWPmSMwMC1RVKSVov2DjROm2swSmJ17k5Vr9lda8eojq2gbN
 bQimi3MoXrJQEjTeVuau6G2CJNGVRMajxESWrLfZSZnXXcmC+AgNxE/d22iugaIwcdr1
 3o6utov1LDx8up5HdaFbbWTtnZZGtT1frBWLrnobWWmdthsBny+8nVJQJfp/4A54fEhG
 rr5e4UdqP1WC7ocd0J09j5n5XwkLtMpcVYcSj/Sydis/V6Zr4ziqIAb3lB20SefRtSdk
 xdFVoLfKWOWMUDBfcFjOH+8W5Ksq4Y23MqfA4v451h6Nk2wCdSHoBlCLOjbNtJbX8AMM
 hOQg==
X-Gm-Message-State: APjAAAU8Tf1nZiJEQGmSYBv9cGteQEXDmS3yzBRuIWcORwzojf+Cuyy+
 ImITzpU3CIsaRn3n5biGPs84SRNFjpI=
X-Google-Smtp-Source: APXvYqzJne2medyeXJfq5wHoVOfmdtyL4P/CcJtlhZcuMGQATiJ7T9qpa3yNhN+8X59nDTBfwR9zxw==
X-Received: by 2002:adf:c7cb:: with SMTP id y11mr24118100wrg.281.1567237534682; 
 Sat, 31 Aug 2019 00:45:34 -0700 (PDT)
Received: from thl530.multi.box (pD9E83624.dip0.t-ipconnect.de.
 [217.232.54.36])
 by smtp.gmail.com with ESMTPSA id w1sm7546650wrm.38.2019.08.31.00.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Aug 2019 00:45:34 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org
Date: Sat, 31 Aug 2019 09:45:18 +0200
Message-Id: <20190831074519.32613-6-huth@tuxfamily.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190831074519.32613-1-huth@tuxfamily.org>
References: <20190831074519.32613-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: [Qemu-devel] [PATCH v5 5/6] m68k: Add serial controller to the
 NeXTcube machine
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The NeXTcube uses a normal 8530 serial controller, so we can simply use
our normal "escc" device here.
While we're at it, also add a boot-serial-test for the next-cube machine,
now that the serial output works.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/Kconfig          |  1 +
 hw/m68k/next-cube.c      | 41 ++++++++++++++++++++++++++++++++++++++--
 tests/boot-serial-test.c | 12 ++++++++++++
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
index ec58a2eb06..a74fac5abd 100644
--- a/hw/m68k/Kconfig
+++ b/hw/m68k/Kconfig
@@ -11,3 +11,4 @@ config MCF5208
 config NEXTCUBE
     bool
     select FRAMEBUFFER
+    select ESCC
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 530c6ac46a..9a4a7328f9 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -10,11 +10,12 @@
  */
 
 #include "qemu/osdep.h"
+#include "cpu.h"
 #include "exec/hwaddr.h"
 #include "exec/address-spaces.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
-#include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/m68k/next-cube.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
@@ -22,6 +23,7 @@
 #include "hw/sysbus.h"
 #include "hw/char/escc.h" /* ZILOG 8530 Serial Emulation */
 #include "hw/block/fdc.h"
+#include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "ui/console.h"
 #include "target/m68k/cpu.h"
@@ -815,6 +817,39 @@ void next_irq(void *opaque, int number, int level)
     }
 }
 
+static void next_serial_irq(void *opaque, int n, int level)
+{
+    /* DPRINTF("SCC IRQ NUM %i\n",n); */
+    if (n) {
+        next_irq(opaque, NEXT_SCC_DMA_I, level);
+    } else {
+        next_irq(opaque, NEXT_SCC_I, level);
+    }
+}
+
+static void next_escc_init(M68kCPU *cpu)
+{
+    qemu_irq *ser_irq = qemu_allocate_irqs(next_serial_irq, cpu, 2);
+    DeviceState *dev;
+    SysBusDevice *s;
+
+    dev = qdev_create(NULL, TYPE_ESCC);
+    qdev_prop_set_uint32(dev, "disabled", 0);
+    qdev_prop_set_uint32(dev, "frequency", 9600 * 384);
+    qdev_prop_set_uint32(dev, "it_shift", 0);
+    qdev_prop_set_bit(dev, "bit_swap", true);
+    qdev_prop_set_chr(dev, "chrB", serial_hd(1));
+    qdev_prop_set_chr(dev, "chrA", serial_hd(0));
+    qdev_prop_set_uint32(dev, "chnBtype", escc_serial);
+    qdev_prop_set_uint32(dev, "chnAtype", escc_serial);
+    qdev_init_nofail(dev);
+
+    s = SYS_BUS_DEVICE(dev);
+    sysbus_connect_irq(s, 0, ser_irq[0]);
+    sysbus_connect_irq(s, 1,  ser_irq[1]);
+    sysbus_mmio_map(s, 0, 0x2118000);
+}
+
 static void next_cube_init(MachineState *machine)
 {
     M68kCPU *cpu;
@@ -906,8 +941,10 @@ static void next_cube_init(MachineState *machine)
         }
     }
 
-    /* TODO: */
     /* Serial */
+    next_escc_init(cpu);
+
+    /* TODO: */
     /* Network */
     /* SCSI */
 
diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 24852d4c7d..c8ded1195e 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -24,6 +24,17 @@ static const uint8_t kernel_mcf5208[] = {
     0x60, 0xfa                              /* bra.s  loop */
 };
 
+static const uint8_t bios_nextcube[] = {
+    0x06, 0x00, 0x00, 0x00,                 /* Initial SP */
+    0x01, 0x00, 0x00, 0x08,                 /* Initial PC */
+    0x41, 0xf9, 0x02, 0x11, 0x80, 0x00,     /* lea 0x02118000,%a0 */
+    0x10, 0x3c, 0x00, 0x54,                 /* move.b #'T',%d0 */
+    0x11, 0x7c, 0x00, 0x05, 0x00, 0x01,     /* move.b #5,1(%a0)    Sel TXCTRL */
+    0x11, 0x7c, 0x00, 0x68, 0x00, 0x01,     /* move.b #0x68,1(%a0) Enable TX */
+    0x11, 0x40, 0x00, 0x03,                 /* move.b %d0,3(%a0)   Print 'T' */
+    0x60, 0xfa                              /* bra.s  loop */
+};
+
 static const uint8_t kernel_pls3adsp1800[] = {
     0xb0, 0x00, 0x84, 0x00,                 /* imm   0x8400 */
     0x30, 0x60, 0x00, 0x04,                 /* addik r3,r0,4 */
@@ -116,6 +127,7 @@ static testdef_t tests[] = {
     { "sparc64", "sun4u", "", "UltraSPARC" },
     { "s390x", "s390-ccw-virtio", "", "device" },
     { "m68k", "mcf5208evb", "", "TT", sizeof(kernel_mcf5208), kernel_mcf5208 },
+    { "m68k", "next-cube", "", "TT", sizeof(bios_nextcube), 0, bios_nextcube },
     { "microblaze", "petalogix-s3adsp1800", "", "TT",
       sizeof(kernel_pls3adsp1800), kernel_pls3adsp1800 },
     { "microblazeel", "petalogix-ml605", "", "TT",
-- 
2.21.0


