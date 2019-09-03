Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20E9C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DFB022CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aY3Iwa0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFB022CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5B83-0002hD-A9
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 11:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArS-0002rr-Et
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArR-0005xp-10
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:50 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:53092)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5ArQ-0005xJ-Qs
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:48 -0400
Received: by mail-wm1-x32d.google.com with SMTP id t17so18753385wmi.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 08:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=9p80byA17XEFVio6ya05QPInVcwQ5DP56dNO6ng3AT0=;
 b=aY3Iwa0IPpMgFuDem7h7q9Yd6/QHPHQRkcyeBGIGJxwFOvqHi++WsU+qnwxMVZR7oM
 jpCNuhBujQzwtGseGD3GHGSGr4cc5RfR/SK7MkuVUsFYoPiRWs+TRCsmI3H8mpAbgI0W
 x2zJbQHBd0JgKE3CWcWcERQ7RKT5fR/sJ/ONjzhT6wR05LzgY4TfDj9x825ApsiTwHqT
 aGzJr12zD1NJvKtHuOjWT1gWIdpOTMMirpWqU5yNH5vR4CWRE+Apx0WHiopNG/OFCQe+
 dYmuTOMsZ5xE1nt5bOVCwGsm/VFCwWpTGyVMqaXbrJ6WoxxpfWL/gqgcb+2bVPTSeHXi
 wE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9p80byA17XEFVio6ya05QPInVcwQ5DP56dNO6ng3AT0=;
 b=Xivv2d/t/GadDWtPeFH5mK0tY3aRvKz+GHXkt5988822W2HAfgdr+AMNgxrOgq+YmR
 oWIe2NpgzLTnysAMtVXjMOpougsqPl4Vpjb+BTmc/uGJIaCNvamSeanRPtT6A5hbMUdz
 4nJMZf5eAM7CmcbBjqut5wtFWJntH9OP6Sifh2DGV2e2yRgBiqBkhClA5V9MRtKbbP5F
 +SNRhZMAGq+O0hXNPMHxAotnuUAEBtPeFavVImtaGTNjts980+7MUaUYGimBisW+t7Ew
 WNLktpKw0YpLB2H0zDXhZfx52EL71BFLbUcTXsf9HaevA7d4m8TPrbGdcHYazErWaXY5
 wogA==
X-Gm-Message-State: APjAAAUAJmCsmpfg+t7TsNerED6NSkzqQR7Ic7WiQFR2DAQTWwDyPIaC
 iZMozwOIA2GXS9OYsCFLEnKnHr51PMiIWQ==
X-Google-Smtp-Source: APXvYqzl8aX9vCb23CuSJJW9F6LHxnlvFgzn42gDXM+j8c0XiAGGFntqC94sF7E520yW1igtDXA2Yw==
X-Received: by 2002:a05:600c:22c9:: with SMTP id
 9mr778520wmg.133.1567525007631; 
 Tue, 03 Sep 2019 08:36:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a18sm24435188wrt.18.2019.09.03.08.36.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 08:36:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:36:22 +0100
