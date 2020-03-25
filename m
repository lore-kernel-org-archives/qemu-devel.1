Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A52BC2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 19:24:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646D320719
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 19:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyaUeLsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646D320719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHBe2-0000cj-I6
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 15:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jHBYK-0000N1-IH
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 15:19:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jHBYJ-0008Uy-7u
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 15:19:00 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38966)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jHBYJ-0008UO-1N; Wed, 25 Mar 2020 15:18:59 -0400
Received: by mail-wm1-x343.google.com with SMTP id a9so4165661wmj.4;
 Wed, 25 Mar 2020 12:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f6uKp3uPJrVKrxXGrT0pUT5lieQ9qkbOy6joblcGLgw=;
 b=pyaUeLsr2K2SsPy0yyFgXsIlyyj8rV4oGJo1asci/4MPy+aJSAcy761P4WE95+ggHe
 KWJhIgzBJvLaWmyk1qc0XNQ0yCATSXqZKOTm5uk7DUiWpLH3SU+sQkPzfkxecu5ThTJD
 TxG89ZXfHAii/Alr87Si44h3LFClH21a9I6YNCrZVau7cxhdj5mt0/k3MlEg4nsB8+U0
 9yYIcmAfr+aC2Ld4MigD8PBmcEZoduZ4ZGRRpMMQT1KRnFqf+eX2oG1Rjzlillcy69ST
 dOT6Gm30xGDqVxw14ttv73at36TX9Src3KnbMRTzbfVADugumwQCI78LSza0c035zojP
 CAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=f6uKp3uPJrVKrxXGrT0pUT5lieQ9qkbOy6joblcGLgw=;
 b=YlxZrUlRUZHN18KQfXexdoo2YqeXIXLt7v5nwovtUOv/PtEEtpEcatl7cEjVr+WqzD
 9cuyHV71sz7oFFHvfVOsb7U7wslpDTVBR6bzzLOUFEjKtFns6SfTI9ofttPTSCvGy+p0
 1n8i5SlHCz4AKmxYgWZ75W4kVQwBTmorNFuAi3Pdyj8cjYzO0NhnS75HrFTBZy1NKtv3
 gFHV+StJwymiYdhTS6YVDOJ3lIXoQP9po5jKCKxvR+wMvya6INdIjJQ/q684B+IN7raJ
 xRK5n9TKU0NDaYFVt7K9W62F8EeVEw8vJL/JnQa8mNmbWtwzy9mdvAvHqgw7z084MqWy
 lx1A==
X-Gm-Message-State: ANhLgQ2k2IJhoHVAANSDUH72mWTxAcB9UqeOech92Xo0ICpewPdOTmhE
 zfTjiqbmDQieIEFDoTZy572hGZ6AJv8=
X-Google-Smtp-Source: ADFU+vssM5rTRRS6nWLopYRU0I3IOOPbtQnaV3Ge7Fcit2tGZUIKwqyP6ttvHzDUq9Nu1GbE2dITOg==
X-Received: by 2002:a1c:456:: with SMTP id 83mr4978477wme.54.1585163937757;
 Wed, 25 Mar 2020 12:18:57 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id r17sm6345672wrx.46.2020.03.25.12.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 12:18:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 08/12] hw/mips/boston: Add missing error-propagation
 code
Date: Wed, 25 Mar 2020 20:18:26 +0100
Message-Id: <20200325191830.16553-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325191830.16553-1-f4bug@amsat.org>
References: <20200325191830.16553-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Running the coccinelle script produced:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/object_property_missing_error_propagate.cocci \
    --keep-comments --smpl-spacing --dir hw

  [[manual check required: error_propagate() might be missing in object_property_set_int() hw/mips/boston.c:462:4]]
  [[manual check required: error_propagate() might be missing in object_property_set_str() hw/mips/boston.c:460:4]]

