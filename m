Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DD6C2BD11
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F33D0206C0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uNtqnTNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33D0206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDvko-0007t1-69
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 16:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDvj7-0006DI-HR
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 16:20:57 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:36763)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDvj5-000857-4H
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 16:20:57 -0400
Received: by mail-wm1-x32f.google.com with SMTP id z9so4126335wmk.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 13:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6lxmtVJqPBkLqKbE78/o4FRZ58Zm5BvzP8WeZTcTIuI=;
 b=uNtqnTNxnFyzjT1YD14dEEjpqstSy/DvooVquH7314K6lY+wnfeU13ahIR/PjDNdNd
 S4cFHNAOJzeOSPaT/CNPFh7l8nR4KhVOR4dEiCjZ1LgzabDRJ0T70rsX/ibr0tehiURk
 cZgtjFksL6tG7UdT8sNRYjZGFlI2v9VsmM67vaHotErmRwRx2FeTiasvpV3s1LcACrG2
 ExVhfKPvg/SLlSSbmEzOrzmTD6mdsFtomLdje+0oLf5MsDoAsmoWnd+0T8kzLBz+xRvu
 f5FOOniJugxAsqpnLXe7fIPw6vL9fHkSbH6MasfaH/Cb943SnkXw0G4a1KR83/FH/vKo
 FDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6lxmtVJqPBkLqKbE78/o4FRZ58Zm5BvzP8WeZTcTIuI=;
 b=T50JVQAn7W8yobtIIVoLbeAbA2b+/VJVG2768Z4A8vMr1evB4LJraY6pRRlxKxbun6
 mpn57SuCUzgwZh6DMDqc5Oj0pm77rE0Mch9OQkWVEoBYC+G08g/MdK0AGl6IHQVnYqC7
 OdoijgARpLiA7Z3+V8B3qP57YWDc6bty1RXmzy2BMbxFdrVC9TR13RJ4GmBAadUcBab/
 Yl62uPOskmhwsIMUYlCnJnlPTbbhlxhm55UA4PmTFuCEEN/ZJWt+tkVpWRGz1FajDlpf
 xqhiWaxy75jXBXAVAtbJkvQr0AWfaCpQfj8fOBLJ8AsfEeOPkvTKMD3VA3nk9MBArxIq
 y6ZA==
X-Gm-Message-State: AOAM532eqmAt7OcH8nqlrFECrGLm9gd9FQjDhYkeln1ifd4dlWw44pkA
 J7czrjjnUGu5xs8mR7eA8JtGJg==
X-Google-Smtp-Source: ABdhPJx16W2JKSkjZsdT+LWndv9hWuEUHEJcJXQeNAg+pKtXCRTxZncOGJZOBmRjS4WMUhCPz3X0UQ==
X-Received: by 2002:a1c:7c1a:: with SMTP id x26mr4366907wmc.112.1599164453778; 
 Thu, 03 Sep 2020 13:20:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p14sm7285023wrg.96.2020.09.03.13.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 13:20:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] hw/arm/mps2: New board model mps2-an500
