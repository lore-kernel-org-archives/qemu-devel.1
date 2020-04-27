Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCBCC4CECC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:21:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FB7020775
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwvxhXQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB7020775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT8NQ-0006n2-7z
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 14:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jT8JT-0000IM-5j
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jT8JS-0005Nt-La
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:17:02 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:44778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jT8JS-0005Iw-6a; Mon, 27 Apr 2020 14:17:02 -0400
Received: by mail-lj1-x243.google.com with SMTP id a21so15743264ljj.11;
 Mon, 27 Apr 2020 11:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ppDFNV0HS5PGl+N0yG8aeZ7r5RAGOOBwmZI9oUukmYs=;
 b=dwvxhXQOT+G38pYEQIAHeXbXYOWFA03bEal1MB0n5lJD1XIP4f73hB3MOkEmZtEKxK
 XLqXhznW1lqlhKES2YCgz9K4QHdK89cOUjtdbQ6wCnUcHupEP/w57taV1Xy32RzkpFIl
 bocjoWmAlvTgUlHcEl8yhClz9EHgwSd7FRbBuJgobqX9i/z7ddz4g2pHuPCX8GG/uBr6
 A5S6u/T/EqXKbjViv5JCdqmkP1ns9QcG8HZTV+6bzoHgwmgjhx4wGSiTbQtYgCCfTXX5
 WmsFoJ1Mspkjt17r/EkPTyCF6ubfnF2J/TOcnimQVoIdT5YlJqKF4eq/5FK2CanHCHQg
 543w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ppDFNV0HS5PGl+N0yG8aeZ7r5RAGOOBwmZI9oUukmYs=;
 b=NV1ThWYTFsc6XDX5aihKiVT+4g6de5yPaDa6Gt2gGNZvlOapsY8hJUp7f0Bdvenayr
 Oew+bhYpCFY9S6b28pnc1ING7eTReMotagIghQS4i2jXa6IAUMK1+EA21BIq/VMPJby2
 nhWbzY+jupB0HeN40R9cXccOLpxpbd35bgY192VIa8QOMOghKBYENdbAYayXrHA81Mzz
 gx7USYCjHmpWK21FhMCngv7TeFYMWnch+HUGBEcSEcFLd8VeOzG6b64RsB/yhjxsmn1V
 WG2VsbIhIp4S3v68p/3J4eyQkvzSQrhUojnESrOLSsVXFgZDbRBCqAobgk1q4M608jVL
 zqmA==
X-Gm-Message-State: AGi0PuYkjQakbrgHotLs5ybd7IpbF6DvztyaJHrObgnz6V773R78b8Vh
 nA+zBc4z0/xkyVOmZi4m9DBYuTFpBaY=
X-Google-Smtp-Source: APiQypJeNSDwuZbrkgLApxqx9DKVFovq5rGjhGZtnhNkjxlZDyqpIj9Oaasv73gjDTjkIh3eNk1D3w==
X-Received: by 2002:a2e:b17a:: with SMTP id a26mr14138623ljm.215.1588011419970; 
 Mon, 27 Apr 2020 11:16:59 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id 14sm11458578lfz.8.2020.04.27.11.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 11:16:59 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 07/11] hw/arm: versal: Embedd the APUs into the SoC type
Date: Mon, 27 Apr 2020 20:16:45 +0200
Message-Id: <20200427181649.26851-8-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427181649.26851-1-edgar.iglesias@gmail.com>
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::243
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Embedd the APUs into the SoC type.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/arm/xlnx-versal-virt.c    |  4 ++--
 hw/arm/xlnx-versal.c         | 19 +++++--------------
 include/hw/arm/xlnx-versal.h |  2 +-
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 8a608074d1..d7be1ad494 100644
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
index ebd2dc51be..c8a296e2e0 100644
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
diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 94b7826fd4..426b66449d 100644
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
-- 
2.20.1


