Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A72C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 09:26:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F22EB20776
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 09:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="um8v3+Dd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22EB20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jexlB-0007BT-5U
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 05:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jexhy-0001sf-DH; Sat, 30 May 2020 05:23:14 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39053)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jexhx-00073h-MP; Sat, 30 May 2020 05:23:14 -0400
Received: by mail-wr1-x443.google.com with SMTP id t18so6523183wru.6;
 Sat, 30 May 2020 02:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x/ui/6hiuSayket0J96oy+kLHg0tt3mLVhvixsodYW0=;
 b=um8v3+Dd2KssLmx6pYBCgJU14zYOASxo3H4iNKP8Rio/pTSL1fjkUHjWm1yt/BevUz
 2YTRC8br/waG81YkfrE8V/V9k4nICGo8K7iQ00ZXy+G7o3J29TLsBEUcnGtwCORvlxiV
 TIx7XuggmAHV56X5cBleliZqsknRV1HmToLbfNpxEOqV7cWggHwePH7JQAWvrNkpV3xh
 n+pRL+BLswwJTRlQQ60YgUbWsn9RGL1C0DyWu1PkuFO0fjvTMueX0XtNQqyN7xOVaZlX
 94mNqu8EOKvTDRVBExD/6Sx6s4ev65Yq9P+WJZlyHnWGXeq7X9c3VZ1d3KrGAOfwJamQ
 XWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=x/ui/6hiuSayket0J96oy+kLHg0tt3mLVhvixsodYW0=;
 b=kgks5GI39kcyvXRlggSpm47ZJ6jz9DelNNbLCTlH6rllDzxrDFTWu8S3651MI1myn3
 MRjkzliYLYxRnSQDqCaBNeEXJOMFHHhy8aLHn81tW10NETvVmazUaXXiQyq165huHdc8
 p/hj0arIGB813Se2yrlktv1O1Zoe9X6vQBLgLWGezSC0pCZnJYfUmO+iUbQN+cgRgZPt
 KYZzvRDLU4JDjpiKu4hyElHYrtola7MW/n4YIqy1kuonAaNzZTP0MWS+umgs3DC47GBv
 qMRF/cOJzx7pVjzxI5JPDY3bfxrD2DGttKmDf3aCLCLR9BjPwBwZmp2F2lS5yPt69A74
 ufHQ==
X-Gm-Message-State: AOAM532nSZaV/4wG8U0Q1++YGaSdjmy9wBtckOFa3TwROZGKgsmGSyFU
 G7PXBZaVkgNhgaYwwMYhgFp3RCb3
X-Google-Smtp-Source: ABdhPJxu+VHGb0r79htUMzeHpP0H+TRHjR2FYAs2e8aRekxZY8IMhaktkxg0mqnVaEIhwph40sYA7w==
X-Received: by 2002:a05:6000:10d2:: with SMTP id
 b18mr12522203wrx.366.1590830591718; 
 Sat, 30 May 2020 02:23:11 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id h1sm3195237wme.42.2020.05.30.02.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2020 02:23:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] hw/sh4: Extract timer definitions to 'hw/timer/tmu012.h'
Date: Sat, 30 May 2020 11:23:03 +0200
Message-Id: <20200530092306.26628-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200530092306.26628-1-f4bug@amsat.org>
References: <20200530092306.26628-1-f4bug@amsat.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extract timer definitions to 'hw/timer/tmu012.h'.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200504081653.14841-3-f4bug@amsat.org>
---
 include/hw/sh4/sh.h       |  9 ---------
 include/hw/timer/tmu012.h | 23 +++++++++++++++++++++++
 hw/sh4/sh7750.c           |  1 +
 hw/timer/sh_timer.c       |  2 ++
 4 files changed, 26 insertions(+), 9 deletions(-)
 create mode 100644 include/hw/timer/tmu012.h

diff --git a/include/hw/sh4/sh.h b/include/hw/sh4/sh.h
index fe773cb01d..93f464bf4c 100644
--- a/include/hw/sh4/sh.h
+++ b/include/hw/sh4/sh.h
@@ -27,15 +27,6 @@ typedef struct {
 
 int sh7750_register_io_device(struct SH7750State *s,
 			      sh7750_io_device * device);
-/* sh_timer.c */
-#define TMU012_FEAT_TOCR   (1 << 0)
-#define TMU012_FEAT_3CHAN  (1 << 1)
-#define TMU012_FEAT_EXTCLK (1 << 2)
-void tmu012_init(MemoryRegion *sysmem, hwaddr base,
-                 int feat, uint32_t freq,
-		 qemu_irq ch0_irq, qemu_irq ch1_irq,
-		 qemu_irq ch2_irq0, qemu_irq ch2_irq1);
-
 
 /* sh_serial.c */
 #define SH_SERIAL_FEAT_SCIF (1 << 0)
diff --git a/include/hw/timer/tmu012.h b/include/hw/timer/tmu012.h
new file mode 100644
index 0000000000..808ed8de1d
--- /dev/null
+++ b/include/hw/timer/tmu012.h
@@ -0,0 +1,23 @@
+/*
+ * SuperH Timer
+ *
+ * Copyright (c) 2007 Magnus Damm
+ *
+ * This code is licensed under the GPL.
+ */
+
+#ifndef HW_TIMER_TMU012_H
+#define HW_TIMER_TMU012_H
+
+#include "exec/hwaddr.h"
+
+#define TMU012_FEAT_TOCR   (1 << 0)
+#define TMU012_FEAT_3CHAN  (1 << 1)
+#define TMU012_FEAT_EXTCLK (1 << 2)
+
+void tmu012_init(MemoryRegion *sysmem, hwaddr base,
+                 int feat, uint32_t freq,
+                 qemu_irq ch0_irq, qemu_irq ch1_irq,
+                 qemu_irq ch2_irq0, qemu_irq ch2_irq1);
+
+#endif
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index d660714443..f8ac3ec6e3 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -30,6 +30,7 @@
 #include "sh7750_regs.h"
 #include "sh7750_regnames.h"
 #include "hw/sh4/sh_intc.h"
+#include "hw/timer/tmu012.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 
diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
index 13c4051808..b9cbacf5d0 100644
--- a/hw/timer/sh_timer.c
+++ b/hw/timer/sh_timer.c
@@ -9,10 +9,12 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/memory.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sh4/sh.h"
 #include "qemu/timer.h"
+#include "hw/timer/tmu012.h"
 #include "hw/ptimer.h"
 
 //#define DEBUG_TIMER
-- 
2.21.3


