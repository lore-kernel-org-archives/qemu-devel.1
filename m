Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD600C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7775320708
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CoI5TY6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7775320708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrPDy-00084O-Mz
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxL-00057U-3k
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:31 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:38471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxJ-0005hY-7p
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:30 -0400
Received: by mail-wr1-x42d.google.com with SMTP id z13so33426252wrw.5
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=FSBAmlrtWVF6FORp650+KLsFcscgV77fdb6cJMrBfcg=;
 b=CoI5TY6KRiaofGrQJIKMv/dVYY8/Q5D2fWS2JMpVuVeYe4Nx+o0dauefwNlbNP+bQj
 G0CNf9nN1w9G/T+PNQbkaYDuODmOVupOjhKs3BkJ0IYMAtQURhOYnU4nxvsT3yq1gZ8A
 L7KWrx4w7kXlYdh0qeaUtzTl6ldlQDBAOKjRvhThxVJ/s7lNLsf+R157Bxeowuy6Uq23
 zVB74AJ0E7V3C8E4+R3/LhwEU7fmsNUdO4+SucNXsU5rD1Aq6RflqCe0/WAS2wBdQzgf
 cO/+i3WEm+R7W0XjN8b3xShNulZSiG2nNVrpRtcXSQmv//9waXM+RJk+S8pu+FwD64Px
 iMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FSBAmlrtWVF6FORp650+KLsFcscgV77fdb6cJMrBfcg=;
 b=gmSGUOZIGTcfgI/+V0iozf8RTEvE8z5qaQK2Vn4uiwdp+tVTwoaLaAsYyBBUYQM1z4
 kPkPEQS7l7yAFKX0DiuXCNDK6vf1YU395VjlTn/m9TBMllU6i8XA6YQX6uzJ+ISuU24Q
 ZeW5FO3i30jC7wlbD4g9TQWt8GWMqQI3BfP82vintzSQvGejBzf0mdMOn5qeppxGO5xa
 bEOwAzxQ5Z7kPbH1MxKL389D9bIaLw2mtrq+Y65u6N8b5OejgdoOA5Abb4OxPGcRkwkh
 sGRGwkJpqxpAolzUur9GQsvwY+902JeSA06/TYrtRdg13swAPxF+WMuALbJO+makVckB
 FlzA==
X-Gm-Message-State: AOAM530kSEKzGXCZoegFl6S7MelyXQiVbtEXH6rB+bToWKBRmQH/SOMk
 l/m/1my7PXHMnTanRv302uXt1A9Ssr/bzQ==
X-Google-Smtp-Source: ABdhPJyT0r8ZI6lzCegBhIRXdr4c5ZXyfW7ZUNDqbwxNVWiSIPR+FqykK1bvYp4IAny99Q9GjIuiSQ==
X-Received: by 2002:adf:9051:: with SMTP id h75mr40378471wrh.152.1593795267438; 
 Fri, 03 Jul 2020 09:54:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/34] hw/arm/spitz: Create SpitzMachineClass abstract base
 class
Date: Fri,  3 Jul 2020 17:53:49 +0100
Message-Id: <20200703165405.17672-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

For the four Spitz-family machines (akita, borzoi, spitz, terrier)
create a proper abstract class SpitzMachineClass which encapsulates
the common behaviour, rather than having them all derive directly
from TYPE_MACHINE:
 * instead of each machine class setting mc->init to a wrapper
   function which calls spitz_common_init() with parameters,
   put that data in the SpitzMachineClass and make spitz_common_init
   the SpitzMachineClass machine-init function
 * move the settings of mc->block_default_type and
   mc->ignore_memory_transaction_failures into the SpitzMachineClass
   class init rather than repeating them in each machine's class init

(The motivation is that we're going to want to keep some state in
the SpitzMachineState so we can connect GPIOs between devices created
in one sub-function of the machine init to devices created in a
different sub-function.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200628142429.17111-3-peter.maydell@linaro.org
---
 hw/arm/spitz.c | 91 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 55 insertions(+), 36 deletions(-)

diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index 9eaedab79b5..c70e912a33d 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -33,6 +33,26 @@
 #include "exec/address-spaces.h"
 #include "cpu.h"
 
+enum spitz_model_e { spitz, akita, borzoi, terrier };
+
+typedef struct {
+    MachineClass parent;
+    enum spitz_model_e model;
+    int arm_id;
+} SpitzMachineClass;
+
+typedef struct {
+    MachineState parent;
+} SpitzMachineState;
+
+#define TYPE_SPITZ_MACHINE "spitz-common"
+#define SPITZ_MACHINE(obj) \
+    OBJECT_CHECK(SpitzMachineState, obj, TYPE_SPITZ_MACHINE)
+#define SPITZ_MACHINE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(SpitzMachineClass, obj, TYPE_SPITZ_MACHINE)
+#define SPITZ_MACHINE_CLASS(klass) \
+    OBJECT_CLASS_CHECK(SpitzMachineClass, klass, TYPE_SPITZ_MACHINE)
+
 #undef REG_FMT
 #define REG_FMT                         "0x%02lx"
 
@@ -905,8 +925,6 @@ static void spitz_gpio_setup(PXA2xxState *cpu, int slots)
 }
 
 /* Board init.  */
