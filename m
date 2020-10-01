Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4058C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:05:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C97B207DE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mg6QWscX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C97B207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO09I-0002GD-LV
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsi-0005Nd-UA
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:29 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:34170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsg-00031w-Ne
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:28 -0400
Received: by mail-wr1-x42f.google.com with SMTP id t10so6135149wrv.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 07:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=MXn7GPNB0G2xDNlS9e9pEhshZeJq6tfNJlqpKjovYoA=;
 b=Mg6QWscXZCnAVSAtJIDqDPmrKifDYscXYB9mlkHBn08cStoy+4AUueT2vkZdnTE5mA
 nTB53a60uXBGI2h5oVeu2XLLtU5Pz3lVQrHL4bTr5PloaziXlCj3QUl2IlITnaYns2EZ
 yiiSSqfrTAHdY1hyv67eLseF49+vXCRf/w+bg5WmJkuWkI5ewY6HQrLkp4LJ1e9z3p6m
 kEBkJUM6m8cFRfMS7Upwn3C7mzxRuuopzNyW7TuZb0cx/frEFlVlkXjkCV8V+DCkwXsL
 2IOkNCb1dnT/9X2rvBiV9XY/hecaw6QEGfNn+qfbq/jix5FJx6VbkJ1vMpPG2o4cNLqx
 KqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MXn7GPNB0G2xDNlS9e9pEhshZeJq6tfNJlqpKjovYoA=;
 b=CnFZ4SXI0jsZ9tdKNBt6rXANcM6EmPljuZ6hlgeuEILmOtUU5a3byTmnk/TIO6iU1o
 U3ajC+/pvqA1CmVrLzI6ldY7/oVdCaTDP3K1qOlqXGzrRjiwaVhUGTqTPYVPC0nwIhWu
 rb1A/BwaFv+rI7HuBUY+Q+QEf4pbu5jUg6RwtZAjztOguY8vQAv/JjB/TKqcWhyKpShj
 YCXvfqD/V/9oAf/PSJrY2rvzpdVIukwhqQk4GWhtc2aJ40BYHq34e6PPoOqhuuqLEhph
 tsmcntKJJCYAHGNSHokyf2x980IRgBb5eZ+IFnZalSD6PQbhVfBzejeMKmKAR2yE8F4E
 69ZA==
X-Gm-Message-State: AOAM531/jp3EdGuLNR7PRcgLmFonutmIymd8i9gOjL3z7lcuYUG5Lpj4
 osS0OXdAEPIjrf0c4NCY3jWPQzMzKxR/R0wn
X-Google-Smtp-Source: ABdhPJxhraQVbVmwxc1FmiNRTNOP5DQUrhdxMr7mrV6mD7xmndeWAo8i3OkvTkcYUCnW0q+BW71kNw==
X-Received: by 2002:adf:f34a:: with SMTP id e10mr9365472wrp.91.1601563705121; 
 Thu, 01 Oct 2020 07:48:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 70sm342052wme.15.2020.10.01.07.48.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 07:48:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/18] hw/arm/raspi: Remove use of the 'version' value in the
 board code
Date: Thu,  1 Oct 2020 15:47:59 +0100
Message-Id: <20201001144759.5964-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201001144759.5964-1-peter.maydell@linaro.org>
References: <20201001144759.5964-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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
Message-id: 20200924111808.77168-9-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.20.1


