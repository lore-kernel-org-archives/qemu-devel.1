Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABD4C43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72B720874
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxVC2BnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72B720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKGla-0000Tz-T0
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 04:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKGgj-0004UF-0U; Mon, 21 Sep 2020 03:56:41 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKGge-0005tr-MR; Mon, 21 Sep 2020 03:56:37 -0400
Received: by mail-wm1-x341.google.com with SMTP id l15so10910384wmh.1;
 Mon, 21 Sep 2020 00:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T9CL3aNfJM88wMcSnRqWzQ2xospTK9SQCj76tJrEnoI=;
 b=RxVC2BnMBeL9NBjUrIxUrgrg8eOQiVmLqhTQJrs8VJQL5/BsPWTVbrJ/P119c6OVMa
 8Y0pphLCwbt+h2ihO4+OMLKkpO6DPBPUdk6DelkWKqALEnc7DgH359YnNawqZ2afVseI
 pLSUfeJhKmlQqoifVg4t/9KloV5ias9uRYpDVFhkZxFQ1qlUlz7EJUQ3AnaSvrWO9drn
 GKIl17Yj79ij/Y2qQW9yd8euijg19+aYLeh9hqjYcPx55RB9Cp/yTAs4y7UgLIEbyT02
 wc4EF6QFYCgQLORikc5rkXH8si3F0WPkMm+A0IrpG6NztTW1HhANkI+ysP+cXStyXjEy
 Kugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=T9CL3aNfJM88wMcSnRqWzQ2xospTK9SQCj76tJrEnoI=;
 b=GApGx9wvAPZG7rQ4s5m/u1xmSEBrrgbHq397hp+09WBj1gFnMaPdxTB1qiPkmYKJHb
 h5gc+asC5ZgsLiv4/P8PmsJbwDimM1FaJhuunXBHbBhjThWamnipK5Yht0A1bz07K4rL
 YdMUVoxtBX8T1+rm+IbfCVAm+d24Gpwyy+vnzcNAoBl3QSsRw9U6LhVIG88UObXQYx9Y
 D8YTAVQXX0BM38+eB0TBEG3nhgHB7+z4NLPoVojc+B+b7te5sj6dyRKvHNKTR2JAxJxf
 Gocr14djsnI1xnfAgIdoCw2MTYpKcmVUcgaL8nKDEHHSzoqM8BSTkLpsbpXI4TuDbO0v
 wOkA==
X-Gm-Message-State: AOAM5327f5V7Xn2BZsABLWwKqIFGBOv3MFtyxOqomuB3pyiIJDMUm2FA
 VZ8tvp/3K/K5EV9nfAuhZ6xekKwmdBY=
X-Google-Smtp-Source: ABdhPJwQQZ6qeIcNDvel4K4aXMQoh+tQwuc9xTBRkdA6XBsgrYhDOHJsRr3QGkI4G7+RBSjBMem1lA==
X-Received: by 2002:a05:600c:221a:: with SMTP id
 z26mr30293349wml.131.1600674993864; 
 Mon, 21 Sep 2020 00:56:33 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id o15sm17807538wmh.29.2020.09.21.00.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 00:56:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/8] hw/arm/raspi: Move arm_boot_info structure to
 RaspiMachineState
Date: Mon, 21 Sep 2020 09:56:23 +0200
Message-Id: <20200921075628.466506-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921075628.466506-1-f4bug@amsat.org>
References: <20200921075628.466506-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The arm_boot_info structure belong to the machine,
move it to RaspiMachineState.

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


