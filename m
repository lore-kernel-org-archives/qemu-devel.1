Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4AFC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E7AE2176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mi53oH44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7AE2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Yox-0000jD-GI
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:56:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkR-0000WS-CM
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkM-0006Is-6I
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:34 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:40711)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkL-0006Dq-UV
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:30 -0500
Received: by mail-wm1-x32f.google.com with SMTP id t14so2834776wmi.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TmKiV2DAhak+nXW1FExGcGGioFmWvkGA1aDQh50T6bs=;
 b=Mi53oH4423iJPNLgsNL/szJfWC0pDV0GdSgfoMUvURp7igvcd/BAnPzdkqxuf2QCok
 ilyOTMD1R+0dGrUx+zrDlWLPZ4510ONAT1zOfnUhtxgCEylkfp6YwJO+1jSquOlire7+
 4YDbUiTpmEBm2IWWeSGX77AnPtz8jEcRGulvxN1c8UxvvE2xUFCuEyZwN4vIjrXUziNm
 kCSz89TBi1SRy/9xP4jGkID2tKjKf/TEJMw21w5L42ZrroNdQDqvJv0NIJW0+DwMvXaY
 5spNojamHxh9yNJrBROyEyb7iXHiinH8U+qBqxYBAoMwWuQ4ccdC5sj/xmyadf5fEKDY
 KG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=TmKiV2DAhak+nXW1FExGcGGioFmWvkGA1aDQh50T6bs=;
 b=tOKSg249+3LBvbMcdnh0EwbGIPgHZdoym1/h3ufJx9SLQ8lDABMm4ywxGZfGZ+FuYe
 gg3XypJCO9STE5KMUYEkM0SL+Dm04KYPScDaYcASXTAe9FkrJcRDUF3IZf1E6Afmi+J/
 66gUZUN0VJXvOU4gcBz56y2r850mNEV4I081HCpvMhZAixxEgtHmZ1YZk5M7QUYkUm+u
 HjQ2mxCIbxCoo1mwh5xHOlqO/Bjvb+pLfaoxBsKG+P07LKmpuWaspAXTe37971iL4g6U
 1ZhD0pwFobOwlp0/zYwrr2fDsJhkO48iYzynVr8Q0i9KQPHV3vM/vBrJgAFJq49TVf5T
 IVRg==
X-Gm-Message-State: APjAAAXVoJzryxwn2U/Wk2kTu2ajZBVurlZFYCbFY05LZFFiDH5kRBWv
 /Ctkv3eGPN+dq7RzZMRzqZs/0P8P
X-Google-Smtp-Source: APXvYqxD7XVGKo+Ge1Nj5y75VjykfX4KB1BHZ/Fz6HG31QYtv7WiVJmFJxmLvpxonvyGZXc/w5Qsbg==
X-Received: by 2002:a1c:38c7:: with SMTP id f190mr4805538wma.94.1582631485620; 
 Tue, 25 Feb 2020 03:51:25 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 020/136] arm/mcimx6ul-evk: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:10 +0100
Message-Id: <1582631466-13880-20-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

memory_region_allocate_system_memory() API is going away, so
replace it with memdev allocated MemoryRegion. The later is
initialized by generic code, so board only needs to opt in
to memdev scheme by providing
  MachineClass::default_ram_id
and using MachineState::ram instead of manually initializing
RAM memory region.

PS:
  remove no longer needed MCIMX6ULEVK

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200219160953.13771-21-imammedo@redhat.com>
---
 hw/arm/mcimx6ul-evk.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index e90b393..23a71ed 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -19,15 +19,10 @@
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
 
-typedef struct {
-    FslIMX6ULState soc;
-    MemoryRegion ram;
-} MCIMX6ULEVK;
-
 static void mcimx6ul_evk_init(MachineState *machine)
 {
     static struct arm_boot_info boot_info;
-    MCIMX6ULEVK *s = g_new0(MCIMX6ULEVK, 1);
+    FslIMX6ULState *s;
     int i;
 
     if (machine->ram_size > FSL_IMX6UL_MMDC_SIZE) {
@@ -43,15 +38,12 @@ static void mcimx6ul_evk_init(MachineState *machine)
         .nb_cpus = machine->smp.cpus,
     };
 
-    object_initialize_child(OBJECT(machine), "soc", &s->soc,  sizeof(s->soc),
-                            TYPE_FSL_IMX6UL, &error_fatal, NULL);
-
-    object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_fatal);
+    s = FSL_IMX6UL(object_new(TYPE_FSL_IMX6UL));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(s), &error_fatal);
+    object_property_set_bool(OBJECT(s), true, "realized", &error_fatal);
 
-    memory_region_allocate_system_memory(&s->ram, NULL, "mcimx6ul-evk.ram",
-                                         machine->ram_size);
-    memory_region_add_subregion(get_system_memory(),
-                                FSL_IMX6UL_MMDC_ADDR, &s->ram);
+    memory_region_add_subregion(get_system_memory(), FSL_IMX6UL_MMDC_ADDR,
+                                machine->ram);
 
     for (i = 0; i < FSL_IMX6UL_NUM_USDHCS; i++) {
         BusState *bus;
@@ -61,7 +53,7 @@ static void mcimx6ul_evk_init(MachineState *machine)
 
         di = drive_get_next(IF_SD);
         blk = di ? blk_by_legacy_dinfo(di) : NULL;
-        bus = qdev_get_child_bus(DEVICE(&s->soc.usdhc[i]), "sd-bus");
+        bus = qdev_get_child_bus(DEVICE(&s->usdhc[i]), "sd-bus");
         carddev = qdev_create(bus, TYPE_SD_CARD);
         qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
         object_property_set_bool(OBJECT(carddev), true,
@@ -69,7 +61,7 @@ static void mcimx6ul_evk_init(MachineState *machine)
     }
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->soc.cpu, machine, &boot_info);
+        arm_load_kernel(&s->cpu, machine, &boot_info);
     }
 }
 
@@ -78,5 +70,6 @@ static void mcimx6ul_evk_machine_init(MachineClass *mc)
     mc->desc = "Freescale i.MX6UL Evaluation Kit (Cortex A7)";
     mc->init = mcimx6ul_evk_init;
     mc->max_cpus = FSL_IMX6UL_NUM_CPUS;
+    mc->default_ram_id = "mcimx6ul-evk.ram";
 }
 DEFINE_MACHINE("mcimx6ul-evk", mcimx6ul_evk_machine_init)
-- 
1.8.3.1



