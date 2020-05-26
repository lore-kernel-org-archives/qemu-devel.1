Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B62C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:40:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 286962084C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DH3gZ4OY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286962084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdZoh-0002vr-39
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 09:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZhe-0006i2-26
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:33:10 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:43544)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZha-0005pe-DL
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:33:09 -0400
Received: by mail-ed1-x542.google.com with SMTP id g9so17644102edw.10
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 06:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0jEyZXKOfk0NVUMitEyrP1npgDeWXpetzdjuJB0NJgA=;
 b=DH3gZ4OYlxNIJDgz6NcHwcpGhMtd77ypOWQ/tlS6n4TEOw2NfZqqoDTA7kvxYfxrx0
 vVa07cAZ2lBjziZiVM3hwF3mNheU0ck9EV/q0GYmRBWr/8anLOEaJF0XYTE0VTvg201r
 lO983m1jhXA37mmgv2nkBRk5Sn4U2Om3nX6Oqlr4/bU9t8ZG8fCT7lIGWMEJXH4FKz1w
 KpjGNpmpeLx/slXjsEdVSZBFs3pLNmHC5ebGCVM+exDOvVHcHF6iwUnAFeowGhUZBOxu
 StZlW7BOopgyYBNFwoauq7VM3hxSk3tqgg3GEWJayLGSC8q2FK8UGE6GvAqeQWF+iKUp
 2Gog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0jEyZXKOfk0NVUMitEyrP1npgDeWXpetzdjuJB0NJgA=;
 b=emCmhxY2w2qIBrSwDOWOfi+GbVYTsVg6PK2hPpLLngAGDM21xgmlAsVNjMNLrR90LZ
 lS+mz14DUNfPEgeNjOLt5Q2ll19LFVP7xNjBq+AMSUZ7vLfZTTaGZKcJfg6cC3Myh02s
 U7WSTqgs+mqW6AHi0zWfpA0a2cbB4MvFrtN5fCBMwTpMFj7CvIt11SAzS4igwTQE7+1k
 Dbdof68llEpbLwmt2XUOuSHSjHmgTMagLs4FQ5xZutpA8+Byynvy+PmfNQntk7Enu4aV
 1cq2oUknQK9hhQn+bflb+BQLLrtULGE970Wj/yNeUgJs8jYOuNtBCO0b1yTtHUeOvnh2
 +2DA==
X-Gm-Message-State: AOAM5318KmVanltSEOoBUe3vnIxJEoZt1iQ76rFppSqxSDyKBCpaV7Ty
 ltMw2Q7WGADasRH6t63f4vjjb2GhFFg=
X-Google-Smtp-Source: ABdhPJwBBMw9oaNKH7TmJAfPkRcxOkYBFE2cSamRqoEZP5XLebPIcKNZKIR2+qzW1Miq5iHHQ54gPQ==
X-Received: by 2002:a05:6402:22d1:: with SMTP id
 dm17mr19160025edb.299.1590499984725; 
 Tue, 26 May 2020 06:33:04 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id n25sm1623084edo.56.2020.05.26.06.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 06:33:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/14] hw/mips/fuloong2e: Fix typo in Fuloong machine name
Date: Tue, 26 May 2020 15:32:43 +0200
Message-Id: <20200526133247.13066-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526133247.13066-1-f4bug@amsat.org>
References: <20200526133247.13066-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, libvir-list@redhat.com,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Huacai Chen <chenhc@lemote.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We always miswrote the Fuloong machine... Fix its name.
Add an machine alias to the previous name for backward
compatibility.

