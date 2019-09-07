Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672EFC43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 15:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA24218AC
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 15:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA24218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6d3K-0002Wm-El
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 11:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <th.huth@gmail.com>) id 1i6cwR-0003lK-85
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 11:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1i6cwP-0007j9-GM
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 11:47:59 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:38633)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1i6cwP-0007iG-6i
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 11:47:57 -0400
Received: by mail-wr1-f42.google.com with SMTP id l11so9467954wrx.5
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 08:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O1nN3uC4WpvEZuW8S1GCd9d83+rwXs1Y8D8aDlJkNMA=;
 b=qvhh05meb6O/Mk53dBJnos4ix7F0xtDUWYs8/e1kgY4YNTVW8Dc40VLV4hcTVSWvmg
 7950XpPXVQ6BykF2BKsYZQ5asJy+9mIECP8Fm3iTLdm0tNKMGVV4cGpzgrlWH2yRCm32
 sv7sq6wyqSHLD6+2sJnMR6lNdLnc/eqYjs/OVP+BME7/LEtZCfiX0KjrJux8WniUl0Rl
 BxnLOTpz/1YwyabYgd+s261t4WxnM0Cg9jjWTu4urQFNX5XsMDer1yxgi8o9ebFJdnaB
 CFgEcJL1iG0AlrjLWfVsWB2KgLNJZxWNLYZ37mZTmIdvjv5V+0LDybQrCcPUA8m75E6N
 KaHg==
X-Gm-Message-State: APjAAAVPj08xjjyIbcZLwkv2HRdoPtWhNqUlokwZrXEMZdCIZGC0Tmcu
 a+OaR+Yo4XKwfJSL9vi9Wws=
X-Google-Smtp-Source: APXvYqzPoPiGUJA63YPiTAtNmzOAWSWlgdsdhP45F+Ef81CkNI61YVzNFtTHBfk+z8DC5qigOBdr3Q==
X-Received: by 2002:a05:6000:82:: with SMTP id
 m2mr6830149wrx.241.1567871276240; 
 Sat, 07 Sep 2019 08:47:56 -0700 (PDT)
Received: from thl530.multi.box (pD9E8385F.dip0.t-ipconnect.de.
 [217.232.56.95])
 by smtp.gmail.com with ESMTPSA id s19sm17173418wrb.14.2019.09.07.08.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2019 08:47:55 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Sat,  7 Sep 2019 17:47:41 +0200
Message-Id: <20190907154744.4136-6-huth@tuxfamily.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190907154744.4136-1-huth@tuxfamily.org>
References: <20190907154744.4136-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.42
Subject: [Qemu-devel] [PULL 5/8] m68k: Add serial controller to the NeXTcube
 machine
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

The NeXTcube uses a normal 8530 serial controller, so we can simply use
our normal "escc" device here.
While we're at it, also add a boot-serial-test for the next-cube machine,
now that the serial output works.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190831074519.32613-6-huth@tuxfamily.org>
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
index a54d007298..d3a54a0ba5 100644
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
@@ -117,6 +128,7 @@ static testdef_t tests[] = {
     { "sparc64", "sun4u", "", "UltraSPARC" },
     { "s390x", "s390-ccw-virtio", "", "device" },
     { "m68k", "mcf5208evb", "", "TT", sizeof(kernel_mcf5208), kernel_mcf5208 },
+    { "m68k", "next-cube", "", "TT", sizeof(bios_nextcube), 0, bios_nextcube },
     { "microblaze", "petalogix-s3adsp1800", "", "TT",
       sizeof(kernel_pls3adsp1800), kernel_pls3adsp1800 },
     { "microblazeel", "petalogix-ml605", "", "TT",
-- 
2.21.0


