Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97940C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C8220833
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JM4xLuSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C8220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48118 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcssE-0005TF-LI
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46655)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiJ-0003YJ-HH
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiH-00083v-5o
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:27 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41756)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcsiG-00082k-Sq
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:25 -0400
Received: by mail-wr1-x444.google.com with SMTP id c2so10220246wrm.8
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=4WOGglriexE6CQruKaZRN4iBHD/0/F+uA+DSiVuMmqg=;
 b=JM4xLuSPo6UIAnqHtv/qHpAvhqi7lBdsH7h5LMbfw35iHLuLPXKFrh/uCQfPuMPbHW
 WA6JN7xFrYDiVnRSxGBjJA9M8TA53OIZ5E5K5TnDvYejy2r9XYORgKfF1IeveQQSlBJJ
 EAiZOLWQgpIwUQkiBZ5HhnoH5DD8f2ixJ0XKIfXG5YBneOgKTcIGtMziA4+x/xT94sSA
 DckYdGnU/Bwn040Zqx65Qe1Iy+ctOa8mKlXmAfYWxGf1FWoB99krpFy+ewFEUBKeCGAM
 tf/UBb7Llwb1uHEV5NFf+kb8VlrKHzdisvBsbzrajV32S9P0zK7dwtfhUDrTZXY3jfc1
 rjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4WOGglriexE6CQruKaZRN4iBHD/0/F+uA+DSiVuMmqg=;
 b=NbH2B6NhK+Z9h7hILIjVneE8TkHfPAY5Flx1Ixq11Xok651QY3vzARTzfJ+QZlrtg+
 DpAO3yw4mARTQcMGFeb+Mvqu5xJvTyCIfySxlzyWZuwE5KrqcZ+V1bFV7Wo3w+lt39q3
 2Ie5tyLRYDivwBOHlLZ3pqwjXnNeMegZRBXpi3fzsYXtm5Z6ify4B0Weto5hQi+3OW14
 rRBAfMoqNNFPM0ipRdflgEjABBJX/DoebsUBBTvfeJ/Ey1I/5c4/loCiZxrAUMPdgwNc
 /5LF7MvUfE+5g2+nvomfYum6Yr3jnpZYKBEEGYTIj9uBLN8YSFTFe09i+oT/IO9cypMI
 aW1g==
X-Gm-Message-State: APjAAAUzr67pfDodIET6oScpFvwoDFrX7JmXbfm+uIOY23AqywWP2nvl
 mn33PaxTMDv5qYhgQ4Nlouu/iPR5OYY5Nw==
X-Google-Smtp-Source: APXvYqyk/GZk5u2xNZiveV40mCX83QIiL1xD4D0a08JKW/vkoMAIw7vvhs4axZBkPrlOGlfFJB3+/A==
X-Received: by 2002:a5d:5542:: with SMTP id g2mr1590568wrw.232.1560782063298; 
 Mon, 17 Jun 2019 07:34:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a67sm13819985wmh.40.2019.06.17.07.34.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:34:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:33:56 +0100
Message-Id: <20190617143412.5734-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617143412.5734-1-peter.maydell@linaro.org>
References: <20190617143412.5734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PULL 08/24] hw/arm: Correctly disable FPU/DSP for
 some ARMSSE-based boards
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

The SSE-200 hardware has configurable integration settings which
determine whether its two CPUs have the FPU and DSP:
 * CPU0_FPU (default 0)
 * CPU0_DSP (default 0)
 * CPU1_FPU (default 1)
 * CPU1_DSP (default 1)

Similarly, the IoTKit has settings for its single CPU:
 * CPU0_FPU (default 1)
 * CPU0_DSP (default 1)

Of our four boards that use either the IoTKit or the SSE-200:
 * mps2-an505, mps2-an521 and musca-a use the default settings
 * musca-b1 enables FPU and DSP on both CPUs

Currently QEMU models all these boards using CPUs with
both FPU and DSP enabled. This means that we are incorrect
for mps2-an521 and musca-a, which should not have FPU or DSP
on CPU0.

