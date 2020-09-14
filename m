Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B409BC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4032E2074B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l9VS+KrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4032E2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHpJc-00026M-7H
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8H-0002R6-9N
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:01 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:35196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8E-0007Zm-QD
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:00 -0400
Received: by mail-wr1-x431.google.com with SMTP id e16so18927953wrm.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=W46vdnAOZWxYuiCOcRluwg5RunZBfavA1+5v0cgkd8k=;
 b=l9VS+KrDtbBFwVyTyKaomilMXVW5y3sqmTWHac3QZMlEcjrDGEeRfeA6r+HAZGOYs1
 oa2g3DdbxOOmFz/+yvbF0pWlv1PWzN4uihKl8Renel65JXYD0aQwHMe4swVbhNb6zrGn
 jnfqvO7tGlgZSgVI+3nbJEgRNj42lkwim++CL0nsptBRSXXDiRkOG1tkB6iqQz4P9IGK
 PCaS4wOHu4pzQON95kXwPQEgl6ZlstDv9Y0t415182qOhrYaqQy0LJbLqtDkTYhtJZ3w
 Oe4f0wZoybmoDov7G+SgfbB8LeMgEhU0ACyyYHtKVfEt8+fCgIFgAPi9HphIvTb5J4Ag
 cVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W46vdnAOZWxYuiCOcRluwg5RunZBfavA1+5v0cgkd8k=;
 b=CsCd1VaSr2/fs1vyncpAnNHAhjBRRbV7vgQ3U5vlcBOcC3L01Xx31DLEXTyQ0j5L6D
 pbZfmEGYBT57mHudA0mo3nngs6lUMe46/9cPSrUAYI5XPvt6+GcPgcSnmvGHBChvVJM5
 YHsf4vPvjXtWns1hprFX3NszdxN3o7DrtcDWPt0RKeVtrDrg2Lr/olYqxVa63Jv+zDFR
 6PBoFBRtTDxmHC7v7T133CfMmLoWlj05k9cS9lzdOk4N6d7SRIHX3P0j+/kLYRlq78t+
 eEbnYPfQdtDQlmkimK6ILdwRKDel7T+qmd+tGf0hkbZVeGfkU2Rt+D/lMmPKKB/+gdnV
 cGgA==
X-Gm-Message-State: AOAM531rghfpHxRdOwboAhhveooC7w0uOf9FflQIsx4HssFbZk6hn9Of
 RlutbANbuIKBAkDvH0dDD+d+jiIB48EnUTqv
X-Google-Smtp-Source: ABdhPJwH8lBO62oS4DVRJXfyaoRsssMcmIpKDShmCIds5XT2qdWflBnldQDmsAW/tb69ae2dP0Y2BQ==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr16806263wrp.187.1600092417141; 
 Mon, 14 Sep 2020 07:06:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.06.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:06:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/36] hw/arm/mps2: New board model mps2-an386
Date: Mon, 14 Sep 2020 15:06:17 +0100
Message-Id: <20200914140641.21369-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Implement a model of the MPS2 with the AN386 firmware. This is
essentially identical to the AN385 firmware, but it has a
Cortex-M4 rather than a Cortex-M3.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200903202048.15370-2-peter.maydell@linaro.org
---
 docs/system/arm/mps2.rst |  8 +++++---
 hw/arm/mps2.c            | 34 +++++++++++++++++++++++++++++-----
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/docs/system/arm/mps2.rst b/docs/system/arm/mps2.rst
index 3a98cb59b0d..e680a4ceb71 100644
--- a/docs/system/arm/mps2.rst
+++ b/docs/system/arm/mps2.rst
@@ -1,5 +1,5 @@
-Arm MPS2 boards (``mps2-an385``, ``mps2-an505``, ``mps2-an511``, ``mps2-an521``)
-================================================================================
+Arm MPS2 boards (``mps2-an385``, ``mps2-an386``, ``mps2-an505``, ``mps2-an511``, ``mps2-an521``)
+================================================================================================
 
 These board models all use Arm M-profile CPUs.
 
@@ -12,6 +12,8 @@ QEMU models the following FPGA images:
 
 ``mps2-an385``
   Cortex-M3 as documented in ARM Application Note AN385
+``mps2-an386``
+  Cortex-M4 as documented in ARM Application Note AN386
 ``mps2-an511``
   Cortex-M3 'DesignStart' as documented in AN511
 ``mps2-an505``
@@ -21,7 +23,7 @@ QEMU models the following FPGA images:
 
 Differences between QEMU and real hardware:
 
-- AN385 remapping of low 16K of memory to either ZBT SSRAM1 or to
+- AN385/AN386 remapping of low 16K of memory to either ZBT SSRAM1 or to
   block RAM is unimplemented (QEMU always maps this to ZBT SSRAM1, as
   if zbt_boot_ctrl is always zero)
 - QEMU provides a LAN9118 ethernet rather than LAN9220; the only guest
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 4ee5c38459e..d3ec73fbe78 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -15,6 +15,7 @@
  * as seen by the guest depend significantly on the FPGA image.
  * We model the following FPGA images:
  *  "mps2-an385" -- Cortex-M3 as documented in ARM Application Note AN385
