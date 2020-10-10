Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE808C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C2F5207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bljb66ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2F5207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRLs3-00033Q-95
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 16:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLiQ-0000ns-9a
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:42 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33555)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLiN-0007Uz-Up
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:41 -0400
Received: by mail-wr1-x444.google.com with SMTP id b8so948495wrn.0
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 13:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=crjYYD4P+lnaJnfeybGjxAMeoUk/QLrgHry0qh2t00w=;
 b=bljb66qlEMrnI2MP9QhMcKhZYwQ7Nc/5IoncdzIis/27SIUCG/UN15GpbALx1CeUvO
 QJQMbvRuW0l+PlOcNzao93IHGaYBx12Mz6k5kChpkjrkpkyRB4UPXCSApQfCNGSrYoYs
 Z0uKyu+aEOz4sjZhtZGbMRluS5HZjo/VG7nOMRYwkTikUhkyb5wi9OZOsNg8jjhK4QSy
 s/Rd4tdJRv3biZlI02s8XLCY+f6caS0dgbBPyn6wdXpdM+OBE4b/gNk+tCW3RlQoShUI
 XCEirtBM/KJCrFYePX9+Td7kCsJWTUMQ+soXC0ShUCyGeyJh3+J8sMQwFgd6otDBtImZ
 dz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=crjYYD4P+lnaJnfeybGjxAMeoUk/QLrgHry0qh2t00w=;
 b=X0wxIR4SJrIwdJSmI3jhWJZjSJg5asdBstd6FwiaOHtn6YxQkIbTBTib/CDK9EfZyR
 0ihkhtZFaRWkzQ25e55aySFLvf0hguiQEPpUiq4qa+9cpdPw67NiTwoIeO1fjVYBfPgb
 Txs7o3wOp0wK2/teDIJ41ruINhXRxHmUR1wJyF87shp/GjeowAnu5fgfTNMgNM19wojX
 LK5AGEW2Mdy29mSH7QHrznGFdxKSPFq8049cXDcEMtk27sKuUBv83YSWujvOGauKUmd/
 WusVqO6ZRlsb4n+hte5uRb04ATUsbiXDbFnHQEEktRTXvod4WcSwEyeYdFtpQPvvGtlr
 3cqQ==
X-Gm-Message-State: AOAM532K7mKlsFbSfDAo29Zbf+3Sg3sq2VamcqPpcNXKRV8PhETAHrd0
 98qbLrSZ0MyP1KhrZjW6Nkaa76N+qhM=
X-Google-Smtp-Source: ABdhPJwPl5P6fDkB+GPoCkNtkTkZ6kzz4XvqBX+c4WS/ALQGcVCHrB3NJhvWMQQ5Zo+pDhTU3iN0nA==
X-Received: by 2002:adf:8b92:: with SMTP id o18mr21949487wra.54.1602362618472; 
 Sat, 10 Oct 2020 13:43:38 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 205sm2705471wme.38.2020.10.10.13.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 13:43:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/20] hw/mips/r4k: Explicit CPU frequency is 200 MHz
Date: Sat, 10 Oct 2020 22:43:11 +0200
Message-Id: <20201010204319.3119239-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010204319.3119239-1-f4bug@amsat.org>
References: <20201010204319.3119239-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since its introduction in commit 6af0bf9c7c3,
the 'r4k' machine runs at 200 MHz.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/r4k.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/mips/r4k.c b/hw/mips/r4k.c
index 3487013a4a1..e64687b505a 100644
--- a/hw/mips/r4k.c
+++ b/hw/mips/r4k.c
@@ -37,6 +37,7 @@
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
 #include "qemu/error-report.h"
+#include "hw/qdev-clock.h"
 
 #define MAX_IDE_BUS 2
 
@@ -184,6 +185,7 @@ void mips_r4k_init(MachineState *machine)
     int bios_size;
     MIPSCPU *cpu;
     CPUMIPSState *env;
+    Clock *cpuclk;
     ResetData *reset_info;
     int i;
     qemu_irq *i8259;
@@ -193,7 +195,11 @@ void mips_r4k_init(MachineState *machine)
     int be;
 
     /* init CPUs */
-    cpu = MIPS_CPU(cpu_create(machine->cpu_type));
+    cpu = MIPS_CPU(object_new(machine->cpu_type));
+    cpuclk = clock_new(OBJECT(machine), "cpu-refclk");
+    clock_set_hz(cpuclk, 200000000); /* 200 MHz */
+    qdev_connect_clock_in(DEVICE(cpu), "clk-in", cpuclk);
+    qdev_realize(DEVICE(cpu), NULL, &error_abort);
     env = &cpu->env;
 
     reset_info = g_malloc0(sizeof(ResetData));
-- 
2.26.2


