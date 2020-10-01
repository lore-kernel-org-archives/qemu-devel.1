Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75E3C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:04:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50EF720780
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fuUMG1om"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50EF720780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO07n-0008Fs-7L
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsd-0005CP-Ue
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:23 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:33596)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsb-0002zc-Qw
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:23 -0400
Received: by mail-wr1-x429.google.com with SMTP id m6so6131625wrn.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 07:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=29OqS31hrytI/JoxBJLw6VhtEjpyT0FqbJQ+mpvhcW8=;
 b=fuUMG1omCrZ2z7BoCou5UQVfi4XoT29zKFz5Sf0WsLddKjB6i1xtyY3Lal2PNvCqmO
 2Q2F4P+0DydOEsjs2P54BFzga4EUpivdSDO94sg1WL4XLSg199kAY7N8wvfZ7r50sNZE
 ZJSEjsSWlAZ9XOafGBkAXaABN9hZXXTUTrRGlf4NFvk7rmjBd2R2Eoos5w5d7iVMrutc
 Y5b+KMGT4+gqs1Cm+KBXs7Yt6ZjoBKbrct99DtR1E1fWWYp0WHOVqCt0TsPdrIWMJX+1
 j2u9lOjsmFR7infkBnZH9lTIneOmx31uxlj23wMRcNax8AoDVDpuWDJTn8Re1uctJFiA
 V0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=29OqS31hrytI/JoxBJLw6VhtEjpyT0FqbJQ+mpvhcW8=;
 b=abXhNNoIVOWQYbhz3eTk8OE+uKKs+CjeErAxfLmz/rNHTbbeIvs+MgfyzSmuTTuUS2
 Kh2pvfcBCQW2nU0i8pgRI422pTcQIRYBfeJkXg2Xlb4g+E1EuB+f0JURHs4gmE+fhNFl
 SUjbrehBlN+PMrX+JTMkJILTFM5PDIWP7fgnrl4P53LyKBXLGAAPyUXr+XnRApe/7kMC
 3nQHAObWkxQvg9RNkeViLComElWYy/RfY8rWcjBlGD2SGF3nslGF27JSL77OOepMB1nF
 AVTnFMZQIqDPXXqpl1nNWBCbnnfXuJj/M+pKvb42hOEQAU11842utgqevhrqVv+sz1Gk
 5lBg==
X-Gm-Message-State: AOAM530dL7LPztdIh2fJI8Z1wrAi1eaSOSwGYRCH7DXIvMUdNCynrwso
 IDWLfB7BMKx/+jia6rBLRyLAaxK1uDYQkoHA
X-Google-Smtp-Source: ABdhPJyAoN1XhlAfzD/6woo2ds1XezDQr7qUd0KLBDHdOyYrm0f8PAKUkWVkjsrEouOlly7iqBqWaQ==
X-Received: by 2002:a5d:4081:: with SMTP id o1mr9764539wrp.338.1601563700166; 
 Thu, 01 Oct 2020 07:48:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 70sm342052wme.15.2020.10.01.07.48.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 07:48:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/18] hw/arm/raspi: Move arm_boot_info structure to
 RaspiMachineState
Date: Thu,  1 Oct 2020 15:47:54 +0100
Message-Id: <20201001144759.5964-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201001144759.5964-1-peter.maydell@linaro.org>
References: <20201001144759.5964-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The arm_boot_info structure belong to the machine,
move it to RaspiMachineState.

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200924111808.77168-4-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.20.1


