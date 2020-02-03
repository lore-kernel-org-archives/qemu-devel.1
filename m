Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49F6C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 08:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80FB420658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 08:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUBsX2iA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FB420658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyX7S-0007mr-NN
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 03:30:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iyX41-0002Fs-VZ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:26:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iyX3u-00012M-Vo
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:26:34 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:39976)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iyX3u-00011t-Pg; Mon, 03 Feb 2020 03:26:30 -0500
Received: by mail-wr1-x434.google.com with SMTP id j104so16723879wrj.7;
 Mon, 03 Feb 2020 00:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DFjUzzObXxlhnN9FkJ2W0kMBSKycCnz3WMxnNXs1uCo=;
 b=lUBsX2iA6rwwz9anYKuoKLRmUhyvGzmAW15ilmBEb6JNn42UCGKG6Wgh32pSu0G+fP
 PaCxgyxWgKj1umHMcOZi7mMMGDhCZjYm41cRcBl6rnSI84I4P1w04QTQr0B1psx0zpDj
 TjcMCAijXDKIw1EzEkZwu4lAOISn5pMXLzSujBqqSIY/6KM1vP7QPseMHrVjygHwNXgz
 vK4QAn6zitvSjr5aizvlGdB6vpq+QLje0vy/mFEVndGrIJ6ycWz++mbT14EnunWS5Ksx
 4L4W5hZRp2E8OdjT1GQePjfbLHwBPHyjYeCvQ+KVv0YQFir/ZvQk0OgsOKSCvqfpAPEQ
 6piA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=DFjUzzObXxlhnN9FkJ2W0kMBSKycCnz3WMxnNXs1uCo=;
 b=fb7Wcrf0T50rmrHSiqbcfHXSH5bxpsrVdLGT0rREiWqgFrWoKxnxki+tFT1l9mJ9eH
 x2sCRRzKySU3A+8pdtXB6g0Hscj62FFyfZMknVKucK0R1FKYf2ZmXxtR6qpgV8tDj4ls
 +ocnH+yzLFxSunCIIWIm9W4PecJEJUQptAblSw/O2tmGbR9oosA9L6IBcFoiHVgAQpOx
 IimF0oY2NKqjzUTEVb7YEngCmKzlrFBQa+0qryhck1BgFfpnEnzbziPjTCgiSuUUgu6+
 SG6pn33+Ga6l7koC3NpAh/UMFR6c52qtu40LYrODVMHg0590rfFQR86DHuIugIMLUlGe
 ZpAQ==
X-Gm-Message-State: APjAAAVn44YMpc+B5rn2qsvgtDcuwcDlkymdfN8enTgq3nqmzDYBJlqe
 RwqXOHRIE2BMnoUudvH1SOC7c33p
X-Google-Smtp-Source: APXvYqxgab2z6B/hzt+gZihlZcO6VApOVZ9hDekjyyX8rGF8x5LRiLei19Rv4yShryD+hN8qm0K2GQ==
X-Received: by 2002:adf:f401:: with SMTP id g1mr13596874wro.129.1580718389336; 
 Mon, 03 Feb 2020 00:26:29 -0800 (PST)
Received: from localhost.localdomain (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id w20sm22396778wmk.34.2020.02.03.00.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 00:26:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] hw/arm/raspi: Dynamically create machines based on the
 board revision
Date: Mon,  3 Feb 2020 09:26:18 +0100
Message-Id: <20200203082619.7426-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200203082619.7426-1-f4bug@amsat.org>
References: <20200203082619.7426-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We added tiny helpers extracting different values from the board
revision, we can now create a full board based on its revision.
The 'raspi-common' type is common to all raspi boards.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 93 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 31 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 656d834e07..12dc4d1486 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -44,12 +44,17 @@ static const struct {
     [C_BCM2837] = {TYPE_BCM2837},
 };
 
