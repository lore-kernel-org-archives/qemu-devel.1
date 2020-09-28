Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F115C4727E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F1CC207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDLiw8je"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1CC207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMwoN-0000oP-2t
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 13:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwko-0004D3-JL
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:16:00 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38591)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwkl-0006MZ-Hb
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:15:57 -0400
Received: by mail-wr1-x441.google.com with SMTP id g4so2213247wrs.5
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 10:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iApW1n40vkvtS8jytEGkpcrFILIgJENgZy4LUSyqrXg=;
 b=SDLiw8jea2tq89tpy+m/5uMIeYyHeJNsNi5WkTfBFZa0qbCJhSrEaI9EPdu/+rmAJh
 Yh7JleH3ByWBy7c7Oc/u9k/u0rMhRWBxXlMTAmEKTBNAvKf3R+mapPLKy3RSQdcpVk/+
 x0Ro/QpTgsP0wF8ewKZT+NdbZqvAAViPdArTZnC6B1vc/aBDW8uo7MKzgH9Pdp559Ryp
 nAoe5Z9xLKS5o913aqK3oDRVT7fBSQXkv+r4kZw1HCXoN9qJgaSG9KTebxYb8CdE4Yjf
 BpcBMFj+geIZscu4Q+u5aqeReX1JX6NQmq9aPLN6aQbHSIwNWKGA4P1I8nnXMUjdngC+
 vIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=iApW1n40vkvtS8jytEGkpcrFILIgJENgZy4LUSyqrXg=;
 b=EcR+CXrVvIH7PIu84kzSGjPz/9gbnhU2qmHE9xAD/qbTck1SPV2oBadISzlDGmBNa5
 m/e0PBES63sFcRJrEwT9tddSdx0055WugsNsCJOtrnYuZshGS7RtlwDvbUujGE04NHFM
 zBNVh/lv+ydeTKaXiBCbcZZ6GvDMmw45UHBgK0mIWnORq++C7fLpKWMGXJmG6NXrZjOq
 heFeKbCi0WrBAYNuysG3wauGLkDbj0rjjfeW7ZR5zYncDWrCC4v5sfnEuydUpdExZjZN
 C54weXRXw5xq9pTyH3J2KO8a7oD2+NmlgBuZirEKaRJF+69RwEuZZffN99o+4t5jaVnQ
 8GPQ==
X-Gm-Message-State: AOAM531tjN+plqe0ULB5fdcsMpEYvzehkW0+2tT0FMvS6zOiDAcxgGtD
 S+PoMV4l45pTYj8+K4679QHmBZRzoBQ=
X-Google-Smtp-Source: ABdhPJzvuoyMLUgb2PyeoyinD7bUhsOwixvRkE7dsdjKgUYIa04osESiEPwaTHaGtw3bMnRMqELGhg==
X-Received: by 2002:a5d:4d01:: with SMTP id z1mr2766829wrt.366.1601313353060; 
 Mon, 28 Sep 2020 10:15:53 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id z67sm464787wme.41.2020.09.28.10.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 10:15:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/16] hw/mips/r4k: Explicit CPU frequency is 200 MHz
Date: Mon, 28 Sep 2020 19:15:30 +0200
Message-Id: <20200928171539.788309-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928171539.788309-1-f4bug@amsat.org>
References: <20200928171539.788309-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199,
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
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
index 3487013a4a1..2aa18203f20 100644
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
+    cpuclk = qdev_init_clock_out(DEVICE(cpu), "cpuclk");
+    clock_set_hz(cpuclk, 200000000); /* 200 MHz */
+    qdev_connect_clock_in(DEVICE(cpu), "clk", cpuclk);
+    qdev_realize(DEVICE(cpu), NULL, &error_abort);
     env = &cpu->env;
 
     reset_info = g_malloc0(sizeof(ResetData));
-- 
2.26.2


