Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD1BC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:13:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4621020679
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="paGx5Wc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4621020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRupt-0002U0-BA
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 06:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRuc7-0001ZU-BH
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:59:31 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35995)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRuc5-0002u2-MU
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:59:31 -0400
Received: by mail-wr1-x443.google.com with SMTP id x7so9843459wrl.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 02:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ytszplYWdJCurTZ0nZEtSvETXq8R68amu9kSJHCX8FE=;
 b=paGx5Wc2/seBuyRGUrNK5HrQu8loNxQ9ND8y3aL2M4GJxy84c1lR1HJwrhh+7Wmbgc
 17mqCiSIocR/KlZsM1cdC48oH4UzLWKI5YYLEluO/lRTmnt/oQhcP2fSoOIf38kOt7JH
 h3DiNr77C5tU/0jZmoKPLT87/gNErTiKP1uWqziVnY74+BaBinz6WS0EQgm+LPFPMb27
 Rde/IK6VP17MJMBChRw6qVHEqU0K03wVwXE3jrrJE3mbhoqPJdzQBTTAEdR5Falu8/3d
 Su9qOBvvItpukzMPkMWiHh1QhiEZTdDJdB2+G4/SZnDP7O0Frrqfv2nK8y0DAM7G/xik
 XFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ytszplYWdJCurTZ0nZEtSvETXq8R68amu9kSJHCX8FE=;
 b=ML25isKnW3div5JWVD7mnZ2o0DkKlrabun54dcwJMnBKWAn3d8VfmpN5VZDKHkTa6S
 cfzLw4zaT8wBZwLs1gKUBN+DU1imiaqh2//xefGCrR6iZOIoeL1q9YrcuOxfmwD9zxjQ
 WFMcNNB22lddwtjyHITN/pxKv29KousJBBuW6lEenRAqEYQOOk+Ax/eJih3aa4uiN1HS
 DKPbv2ONj0OE5erwUEc2G7RQ2JpFUkDalkaZ0VO/GZu/vRROy0sbiju3/4Z9tdXy3s58
 T3A8bK4/u0Wgz7z+hRxVyhFYnGR0txucAVjKl7lLOuPPGckYevlWzMHX05Isa+/StQwj
 HQHw==
X-Gm-Message-State: AOAM531B/F6EHUxYvc3yB/HIbCIKQ6YNLbvd24xR854n3w3X2n7WNwK5
 Dnb6x2HmjikRn/dSAEqMRlYQm1WMkNY=
X-Google-Smtp-Source: ABdhPJzGiUsE7pndCQl3jM+RcxaMRu5BR5mc29hTNJrP+yBUiT/JEMr4O7aNFi0yGes3+u41yYkY3w==
X-Received: by 2002:a5d:4802:: with SMTP id l2mr28098268wrq.282.1602496768207; 
 Mon, 12 Oct 2020 02:59:28 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id u195sm638354wmu.18.2020.10.12.02.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 02:59:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 16/21] hw/mips/jazz: Correct CPU frequencies
Date: Mon, 12 Oct 2020 11:57:59 +0200
Message-Id: <20201012095804.3335117-17-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012095804.3335117-1-f4bug@amsat.org>
References: <20201012095804.3335117-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Magnum 4000PC CPU runs at 100 MHz, and the Acer PICA-61
CPU at ~134 MHz.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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


