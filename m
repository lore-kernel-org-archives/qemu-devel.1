Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441ADC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 17:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 887E52246B
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 17:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVKyDzTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887E52246B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRItd-0002K6-H4
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 13:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRIe1-0000lQ-B9
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 13:26:57 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:47076)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRIdz-0003sb-D1
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 13:26:56 -0400
Received: by mail-wr1-x443.google.com with SMTP id n6so13370430wrm.13
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 10:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5FmtWrPGtRrGLQ2kaslyRtSRGaDuo1hSoL/f+YzkQ9M=;
 b=fVKyDzTQal6dpYYSR2lcKtlVlrfWjTZ4AGwFz10B8Go9YJXuhfCRkiGtSJVArfznXr
 Y4IEIoJMk0/VijhvqT8Pc1kIITrw8JN20WEZPGslC4yPEAoEnfSIRqDMfURuOK0iRNsY
 Sc0O3f5kJAn4hl4rsJu3Euu8grmcuXNXNVMnFxgczkPrXcyIDHXExKEwQWWjh94ShW/j
 sSZYi/bGDgRhWqNngq+j58ou/NKjTKk29G9Ofc1bNVTHUrC/5lWpt4VwRmwi+wzRcoeu
 3Wwwg/HxP8qZp8ngBDi2Mj3VGhp7ZLqY5AkHw8B6ZachNPIHQbAQadQSZJj0SrvdYpuB
 vfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=5FmtWrPGtRrGLQ2kaslyRtSRGaDuo1hSoL/f+YzkQ9M=;
 b=I+WCPy/n1fR4GErHzduUI6HPvOvq4kLj/ayyGRTlUCmY7QAOv9iQaD/fT39DGGYMk6
 qkYr9UrLJHivm2LUaseIJpgAQ7qpQ/jsPjqGhSg2k+YfTs55gQUWie770C/jkf23YzN+
 FNFXdFjWUkMplrhg7ofW3RkD5bXYYjWgphj8iMW5/OTPh/fRGTmEb3kKya8fpksg8E2M
 odPfaarKW5twOey27YqFuLVxyVdbhz6PfviVoODcVaDLc2cR4580QF8coWDVTEIr7kUg
 KdFo23mX6QH60VK1IBPdRv8vgmUHw6+FtYIkLbYQ5/wh5wZgLJubSJYnz1NjaxfFIYPM
 yNSw==
X-Gm-Message-State: AOAM530SZ0D5/J7txmC5WKH+3tRYx350x5ha6X/zSfgpwV/F7GwfknXI
 8uTH0r6zdHSgqfRCAyJLH0olmX5uguc=
X-Google-Smtp-Source: ABdhPJyyEPnyPXsxpllYWbrE6qazQJxTUvqTYG0c0yhUamfbqD1XtHAGIQIDRd2LbSU+jmFWqWzWYg==
X-Received: by 2002:adf:d841:: with SMTP id k1mr20957030wrl.227.1602350802958; 
 Sat, 10 Oct 2020 10:26:42 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id i11sm16786068wre.32.2020.10.10.10.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 10:26:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 17/20] hw/mips/boston: Set CPU frequency to 1 GHz
Date: Sat, 10 Oct 2020 19:26:14 +0200
Message-Id: <20201010172617.3079633-18-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010172617.3079633-1-f4bug@amsat.org>
References: <20201010172617.3079633-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Luc Michel <luc@lmichel.fr>,
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The I6400 can run at 1 GHz or more. Create a 'cpuclk'
output clock and connect it to the CPU input clock.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/boston.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 1b3f69e949c..c998140d7bb 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -30,6 +30,7 @@
 #include "hw/mips/cps.h"
 #include "hw/mips/cpudevs.h"
 #include "hw/pci-host/xilinx-pcie.h"
+#include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -54,6 +55,7 @@ struct BostonState {
     MachineState *mach;
     MIPSCPSState cps;
     SerialMM *uart;
+    Clock *cpuclk;
 
     CharBackend lcd_display;
     char lcd_content[8];
@@ -251,10 +253,19 @@ static const MemoryRegionOps boston_platreg_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
+static void mips_boston_instance_init(Object *obj)
+{
+    BostonState *s = BOSTON(obj);
+
+    s->cpuclk = qdev_init_clock_out(DEVICE(obj), "cpuclk-out");
+    clock_set_hz(s->cpuclk, 1000000000); /* 1 GHz */
+}
+
 static const TypeInfo boston_device = {
     .name          = TYPE_MIPS_BOSTON,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(BostonState),
+    .instance_init = mips_boston_instance_init,
 };
 
 static void boston_register_types(void)
@@ -462,6 +473,8 @@ static void boston_mach_init(MachineState *machine)
                             &error_fatal);
     object_property_set_int(OBJECT(&s->cps), "num-vp", machine->smp.cpus,
                             &error_fatal);
+    qdev_connect_clock_in(DEVICE(&s->cps), "clk",
+                          qdev_get_clock_out(dev, "cpuclk"));
     sysbus_realize(SYS_BUS_DEVICE(&s->cps), &error_fatal);
 
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
-- 
2.26.2


