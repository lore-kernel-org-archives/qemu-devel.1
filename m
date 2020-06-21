Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95A0C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 12:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951EB248EC
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 12:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdFJ95ov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951EB248EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmzPn-0006rC-QM
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 08:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmzOT-000565-P6
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 08:48:17 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:46046)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmzOS-0002pH-7F
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 08:48:17 -0400
Received: by mail-wr1-x42d.google.com with SMTP id c3so13946160wru.12
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 05:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8b3HXRDRgYc7wWaPey7dft5cQmLY7o7QcJ77viT780g=;
 b=QdFJ95ov2G/bwgUu2qIl3an5RDd02n7tpfcwCBuq59jVHl/xlE98vwljXu9oUVjumB
 5sOJ5kJ04gJXrrzilgSuIx215hvOnR034TixT6gefoPifrS5SiOAqxekU1Z2BWNoqtAQ
 4SZAywjMS1WS7sqYZ47sDKBq3skvSNsmMBuMaixOiqUv+G6He/bKPV9kJBaSXIDB4Kv5
 AVu54m3jqZ6Ge79GiIusJnfTjJqhp7NpZaLtriZvVWhVOYIrftJDdtZhZHO58JtwyUyn
 63YJm4ZXsGUQ6dM8ZH1DWZrUH2sDZR+VIU9y35iROpqNtMa7DLONFFjwwaCYoaa5Xe7a
 DVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8b3HXRDRgYc7wWaPey7dft5cQmLY7o7QcJ77viT780g=;
 b=Kxtw9bauXqL/LZOumn4CcK6P2KfIFY4x6mSpdx7sWgGtz3zUqBn/KCXRbAFOzpSugt
 a9gEaA7KVc7082oyeTk9EcL1lMsich36bYP0q9cnicbwU4geHYVoePTHGm9yOHGlqijd
 IkTex7ejjcsr+EJNCGKtnMttzcV7gpFCRr5rGPDTpzfd4h6u0/XHtL3UKZ0y33GGl0c3
 ym+6t7SPOkxkiMLljWQP7iUENhVhPdvo8TzBDdm1k4zV1PughtkAIZ+Qd2uaqFEK0vPy
 MtINMzkjKXEKVZSD7EQITmdCldGVHHjt9z2PKrU8k3gLHxolqNvcRGm6RJCrNAMo+fuf
 n/Bw==
X-Gm-Message-State: AOAM530D9s9WGOacyuaPNuafCggO9n847VvzhNopyG5hDtQZ3QMcaJHp
 s/mMOCOWCX6JFIqKL+K9+0ZAj6VP
X-Google-Smtp-Source: ABdhPJwZcU55jIxaqTgSqxEJIXY5PQ7rV81voWWmo3FlyVx5VK6go+YL8h2O/C8XJv/t+tkMGAlPbw==
X-Received: by 2002:a5d:554a:: with SMTP id g10mr14195802wrw.334.1592743694715; 
 Sun, 21 Jun 2020 05:48:14 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o10sm13779362wrj.37.2020.06.21.05.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2020 05:48:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/15] hw/sh4: Extract timer definitions to 'hw/timer/tmu012.h'
Date: Sun, 21 Jun 2020 14:47:56 +0200
Message-Id: <20200621124807.17226-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200621124807.17226-1-f4bug@amsat.org>
References: <20200621124807.17226-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extract timer definitions to 'hw/timer/tmu012.h'.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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