Message-Id: <20190903153633.6651-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903153633.6651-1-peter.maydell@linaro.org>
References: <20190903153633.6651-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
Subject: [Qemu-devel] [PULL 10/21] hw/arm: Use ARM_CPU_TYPE_NAME() macro
 when appropriate
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Commit ba1ba5cca introduce the ARM_CPU_TYPE_NAME() macro.
Unify the code base by use it in all places.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190823143249.8096-2-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/allwinner-a10.c | 3 ++-
 hw/arm/cubieboard.c    | 3 ++-
 hw/arm/digic.c         | 3 ++-
 hw/arm/fsl-imx25.c     | 2 +-
 hw/arm/fsl-imx31.c     | 2 +-
 hw/arm/fsl-imx6.c      | 3 ++-
 hw/arm/fsl-imx6ul.c    | 2 +-
 hw/arm/xlnx-zynqmp.c   | 8 ++++----
 8 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 73810a44402..118032c8c72 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -30,7 +30,8 @@ static void aw_a10_init(Object *obj)
     AwA10State *s = AW_A10(obj);
 
     object_initialize_child(obj, "cpu", &s->cpu, sizeof(s->cpu),
-                            "cortex-a8-" TYPE_ARM_CPU, &error_abort, NULL);
+                            ARM_CPU_TYPE_NAME("cortex-a8"),
+                            &error_abort, NULL);
 
     sysbus_init_child_obj(obj, "intc", &s->intc, sizeof(s->intc),
                           TYPE_AW_A10_PIC);
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 38e0ca0f533..ed8d2333a07 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -81,7 +81,8 @@ static void cubieboard_init(MachineState *machine)
 
 static void cubieboard_machine_init(MachineClass *mc)
 {
-    mc->desc = "cubietech cubieboard";
+    mc->desc = "cubietech cubieboard (Cortex-A9)";
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
     mc->init = cubieboard_init;
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
diff --git a/hw/arm/digic.c b/hw/arm/digic.c
index 4f524658756..22434a65a28 100644
--- a/hw/arm/digic.c
+++ b/hw/arm/digic.c
@@ -37,7 +37,8 @@ static void digic_init(Object *obj)
     int i;
 
     object_initialize_child(obj, "cpu", &s->cpu, sizeof(s->cpu),
-                            "arm946-" TYPE_ARM_CPU, &error_abort, NULL);
+                            ARM_CPU_TYPE_NAME("arm946"),
+                            &error_abort, NULL);
 
     for (i = 0; i < DIGIC4_NB_TIMERS; i++) {
 #define DIGIC_TIMER_NAME_MLEN    11
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 532d088298b..2b2fdb203a2 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -36,7 +36,7 @@ static void fsl_imx25_init(Object *obj)
     FslIMX25State *s = FSL_IMX25(obj);
     int i;
 
-    object_initialize(&s->cpu, sizeof(s->cpu), "arm926-" TYPE_ARM_CPU);
+    object_initialize(&s->cpu, sizeof(s->cpu), ARM_CPU_TYPE_NAME("arm926"));
 
     sysbus_init_child_obj(obj, "avic", &s->avic, sizeof(s->avic),
                           TYPE_IMX_AVIC);
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 1a37a7b997c..6760de3c8c1 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -33,7 +33,7 @@ static void fsl_imx31_init(Object *obj)
     FslIMX31State *s = FSL_IMX31(obj);
     int i;
 
-    object_initialize(&s->cpu, sizeof(s->cpu), "arm1136-" TYPE_ARM_CPU);
+    object_initialize(&s->cpu, sizeof(s->cpu), ARM_CPU_TYPE_NAME("arm1136"));
 
     sysbus_init_child_obj(obj, "avic", &s->avic, sizeof(s->avic),
                           TYPE_IMX_AVIC);
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 8c397ef04ba..552145b24ec 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -43,7 +43,8 @@ static void fsl_imx6_init(Object *obj)
     for (i = 0; i < MIN(ms->smp.cpus, FSL_IMX6_NUM_CPUS); i++) {
         snprintf(name, NAME_SIZE, "cpu%d", i);
         object_initialize_child(obj, name, &s->cpu[i], sizeof(s->cpu[i]),
-                                "cortex-a9-" TYPE_ARM_CPU, &error_abort, NULL);
+                                ARM_CPU_TYPE_NAME("cortex-a9"),
+                                &error_abort, NULL);
     }
 
     sysbus_init_child_obj(obj, "a9mpcore", &s->a9mpcore, sizeof(s->a9mpcore),
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index b074177a71d..c405b68d1dd 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -34,7 +34,7 @@ static void fsl_imx6ul_init(Object *obj)
     int i;
 
     object_initialize_child(obj, "cpu0", &s->cpu, sizeof(s->cpu),
-                            "cortex-a7-" TYPE_ARM_CPU, &error_abort, NULL);
+                            ARM_CPU_TYPE_NAME("cortex-a7"), &error_abort, NULL);
 
     /*
      * A7MPCORE
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 0f587e63d35..fb03c60ebb8 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -196,8 +196,8 @@ static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
 
         object_initialize_child(OBJECT(&s->rpu_cluster), "rpu-cpu[*]",
                                 &s->rpu_cpu[i], sizeof(s->rpu_cpu[i]),
-                                "cortex-r5f-" TYPE_ARM_CPU, &error_abort,
-                                NULL);
+                                ARM_CPU_TYPE_NAME("cortex-r5f"),
+                                &error_abort, NULL);
 
         name = object_get_canonical_path_component(OBJECT(&s->rpu_cpu[i]));
         if (strcmp(name, boot_cpu)) {
@@ -237,8 +237,8 @@ static void xlnx_zynqmp_init(Object *obj)
     for (i = 0; i < num_apus; i++) {
         object_initialize_child(OBJECT(&s->apu_cluster), "apu-cpu[*]",
                                 &s->apu_cpu[i], sizeof(s->apu_cpu[i]),
-                                "cortex-a53-" TYPE_ARM_CPU, &error_abort,
-                                NULL);
+                                ARM_CPU_TYPE_NAME("cortex-a53"),
+                                &error_abort, NULL);
     }
 
     sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic),
-- 
2.20.1