Date: Thu,  3 Sep 2020 21:20:47 +0100
Message-Id: <20200903202048.15370-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200903202048.15370-1-peter.maydell@linaro.org>
References: <20200903202048.15370-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kumar Gala <kumar.gala@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement a model of the MPS2 with the AN500 firmware. This is
similar to the AN385, with the following differences:
 * Cortex-M7 CPU
 * PSRAM is at 0x6000_0000
 * Ethernet is at 0xa000_0000
 * No zbt_boot_ctrl remapping of the low 16K
   (but QEMU doesn't implement this anyway)
 * no "block RAM" at 0x01000000

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
The AN500 also defines some behaviour for CFG_REG[2567] in
the SCC (QEMU hw/misc/mps2-scc.c) but none of it is anything
QEMU can conveniently support so I have left that code as-is
(a guest accessing those registers will hit the LOG_GUEST_ERROR
case for "bad offset").

Tested with a buildroot image created using the instructions at:
 https://community.arm.com/developer/tools-software/oss-platforms/w/docs/578/running-uclinux-on-the-arm-mps2-platform
and the "arm_mps2_CM7fpga" defconfig; QEMU commandline is
 qemu-system-arm -M mps2-an500 -serial stdio -display none -kernel boot.axf -device loader,file=linux.axf
---
 docs/system/arm/mps2.rst |  6 ++--
 hw/arm/mps2.c            | 71 ++++++++++++++++++++++++++++++++--------
 2 files changed, 62 insertions(+), 15 deletions(-)

diff --git a/docs/system/arm/mps2.rst b/docs/system/arm/mps2.rst
index e680a4ceb71..7f2e9c8d52e 100644
--- a/docs/system/arm/mps2.rst
+++ b/docs/system/arm/mps2.rst
@@ -1,5 +1,5 @@
-Arm MPS2 boards (``mps2-an385``, ``mps2-an386``, ``mps2-an505``, ``mps2-an511``, ``mps2-an521``)
-================================================================================================
+Arm MPS2 boards (``mps2-an385``, ``mps2-an386``, ``mps2-an500``, ``mps2-an505``, ``mps2-an511``, ``mps2-an521``)
+================================================================================================================
 
 These board models all use Arm M-profile CPUs.
 
@@ -14,6 +14,8 @@ QEMU models the following FPGA images:
   Cortex-M3 as documented in ARM Application Note AN385
 ``mps2-an386``
   Cortex-M4 as documented in ARM Application Note AN386
+``mps2-an500``
+  Cortex-M7 as documented in ARM Application Note AN500
 ``mps2-an511``
   Cortex-M3 'DesignStart' as documented in AN511
 ``mps2-an505``
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 559b297e788..d17fd7a7cb5 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -16,6 +16,7 @@
  * We model the following FPGA images:
  *  "mps2-an385" -- Cortex-M3 as documented in ARM Application Note AN385
  *  "mps2-an386" -- Cortex-M4 as documented in ARM Application Note AN386
+ *  "mps2-an500" -- Cortex-M7 as documented in ARM Application Note AN500
  *  "mps2-an511" -- Cortex-M3 'DesignStart' as documented in AN511
  *
  * Links to the TRM for the board itself and to the various Application
@@ -49,6 +50,7 @@
 typedef enum MPS2FPGAType {
     FPGA_AN385,
     FPGA_AN386,
+    FPGA_AN500,
     FPGA_AN511,
 } MPS2FPGAType;
 
@@ -56,6 +58,9 @@ typedef struct {
     MachineClass parent;
     MPS2FPGAType fpga_type;
     uint32_t scc_id;
+    bool has_block_ram;
+    hwaddr ethernet_base;
+    hwaddr psram_base;
 } MPS2MachineClass;
 
 typedef struct {
@@ -82,6 +87,7 @@ typedef struct {
 #define TYPE_MPS2_MACHINE "mps2"
 #define TYPE_MPS2_AN385_MACHINE MACHINE_TYPE_NAME("mps2-an385")
 #define TYPE_MPS2_AN386_MACHINE MACHINE_TYPE_NAME("mps2-an386")
+#define TYPE_MPS2_AN500_MACHINE MACHINE_TYPE_NAME("mps2-an500")
 #define TYPE_MPS2_AN511_MACHINE MACHINE_TYPE_NAME("mps2-an511")
 
 #define MPS2_MACHINE(obj)                                       \
@@ -143,13 +149,14 @@ static void mps2_common_init(MachineState *machine)
      * tradeoffs. For QEMU they're all just RAM, though. We arbitrarily
      * call the 16MB our "system memory", as it's the largest lump.
      *
-     * Common to both boards:
-     *  0x21000000..0x21ffffff : PSRAM (16MB)
-     * AN385/AN386 only:
+     * AN385/AN386/AN511:
+     *  0x21000000 .. 0x21ffffff : PSRAM (16MB)
+     * AN385/AN386/AN500:
      *  0x00000000 .. 0x003fffff : ZBT SSRAM1
      *  0x00400000 .. 0x007fffff : mirror of ZBT SSRAM1
      *  0x20000000 .. 0x203fffff : ZBT SSRAM 2&3
      *  0x20400000 .. 0x207fffff : mirror of ZBT SSRAM 2&3
+     * AN385/AN386 only:
      *  0x01000000 .. 0x01003fff : block RAM (16K)
      *  0x01004000 .. 0x01007fff : mirror of above
      *  0x01008000 .. 0x0100bfff : mirror of above
@@ -159,22 +166,17 @@ static void mps2_common_init(MachineState *machine)
      *  0x00400000 .. 0x007fffff : ZBT SSRAM1
      *  0x20000000 .. 0x2001ffff : SRAM
      *  0x20400000 .. 0x207fffff : ZBT SSRAM 2&3
+     * AN500 only:
+     *  0x60000000 .. 0x60ffffff : PSRAM (16MB)
      *
      * The AN385/AN386 has a feature where the lowest 16K can be mapped
      * either to the bottom of the ZBT SSRAM1 or to the block RAM.
      * This is of no use for QEMU so we don't implement it (as if
      * zbt_boot_ctrl is always zero).
      */
-    memory_region_add_subregion(system_memory, 0x21000000, machine->ram);
+    memory_region_add_subregion(system_memory, mmc->psram_base, machine->ram);
 
-    switch (mmc->fpga_type) {
-    case FPGA_AN385:
-    case FPGA_AN386:
-        make_ram(&mms->ssram1, "mps.ssram1", 0x0, 0x400000);
-        make_ram_alias(&mms->ssram1_m, "mps.ssram1_m", &mms->ssram1, 0x400000);
-        make_ram(&mms->ssram23, "mps.ssram23", 0x20000000, 0x400000);
-        make_ram_alias(&mms->ssram23_m, "mps.ssram23_m",
-                       &mms->ssram23, 0x20400000);
+    if (mmc->has_block_ram) {
         make_ram(&mms->blockram, "mps.blockram", 0x01000000, 0x4000);
         make_ram_alias(&mms->blockram_m1, "mps.blockram_m1",
                        &mms->blockram, 0x01004000);
@@ -182,6 +184,17 @@ static void mps2_common_init(MachineState *machine)
                        &mms->blockram, 0x01008000);
         make_ram_alias(&mms->blockram_m3, "mps.blockram_m3",
                        &mms->blockram, 0x0100c000);
+    }
+
+    switch (mmc->fpga_type) {
+    case FPGA_AN385:
+    case FPGA_AN386:
+    case FPGA_AN500:
+        make_ram(&mms->ssram1, "mps.ssram1", 0x0, 0x400000);
+        make_ram_alias(&mms->ssram1_m, "mps.ssram1_m", &mms->ssram1, 0x400000);
+        make_ram(&mms->ssram23, "mps.ssram23", 0x20000000, 0x400000);
+        make_ram_alias(&mms->ssram23_m, "mps.ssram23_m",
+                       &mms->ssram23, 0x20400000);
         break;
     case FPGA_AN511:
         make_ram(&mms->blockram, "mps.blockram", 0x0, 0x40000);
@@ -198,6 +211,7 @@ static void mps2_common_init(MachineState *machine)
     switch (mmc->fpga_type) {
     case FPGA_AN385:
     case FPGA_AN386:
+    case FPGA_AN500:
         qdev_prop_set_uint32(armv7m, "num-irq", 32);
         break;
     case FPGA_AN511:
@@ -235,6 +249,7 @@ static void mps2_common_init(MachineState *machine)
     switch (mmc->fpga_type) {
     case FPGA_AN385:
     case FPGA_AN386:
+    case FPGA_AN500:
     {
         /* The overflow IRQs for UARTs 0, 1 and 2 are ORed together.
          * Overflow for UARTs 4 and 5 doesn't trigger any interrupt.
@@ -384,7 +399,7 @@ static void mps2_common_init(MachineState *machine)
     /* In hardware this is a LAN9220; the LAN9118 is software compatible
      * except that it doesn't support the checksum-offload feature.
      */
-    lan9118_init(&nd_table[0], 0x40200000,
+    lan9118_init(&nd_table[0], mmc->ethernet_base,
                  qdev_get_gpio_in(armv7m,
                                   mmc->fpga_type == FPGA_AN511 ? 47 : 13));
 
@@ -413,6 +428,9 @@ static void mps2_an385_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN385;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
     mmc->scc_id = 0x41043850;
+    mmc->psram_base = 0x21000000;
+    mmc->ethernet_base = 0x40200000;
+    mmc->has_block_ram = true;
 }
 
 static void mps2_an386_class_init(ObjectClass *oc, void *data)
@@ -424,6 +442,23 @@ static void mps2_an386_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN386;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m4");
     mmc->scc_id = 0x41043860;
+    mmc->psram_base = 0x21000000;
+    mmc->ethernet_base = 0x40200000;
+    mmc->has_block_ram = true;
+}
+
+static void mps2_an500_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    MPS2MachineClass *mmc = MPS2_MACHINE_CLASS(oc);
+
+    mc->desc = "ARM MPS2 with AN500 FPGA image for Cortex-M7";
+    mmc->fpga_type = FPGA_AN500;
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m7");
+    mmc->scc_id = 0x41045000;
+    mmc->psram_base = 0x60000000;
+    mmc->ethernet_base = 0xa0000000;
+    mmc->has_block_ram = false;
 }
 
 static void mps2_an511_class_init(ObjectClass *oc, void *data)
@@ -435,6 +470,9 @@ static void mps2_an511_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN511;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
     mmc->scc_id = 0x41045110;
+    mmc->psram_base = 0x21000000;
+    mmc->ethernet_base = 0x40200000;
+    mmc->has_block_ram = false;
 }
 
 static const TypeInfo mps2_info = {
@@ -458,6 +496,12 @@ static const TypeInfo mps2_an386_info = {
     .class_init = mps2_an386_class_init,
 };
 
+static const TypeInfo mps2_an500_info = {
+    .name = TYPE_MPS2_AN500_MACHINE,
+    .parent = TYPE_MPS2_MACHINE,
+    .class_init = mps2_an500_class_init,
+};
+
 static const TypeInfo mps2_an511_info = {
     .name = TYPE_MPS2_AN511_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
@@ -469,6 +513,7 @@ static void mps2_machine_init(void)
     type_register_static(&mps2_info);
     type_register_static(&mps2_an385_info);
     type_register_static(&mps2_an386_info);
+    type_register_static(&mps2_an500_info);
     type_register_static(&mps2_an511_info);
 }
 
-- 
2.20.1