Suggested-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-id: <20200526104726.11273-11-f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 docs/system/deprecated.rst               |  5 +++
 docs/system/target-mips.rst              |  2 +-
 default-configs/mips64el-softmmu.mak     |  2 +-
 hw/isa/vt82c686.c                        |  2 +-
 hw/mips/{mips_fulong2e.c => fuloong2e.c} | 41 ++++++++++++------------
 hw/pci-host/bonito.c                     |  8 ++---
 tests/qtest/endianness-test.c            |  2 +-
 MAINTAINERS                              |  4 +--
 hw/mips/Kconfig                          |  2 +-
 hw/mips/Makefile.objs                    |  2 +-
 10 files changed, 38 insertions(+), 32 deletions(-)
 rename hw/mips/{mips_fulong2e.c => fuloong2e.c} (91%)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 3142fac386..f0061f94aa 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -368,6 +368,11 @@ mips ``r4k`` platform (since 5.0)
 This machine type is very old and unmaintained. Users should use the ``malta``
 machine type instead.
 
+mips ``fulong2e`` machine (since 5.1)
+'''''''''''''''''''''''''''''''''''''
+
+This machine has been renamed ``fuloong2e``.
+
 ``pc-1.0``, ``pc-1.1``, ``pc-1.2`` and ``pc-1.3`` (since 5.0)
 '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
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
index 6996f5e3d1..f583c44b79 100644
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
@@ -45,13 +45,13 @@
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
 
@@ -68,12 +68,12 @@
  * 2, use "Bonito2edev" to replace "dir_corresponding_to_your_target_hardware"
  * in the "Compile Guide".
  */
-#define FULONG_BIOSNAME "pmon_fulong2e.bin"
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
@@ -278,7 +278,7 @@ static void network_init(PCIBus *pci_bus)
         const char *default_devaddr = NULL;
 
         if (i == 0 && (!nd->model || strcmp(nd->model, "rtl8139") == 0)) {
-            /* The fulong board has a RTL8139 card using PCI SLOT 7 */
+            /* The Fuloong board has a RTL8139 card using PCI SLOT 7 */
             default_devaddr = "07";
         }
 
@@ -286,7 +286,7 @@ static void network_init(PCIBus *pci_bus)
     }
 }
 
-static void mips_fulong2e_init(MachineState *machine)
+static void mips_fuloong2e_init(MachineState *machine)
 {
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
@@ -318,7 +318,7 @@ static void mips_fulong2e_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
     /* Boot ROM */
-    memory_region_init_rom(bios, NULL, "fulong2e.bios", BIOS_SIZE,
+    memory_region_init_rom(bios, NULL, "fuloong2e.bios", BIOS_SIZE,
                            &error_fatal);
     memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
 
@@ -336,7 +336,7 @@ static void mips_fulong2e_init(MachineState *machine)
         write_bootloader(env, memory_region_get_ram_ptr(bios), kernel_entry);
     } else {
         if (bios_name == NULL) {
-                bios_name = FULONG_BIOSNAME;
+                bios_name = FULOONG_BIOSNAME;
         }
         filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
         if (filename) {
@@ -362,7 +362,7 @@ static void mips_fulong2e_init(MachineState *machine)
     pci_bus = bonito_init((qemu_irq *)&(env->irq[2]));
 
     /* South bridge -> IP5 */
-    vt82c686b_southbridge_init(pci_bus, FULONG2E_VIA_SLOT, env->irq[5],
+    vt82c686b_southbridge_init(pci_bus, FULOONG2E_VIA_SLOT, env->irq[5],
                                &smbus, &isa_bus);
 
     /* GPU */
@@ -383,14 +383,15 @@ static void mips_fulong2e_init(MachineState *machine)
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
index d0201ce59e..f9697dcc43 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -11,7 +11,7 @@
  */
 
 /*
- * fulong 2e mini pc has a bonito north bridge.
+ * fuloong 2e mini pc has a bonito north bridge.
  */
 
 /*
@@ -573,11 +573,11 @@ static int pci_bonito_map_irq(PCIDevice *pci_dev, int irq_num)
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
index 8f597aae12..8136a0e56c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1081,13 +1081,13 @@ R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
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
index 2240504dff..67d39c56a4 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -41,7 +41,7 @@ config JAZZ
     select DS1225Y
     select JAZZ_LED
 
-config FULONG
+config FULOONG
     bool
     select PCI_BONITO
 
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


