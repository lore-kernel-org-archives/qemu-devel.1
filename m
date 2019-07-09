Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA69AC606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 07:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9112821537
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 07:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9112821537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkki0-0000Zt-1d
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 03:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46778)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <th.huth@gmail.com>) id 1hkkcU-0004H2-PG
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:33:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1hkkcT-0001Pf-LL
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:32:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54733)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1hkkcT-0001P5-FC
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:32:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id p74so1926987wme.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 00:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mGlq4zv/JGEQe51vyhadK2WH40cIR+kLUMnb3nqkhFY=;
 b=OaxT1KqXZK98eNRGMJ9hQLiA/+c0gGFLCVX0JOfEbdRfGGVvCaQyTvUlqMwoFciqIN
 kka/xaTusrNMvkU43X3KSowxgOtgV9HtBv/48kTFEqes81pXd1q6/vn/jESX3FP423bI
 p7zCGeJnJQ3olqsj71Ma3lRDHTfp7V3lcJBetgQELE51yZYmaa25iFLjP1YWi9GSodUx
 C2Phw0KNHc03QhBPQEkE7HmxcsxZAJxsJ1OrmWN9EKppEeE9haVDNMBow4eianWv9i7Y
 swY58+0uykLzUVnyvHSMJJF+7GyvOfZ2vPEPPA0jUs9DtIr9GFvBrYqvCWT5zJvXNBCb
 Ru4g==
X-Gm-Message-State: APjAAAUi+bdPIlV2X0+m8p9TcdAJ2zWVy1udb7Gj5QseKik1I9gM5O0k
 clglItCnV+STIl9vbJXemBjenFGj860=
X-Google-Smtp-Source: APXvYqyWpuJ0gwH/nLviOwfsRpVvVy3cOhY41Rccvrx6VCgbVujkYqeFhLkqRTMARl96/N805Jc/Vw==
X-Received: by 2002:a7b:c776:: with SMTP id x22mr20259679wmk.55.1562657576199; 
 Tue, 09 Jul 2019 00:32:56 -0700 (PDT)
Received: from thl530.multi.box (pD95752BD.dip0.t-ipconnect.de.
 [217.87.82.189])
 by smtp.gmail.com with ESMTPSA id l2sm1529208wmj.4.2019.07.09.00.32.55
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 00:32:55 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 09:32:21 +0200
Message-Id: <20190709073222.26370-6-huth@tuxfamily.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190709073222.26370-1-huth@tuxfamily.org>
References: <20190709073222.26370-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: [Qemu-devel] [PATCH v4 5/6] m68k: Add serial controller to the
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
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

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/Kconfig          |  1 +
 hw/m68k/next-cube.c      | 37 ++++++++++++++++++++++++++++++++++++-
 tests/boot-serial-test.c | 12 ++++++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)

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
index 0737605417..b7f1e9106b 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -846,6 +846,39 @@ void next_irq(void *opaque, int number, int level)
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
@@ -937,8 +970,10 @@ static void next_cube_init(MachineState *machine)
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


