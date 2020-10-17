Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCB5C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 788EC20704
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqHNvVO2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788EC20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTmxj-0007AW-JI
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmpC-000339-Cl
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:04:46 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:35836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmpA-0003ou-Ot
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:04:46 -0400
Received: by mail-wm1-x334.google.com with SMTP id q5so8400700wmq.0
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XmLmCuW1uC91Ho4Ow45XNevc9vvm/zFFsaaxmUUiG5M=;
 b=mqHNvVO2fTMeS3nBKdm4vhleFvgihW6QRu3mUkC5imATa2QZ2zKtKNyFHkR6Ccot2+
 +md8ipYIZm57WNnUPBgSfgg9qi0E0jD6oE295Y8MBqzt7v9H9IOzbWJvyhk7Oud/oc1X
 eMoib9l90CxJtzMpG/VAALC0aK5FkBi8eRG956I5ayjrpZk2UuIQrWfPeVJ40bR+70yV
 BGpXsPc3eTxE5jLjTAeUqUamkjgNgR7Y35CdAoCm8Zzyg5JPXo1+rmfe4tcOY7AZPbmO
 CcjGQmcGwLqSMRQHzqsJ6lCivTjtnw2LmJBf+qzUaNHoHCR79B+k7YbLyoVL1DUSck4s
 HVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=XmLmCuW1uC91Ho4Ow45XNevc9vvm/zFFsaaxmUUiG5M=;
 b=jELkQfnFs411boZ7eRT4FL5KwzXSHggHSFpnqR0b4xTDtKHq8oPwaOMl2Bu53XITvS
 4CD5F+pC6LxOSlxkCFTiqulOTQCvLSGPUuVC3FQHBzfD7Ed8aqZjRPqLUV/PCeOGaITf
 VjuSexR/ZDbhWSf0sZwYscunufLtB/rufON+DmH+rIi0T7gVNPbCsT1N28RCyGZFEiB7
 CjuKqs1MxL+x0IRU9/d9XjNaCfHoLcKMbrXwTuj1LTlE2qDMYQkJ1DMUJ1YgWQE5rA4C
 ckyctiBNmBYw2O05rYI1lkZdqyqDHdxaveSHur/wO4k7z8iBH8sj4xIXJvxCIMh2z7Tb
 r3wg==
X-Gm-Message-State: AOAM532awnEJyL8z2bghBY/9Z5k/b5iFU9vKQ7O+NKMrYbzmyK72GXxB
 wfWBBt8Brv2QuU/g1QInwkRjqnepqAk=
X-Google-Smtp-Source: ABdhPJwj01yC179U9DYlynyObToIbQeXqwPVrPV5r+USZE7Ridb8rpPYLCwGaZB60dbFY1V2tyOFSw==
X-Received: by 2002:a05:600c:2144:: with SMTP id
 v4mr8603091wml.172.1602943482716; 
 Sat, 17 Oct 2020 07:04:42 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id j7sm9226923wrn.81.2020.10.17.07.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:04:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/44] hw/mips/jazz: Correct CPU frequencies
Date: Sat, 17 Oct 2020 16:02:24 +0200
Message-Id: <20201017140243.1078718-26-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Magnum 4000PC CPU runs at 100 MHz, and the Acer PICA-61
CPU at ~134 MHz.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201012095804.3335117-17-f4bug@amsat.org>
---
 hw/mips/jazz.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 47723093b63..8f1ad55ba34 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
+#include "hw/clock.h"
 #include "hw/mips/mips.h"
 #include "hw/mips/cpudevs.h"
 #include "hw/intc/i8259.h"
@@ -142,6 +143,7 @@ static void mips_jazz_init(MachineState *machine,
     MemoryRegion *address_space = get_system_memory();
     char *filename;
     int bios_size, n;
+    Clock *cpuclk;
     MIPSCPU *cpu;
     CPUClass *cc;
     CPUMIPSState *env;
@@ -163,14 +165,25 @@ static void mips_jazz_init(MachineState *machine,
     MemoryRegion *bios2 = g_new(MemoryRegion, 1);
     SysBusESPState *sysbus_esp;
     ESPState *esp;
+    static const struct {
+        unsigned freq_hz;
+        unsigned pll_mult;
+    } ext_clk[] = {
+        [JAZZ_MAGNUM] = {50000000, 2},
+        [JAZZ_PICA61] = {33333333, 4},
+    };
 
     if (machine->ram_size > 256 * MiB) {
         error_report("RAM size more than 256Mb is not supported");
         exit(EXIT_FAILURE);
     }
 
+    cpuclk = clock_new(OBJECT(machine), "cpu-refclk");
+    clock_set_hz(cpuclk, ext_clk[jazz_model].freq_hz
+                         * ext_clk[jazz_model].pll_mult);
+
     /* init CPUs */
-    cpu = MIPS_CPU(cpu_create(machine->cpu_type));
+    cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk);
     env = &cpu->env;
     qemu_register_reset(main_cpu_reset, cpu);
 
-- 
2.26.2


