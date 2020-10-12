Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CC7C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:08:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BB8220776
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2bX4goU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB8220776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRukh-0003we-7u
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 06:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRubr-0001AQ-Ka
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:59:15 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50773)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRubp-0002rj-Dy
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:59:15 -0400
Received: by mail-wm1-x341.google.com with SMTP id 13so16656284wmf.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 02:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=byk2/oSFMnCdpjKrO2EAT/wj1qG+dKg35aVK/7AqGxI=;
 b=b2bX4goUCEc7lJZzyaNl7H3q17UBM1cF9nXYftCPlkgDyhQk7w+imMA1ITEU7HDZXt
 LDavM8k2GjqFFSBcnGlMge+mga1iMYJDZaWoohCf4rfNLLgFnEjQ47UqLv4Fx/pBlbjY
 CQQUb7IW5y+s5s4sjt972xBzikfTlyVtBYBfrlHHRWKBAVfyk2cNr0q/RhtDpY8pR5Fk
 zXS+QgThMa+ZeNSWgGN1x0TwXtTC+0B+Vb+rGRss+aS1KvZevmL1Eee/i02+LtFrfI4o
 k8iKwbKkZm5Askfk/f/w9nnWXazL5u2w6HKr+8713cyAmdOdmEfc3gn/uN+FW8Fbgq/i
 TbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=byk2/oSFMnCdpjKrO2EAT/wj1qG+dKg35aVK/7AqGxI=;
 b=f7Ay2fCg/zU3K9EGXa8C0PyOp4GOEL/f1nkYPISZNep6OuNEcRW07L6Ha2YJJre8D6
 7IqB15d3AVeDOX5l556Iy9DUP2HU/RnDzo3So3go4U7R5ig7AjR3gehai1zoEFBtabkr
 1Ehi195uydPyv0sa12k9M5sTjzHDcdb00bo5CaPXaPMuq4PhuW1rx5DntWbSunAE6A2Q
 hyO3rnhh9cROXRluujsLqlQ+pX+WehjZEa0hz4/w7uJ8itRRstyPytDHq3tcBiXS8lUO
 H7H6BjccbvGM/qJWz7ZrZPtv/QCOck5+9wIhuqUInGxBe2bzScNNbY3KoWWvBWqGLFvG
 UKbQ==
X-Gm-Message-State: AOAM530iaofif/JzPRY+cXnBCk2LsUh7g2saMDMH3lIWXor+PI0N0+Ov
 OyopwZznRGeu65uriFiLt7kUUyiLTrg=
X-Google-Smtp-Source: ABdhPJyC9QNaif9pdTfDJ0nrkHBf+ccTR1+Cn2fPCzL3/9JAUHKrEA0Q0GeUFeWBXTWzzLk/4jBTGg==
X-Received: by 2002:a1c:5583:: with SMTP id j125mr9864324wmb.75.1602496752032; 
 Mon, 12 Oct 2020 02:59:12 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id v8sm23093229wmb.20.2020.10.12.02.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 02:59:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 13/21] hw/mips/r4k: Explicit CPU frequency is 200 MHz
Date: Mon, 12 Oct 2020 11:57:56 +0200
Message-Id: <20201012095804.3335117-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012095804.3335117-1-f4bug@amsat.org>
References: <20201012095804.3335117-1-f4bug@amsat.org>
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

Since its introduction in commit 6af0bf9c7c3,
the 'r4k' machine runs at 200 MHz.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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


