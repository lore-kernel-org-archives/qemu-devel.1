Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F47C38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 21:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 631DC206F5
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 21:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxbqBKUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631DC206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXt9T-0005zi-Lr
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 17:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXt4x-0007FH-VZ
 for qemu-devel@nongnu.org; Sun, 10 May 2020 17:01:44 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:35202)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXt4v-000167-Oq
 for qemu-devel@nongnu.org; Sun, 10 May 2020 17:01:43 -0400
Received: by mail-ej1-x643.google.com with SMTP id q8so6202401eja.2
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 14:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1ThLD8vMioUEp8RwiXErdzx6S9+lgzaN9JJAAWuoUJc=;
 b=AxbqBKUnxKkyQqbP3uTGSKYHLFopp383tu8MvwKNC729vB22PcUNoI8Dr+4TdUdloW
 LlsCiCFaJnJdQ1iaX/Hb6Ok38FPTvPCJOkt+rgzxJ9tIo2TcdNABOloSF8wxQpLD/af5
 voWAtQktnQJFTdrcQfqxD7KEdlqlBjUkdNqbBmp8aM0f4XhAwPOyaSXnu3rJGZTTjbUE
 GK4MiDUiasWu2q3aZDwGF83Tw0oS+FOJ7xFzeldZ0OQyXVbJtpZ+Pks3oUXtCoyuZhiZ
 cNchQby0/qzd0UbYexkCMFNqt21FaIRK3iaLtvqo8UQaJ76ohjoQzlyv/FdsSIolLGeY
 1Yvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=1ThLD8vMioUEp8RwiXErdzx6S9+lgzaN9JJAAWuoUJc=;
 b=cMk1X8Pe6EakgOFxO7ihupJnhnU9sl0v8QhPB+UHYGnucBBpBQHg6upzidSYLtIwSN
 tc/7ZX4YgZUaK/sbp6hpttQtdbRHvO5L+udJ8MMvFo+EnIPShArtPZgJRSI4U2o0Y+/h
 hvlPlT/39Pecwef9UNgrnNhDlSkyWIAjXxFV7fRHSs2yoV8lVKJ9Tdc4wRa85INcfA+s
 Jr25bXk30NZGJJlch8mi2g73+HfkPxdcrCCqL81d32P45YiDq0LujAPJ5tvR5O4mdn/T
 c7dgA04S8r1GBDEVmUXmqFBDbfX8mESl04iK2BotlzAeCPSaHz4wkGEVYqnDOG60t61I
 FNcQ==
X-Gm-Message-State: AGi0Pub0vjzaiPsdC8BVGBL5UbbVpWoWcLo0V8kKE799cY2/z0vqZ/SN
 DEZ4ykUIuQ/C91/RPeYp89bFs44qSHY=
X-Google-Smtp-Source: APiQypLYBXz4LzeHe3LTnRoem+ebGMBIt33f63CtfW92ERzjSymjUbhT0kbyzvl6CM9a6ge8DIZraw==
X-Received: by 2002:a17:906:1804:: with SMTP id
 v4mr11143825eje.104.1589144500030; 
 Sun, 10 May 2020 14:01:40 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id d15sm921152ejr.50.2020.05.10.14.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 14:01:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/12] hw/mips/fuloong2e: Fix typo in Fuloong machine name
Date: Sun, 10 May 2020 23:01:20 +0200
Message-Id: <20200510210128.18343-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200510210128.18343-1-f4bug@amsat.org>
References: <20200510210128.18343-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We always miswrote the Fuloong machine... Fix its name.
Add an machine alias to the previous name for backward
compatibility.

Suggested-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 docs/system/target-mips.rst              |  2 +-
 default-configs/mips64el-softmmu.mak     |  2 +-
 hw/isa/vt82c686.c                        |  2 +-
 hw/mips/{mips_fulong2e.c => fuloong2e.c} | 46 ++++++++++++------------
 hw/pci-host/bonito.c                     |  8 ++---
 tests/qtest/endianness-test.c            |  2 +-
 MAINTAINERS                              |  4 +--
 hw/mips/Kconfig                          |  2 +-
 hw/mips/Makefile.objs                    |  2 +-
 9 files changed, 36 insertions(+), 34 deletions(-)
 rename hw/mips/{mips_fulong2e.c => fuloong2e.c} (91%)

diff --git a/docs/system/target-mips.rst b/docs/system/target-mips.rst
index 2736fd0509..cd2a931edf 100644
--- a/docs/system/target-mips.rst
+++ b/docs/system/target-mips.rst
@@ -74,7 +74,7 @@ The MIPS Magnum R4000 emulation supports:
 
 -  G364 framebuffer
 
-The Fulong 2E emulation supports:
+The Fuloong 2E emulation supports:
 
 -  Loongson 2E CPU
 
diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mips64el-softmmu.mak
index 8b0c9b1e15..9f8a3ef156 100644
--- a/default-configs/mips64el-softmmu.mak
+++ b/default-configs/mips64el-softmmu.mak
@@ -2,7 +2,7 @@
 
 include mips-softmmu-common.mak
 CONFIG_IDE_VIA=y
