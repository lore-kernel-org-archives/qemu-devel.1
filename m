Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BB0C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:21:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49BBC20714
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpSQevVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BBC20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTn5Q-0001MJ-FW
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmox-0002f0-HU
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:04:31 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:37876)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmow-0003nN-6U
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:04:31 -0400
Received: by mail-wr1-x42b.google.com with SMTP id h7so6603838wre.4
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JLqgqbu6mCeu1jSTXbJurpmL7Y1M4T4XCrJGTCpmUp4=;
 b=QpSQevVZUtIiqmG2Ftmfz6mCK/Q5bS1BCmBiXIYM6R3YIaopkI5gfx4sr18xw5mbQ8
 fRRbLKW2yUypz4GvfhXjLfVEwihacOlFe1V+38uIZDKZVVHijB8ejfxR02135A5x3aST
 gwhK3iyDldh99ovkiYUyWMPM/oxmSIKvB2PKFMt8PWYHpo5YWI7sZlTdmrM7Z5DZiUcr
 2iXiibWQxrhIWZZSSDdws4yKKkNKdklki7VJ0fB4y4Osail5hHhmxwhuQq7mQ3FpYQYp
 9b85chWBuk2Z/XsW0fpYIh9AlX71DpNDxWtrXr0MQuLDfVu+9eUbidSueg+TU54EszpS
 qkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=JLqgqbu6mCeu1jSTXbJurpmL7Y1M4T4XCrJGTCpmUp4=;
 b=JBmCgRZwtBNUx19Ip1iX+UuZGUUixrX4skClwa71okhrM6z2keQjlJiK26QSp6Nbwy
 ENjp7LRhRqjhGkXau+PM+1hBjdH8EHD85LWkyiz/yZg4YkKDn74HJMyjbhdXpoDWrNmQ
 50JrlAarpWNNwMDLFzQaXe1JcPrjH9QsAiD0sXuUpe33U3GnK/w8ts0axW5vUrAxbPlb
 zx72OUNPIc8GQ1gcqbrJXr9BCtSPKbUtEDkVWP4/r9X6ZVru6fsbuDC6MNWOPF15fQn0
 wIkmXltIuhdGGq/D3gJ+CHaZKe96p6u8l48hVZgeUiro5+nvj5gJQ2F3uoad8ATqTUJk
 grCQ==
X-Gm-Message-State: AOAM532pNfdLVxVHJg0SSyHmHNa0VeclsC7bEbLiH9Cdvlnzht0hsU6S
 sx6APv978WSBzcf0VIZ6yfuWjGfykWc=
X-Google-Smtp-Source: ABdhPJwUC01eHf5jX2kvTvmW6gS3Icm+qqw5GMPL29mMR43//3XsrFJa7bS7LD/T1DQP9IuiD34w8A==
X-Received: by 2002:adf:ec50:: with SMTP id w16mr10241641wrn.265.1602943468726; 
 Sat, 17 Oct 2020 07:04:28 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id s11sm8853952wrm.56.2020.10.17.07.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:04:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/44] hw/mips/r4k: Explicit CPU frequency is 200 MHz
Date: Sat, 17 Oct 2020 16:02:21 +0200
Message-Id: <20201017140243.1078718-23-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42b.google.com
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

Since its introduction in commit 6af0bf9c7c3,
the 'r4k' machine runs at 200 MHz.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201012095804.3335117-14-f4bug@amsat.org>
---
 hw/mips/r4k.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/mips/r4k.c b/hw/mips/r4k.c
index 3487013a4a1..39bc626e7c5 100644
--- a/hw/mips/r4k.c
+++ b/hw/mips/r4k.c
@@ -13,6 +13,7 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
+#include "hw/clock.h"
 #include "hw/mips/mips.h"
 #include "hw/mips/cpudevs.h"
 #include "hw/intc/i8259.h"
@@ -182,6 +183,7 @@ void mips_r4k_init(MachineState *machine)
     MemoryRegion *isa_io = g_new(MemoryRegion, 1);
     MemoryRegion *isa_mem = g_new(MemoryRegion, 1);
     int bios_size;
+    Clock *cpuclk;
     MIPSCPU *cpu;
     CPUMIPSState *env;
     ResetData *reset_info;
@@ -192,8 +194,11 @@ void mips_r4k_init(MachineState *machine)
     DriveInfo *dinfo;
     int be;
 
+    cpuclk = clock_new(OBJECT(machine), "cpu-refclk");
+    clock_set_hz(cpuclk, 200000000); /* 200 MHz */
+
     /* init CPUs */
-    cpu = MIPS_CPU(cpu_create(machine->cpu_type));
+    cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk);
     env = &cpu->env;
 
     reset_info = g_malloc0(sizeof(ResetData));
-- 
2.26.2


