Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F51DC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:04:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9700218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkjWx5FE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9700218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZtK-0007qA-Qy
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:04:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0L-0003hJ-HU
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0G-0003Yi-R5
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:01 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:53395)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Z0G-0003Xc-HK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:56 -0500
Received: by mail-wm1-x32d.google.com with SMTP id t79so1237773wmt.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zqgxEGRIkxflFZI1X/Zx4ZL6cic6r1lnmPId0ikEEgU=;
 b=OkjWx5FERt8cQLXbvQvW5SnCy3AqqNL4Y1Ic0hidDQuF+h4hlU/5eq/Sm+DMqpICLq
 DyJhXtrYyN1lBe+phwvqbRi+EcYCdNvyoiYdFeHqOaDjL7ZjKnppjBylVwkRqGjNfKS7
 62janhQLocWMB+8izHWoyrtQw6iAom5LUDjk4Lmg3rYbtw3rc7DDn/R9oWk7nH4pGz7U
 0q/xLMN5vT9p+I2V4KWUErc3N5mU7poO8FUwrkZSV3D2fbCTaF66M9mWyLmQGVt7fLdJ
 w7VzP2/eeExU/H7L52gjciHFN9CPyRcs6J5crMreDcU4WfCSgqapGF/keTnMT9RIpnyj
 8/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zqgxEGRIkxflFZI1X/Zx4ZL6cic6r1lnmPId0ikEEgU=;
 b=lge9FTUi+02x0onPqRo0HSjAPKk4d7zBIEL3Y3S48tQREJ5Oxxb/4hG1xRDk+val4g
 r/KZ87rFU/r3OEeD0aizaS/EtqlqNw3aeIepTdR22EeX4OTVb4qtdlUeDS1cZ0LC2nfX
 OWo4QmqKf2fbX8tDlSM1fmqHMEJdo0HBhPQG+nL4qcHY1HtUC33qE+YHR5GWNcdxkrzg
 REqlxzMoSn4ohxfMHH2PUV/HNJNVmEmN+XBONcFKKYgNbQX3QRwEU017Ii9v2Ajwf5S0
 SRcEuhhy3Q5BRd/8d8ev5WdCA6Fd/XJHdv4EZv6cjDZi70wdu8mBfzdK2RIvz7bxpy67
 U+sA==
X-Gm-Message-State: APjAAAW9BUsBtb/BLlAT1ef/lNw8an+hg6xr87UP8+7gTQE6fssbWa/w
 yiEFeqlWTFg+lJdsFOeHIvWfZDSM
X-Google-Smtp-Source: APXvYqxd8Z+gzcvXg6KcPFQUJZDe9lYtBphJDTgRSjsfCcVhAaFLPvIpk004kTEiAUzJjK9miUOhHg==
X-Received: by 2002:a1c:960c:: with SMTP id y12mr4985734wmd.9.1582632474506;
 Tue, 25 Feb 2020 04:07:54 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.07.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:07:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 121/136] hw/arm: Let devices own the MemoryRegion they create
Date: Tue, 25 Feb 2020 13:07:19 +0100
Message-Id: <1582632454-16491-19-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Avoid orphan memory regions being added in the /unattached QOM
container.

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224205533.23798-24-philmd@redhat.com>
Supersedes: <20200221173049.18134-1-philmd@redhat.com>
---
 hw/arm/exynos4210.c    | 12 ++++++------
 hw/arm/fsl-imx25.c     | 10 +++++-----
 hw/arm/fsl-imx31.c     |  6 +++---
 hw/arm/fsl-imx6.c      |  6 +++---
 hw/arm/fsl-imx6ul.c    |  9 +++++----
 hw/arm/msf2-soc.c      |  6 +++---
 hw/arm/nrf51_soc.c     |  2 +-
 hw/arm/stm32f205_soc.c |  8 ++++----
 hw/arm/stm32f405_soc.c |  9 +++++----
 hw/arm/xlnx-zynqmp.c   | 11 +++++------
 10 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 4e1fd7e..1f7253e 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -305,20 +305,20 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
     /*** Memory ***/
 
     /* Chip-ID and OMR */
