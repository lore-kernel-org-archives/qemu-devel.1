Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEE9C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:21:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1267F2395B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXeim/rJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1267F2395B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLPJo-00005V-3K
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 07:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLPGT-0004DV-L5; Thu, 24 Sep 2020 07:18:17 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43437)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLPGS-0003ux-2X; Thu, 24 Sep 2020 07:18:17 -0400
Received: by mail-wr1-x443.google.com with SMTP id k15so3346338wrn.10;
 Thu, 24 Sep 2020 04:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pqQjOUWtcLPC8L4qk6a3pit1FoREjeT8r9pPsJuQ7/Y=;
 b=FXeim/rJjWU6LkaUraj/OoBym0yEzXqTPieMK9tHHjSOzEQb4IVlZKcCes8QtjQVGF
 coLEr1oIzD6NLF1oFsxIqrAWiyiCCA3RFVFUKQ25Q5dG3N/aq/AVixM8aQSP76y/xgzk
 OtExW5qE/a77oralWtAM3yz+Opn9ujWzP4EC2I6y/apiB/MYmW8b5eDNHWTXPwuQMMRv
 KQPZQ3XDkvoah+i3FpeoZ2hdqngRANDw45IcfDEeEthXuu7jvWMYtg2cxwq+uxShqgAn
 Vd2S/bmXX+yLECac5G4XHxN5FjTFEi9sXpH8Hn+NahPg194rEnx1/HawTIhwI9EjHfOL
 6pMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=pqQjOUWtcLPC8L4qk6a3pit1FoREjeT8r9pPsJuQ7/Y=;
 b=hZlB8psHxeaANN0rcZo1K9ERYwDP6+rRMmr8H5X1SJlt48/F3iZzdOZlj5KHGfpVWW
 O6wrZGAQirK+CCdrvFJobjs/wAgyV4bxH9e4li5blN2Kc97OqYLCP48LEZOTUHxkDtGF
 oxKWWxlGy/CTUx3lQe41vFHpuJQW9A4uhtk191vuY9xCDCW4LCU6AxLR1A42C7+Eo8d5
 wvCeooLKoltXsclV/SM31wv77jYmf5+C/z6ZgyWkpb7NWeYzcZLGLSOtSkYGt6JlVZk3
 COhzNrhnhr7KCKpuL2u5i4Kq3mgPqDvaTeoWjOR8QjNc4BBGx2SDHsTadNWTETMSETBH
 tC1A==
X-Gm-Message-State: AOAM532ZgkkZDSPSw9C2lxojuMHTl3ul9vFoV4tLHNUCTp5n4/4Rur6k
 r12crMJybspDVfPDUT4p7XL4T+oLjpE=
X-Google-Smtp-Source: ABdhPJzXu6MVOW9JpbhEogq2CCgBkbw5OI7/ALbN7FusoM1q3D7GcSYGftg7P6h2NfXXCn4xii0J8g==
X-Received: by 2002:adf:f544:: with SMTP id j4mr4506941wrp.74.1600946294118;
 Thu, 24 Sep 2020 04:18:14 -0700 (PDT)
Received: from x1w.redhat.com (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id h76sm3400363wme.10.2020.09.24.04.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 04:18:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/8] hw/arm/raspi: Move arm_boot_info structure to
 RaspiMachineState
Date: Thu, 24 Sep 2020 13:18:03 +0200
Message-Id: <20200924111808.77168-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924111808.77168-1-f4bug@amsat.org>
References: <20200924111808.77168-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The arm_boot_info structure belong to the machine,
move it to RaspiMachineState.

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 8716a80a75e..16e6c83c925 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -41,6 +41,7 @@ struct RaspiMachineState {
     MachineState parent_obj;
     /*< public >*/
     BCM283XState soc;
+    struct arm_boot_info binfo;
 };
 typedef struct RaspiMachineState RaspiMachineState;
 
@@ -206,12 +207,11 @@ static void reset_secondary(ARMCPU *cpu, const struct arm_boot_info *info)
 static void setup_boot(MachineState *machine, int version, size_t ram_size)
 {
     RaspiMachineState *s = RASPI_MACHINE(machine);
-    static struct arm_boot_info binfo;
     int r;
 
-    binfo.board_id = MACH_TYPE_BCM2708;
-    binfo.ram_size = ram_size;
-    binfo.nb_cpus = machine->smp.cpus;
+    s->binfo.board_id = MACH_TYPE_BCM2708;
+    s->binfo.ram_size = ram_size;
+    s->binfo.nb_cpus = machine->smp.cpus;
 
     if (version <= 2) {
         /* The rpi1 and 2 require some custom setup code to run in Secure
@@ -220,21 +220,21 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
          * firmware for some cache maintenance operations.
          * The rpi3 doesn't need this.
          */
-        binfo.board_setup_addr = BOARDSETUP_ADDR;
-        binfo.write_board_setup = write_board_setup;
-        binfo.secure_board_setup = true;
-        binfo.secure_boot = true;
+        s->binfo.board_setup_addr = BOARDSETUP_ADDR;
+        s->binfo.write_board_setup = write_board_setup;
+        s->binfo.secure_board_setup = true;
+        s->binfo.secure_boot = true;
     }
 
     /* Pi2 and Pi3 requires SMP setup */
     if (version >= 2) {
-        binfo.smp_loader_start = SMPBOOT_ADDR;
+        s->binfo.smp_loader_start = SMPBOOT_ADDR;
         if (version == 2) {
-            binfo.write_secondary_boot = write_smpboot;
+            s->binfo.write_secondary_boot = write_smpboot;
         } else {
-            binfo.write_secondary_boot = write_smpboot64;
+            s->binfo.write_secondary_boot = write_smpboot64;
         }
-        binfo.secondary_cpu_reset_hook = reset_secondary;
+        s->binfo.secondary_cpu_reset_hook = reset_secondary;
     }
 
     /* If the user specified a "firmware" image (e.g. UEFI), we bypass
@@ -250,11 +250,11 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
             exit(1);
         }
 
-        binfo.entry = firmware_addr;
-        binfo.firmware_loaded = true;
+        s->binfo.entry = firmware_addr;
+        s->binfo.firmware_loaded = true;
     }
 
-    arm_load_kernel(&s->soc.cpu[0].core, machine, &binfo);
+    arm_load_kernel(&s->soc.cpu[0].core, machine, &s->binfo);
 }
 
 static void raspi_machine_init(MachineState *machine)
-- 
2.26.2