-enum spitz_model_e { spitz, akita, borzoi, terrier };
-
 #define SPITZ_RAM       0x04000000
 #define SPITZ_ROM       0x00800000
 
@@ -915,9 +933,10 @@ static struct arm_boot_info spitz_binfo = {
     .ram_size = 0x04000000,
 };
 
-static void spitz_common_init(MachineState *machine,
-                              enum spitz_model_e model, int arm_id)
+static void spitz_common_init(MachineState *machine)
 {
+    SpitzMachineClass *smc = SPITZ_MACHINE_GET_CLASS(machine);
+    enum spitz_model_e model = smc->model;
     PXA2xxState *mpu;
     DeviceState *scp0, *scp1 = NULL;
     MemoryRegion *address_space_mem = get_system_memory();
@@ -958,100 +977,100 @@ static void spitz_common_init(MachineState *machine,
         /* A 4.0 GB microdrive is permanently sitting in CF slot 0.  */
         spitz_microdrive_attach(mpu, 0);
 
-    spitz_binfo.board_id = arm_id;
+    spitz_binfo.board_id = smc->arm_id;
     arm_load_kernel(mpu->cpu, machine, &spitz_binfo);
     sl_bootparam_write(SL_PXA_PARAM_BASE);
 }
 
-static void spitz_init(MachineState *machine)
+static void spitz_common_class_init(ObjectClass *oc, void *data)
 {
-    spitz_common_init(machine, spitz, 0x2c9);
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->block_default_type = IF_IDE;
+    mc->ignore_memory_transaction_failures = true;
+    mc->init = spitz_common_init;
 }
 
-static void borzoi_init(MachineState *machine)
-{
-    spitz_common_init(machine, borzoi, 0x33f);
-}
-
-static void akita_init(MachineState *machine)
-{
-    spitz_common_init(machine, akita, 0x2e8);
-}
-
-static void terrier_init(MachineState *machine)
-{
-    spitz_common_init(machine, terrier, 0x33f);
-}
+static const TypeInfo spitz_common_info = {
+    .name = TYPE_SPITZ_MACHINE,
+    .parent = TYPE_MACHINE,
+    .abstract = true,
+    .instance_size = sizeof(SpitzMachineState),
+    .class_size = sizeof(SpitzMachineClass),
+    .class_init = spitz_common_class_init,
+};
 
 static void akitapda_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    SpitzMachineClass *smc = SPITZ_MACHINE_CLASS(oc);
 
     mc->desc = "Sharp SL-C1000 (Akita) PDA (PXA270)";
-    mc->init = akita_init;
-    mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("pxa270-c0");
+    smc->model = akita;
+    smc->arm_id = 0x2e8;
 }
 
 static const TypeInfo akitapda_type = {
     .name = MACHINE_TYPE_NAME("akita"),
-    .parent = TYPE_MACHINE,
+    .parent = TYPE_SPITZ_MACHINE,
     .class_init = akitapda_class_init,
 };
 
 static void spitzpda_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    SpitzMachineClass *smc = SPITZ_MACHINE_CLASS(oc);
 
     mc->desc = "Sharp SL-C3000 (Spitz) PDA (PXA270)";
-    mc->init = spitz_init;
-    mc->block_default_type = IF_IDE;
-    mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("pxa270-c0");
+    smc->model = spitz;
+    smc->arm_id = 0x2c9;
 }
 
 static const TypeInfo spitzpda_type = {
     .name = MACHINE_TYPE_NAME("spitz"),
-    .parent = TYPE_MACHINE,
+    .parent = TYPE_SPITZ_MACHINE,
     .class_init = spitzpda_class_init,
 };
 
 static void borzoipda_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    SpitzMachineClass *smc = SPITZ_MACHINE_CLASS(oc);
 
     mc->desc = "Sharp SL-C3100 (Borzoi) PDA (PXA270)";
-    mc->init = borzoi_init;
-    mc->block_default_type = IF_IDE;
-    mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("pxa270-c0");
+    smc->model = borzoi;
+    smc->arm_id = 0x33f;
 }
 
 static const TypeInfo borzoipda_type = {
     .name = MACHINE_TYPE_NAME("borzoi"),
-    .parent = TYPE_MACHINE,
+    .parent = TYPE_SPITZ_MACHINE,
     .class_init = borzoipda_class_init,
 };
 
 static void terrierpda_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    SpitzMachineClass *smc = SPITZ_MACHINE_CLASS(oc);
 
     mc->desc = "Sharp SL-C3200 (Terrier) PDA (PXA270)";
-    mc->init = terrier_init;
-    mc->block_default_type = IF_IDE;
-    mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("pxa270-c5");
+    smc->model = terrier;
+    smc->arm_id = 0x33f;
 }
 
 static const TypeInfo terrierpda_type = {
     .name = MACHINE_TYPE_NAME("terrier"),
-    .parent = TYPE_MACHINE,
+    .parent = TYPE_SPITZ_MACHINE,
     .class_init = terrierpda_class_init,
 };
 
 static void spitz_machine_init(void)
 {
+    type_register_static(&spitz_common_info);
     type_register_static(&akitapda_type);
     type_register_static(&spitzpda_type);
     type_register_static(&borzoipda_type);
-- 
2.20.1