Create QOM properties on the ARMSSE devices corresponding to the
default h/w integration settings, and make the Musca-B1 board
enable FPU and DSP on both CPUs. This fixes the mps2-an521
and musca-a behaviour, and leaves the musca-b1 and mps2-an505
behaviour unchanged.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20190517174046.11146-5-peter.maydell@linaro.org
---
 include/hw/arm/armsse.h |  7 +++++
 hw/arm/armsse.c         | 58 ++++++++++++++++++++++++++++++++---------
 hw/arm/musca.c          |  8 ++++++
 3 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index 81e082cccf8..84080c22993 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -50,6 +50,11 @@
  *    address of each SRAM bank (and thus the total amount of internal SRAM)
  *  + QOM property "init-svtor" sets the initial value of the CPU SVTOR register
  *    (where it expects to load the PC and SP from the vector table on reset)
+ *  + QOM properties "CPU0_FPU", "CPU0_DSP", "CPU1_FPU" and "CPU1_DSP" which
+ *    set whether the CPUs have the FPU and DSP features present. The default
+ *    (matching the hardware) is that for CPU0 in an IoTKit and CPU1 in an
+ *    SSE-200 both are present; CPU0 in an SSE-200 has neither.
+ *    Since the IoTKit has only one CPU, it does not have the CPU1_* properties.
  *  + Named GPIO inputs "EXP_IRQ" 0..n are the expansion interrupts for CPU 0,
  *    which are wired to its NVIC lines 32 .. n+32
  *  + Named GPIO inputs "EXP_CPU1_IRQ" 0..n are the expansion interrupts for
