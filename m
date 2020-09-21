Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309A1C43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:04:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED5C20874
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHGnt+RF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED5C20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKGo9-0002kt-PR
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 04:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKGgl-0004Vk-Nt; Mon, 21 Sep 2020 03:56:44 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41397)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKGgj-0005uc-EC; Mon, 21 Sep 2020 03:56:43 -0400
Received: by mail-wr1-x442.google.com with SMTP id w5so11644009wrp.8;
 Mon, 21 Sep 2020 00:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3cUAmcXEySvZuiPUDhUwrBrWEw0aliYA7aOM+n1UWOI=;
 b=HHGnt+RFag9XZfkWzme5pKMLKAPNbLZq1vHaYb2qtu+SFuxHrDXFvaz3DELv/QkAnk
 3Y74UyD9FYSZZXOW32Al4PVpx6coBMzUUlB5rXR9DY1MEkc9yliI9D6bMBamMtLrwlBg
 cBZ9qnuA1VX16P2t9zB27TTJDy2Gc86hcgGVedGlSiIDlY24HIRRe7dxzV8bAYMesxCL
 Gdcrr7HR51fxftvwjXNoGOD0Dfxnjzm8na99RtXDUO1geAN1Glumrqea8QiH5+CA37rz
 /GaGcyLk0FsEfykRgqEwFapqYMamvd8MCnry759Uh/0kiA9Q06uc5PI2rmhWCq1H2Fd6
 Obdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3cUAmcXEySvZuiPUDhUwrBrWEw0aliYA7aOM+n1UWOI=;
 b=I0qP/4OQuLPW9EuddO2TN3h2GBIywhi4jmsjc0W4t22SKCe+wiqzNfEFFBMC5/AXZq
 4hohoTxqWhll3NkdKHi+z9jdr5pKU74nzhH+UVY2OqXA21ATC2iwGppDXLPfHHmpIndW
 1cBWqltydrdPP8mG9HzvJHvRLtxwTDqtn0um4unnm9EpGjUSXg/BaEYBThAKWlCi//wT
 J8oWHEEtgAAs0/vdt8U8Rt03uxSnpN6WVeZ4etuK/U+cLvIqKov9Xy3FcWGYRNcJ8R59
 g7ZjjEgMrbgFk3ar4ajOtPmHxDzhqTcbtsa+flln4vu9tB3uWOl8YVbCryfZIktRSEzP
 psCw==
X-Gm-Message-State: AOAM532icoUZQrs4xBuGnEGnryICh3f9bk+siwPlVI8X5qaoYPPJxG6U
 qrRhmGl9NcS1/2toqfJmwoVEwX1gANQ=
X-Google-Smtp-Source: ABdhPJyYhBHjfebxHKTyJVFY+HdnLw1Z/14Lys9WpMdXMRbXNFVqgci3j600qn/bWT8Imrxom2LVeg==
X-Received: by 2002:a5d:60c6:: with SMTP id x6mr19007867wrt.157.1600674999332; 
 Mon, 21 Sep 2020 00:56:39 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id o15sm17807538wmh.29.2020.09.21.00.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 00:56:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 8/8] hw/arm/raspi: Remove use of the 'version' value in the
 board code
Date: Mon, 21 Sep 2020 09:56:28 +0200
Message-Id: <20200921075628.466506-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921075628.466506-1-f4bug@amsat.org>
References: <20200921075628.466506-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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

We expected the 'version' ID to match the board processor ID,
but this is not always true (for example boards with revision
id 0xa02042/0xa22042 are Raspberry Pi 2 with a BCM2837 SoC).
This was not important because we were not modelling them, but
since the recent refactor now allow to model these boards, it
is safer to check the processor id directly. Remove the version
check.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index ae98a2fbfca..b5b30f0f38f 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -98,11 +98,6 @@ static RaspiProcessorId board_processor_id(uint32_t board_rev)
     return proc_id;
 }
 
-static int board_version(uint32_t board_rev)
-{
-    return board_processor_id(board_rev) + 1;
-}
-
 static const char *board_soc_type(uint32_t board_rev)
 {
     return soc_property[board_processor_id(board_rev)].type;
@@ -201,7 +196,8 @@ static void reset_secondary(ARMCPU *cpu, const struct arm_boot_info *info)
     cpu_set_pc(cs, info->smp_loader_start);
 }
 
-static void setup_boot(MachineState *machine, int version, size_t ram_size)
+static void setup_boot(MachineState *machine, RaspiProcessorId processor_id,
+                       size_t ram_size)
 {
     RaspiMachineState *s = RASPI_MACHINE(machine);
     int r;
@@ -210,12 +206,13 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
     s->binfo.ram_size = ram_size;
     s->binfo.nb_cpus = machine->smp.cpus;
 
-    if (version <= 2) {
-        /* The rpi1 and 2 require some custom setup code to run in Secure
-         * mode before booting a kernel (to set up the SMC vectors so
-         * that we get a no-op SMC; this is used by Linux to call the
+    if (processor_id <= PROCESSOR_ID_BCM2836) {
+        /*
+         * The BCM2835 and BCM2836 require some custom setup code to run
+         * in Secure mode before booting a kernel (to set up the SMC vectors
+         * so that we get a no-op SMC; this is used by Linux to call the
          * firmware for some cache maintenance operations.
-         * The rpi3 doesn't need this.
+         * The BCM2837 doesn't need this.
          */
         s->binfo.board_setup_addr = BOARDSETUP_ADDR;
         s->binfo.write_board_setup = write_board_setup;
@@ -223,10 +220,10 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
         s->binfo.secure_boot = true;
     }
 
-    /* Pi2 and Pi3 requires SMP setup */
-    if (version >= 2) {
+    /* BCM2836 and BCM2837 requires SMP setup */
+    if (processor_id >= PROCESSOR_ID_BCM2836) {
         s->binfo.smp_loader_start = SMPBOOT_ADDR;
-        if (version == 2) {
+        if (processor_id == PROCESSOR_ID_BCM2836) {
             s->binfo.write_secondary_boot = write_smpboot;
         } else {
             s->binfo.write_secondary_boot = write_smpboot64;
@@ -260,7 +257,6 @@ static void raspi_machine_init(MachineState *machine)
     RaspiMachineClass *mc = RASPI_MACHINE_GET_CLASS(machine);
     RaspiMachineState *s = RASPI_MACHINE(machine);
     uint32_t board_rev = mc->board_rev;
-    int version = board_version(board_rev);
     uint64_t ram_size = board_ram_size(board_rev);
     uint32_t vcram_size;
     DriveInfo *di;
@@ -301,7 +297,8 @@ static void raspi_machine_init(MachineState *machine)
 
     vcram_size = object_property_get_uint(OBJECT(&s->soc), "vcram-size",
                                           &error_abort);
-    setup_boot(machine, version, machine->ram_size - vcram_size);
+    setup_boot(machine, board_processor_id(mc->board_rev),
+               machine->ram_size - vcram_size);
 }
 
 static void raspi_machine_class_common_init(MachineClass *mc,
-- 
2.26.2