-CONFIG_FULONG=y
+CONFIG_FULOONG=y
 CONFIG_ATI_VGA=y
 CONFIG_RTL8139_PCI=y
 CONFIG_JAZZ=y
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index d9b51fce8d..fac4e56b7d 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -503,7 +503,7 @@ static void via_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_via;
     /*
      * Reason: part of VIA VT82C686 southbridge, needs to be wired up,
-     * e.g. by mips_fulong2e_init()
+     * e.g. by mips_fuloong2e_init()
      */
     dc->user_creatable = false;
 }
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/fuloong2e.c
similarity index 91%
rename from hw/mips/mips_fulong2e.c
rename to hw/mips/fuloong2e.c
index 4e1a3646af..624c46a4fd 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -1,5 +1,5 @@
 /*
- * QEMU fulong 2e mini pc support
+ * QEMU fuloong 2e mini pc support
  *
  * Copyright (c) 2008 yajin (yajin@vm-kernel.org)
  * Copyright (c) 2009 chenming (chenming@rdc.faw.com.cn)
@@ -11,8 +11,8 @@
  */
 
 /*
- * Fulong 2e mini pc is based on ICT/ST Loongson 2e CPU (MIPS III like, 800MHz)
- * http://www.linux-mips.org/wiki/Fulong
+ * Fuloong 2e mini pc is based on ICT/ST Loongson 2e CPU (MIPS III like, 800MHz)
+ * https://www.linux-mips.org/wiki/Fuloong_2E
  *
  * Loongson 2e user manual:
  * http://www.loongsondeveloper.com/doc/Loongson2EUserGuide.pdf
@@ -46,13 +46,13 @@
 #include "sysemu/reset.h"
 #include "qemu/error-report.h"
 
-#define DEBUG_FULONG2E_INIT
+#define DEBUG_FULOONG2E_INIT
 
 #define ENVP_ADDR               0x80002000l
 #define ENVP_NB_ENTRIES         16
 #define ENVP_ENTRY_SIZE         256
 
-/* fulong 2e has a 512k flash: Winbond W39L040AP70Z */
+/* Fuloong 2e has a 512k flash: Winbond W39L040AP70Z */
 #define BIOS_SIZE               (512 * KiB)
 #define MAX_IDE_BUS             2
 
@@ -69,12 +69,12 @@
  * 2, use "Bonito2edev" to replace "dir_corresponding_to_your_target_hardware"
  * in the "Compile Guide".
  */
-#define FULONG_BIOSNAME "pmon_2e.bin"
+#define FULOONG_BIOSNAME "pmon_2e.bin"
 
-/* PCI SLOT in fulong 2e */
-#define FULONG2E_VIA_SLOT        5
-#define FULONG2E_ATI_SLOT        6
-#define FULONG2E_RTL8139_SLOT    7
+/* PCI SLOT in Fuloong 2e */
+#define FULOONG2E_VIA_SLOT        5
+#define FULOONG2E_ATI_SLOT        6
+#define FULOONG2E_RTL8139_SLOT    7
 
 static struct _loaderparams {
     int ram_size;
@@ -279,7 +279,7 @@ static void network_init(PCIBus *pci_bus)
         const char *default_devaddr = NULL;
 
         if (i == 0 && (!nd->model || strcmp(nd->model, "rtl8139") == 0)) {
-            /* The fulong board has a RTL8139 card using PCI SLOT 7 */
+            /* The Fuloong board has a RTL8139 card using PCI SLOT 7 */
             default_devaddr = "07";
         }
 
@@ -287,7 +287,7 @@ static void network_init(PCIBus *pci_bus)
     }
 }
 
-static void mips_fulong2e_init(MachineState *machine)
+static void mips_fuloong2e_init(MachineState *machine)
 {
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
@@ -316,11 +316,12 @@ static void mips_fulong2e_init(MachineState *machine)
         error_report("Invalid RAM size, should be 256MB");
         exit(EXIT_FAILURE);
     }
