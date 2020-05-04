Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDF7C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:45:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E04172071C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xN5Y7hO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04172071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaTh-00070C-Ve
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHs-0000Fe-53
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:32 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHq-0000vI-9z
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:31 -0400
Received: by mail-wr1-x442.google.com with SMTP id k1so1831371wro.12
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=jVf6r09P5aGx03on/1HNxy/oqWSgeNz/oU/1pXVCDMQ=;
 b=xN5Y7hO4ycQUqeuhQhPgegV1xgJ5dw+M9kxV6r6bI+JoPa2CJGT1mVLODhWXI1v4I+
 jmmHUJFr64u9jE/lxdkUCuDDvuSZp7JbY/FDpT236iiyAM8qsP1AdBmW/RwCvnI3iweB
 p0+OasvUaKQmH3jDrCdMlpgeFN9mlJaTdmf9xSC+G11cRRuTNTsFGaIEI0w1Aw6GXOT4
 msbwo2nkfXlti+m1aM7xgGk7XRKdsIbTsE4jkdMjzj1U6Jjv/ZfivWwpp7xKKiSC4sGC
 jl0XrRhCtwtvvQu2mwx5SRxreBzERhlGZ4+teQRqVtEx3w3hUgO6rF4p/puBbcWZ7BQF
 WGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jVf6r09P5aGx03on/1HNxy/oqWSgeNz/oU/1pXVCDMQ=;
 b=qMdI2ZhTlHAhMxBKtS19+Lic/6dPlNHRJDK0wepFZiLETtVvI2WxcNBaK3kq4UatR7
 LAp1fCIrv+8QptXYFDHpFHrkxfnVXh0t2qsK883dwkbQBrX0qu+2FSr10w4OJN+TCTez
 c16xe8pYbhlr9JFA6FMv3pZlyqBYMgIKdhGQm/VbHBYHQMbJMT9hWWOgBpB3LZReQrFp
 DWPbgZN+84M7hmc1MBRYmzXu/1dhFunXL79mgeRa1E4O8zBUNX19psfYJY7hoNT3Ki1J
 8F7/NcnrkriSxVYvMDeN6pB4WuYS6ah4F+bEczUijFyyIDVZ5qQ/oh/gxa+nqHtfVJRX
 AlEw==
X-Gm-Message-State: AGi0PuYjMM2YQMFUoLXqdu5tNxpcuYFlBmNaHpLPvK67QxYDdXWWSwaJ
 PtPb/BE7/4PG5eM0CsPJD+RwXGARQNArMg==
X-Google-Smtp-Source: APiQypJ2++utpOb9O+LdT8bVwme4ETa19TiTRUFoiPKRI6SBlaJbhV3BrUriywUQG8/3FfF9DSiVOg==
X-Received: by 2002:adf:ea05:: with SMTP id q5mr4942004wrm.87.1588595608606;
 Mon, 04 May 2020 05:33:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/39] hw/arm: versal: Embed the APUs into the SoC type
Date: Mon,  4 May 2020 13:32:45 +0100
Message-Id: <20200504123309.3808-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Embed the APUs into the SoC type.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20200427181649.26851-8-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h |  2 +-
 hw/arm/xlnx-versal-virt.c    |  4 ++--
 hw/arm/xlnx-versal.c         | 19 +++++--------------
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 94b7826fd49..426b66449de 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -36,7 +36,7 @@ typedef struct Versal {
     struct {
         struct {
             MemoryRegion mr;
-            ARMCPU *cpu[XLNX_VERSAL_NR_ACPUS];
+            ARMCPU cpu[XLNX_VERSAL_NR_ACPUS];
             GICv3State gic;
         } apu;
     } fpd;
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 8a608074d15..d7be1ad4942 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -469,9 +469,9 @@ static void versal_virt_init(MachineState *machine)
     s->binfo.get_dtb = versal_virt_get_dtb;
     s->binfo.modify_dtb = versal_virt_modify_dtb;
     if (machine->kernel_filename) {
-        arm_load_kernel(s->soc.fpd.apu.cpu[0], machine, &s->binfo);
+        arm_load_kernel(&s->soc.fpd.apu.cpu[0], machine, &s->binfo);
     } else {
-        AddressSpace *as = arm_boot_address_space(s->soc.fpd.apu.cpu[0],
+        AddressSpace *as = arm_boot_address_space(&s->soc.fpd.apu.cpu[0],
                                                   &s->binfo);
         /* Some boot-loaders (e.g u-boot) don't like blobs at address 0 (NULL).
          * Offset things by 4K.  */
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index ebd2dc51beb..c8a296e2e05 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -31,19 +31,11 @@ static void versal_create_apu_cpus(Versal *s)
 
     for (i = 0; i < ARRAY_SIZE(s->fpd.apu.cpu); i++) {
         Object *obj;
-        char *name;
-
-        obj = object_new(XLNX_VERSAL_ACPU_TYPE);
-        if (!obj) {
-            error_report("Unable to create apu.cpu[%d] of type %s",
-                         i, XLNX_VERSAL_ACPU_TYPE);
-            exit(EXIT_FAILURE);
-        }
-
-        name = g_strdup_printf("apu-cpu[%d]", i);
-        object_property_add_child(OBJECT(s), name, obj, &error_fatal);
-        g_free(name);
 
+        object_initialize_child(OBJECT(s), "apu-cpu[*]",
+                                &s->fpd.apu.cpu[i], sizeof(s->fpd.apu.cpu[i]),
+                                XLNX_VERSAL_ACPU_TYPE, &error_abort, NULL);
+        obj = OBJECT(&s->fpd.apu.cpu[i]);
         object_property_set_int(obj, s->cfg.psci_conduit,
                                 "psci-conduit", &error_abort);
         if (i) {
@@ -57,7 +49,6 @@ static void versal_create_apu_cpus(Versal *s)
         object_property_set_link(obj, OBJECT(&s->fpd.apu.mr), "memory",
                                  &error_abort);
         object_property_set_bool(obj, true, "realized", &error_fatal);
-        s->fpd.apu.cpu[i] = ARM_CPU(obj);
     }
 }
 
@@ -95,7 +86,7 @@ static void versal_create_apu_gic(Versal *s, qemu_irq *pic)
     }
 
     for (i = 0; i < nr_apu_cpus; i++) {
-        DeviceState *cpudev = DEVICE(s->fpd.apu.cpu[i]);
+        DeviceState *cpudev = DEVICE(&s->fpd.apu.cpu[i]);
         int ppibase = XLNX_VERSAL_NR_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
         qemu_irq maint_irq;
         int ti;
-- 
2.20.1


