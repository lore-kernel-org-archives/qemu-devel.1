Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FADC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:06:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9302E206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUu304yK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9302E206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiDjx-0002v0-Sb
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 05:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiDfK-0004yW-Sp; Mon, 08 Jun 2020 05:01:58 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56223)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiDfJ-0004JO-VA; Mon, 08 Jun 2020 05:01:58 -0400
Received: by mail-wm1-x341.google.com with SMTP id c71so14514420wmd.5;
 Mon, 08 Jun 2020 02:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x/ui/6hiuSayket0J96oy+kLHg0tt3mLVhvixsodYW0=;
 b=LUu304yKpwfJWEOSX2aMCLLe2wRU5l68mnnTm25Htp2AEU9IdQxvNr8uxQiVAUZU77
 AUKCSGtSCVWaVOzg7g8s82VgQITh05CZRlTsHkQvrDaMw1bg2y9+LhxAoXBEY0UOO6q7
 Ch5dPfau9p3tXuB9/nNQlt1dDRRIH1ewIEnLvbpop6aI3Fjqz9Pc8Y0ViPej/AEr/4Ov
 Wwsbl9Bid3pgGgKuJDUckzLAmeCPVKxwHH93QRUhVm4QdI4mS2/R1OzjH4xjOgq1pLDi
 evAzOY8OOK4itzXlurgfEHPNYAnxt6lUmloAtfF/iCZX/36rNhr0S7e369RL2hEYf/uQ
 e8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=x/ui/6hiuSayket0J96oy+kLHg0tt3mLVhvixsodYW0=;
 b=bFGrENxTUlkMYeaq9TPOgHpOfVqjniUmJ55aAez4JPLasXlLRJGEITfEkTEazdHB/f
 UF9e4cEcz4ETPCLeQDMGrSCB8B++eKkKw2uBJY1FHJ1KjUU0wVeP2Df75MR6SUt2W3Zq
 bdRPl9msoUiBAgFxaC/E5I8XDX3M7wy+E50d/P8l0qRim7c3z+qwQ9ate7fjnOhr6LM4
 /N/O0iNDCgy/nWAs9cBpmFt1t2PnFQUkCscbm7nFVozqQDRdnZaV2v8hNWNNugAA7R/O
 ues+ODs78g2THWP71sP8bLfJIyvJcIdSdskWUHriSmX87MyvQUQwrgM8uSiDJU8qseDL
 K2AQ==
X-Gm-Message-State: AOAM533tsEkozBBdG1kGa4CApsKdY1DJjGNeaMEhi++6e7q+uzxO/45G
 vQWEGBfzU+hADQS1GuNOJC/R/ail
X-Google-Smtp-Source: ABdhPJxHATz+Mks7SXhtSujfUJ5KYJaGlOg1cwidxvMJQl0balj61crhJXKs2GHklMsx35BG0bx2Rw==
X-Received: by 2002:a1c:2e47:: with SMTP id u68mr15919558wmu.45.1591606914776; 
 Mon, 08 Jun 2020 02:01:54 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id t8sm22192989wro.56.2020.06.08.02.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 02:01:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/8] hw/sh4: Extract timer definitions to
 'hw/timer/tmu012.h'
Date: Mon,  8 Jun 2020 11:01:39 +0200
Message-Id: <20200608090142.6793-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608090142.6793-1-f4bug@amsat.org>
References: <20200608090142.6793-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
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