Since the uses are inside a MachineClass::init() function,
directly use &error_fatal instead of error_propagate().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/boston.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 98ecd25e8e..2e821ca7d6 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -425,121 +425,116 @@ xilinx_pcie_init(MemoryRegion *sys_mem, uint32_t bus_nr,
 static void boston_mach_init(MachineState *machine)
 {
     DeviceState *dev;
     BostonState *s;
-    Error *err = NULL;
     MemoryRegion *flash, *ddr_low_alias, *lcd, *platreg;
     MemoryRegion *sys_mem = get_system_memory();
     XilinxPCIEHost *pcie2;
     PCIDevice *ahci;
     DriveInfo *hd[6];
     Chardev *chr;
     int fw_size, fit_err;
     bool is_64b;
 
     if ((machine->ram_size % GiB) ||
         (machine->ram_size > (2 * GiB))) {
         error_report("Memory size must be 1GB or 2GB");
         exit(1);
     }
 
     dev = qdev_create(NULL, TYPE_MIPS_BOSTON);
     qdev_init_nofail(dev);
 
     s = BOSTON(dev);
     s->mach = machine;
 
     if (!cpu_supports_cps_smp(machine->cpu_type)) {
         error_report("Boston requires CPUs which support CPS");
         exit(1);
     }
 
     is_64b = cpu_supports_isa(machine->cpu_type, ISA_MIPS64);
 
     sysbus_init_child_obj(OBJECT(machine), "cps", OBJECT(&s->cps),
                           sizeof(s->cps), TYPE_MIPS_CPS);
     object_property_set_str(OBJECT(&s->cps), machine->cpu_type, "cpu-type",
-                            &err);
-    object_property_set_int(OBJECT(&s->cps), machine->smp.cpus, "num-vp", &err);
-    object_property_set_bool(OBJECT(&s->cps), true, "realized", &err);
-
-    if (err != NULL) {
-        error_report("%s", error_get_pretty(err));
-        exit(1);
-    }
-
+                            &error_fatal);
+    object_property_set_int(OBJECT(&s->cps), machine->smp.cpus, "num-vp",
+                            &error_fatal);
+    object_property_set_bool(OBJECT(&s->cps), true, "realized", &error_fatal);
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
 
     flash =  g_new(MemoryRegion, 1);
-    memory_region_init_rom(flash, NULL, "boston.flash", 128 * MiB, &err);
+    memory_region_init_rom(flash, NULL, "boston.flash", 128 * MiB,
+                           &error_fatal);
     memory_region_add_subregion_overlap(sys_mem, 0x18000000, flash, 0);
 
     memory_region_add_subregion_overlap(sys_mem, 0x80000000, machine->ram, 0);
 
     ddr_low_alias = g_new(MemoryRegion, 1);
     memory_region_init_alias(ddr_low_alias, NULL, "boston_low.ddr",
                              machine->ram, 0,
                              MIN(machine->ram_size, (256 * MiB)));
     memory_region_add_subregion_overlap(sys_mem, 0, ddr_low_alias, 0);
 
     xilinx_pcie_init(sys_mem, 0,
                      0x10000000, 32 * MiB,
                      0x40000000, 1 * GiB,
                      get_cps_irq(&s->cps, 2), false);
 
     xilinx_pcie_init(sys_mem, 1,
                      0x12000000, 32 * MiB,
                      0x20000000, 512 * MiB,
                      get_cps_irq(&s->cps, 1), false);
 
     pcie2 = xilinx_pcie_init(sys_mem, 2,
                              0x14000000, 32 * MiB,
                              0x16000000, 1 * MiB,
                              get_cps_irq(&s->cps, 0), true);
 
     platreg = g_new(MemoryRegion, 1);
     memory_region_init_io(platreg, NULL, &boston_platreg_ops, s,
                           "boston-platregs", 0x1000);
     memory_region_add_subregion_overlap(sys_mem, 0x17ffd000, platreg, 0);
 
     s->uart = serial_mm_init(sys_mem, 0x17ffe000, 2,
                              get_cps_irq(&s->cps, 3), 10000000,
                              serial_hd(0), DEVICE_NATIVE_ENDIAN);
 
     lcd = g_new(MemoryRegion, 1);
     memory_region_init_io(lcd, NULL, &boston_lcd_ops, s, "boston-lcd", 0x8);
     memory_region_add_subregion_overlap(sys_mem, 0x17fff000, lcd, 0);
 
     chr = qemu_chr_new("lcd", "vc:320x240", NULL);
     qemu_chr_fe_init(&s->lcd_display, chr, NULL);
     qemu_chr_fe_set_handlers(&s->lcd_display, NULL, NULL,
                              boston_lcd_event, NULL, s, NULL, true);
 
     ahci = pci_create_simple_multifunction(&PCI_BRIDGE(&pcie2->root)->sec_bus,
                                            PCI_DEVFN(0, 0),
                                            true, TYPE_ICH9_AHCI);
     g_assert(ARRAY_SIZE(hd) == ahci_get_num_ports(ahci));
     ide_drive_get(hd, ahci_get_num_ports(ahci));
     ahci_ide_create_devs(ahci, hd);
 
     if (machine->firmware) {
         fw_size = load_image_targphys(machine->firmware,
                                       0x1fc00000, 4 * MiB);
         if (fw_size == -1) {
             error_report("unable to load firmware image '%s'",
                           machine->firmware);
             exit(1);
         }
     } else if (machine->kernel_filename) {
         fit_err = load_fit(&boston_fit_loader, machine->kernel_filename, s);
         if (fit_err) {
             error_report("unable to load FIT image");
             exit(1);
         }
 
         gen_firmware(memory_region_get_ram_ptr(flash) + 0x7c00000,
                      s->kernel_entry, s->fdt_base, is_64b);
     } else if (!qtest_enabled()) {
         error_report("Please provide either a -kernel or -bios argument");
         exit(1);
     }
 }
-- 
2.21.1