-    memory_region_init_io(&s->chipid_mem, NULL, &exynos4210_chipid_and_omr_ops,
-        NULL, "exynos4210.chipid", sizeof(chipid_and_omr));
+    memory_region_init_io(&s->chipid_mem, OBJECT(socdev),
+                          &exynos4210_chipid_and_omr_ops, NULL,
+                          "exynos4210.chipid", sizeof(chipid_and_omr));
     memory_region_add_subregion(system_mem, EXYNOS4210_CHIPID_ADDR,
                                 &s->chipid_mem);
 
     /* Internal ROM */
-    memory_region_init_rom(&s->irom_mem, NULL, "exynos4210.irom",
+    memory_region_init_rom(&s->irom_mem, OBJECT(socdev), "exynos4210.irom",
                            EXYNOS4210_IROM_SIZE, &error_fatal);
     memory_region_add_subregion(system_mem, EXYNOS4210_IROM_BASE_ADDR,
                                 &s->irom_mem);
     /* mirror of iROM */
-    memory_region_init_alias(&s->irom_alias_mem, NULL, "exynos4210.irom_alias",
-                             &s->irom_mem,
-                             0,
+    memory_region_init_alias(&s->irom_alias_mem, OBJECT(socdev),
+                             "exynos4210.irom_alias", &s->irom_mem, 0,
                              EXYNOS4210_IROM_SIZE);
     memory_region_add_subregion(system_mem, EXYNOS4210_IROM_MIRROR_BASE_ADDR,
                                 &s->irom_alias_mem);
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index da3471b..104bff6 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -247,16 +247,16 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
     }
 
     /* initialize 2 x 16 KB ROM */
-    memory_region_init_rom(&s->rom[0], NULL,
-                           "imx25.rom0", FSL_IMX25_ROM0_SIZE, &err);
+    memory_region_init_rom(&s->rom[0], OBJECT(dev), "imx25.rom0",
+                           FSL_IMX25_ROM0_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX25_ROM0_ADDR,
                                 &s->rom[0]);
-    memory_region_init_rom(&s->rom[1], NULL,
-                           "imx25.rom1", FSL_IMX25_ROM1_SIZE, &err);
+    memory_region_init_rom(&s->rom[1], OBJECT(dev), "imx25.rom1",
+                           FSL_IMX25_ROM1_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -275,7 +275,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
                                 &s->iram);
 
     /* internal RAM (128 KB) is aliased over 128 MB - 128 KB */
-    memory_region_init_alias(&s->iram_alias, NULL, "imx25.iram_alias",
+    memory_region_init_alias(&s->iram_alias, OBJECT(dev), "imx25.iram_alias",
                              &s->iram, 0, FSL_IMX25_IRAM_ALIAS_SIZE);
     memory_region_add_subregion(get_system_memory(), FSL_IMX25_IRAM_ALIAS_ADDR,
                                 &s->iram_alias);
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 55e90d1..8472d2e 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -206,7 +206,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
     }
 
     /* On a real system, the first 16k is a `secure boot rom' */
-    memory_region_init_rom(&s->secure_rom, NULL, "imx31.secure_rom",
+    memory_region_init_rom(&s->secure_rom, OBJECT(dev), "imx31.secure_rom",
                            FSL_IMX31_SECURE_ROM_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
@@ -216,7 +216,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
                                 &s->secure_rom);
 
     /* There is also a 16k ROM */
-    memory_region_init_rom(&s->rom, NULL, "imx31.rom",
+    memory_region_init_rom(&s->rom, OBJECT(dev), "imx31.rom",
                            FSL_IMX31_ROM_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
@@ -236,7 +236,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
                                 &s->iram);
 
     /* internal RAM (16 KB) is aliased over 256 MB - 16 KB */
-    memory_region_init_alias(&s->iram_alias, NULL, "imx31.iram_alias",
+    memory_region_init_alias(&s->iram_alias, OBJECT(dev), "imx31.iram_alias",
                              &s->iram, 0, FSL_IMX31_IRAM_ALIAS_SIZE);
     memory_region_add_subregion(get_system_memory(), FSL_IMX31_IRAM_ALIAS_ADDR,
                                 &s->iram_alias);
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index ecc6285..9c09f71 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -405,7 +405,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     }
 
     /* ROM memory */
-    memory_region_init_rom(&s->rom, NULL, "imx6.rom",
+    memory_region_init_rom(&s->rom, OBJECT(dev), "imx6.rom",
                            FSL_IMX6_ROM_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
@@ -415,7 +415,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                 &s->rom);
 
     /* CAAM memory */
-    memory_region_init_rom(&s->caam, NULL, "imx6.caam",
+    memory_region_init_rom(&s->caam, OBJECT(dev), "imx6.caam",
                            FSL_IMX6_CAAM_MEM_SIZE, &err);
     if (err) {
         error_propagate(errp, err);
@@ -435,7 +435,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                 &s->ocram);
 
     /* internal OCRAM (256 KB) is aliased over 1 MB */
-    memory_region_init_alias(&s->ocram_alias, NULL, "imx6.ocram_alias",
+    memory_region_init_alias(&s->ocram_alias, OBJECT(dev), "imx6.ocram_alias",
                              &s->ocram, 0, FSL_IMX6_OCRAM_ALIAS_SIZE);
     memory_region_add_subregion(get_system_memory(), FSL_IMX6_OCRAM_ALIAS_ADDR,
                                 &s->ocram_alias);
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index c405b68..f4a9ed6 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -543,7 +543,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     /*
      * ROM memory
      */
-    memory_region_init_rom(&s->rom, NULL, "imx6ul.rom",
+    memory_region_init_rom(&s->rom, OBJECT(dev), "imx6ul.rom",
                            FSL_IMX6UL_ROM_SIZE, &error_abort);
     memory_region_add_subregion(get_system_memory(), FSL_IMX6UL_ROM_ADDR,
                                 &s->rom);
@@ -551,7 +551,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     /*
      * CAAM memory
      */
-    memory_region_init_rom(&s->caam, NULL, "imx6ul.caam",
+    memory_region_init_rom(&s->caam, OBJECT(dev), "imx6ul.caam",
                            FSL_IMX6UL_CAAM_MEM_SIZE, &error_abort);
     memory_region_add_subregion(get_system_memory(), FSL_IMX6UL_CAAM_MEM_ADDR,
                                 &s->caam);
@@ -568,8 +568,9 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     /*
      * internal OCRAM (128 KB) is aliased over 512 KB
      */
-    memory_region_init_alias(&s->ocram_alias, NULL, "imx6ul.ocram_alias",
-                             &s->ocram, 0, FSL_IMX6UL_OCRAM_ALIAS_SIZE);
+    memory_region_init_alias(&s->ocram_alias, OBJECT(dev),
+                             "imx6ul.ocram_alias", &s->ocram, 0,
+                             FSL_IMX6UL_OCRAM_ALIAS_SIZE);
     memory_region_add_subregion(get_system_memory(),
                                 FSL_IMX6UL_OCRAM_ALIAS_ADDR, &s->ocram_alias);
 }
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 8f84692..588d643 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -96,7 +96,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     MemoryRegion *nvm_alias = g_new(MemoryRegion, 1);
     MemoryRegion *sram = g_new(MemoryRegion, 1);
 
-    memory_region_init_rom(nvm, NULL, "MSF2.eNVM", s->envm_size,
+    memory_region_init_rom(nvm, OBJECT(dev_soc), "MSF2.eNVM", s->envm_size,
                            &error_fatal);
     /*
      * On power-on, the eNVM region 0x60000000 is automatically
@@ -104,8 +104,8 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
      * start address (0x0). We do not support remapping other eNVM,
      * eSRAM and DDR regions by guest(via Sysreg) currently.
      */
-    memory_region_init_alias(nvm_alias, NULL, "MSF2.eNVM",
-                             nvm, 0, s->envm_size);
+    memory_region_init_alias(nvm_alias, OBJECT(dev_soc), "MSF2.eNVM", nvm, 0,
+                             s->envm_size);
 
     memory_region_add_subregion(system_memory, ENVM_BASE_ADDRESS, nvm);
     memory_region_add_subregion(system_memory, 0, nvm_alias);
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 4817a76..57eff63 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -165,7 +165,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     }
 
     /* STUB Peripherals */
-    memory_region_init_io(&s->clock, NULL, &clock_ops, NULL,
+    memory_region_init_io(&s->clock, OBJECT(dev_soc), &clock_ops, NULL,
                           "nrf51_soc.clock", 0x1000);
     memory_region_add_subregion_overlap(&s->container,
                                         NRF51_IOMEM_BASE, &s->clock, -1);
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 6e93726..118c342 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -93,10 +93,10 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     MemoryRegion *flash = g_new(MemoryRegion, 1);
     MemoryRegion *flash_alias = g_new(MemoryRegion, 1);
 
-    memory_region_init_rom(flash, NULL, "STM32F205.flash", FLASH_SIZE,
-                           &error_fatal);
-    memory_region_init_alias(flash_alias, NULL, "STM32F205.flash.alias",
-                             flash, 0, FLASH_SIZE);
+    memory_region_init_rom(flash, OBJECT(dev_soc), "STM32F205.flash",
+                           FLASH_SIZE, &error_fatal);
+    memory_region_init_alias(flash_alias, OBJECT(dev_soc),
+                             "STM32F205.flash.alias", flash, 0, FLASH_SIZE);
 
     memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, flash);
     memory_region_add_subregion(system_memory, 0, flash_alias);
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index d590cd0..4f10ce6 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -95,14 +95,15 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     Error *err = NULL;
     int i;
 
-    memory_region_init_rom(&s->flash, NULL, "STM32F405.flash", FLASH_SIZE,
-                           &err);
+    memory_region_init_rom(&s->flash, OBJECT(dev_soc), "STM32F405.flash",
+                           FLASH_SIZE, &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
     }
-    memory_region_init_alias(&s->flash_alias, NULL, "STM32F405.flash.alias",
-                             &s->flash, 0, FLASH_SIZE);
+    memory_region_init_alias(&s->flash_alias, OBJECT(dev_soc),
+                             "STM32F405.flash.alias", &s->flash, 0,
+                             FLASH_SIZE);
 
     memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->flash);
     memory_region_add_subregion(system_memory, 0, &s->flash_alias);
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index cab0160..49f1c8d 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -318,9 +318,9 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         ddr_low_size = XLNX_ZYNQMP_MAX_LOW_RAM_SIZE;
         ddr_high_size = ram_size - XLNX_ZYNQMP_MAX_LOW_RAM_SIZE;
 
-        memory_region_init_alias(&s->ddr_ram_high, NULL,
-                                 "ddr-ram-high", s->ddr_ram,
-                                  ddr_low_size, ddr_high_size);
+        memory_region_init_alias(&s->ddr_ram_high, OBJECT(dev),
+                                 "ddr-ram-high", s->ddr_ram, ddr_low_size,
+                                 ddr_high_size);
         memory_region_add_subregion(get_system_memory(),
                                     XLNX_ZYNQMP_HIGH_RAM_START,
                                     &s->ddr_ram_high);
@@ -330,9 +330,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         ddr_low_size = ram_size;
     }
 
-    memory_region_init_alias(&s->ddr_ram_low, NULL,
-                             "ddr-ram-low", s->ddr_ram,
-                              0, ddr_low_size);
+    memory_region_init_alias(&s->ddr_ram_low, OBJECT(dev), "ddr-ram-low",
+                             s->ddr_ram, 0, ddr_low_size);
     memory_region_add_subregion(get_system_memory(), 0, &s->ddr_ram_low);
 
     /* Create the four OCM banks */
-- 
1.8.3.1



