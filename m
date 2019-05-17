Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF0FC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 17:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E296920848
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 17:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g4tE6OQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E296920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51751 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRgun-0002FE-1d
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 13:45:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRgqy-00082S-LY
	for qemu-devel@nongnu.org; Fri, 17 May 2019 13:41:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRgqu-0003IK-Im
	for qemu-devel@nongnu.org; Fri, 17 May 2019 13:41:06 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRgqq-00032O-TD
	for qemu-devel@nongnu.org; Fri, 17 May 2019 13:41:02 -0400
Received: by mail-wm1-x342.google.com with SMTP id 198so7688527wme.3
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 10:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=7QU2E61ExLPRQ5cVFAuMwBaju416G00wlZEn+t3cGhw=;
	b=g4tE6OQp4CPXBvjCv3gkW1ESF6ZYG/bQbX38fjpp8rGCiARyxkmapH/GZ6TsnFN8v6
	V3+u7yuf9heD7f2QbIG5qK4WyahSPlwaY+UIu3kof/agaWmcNgyvACS6dHGSsiDFfZI0
	z4lICVyIK/2ka2qsXpq9Fwzp7GN6Abf4EZ+8UPUfI2DjOW3EN3QZFZ7xfgdVFb3vFkvJ
	3xnqlZTnwx2qBTRpUh2FDk/pTrYrRuUz+a7nUV38nUSWN0o5U2xc3w5JB7L2JLFpntkD
	nTBzZTB2ndhcgK3LfeUAKEFIAZRr96EVDg/g7enOpDXA9fD5MqDqiAP/CFs7jD2B429t
	un3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=7QU2E61ExLPRQ5cVFAuMwBaju416G00wlZEn+t3cGhw=;
	b=Vo5UCB2rNUNOBilOMJ2S+Ya7AFehIxgrghXe3cbbPNFkl/K4f7dIPxWibbHuKhYRZ+
	fsBP6++5ZDlaUSCYnI5Tru8TcLojNY+ZwcqQ+N44i3V7/XRMHk1b+dqUlNCmJTY2NHCJ
	aR8tBiI/sHZYyKPOyzgFsH4nX0wYj7t5sfZzSt8ZLXQ1NS008OUrMuW/u7b2hBG6tLPo
	NBczs2Ph9Oz8xZQCXTBWx8+zEWbl+0PEt5TE2ONEJEpbLcCJBBG/rsJIe8xed3VwTvn/
	bA8SA29iQIQu56EqtyN94mmUZdP5BuelnUzCvkKi4ZOMpnMUK3jh2MhvPuX6/rqton0c
	/p/w==
X-Gm-Message-State: APjAAAWnp1y6e9XlSwjkJSahEABOBxTu+YbxKfkqqW2+op09xZTIMfgx
	zrgttOn4bsnIKNqIScgYpiacebEaOWc=
X-Google-Smtp-Source: APXvYqzv9P7GBozUr6OCS4pzol/BcTKHwMiCNd/tlXS3EN9f86BwKFPiAG++cAwDYGulsdx7xyqS2w==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr3044698wmj.41.1558114853382;
	Fri, 17 May 2019 10:40:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	y18sm5418641wmd.29.2019.05.17.10.40.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 10:40:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Fri, 17 May 2019 18:40:46 +0100
Message-Id: <20190517174046.11146-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517174046.11146-1-peter.maydell@linaro.org>
References: <20190517174046.11146-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH 4/4] hw/arm: Correctly disable FPU/DSP for some
 ARMSSE-based boards
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
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
index 76cc6905798..e138aee673f 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -37,6 +37,33 @@ struct ARMSSEInfo {
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
@@ -52,6 +79,7 @@ static const ARMSSEInfo armsse_variants[] = {
         .has_cachectrl = false,
         .has_cpusecctrl = false,
         .has_cpuid = false,
+        .props = iotkit_properties,
     },
     {
         .name = TYPE_SSE200,
@@ -65,6 +93,7 @@ static const ARMSSEInfo armsse_variants[] = {
         .has_cachectrl = true,
         .has_cpusecctrl = true,
         .has_cpuid = true,
+        .props = armsse_properties,
     },
 };
 
@@ -532,6 +561,20 @@ static void armsse_realize(DeviceState *dev, Error **errp)
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
@@ -1221,16 +1264,6 @@ static const VMStateDescription armsse_vmstate = {
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
@@ -1243,13 +1276,14 @@ static void armsse_class_init(ObjectClass *klass, void *data)
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
index 23aff43f4bc..736f37b774c 100644
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