-typedef struct RasPiState {
+typedef struct RaspiMachineState {
+    /*< private >*/
+    MachineState parent_obj;
+    /*< public >*/
     BCM283XState soc;
     MemoryRegion ram;
-} RasPiState;
+} RaspiMachineState;
 
 typedef struct RaspiBoardInfo {
+    const char *name;
+    const char *desc;
     /*
      * Board revision codes:
      * www.raspberrypi.org/documentation/hardware/raspberrypi/revision-codes/
@@ -57,16 +62,32 @@ typedef struct RaspiBoardInfo {
     uint32_t board_rev;
 } RaspiBoardInfo;
 
-enum { BOARD_PI2, BOARD_PI3 };
+typedef struct RaspiMachineClass {
+    /*< private >*/
+    MachineClass parent_obj;
+    /*< public >*/
+    const RaspiBoardInfo *config;
+} RaspiMachineClass;
+
+#define TYPE_RASPI_MACHINE       MACHINE_TYPE_NAME("raspi-common")
+#define RASPI_MACHINE(obj) \
+    OBJECT_CHECK(RaspiMachineState, (obj), TYPE_RASPI_MACHINE)
+
+#define RASPI_MACHINE_CLASS(klass) \
+     OBJECT_CLASS_CHECK(RaspiMachineClass, (klass), TYPE_RASPI_MACHINE)
+#define RASPI_MACHINE_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(RaspiMachineClass, (obj), TYPE_RASPI_MACHINE)
 
 static const RaspiBoardInfo raspi_boards[] = {
-    [BOARD_PI2] =
     {
+        .name = MACHINE_TYPE_NAME("raspi2"),
+        .desc = "Raspberry Pi 2B",
         .board_rev = 0xa21041,
     },
 #ifdef TARGET_AARCH64
-    [BOARD_PI3] =
     {
+        .name = MACHINE_TYPE_NAME("raspi3"),
+        .desc = "Raspberry Pi 3B",
         .board_rev = 0xa02082,
     },
 #endif
@@ -221,7 +242,7 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
 
 static void raspi_init(MachineState *machine, const RaspiBoardInfo *config)
 {
-    RasPiState *s = g_new0(RasPiState, 1);
+    RaspiMachineState *s = RASPI_MACHINE(machine);
     int version = board_version(config);
     uint32_t vcram_size;
     DriveInfo *di;
@@ -271,15 +292,22 @@ static void raspi_init(MachineState *machine, const RaspiBoardInfo *config)
     setup_boot(machine, version, machine->ram_size - vcram_size);
 }
 
-static void raspi2_init(MachineState *machine)
+static void raspi_machine_init(MachineState *machine)
 {
-    raspi_init(machine, &raspi_boards[BOARD_PI2]);
+    RaspiMachineClass *rmc = RASPI_MACHINE_GET_CLASS(machine);
+
+    raspi_init(machine, rmc->config);
 }
 
-static void raspi2_machine_init(MachineClass *mc)
+static void raspi_machine_class_init(ObjectClass *oc, void *data)
 {
-    mc->desc = "Raspberry Pi 2";
-    mc->init = raspi2_init;
+    MachineClass *mc = MACHINE_CLASS(oc);
+    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
+    const RaspiBoardInfo *config = data;
+
+    rmc->config = config;
+    mc->desc = config->desc;
+    mc->init = raspi_machine_init;
     mc->block_default_type = IF_SD;
     mc->no_parallel = 1;
     mc->no_floppy = 1;
@@ -287,29 +315,32 @@ static void raspi2_machine_init(MachineClass *mc)
     mc->max_cpus = BCM283X_NCPUS;
     mc->min_cpus = BCM283X_NCPUS;
     mc->default_cpus = BCM283X_NCPUS;
-    mc->default_ram_size = 1 * GiB;
+    mc->default_ram_size = board_ram_size(config);
     mc->ignore_memory_transaction_failures = true;
+}
+
+static const TypeInfo raspi_machine_type = {
+    .name = TYPE_RASPI_MACHINE,
+    .parent = TYPE_MACHINE,
+    .instance_size = sizeof(RaspiMachineState),
+    .class_size = sizeof(RaspiMachineClass),
+    .abstract = true,
 };
-DEFINE_MACHINE("raspi2", raspi2_machine_init)
 
-#ifdef TARGET_AARCH64
-static void raspi3_init(MachineState *machine)
+static void raspi_machine_types(void)
 {
-    raspi_init(machine, &raspi_boards[BOARD_PI3]);
+    int i;
+
+    type_register_static(&raspi_machine_type);
+    for (i = 0; i < ARRAY_SIZE(raspi_boards); ++i) {
+        TypeInfo ti = {
+            .name       = raspi_boards[i].name,
+            .parent     = TYPE_RASPI_MACHINE,
+            .class_init = raspi_machine_class_init,
+            .class_data = (void *)&raspi_boards[i],
+        };
+        type_register(&ti);
+    }
 }
 
-static void raspi3_machine_init(MachineClass *mc)
-{
-    mc->desc = "Raspberry Pi 3";
-    mc->init = raspi3_init;
-    mc->block_default_type = IF_SD;
-    mc->no_parallel = 1;
-    mc->no_floppy = 1;
-    mc->no_cdrom = 1;
-    mc->max_cpus = BCM283X_NCPUS;
-    mc->min_cpus = BCM283X_NCPUS;
-    mc->default_cpus = BCM283X_NCPUS;
-    mc->default_ram_size = 1 * GiB;
-}
-DEFINE_MACHINE("raspi3", raspi3_machine_init)
-#endif
+type_init(raspi_machine_types)
-- 
2.21.1