-    memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
-    /* Boot ROM */
-    memory_region_init_rom(bios, NULL, "fulong2e.bios", BIOS_SIZE,
+    /* allocate RAM */
+    memory_region_init_rom(bios, NULL, "fuloong2e.bios", BIOS_SIZE,
                            &error_fatal);
+
+    memory_region_add_subregion(address_space_mem, 0, machine->ram);
     memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
 
     /*
@@ -337,7 +338,7 @@ static void mips_fulong2e_init(MachineState *machine)
         write_bootloader(env, memory_region_get_ram_ptr(bios), kernel_entry);
     } else {
         if (bios_name == NULL) {
-                bios_name = FULONG_BIOSNAME;
+                bios_name = FULOONG_BIOSNAME;
         }
         filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
         if (filename) {
@@ -363,7 +364,7 @@ static void mips_fulong2e_init(MachineState *machine)
     pci_bus = bonito_init((qemu_irq *)&(env->irq[2]));
 
     /* South bridge -> IP5 */
-    vt82c686b_southbridge_init(pci_bus, FULONG2E_VIA_SLOT, env->irq[5],
+    vt82c686b_southbridge_init(pci_bus, FULOONG2E_VIA_SLOT, env->irq[5],
                                &smbus, &isa_bus);
 
     /* GPU */
@@ -384,14 +385,15 @@ static void mips_fulong2e_init(MachineState *machine)
     network_init(pci_bus);
 }
 
-static void mips_fulong2e_machine_init(MachineClass *mc)
+static void mips_fuloong2e_machine_init(MachineClass *mc)
 {
-    mc->desc = "Fulong 2e mini pc";
-    mc->init = mips_fulong2e_init;
+    mc->desc = "Fuloong 2e mini pc";
+    mc->alias = "fulong2e";             /* Incorrect name used up to QEMU 4.2 */
+    mc->init = mips_fuloong2e_init;
     mc->block_default_type = IF_IDE;
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("Loongson-2E");
     mc->default_ram_size = 256 * MiB;
-    mc->default_ram_id = "fulong2e.ram";
+    mc->default_ram_id = "fuloong2e.ram";
 }
 
-DEFINE_MACHINE("fulong2e", mips_fulong2e_machine_init)
+DEFINE_MACHINE("fuloong2e", mips_fuloong2e_machine_init)
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index cc6545c8a8..b9bfe3c417 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -11,7 +11,7 @@
  */
 
 /*
- * fulong 2e mini pc has a bonito north bridge.
+ * fuloong 2e mini pc has a bonito north bridge.
  */
 
 /*
@@ -559,11 +559,11 @@ static int pci_bonito_map_irq(PCIDevice *pci_dev, int irq_num)
     slot = (pci_dev->devfn >> 3);
 
     switch (slot) {
-    case 5:   /* FULONG2E_VIA_SLOT, SouthBridge, IDE, USB, ACPI, AC97, MC97 */
+    case 5:   /* FULOONG2E_VIA_SLOT, SouthBridge, IDE, USB, ACPI, AC97, MC97 */
         return irq_num % 4 + BONITO_IRQ_BASE;
-    case 6:   /* FULONG2E_ATI_SLOT, VGA */
+    case 6:   /* FULOONG2E_ATI_SLOT, VGA */
         return 4 + BONITO_IRQ_BASE;
-    case 7:   /* FULONG2E_RTL_SLOT, RTL8139 */
+    case 7:   /* FULOONG2E_RTL_SLOT, RTL8139 */
         return 5 + BONITO_IRQ_BASE;
     case 8 ... 12: /* PCI slot 1 to 4 */
         return (slot - 8 + irq_num) + 6 + BONITO_IRQ_BASE;
diff --git a/tests/qtest/endianness-test.c b/tests/qtest/endianness-test.c
index 2798802c63..cc088ac01a 100644
--- a/tests/qtest/endianness-test.c
+++ b/tests/qtest/endianness-test.c
@@ -33,7 +33,7 @@ static const TestCase test_cases[] = {
     { "mips64", "pica61", 0x90000000, .bswap = true },
     { "mips64", "mips", 0x14000000, .bswap = true },
     { "mips64", "malta", 0x10000000, .bswap = true },
-    { "mips64el", "fulong2e", 0x1fd00000 },
+    { "mips64el", "fuloong2e", 0x1fd00000 },
     { "ppc", "g3beige", 0xfe000000, .bswap = true, .superio = "i82378" },
     { "ppc", "40p", 0x80000000, .bswap = true },
     { "ppc", "bamboo", 0xe8000000, .bswap = true, .superio = "i82378" },
diff --git a/MAINTAINERS b/MAINTAINERS
index aa5c54c75a..50f6a5f1bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1074,13 +1074,13 @@ R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
 S: Obsolete
 F: hw/mips/mips_r4k.c
 
-Fulong 2E
+Fuloong 2E
 M: Huacai Chen <chenhc@lemote.com>
 M: Philippe Mathieu-Daudé <f4bug@amsat.org>
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Odd Fixes
-F: hw/mips/mips_fulong2e.c
+F: hw/mips/fuloong2e.c
 F: hw/isa/vt82c686.c
 F: hw/pci-host/bonito.c
 F: include/hw/isa/vt82c686.h
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 2c2adbc42a..cd38546689 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -41,7 +41,7 @@ config JAZZ
     select DS1225Y
     select JAZZ_LED
 
-config FULONG
+config FULOONG
     bool
 
 config MIPS_CPS
diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
index 525809af07..8ab41edc3f 100644
--- a/hw/mips/Makefile.objs
+++ b/hw/mips/Makefile.objs
@@ -3,6 +3,6 @@ obj-$(CONFIG_R4K) += mips_r4k.o
 obj-$(CONFIG_MALTA) += gt64xxx_pci.o mips_malta.o
 obj-$(CONFIG_MIPSSIM) += mips_mipssim.o
 obj-$(CONFIG_JAZZ) += mips_jazz.o
-obj-$(CONFIG_FULONG) += mips_fulong2e.o
+obj-$(CONFIG_FULOONG) += fuloong2e.o
 obj-$(CONFIG_MIPS_CPS) += cps.o
 obj-$(CONFIG_MIPS_BOSTON) += boston.o
-- 
2.21.3


