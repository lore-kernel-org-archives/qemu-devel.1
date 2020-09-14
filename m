Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5638EC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A4720EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H0Bl+JAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A4720EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHpDf-0002zp-T3
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8I-0002Tq-9G
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:02 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:43837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8F-0007Zs-T3
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:01 -0400
Received: by mail-wr1-x433.google.com with SMTP id k15so18883535wrn.10
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=I+xRFj0Pua6FcY25kkQsuDQ6RxC4LRVSzB6Gjdo+C3o=;
 b=H0Bl+JAZ/G/h+AwRRXtbAnWBw4zSmPJ3s2Ar6yndeWlPet87eirjMgz7J/tG6cxEYr
 lxfHsKxLKlYXcf6mOaa/U44OjRxQC99GlxsRoB9f3CybYXirzvJIYubMpXCwVHL5TjDk
 gniTmeStsbuhO5Hf9/jDUVqLFHoak9kGDc12Y5KNHl55Qq9dRKu1VPEN3mKywGbJOXmY
 lZgwmnB9//bVM4jKE3iQUpf623JmNs8PAlZFAGB6J1CpnYVv41I77MLsmgV1NU3UUDEs
 vkynEXhIiBGKixNd99sQUe1Qt+sajn3aCabsVrTdry8zIcas4eBH8oE7IVwzxIxLpP48
 heXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I+xRFj0Pua6FcY25kkQsuDQ6RxC4LRVSzB6Gjdo+C3o=;
 b=XxkvsZTBY3slUrXWRkc1UMsLROZZsD2AH/gHmt29E2HAkU+XLoc9V1u91Egkh8FFLO
 iH4UKw85OUjbhfEP7D9PFGsvqIBUldBv1jve7NfFEZTvZ2no5wxE0qH5aRUx6dwC/UNK
 IP//rjI+tiNX++A7BjxytMpaA77KuGpueO4eWUrh0a0B2BlKVWLHxnRqYnjA59GiwouF
 aOC4FI6t9JqMKefyATrWUgulIqpN+FbepNd+5x6YshzEHkN9kaF1jCnr3oEPEL/T0Lhb
 ncsEMUE3+7MldJclOiFoTqd84cHq7PPY8hfRw3n/jJTxC3+h4TMqo2NVf2wt7KrAmI88
 wujw==
X-Gm-Message-State: AOAM530tR8HJjD71VsbCH2pzTHSzrPyOWCxn1J+dJYJR0GIdCBJC66sq
 ENXDaM4d7Emq1tSuV/ufyRyOoeJUIRc4uaeE
X-Google-Smtp-Source: ABdhPJyJ6aq7Go35s9xU3Px5W8KzbpkpG8Q46FhlABugXsetX35ZgjKi4Gpta+bZCJ7iWRLaQ6g2lg==
X-Received: by 2002:a05:6000:1282:: with SMTP id
 f2mr17255662wrx.251.1600092418221; 
 Mon, 14 Sep 2020 07:06:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.06.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:06:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/36] hw/arm/mps2: New board model mps2-an500
Date: Mon, 14 Sep 2020 15:06:18 +0100
Message-Id: <20200914140641.21369-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200903202048.15370-3-peter.maydell@linaro.org
---
 docs/system/arm/mps2.rst |  6 ++--
 hw/arm/mps2.c            | 67 +++++++++++++++++++++++++++++++++-------
 2 files changed, 60 insertions(+), 13 deletions(-)

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
index d3ec73fbe78..5d471608503 100644
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
@@ -50,6 +51,7 @@
 typedef enum MPS2FPGAType {
     FPGA_AN385,
     FPGA_AN386,
+    FPGA_AN500,
     FPGA_AN511,
 } MPS2FPGAType;
 
@@ -57,6 +59,9 @@ struct MPS2MachineClass {
     MachineClass parent;
     MPS2FPGAType fpga_type;
     uint32_t scc_id;
+    bool has_block_ram;
+    hwaddr ethernet_base;
+    hwaddr psram_base;
 };
 typedef struct MPS2MachineClass MPS2MachineClass;
 