@@ -208,6 +213,8 @@ typedef struct ARMSSE {
     uint32_t mainclk_frq;
     uint32_t sram_addr_width;
     uint32_t init_svtor;
+    bool cpu_fpu[SSE_MAX_CPUS];
+    bool cpu_dsp[SSE_MAX_CPUS];
 } ARMSSE;
 
 typedef struct ARMSSEInfo ARMSSEInfo;
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 47d13312dc1..b5c614cc3a1 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -38,6 +38,33 @@ struct ARMSSEInfo {
     bool has_cachectrl;
     bool has_cpusecctrl;
     bool has_cpuid;
+    Property *props;
+};
+
+static Property iotkit_properties[] = {
+    DEFINE_PROP_LINK("memory", ARMSSE, board_memory, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+    DEFINE_PROP_UINT32("EXP_NUMIRQ", ARMSSE, exp_numirq, 64),
+    DEFINE_PROP_UINT32("MAINCLK", ARMSSE, mainclk_frq, 0),
+    DEFINE_PROP_UINT32("SRAM_ADDR_WIDTH", ARMSSE, sram_addr_width, 15),
+    DEFINE_PROP_UINT32("init-svtor", ARMSSE, init_svtor, 0x10000000),
+    DEFINE_PROP_BOOL("CPU0_FPU", ARMSSE, cpu_fpu[0], true),
+    DEFINE_PROP_BOOL("CPU0_DSP", ARMSSE, cpu_dsp[0], true),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static Property armsse_properties[] = {
+    DEFINE_PROP_LINK("memory", ARMSSE, board_memory, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+    DEFINE_PROP_UINT32("EXP_NUMIRQ", ARMSSE, exp_numirq, 64),
+    DEFINE_PROP_UINT32("MAINCLK", ARMSSE, mainclk_frq, 0),
+    DEFINE_PROP_UINT32("SRAM_ADDR_WIDTH", ARMSSE, sram_addr_width, 15),
+    DEFINE_PROP_UINT32("init-svtor", ARMSSE, init_svtor, 0x10000000),
+    DEFINE_PROP_BOOL("CPU0_FPU", ARMSSE, cpu_fpu[0], false),
+    DEFINE_PROP_BOOL("CPU0_DSP", ARMSSE, cpu_dsp[0], false),
+    DEFINE_PROP_BOOL("CPU1_FPU", ARMSSE, cpu_fpu[1], true),
+    DEFINE_PROP_BOOL("CPU1_DSP", ARMSSE, cpu_dsp[1], true),
+    DEFINE_PROP_END_OF_LIST()
 };
 
 static const ARMSSEInfo armsse_variants[] = {
@@ -53,6 +80,7 @@ static const ARMSSEInfo armsse_variants[] = {
         .has_cachectrl = false,
         .has_cpusecctrl = false,
         .has_cpuid = false,
+        .props = iotkit_properties,
     },
     {
         .name = TYPE_SSE200,
@@ -66,6 +94,7 @@ static const ARMSSEInfo armsse_variants[] = {
         .has_cachectrl = true,
         .has_cpusecctrl = true,
         .has_cpuid = true,
+        .props = armsse_properties,
     },
 };
 
@@ -533,6 +562,20 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                 return;
             }
         }
+        if (!s->cpu_fpu[i]) {
+            object_property_set_bool(cpuobj, false, "vfp", &err);
+            if (err) {
+                error_propagate(errp, err);
+                return;
+            }
+        }
+        if (!s->cpu_dsp[i]) {
+            object_property_set_bool(cpuobj, false, "dsp", &err);
+            if (err) {
+                error_propagate(errp, err);
+                return;
+            }
+        }
 
         if (i > 0) {
             memory_region_add_subregion_overlap(&s->cpu_container[i], 0,
@@ -1222,16 +1265,6 @@ static const VMStateDescription armsse_vmstate = {
     }
 };
 
-static Property armsse_properties[] = {
-    DEFINE_PROP_LINK("memory", ARMSSE, board_memory, TYPE_MEMORY_REGION,
-                     MemoryRegion *),
-    DEFINE_PROP_UINT32("EXP_NUMIRQ", ARMSSE, exp_numirq, 64),
-    DEFINE_PROP_UINT32("MAINCLK", ARMSSE, mainclk_frq, 0),
-    DEFINE_PROP_UINT32("SRAM_ADDR_WIDTH", ARMSSE, sram_addr_width, 15),
-    DEFINE_PROP_UINT32("init-svtor", ARMSSE, init_svtor, 0x10000000),
-    DEFINE_PROP_END_OF_LIST()
-};
-
 static void armsse_reset(DeviceState *dev)
 {
     ARMSSE *s = ARMSSE(dev);
@@ -1244,13 +1277,14 @@ static void armsse_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     IDAUInterfaceClass *iic = IDAU_INTERFACE_CLASS(klass);
     ARMSSEClass *asc = ARMSSE_CLASS(klass);
+    const ARMSSEInfo *info = data;
 
     dc->realize = armsse_realize;
     dc->vmsd = &armsse_vmstate;
-    dc->props = armsse_properties;
+    dc->props = info->props;
     dc->reset = armsse_reset;
     iic->check = armsse_idau_check;
-    asc->info = data;
+    asc->info = info;
 }
 
 static const TypeInfo armsse_info = {
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 825d80e75a4..ddd8842732c 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -385,6 +385,14 @@ static void musca_init(MachineState *machine)
     qdev_prop_set_uint32(ssedev, "init-svtor", mmc->init_svtor);
     qdev_prop_set_uint32(ssedev, "SRAM_ADDR_WIDTH", mmc->sram_addr_width);
     qdev_prop_set_uint32(ssedev, "MAINCLK", SYSCLK_FRQ);
+    /*
+     * Musca-A takes the default SSE-200 FPU/DSP settings (ie no for
+     * CPU0 and yes for CPU1); Musca-B1 explicitly enables them for CPU0.
+     */
+    if (mmc->type == MUSCA_B1) {
+        qdev_prop_set_bit(ssedev, "CPU0_FPU", true);
+        qdev_prop_set_bit(ssedev, "CPU0_DSP", true);
+    }
     object_property_set_bool(OBJECT(&mms->sse), true, "realized",
                              &error_fatal);
 
-- 
2.20.1