+ *  "mps2-an386" -- Cortex-M4 as documented in ARM Application Note AN386
  *  "mps2-an511" -- Cortex-M3 'DesignStart' as documented in AN511
  *
  * Links to the TRM for the board itself and to the various Application
@@ -48,6 +49,7 @@
 
 typedef enum MPS2FPGAType {
     FPGA_AN385,
+    FPGA_AN386,
     FPGA_AN511,
 } MPS2FPGAType;
 
@@ -82,6 +84,7 @@ typedef struct MPS2MachineState MPS2MachineState;
 
 #define TYPE_MPS2_MACHINE "mps2"
 #define TYPE_MPS2_AN385_MACHINE MACHINE_TYPE_NAME("mps2-an385")
+#define TYPE_MPS2_AN386_MACHINE MACHINE_TYPE_NAME("mps2-an386")
 #define TYPE_MPS2_AN511_MACHINE MACHINE_TYPE_NAME("mps2-an511")
 
 DECLARE_OBJ_CHECKERS(MPS2MachineState, MPS2MachineClass,
@@ -139,9 +142,9 @@ static void mps2_common_init(MachineState *machine)
      * tradeoffs. For QEMU they're all just RAM, though. We arbitrarily
      * call the 16MB our "system memory", as it's the largest lump.
      *
-     * Common to both boards:
-     *  0x21000000..0x21ffffff : PSRAM (16MB)
-     * AN385 only:
+     * AN385/AN386/AN511:
+     *  0x21000000 .. 0x21ffffff : PSRAM (16MB)
+     * AN385/AN386 only:
      *  0x00000000 .. 0x003fffff : ZBT SSRAM1
      *  0x00400000 .. 0x007fffff : mirror of ZBT SSRAM1
      *  0x20000000 .. 0x203fffff : ZBT SSRAM 2&3
@@ -156,7 +159,7 @@ static void mps2_common_init(MachineState *machine)
      *  0x20000000 .. 0x2001ffff : SRAM
      *  0x20400000 .. 0x207fffff : ZBT SSRAM 2&3
      *
-     * The AN385 has a feature where the lowest 16K can be mapped
+     * The AN385/AN386 has a feature where the lowest 16K can be mapped
      * either to the bottom of the ZBT SSRAM1 or to the block RAM.
      * This is of no use for QEMU so we don't implement it (as if
      * zbt_boot_ctrl is always zero).
@@ -165,6 +168,7 @@ static void mps2_common_init(MachineState *machine)
 
     switch (mmc->fpga_type) {
     case FPGA_AN385:
+    case FPGA_AN386:
         make_ram(&mms->ssram1, "mps.ssram1", 0x0, 0x400000);
         make_ram_alias(&mms->ssram1_m, "mps.ssram1_m", &mms->ssram1, 0x400000);
         make_ram(&mms->ssram23, "mps.ssram23", 0x20000000, 0x400000);
@@ -192,6 +196,7 @@ static void mps2_common_init(MachineState *machine)
     armv7m = DEVICE(&mms->armv7m);
     switch (mmc->fpga_type) {
     case FPGA_AN385:
+    case FPGA_AN386:
         qdev_prop_set_uint32(armv7m, "num-irq", 32);
         break;
     case FPGA_AN511:
@@ -228,6 +233,7 @@ static void mps2_common_init(MachineState *machine)
 
     switch (mmc->fpga_type) {
     case FPGA_AN385:
+    case FPGA_AN386:
     {
         /* The overflow IRQs for UARTs 0, 1 and 2 are ORed together.
          * Overflow for UARTs 4 and 5 doesn't trigger any interrupt.
@@ -379,7 +385,7 @@ static void mps2_common_init(MachineState *machine)
      */
     lan9118_init(&nd_table[0], 0x40200000,
                  qdev_get_gpio_in(armv7m,
-                                  mmc->fpga_type == FPGA_AN385 ? 13 : 47));
+                                  mmc->fpga_type == FPGA_AN511 ? 47 : 13));
 
     system_clock_scale = NANOSECONDS_PER_SECOND / SYSCLK_FRQ;
 
@@ -408,6 +414,17 @@ static void mps2_an385_class_init(ObjectClass *oc, void *data)
     mmc->scc_id = 0x41043850;
 }
 
+static void mps2_an386_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    MPS2MachineClass *mmc = MPS2_MACHINE_CLASS(oc);
+
+    mc->desc = "ARM MPS2 with AN386 FPGA image for Cortex-M4";
+    mmc->fpga_type = FPGA_AN386;
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m4");
+    mmc->scc_id = 0x41043860;
+}
+
 static void mps2_an511_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -434,6 +451,12 @@ static const TypeInfo mps2_an385_info = {
     .class_init = mps2_an385_class_init,
 };
 
+static const TypeInfo mps2_an386_info = {
+    .name = TYPE_MPS2_AN386_MACHINE,
+    .parent = TYPE_MPS2_MACHINE,
+    .class_init = mps2_an386_class_init,
+};
+
 static const TypeInfo mps2_an511_info = {
     .name = TYPE_MPS2_AN511_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
@@ -444,6 +467,7 @@ static void mps2_machine_init(void)
 {
     type_register_static(&mps2_info);
     type_register_static(&mps2_an385_info);
+    type_register_static(&mps2_an386_info);
     type_register_static(&mps2_an511_info);
 }
 
-- 
2.20.1