@@ -85,6 +90,7 @@ typedef struct MPS2MachineState MPS2MachineState;
 #define TYPE_MPS2_MACHINE "mps2"
 #define TYPE_MPS2_AN385_MACHINE MACHINE_TYPE_NAME("mps2-an385")
 #define TYPE_MPS2_AN386_MACHINE MACHINE_TYPE_NAME("mps2-an386")
+#define TYPE_MPS2_AN500_MACHINE MACHINE_TYPE_NAME("mps2-an500")
 #define TYPE_MPS2_AN511_MACHINE MACHINE_TYPE_NAME("mps2-an511")
 
 DECLARE_OBJ_CHECKERS(MPS2MachineState, MPS2MachineClass,
@@ -144,11 +150,12 @@ static void mps2_common_init(MachineState *machine)
      *
      * AN385/AN386/AN511:
      *  0x21000000 .. 0x21ffffff : PSRAM (16MB)
-     * AN385/AN386 only:
+     * AN385/AN386/AN500:
      *  0x00000000 .. 0x003fffff : ZBT SSRAM1
      *  0x00400000 .. 0x007fffff : mirror of ZBT SSRAM1
      *  0x20000000 .. 0x203fffff : ZBT SSRAM 2&3
      *  0x20400000 .. 0x207fffff : mirror of ZBT SSRAM 2&3
+     * AN385/AN386 only:
      *  0x01000000 .. 0x01003fff : block RAM (16K)
      *  0x01004000 .. 0x01007fff : mirror of above
      *  0x01008000 .. 0x0100bfff : mirror of above
@@ -158,22 +165,17 @@ static void mps2_common_init(MachineState *machine)
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
@@ -181,6 +183,17 @@ static void mps2_common_init(MachineState *machine)
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
@@ -197,6 +210,7 @@ static void mps2_common_init(MachineState *machine)
     switch (mmc->fpga_type) {
     case FPGA_AN385:
     case FPGA_AN386:
+    case FPGA_AN500:
         qdev_prop_set_uint32(armv7m, "num-irq", 32);
         break;
     case FPGA_AN511:
@@ -234,6 +248,7 @@ static void mps2_common_init(MachineState *machine)
     switch (mmc->fpga_type) {
     case FPGA_AN385:
     case FPGA_AN386:
+    case FPGA_AN500:
     {
         /* The overflow IRQs for UARTs 0, 1 and 2 are ORed together.
          * Overflow for UARTs 4 and 5 doesn't trigger any interrupt.
@@ -383,7 +398,7 @@ static void mps2_common_init(MachineState *machine)
     /* In hardware this is a LAN9220; the LAN9118 is software compatible
      * except that it doesn't support the checksum-offload feature.
      */
-    lan9118_init(&nd_table[0], 0x40200000,
+    lan9118_init(&nd_table[0], mmc->ethernet_base,
                  qdev_get_gpio_in(armv7m,
                                   mmc->fpga_type == FPGA_AN511 ? 47 : 13));
 
@@ -412,6 +427,9 @@ static void mps2_an385_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN385;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
     mmc->scc_id = 0x41043850;
+    mmc->psram_base = 0x21000000;
+    mmc->ethernet_base = 0x40200000;
+    mmc->has_block_ram = true;
 }
 
 static void mps2_an386_class_init(ObjectClass *oc, void *data)
@@ -423,6 +441,23 @@ static void mps2_an386_class_init(ObjectClass *oc, void *data)
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
@@ -434,6 +469,9 @@ static void mps2_an511_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN511;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
     mmc->scc_id = 0x41045110;
+    mmc->psram_base = 0x21000000;
+    mmc->ethernet_base = 0x40200000;
+    mmc->has_block_ram = false;
 }
 
 static const TypeInfo mps2_info = {
@@ -457,6 +495,12 @@ static const TypeInfo mps2_an386_info = {
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
@@ -468,6 +512,7 @@ static void mps2_machine_init(void)
     type_register_static(&mps2_info);
     type_register_static(&mps2_an385_info);
     type_register_static(&mps2_an386_info);
+    type_register_static(&mps2_an500_info);
     type_register_static(&mps2_an511_info);
 }
 
-- 
2.20.1


