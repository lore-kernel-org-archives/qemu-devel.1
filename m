Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FFAC2D0EC
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 21:31:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 638ED206C3
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 21:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M39Doopr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638ED206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNkCp-000586-Kg
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 17:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNkAr-0001nG-5i
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 17:29:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNkAp-0006lJ-Ug
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 17:29:53 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39534)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNkAp-0006kp-Of; Sun, 12 Apr 2020 17:29:51 -0400
Received: by mail-wm1-x341.google.com with SMTP id y24so8277577wma.4;
 Sun, 12 Apr 2020 14:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9lG55JXMQua8faxEthIzl+F4nOkWKVo0aZHxcdKHaR4=;
 b=M39Dooprl3wwdtg2b5n978XBAC/jF0BInH3Bg7/oC0gnyGhXOoEfEcSBWZRu4SzdxL
 HPdd7U1QCUPcWaZGjRvCbbPuA85YbcXG2nM1DNxghcrC1HwS4z9it5p4A9wpxbwTYpwQ
 rrFf3mwiHuQSRTYpc5Nih5oqTQEhLl7mp0EgCfE4mwUddJAcfZx4Y44DD4WfzKc8KYmX
 R+A33+zXqxhX12Eg0U8UIA4XkJXjkEeTqBH77cG/O5cQ7UTMnASQaAy7OB+anXNGIypT
 7cdXEU0FWVIBZwQ/lGjVrwihiMz0+vUo2N7u6YA6mzBMDjR+lJBDThplXzzJKZf58U4W
 tY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9lG55JXMQua8faxEthIzl+F4nOkWKVo0aZHxcdKHaR4=;
 b=Kgl/A4o7ybPqZurF1/Gn6kwC1HeVMl/HjNuQBIGIh9dXVAobYzY63K+rZ+Tz2XIs3k
 dTQg99xmxfqoZriESIPvpYFqEepseAF62HyZP2VllY7vqk2DHl+5FxM99KTcxP4wHsBX
 xtkixoHE5cJgrkSq143j2XmuRgzGulbaLwyyK3NIzVTHvVPVuLB7EJzBmD4AASuKTL3w
 8CCO2Sj3fGouZHRHrX/BZIv+qzRtvJg2dnTIWH17vlKmY6F0QHn2Yf0I14WuW18oysGh
 GomrxkovUYpuvZpMs+ks06FM4k+K815Tw4tI58jAuOggB+IRl7Yzxa1yW+9IoheUIYb5
 grJQ==
X-Gm-Message-State: AGi0PuakwOCPdIINE7LR96iQZQ+//QgOz8Heck0BXVDchh0ho4KTwLoE
 KPKWE+M9TpI2mUTC5IZuaoH8OKJfs/U=
X-Google-Smtp-Source: APiQypJc13zYA2Q3cYQT/I1V6ApoG6BuwgCFN3OnrUudz63oz3i+ZdxN2eJgQjk0NZd6VxBKVyzbVw==
X-Received: by 2002:a1c:4346:: with SMTP id q67mr15311842wma.162.1586726990649; 
 Sun, 12 Apr 2020 14:29:50 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id r3sm12797798wrm.35.2020.04.12.14.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 14:29:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0? 3/3] hw/openrisc/pic_cpu: Use qdev gpio rather than
 qemu_allocate_irqs()
Date: Sun, 12 Apr 2020 23:29:43 +0200
Message-Id: <20200412212943.4117-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412212943.4117-1-f4bug@amsat.org>
References: <20200412212943.4117-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Stafford Horne <shorne@gmail.com>, John Snow <jsnow@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch to using the qdev gpio API which is preferred over
qemu_allocate_irqs(). Doing so we also stop leaking the
allocated memory. One step to eventually deprecate and
remove qemu_allocate_irqs() one day.

Patch created mechanically using spatch with this script
inspired from commit d6ef883d9d7:

  @@
  typedef qemu_irq;
  identifier irqs, handler;
  expression opaque, count, i;
  @@
  -   qemu_irq *irqs;
      ...
  -   irqs = qemu_allocate_irqs(handler, opaque, count);
  +   qdev_init_gpio_in(DEVICE(opaque), handler, count);
      <+...
  -   irqs[i]
  +   qdev_get_gpio_in(DEVICE(opaque), i)
      ...+>
  ?-  g_free(irqs);

Inspired-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/openrisc/pic_cpu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/openrisc/pic_cpu.c b/hw/openrisc/pic_cpu.c
index 36f9350830..4b0c92f842 100644
--- a/hw/openrisc/pic_cpu.c
+++ b/hw/openrisc/pic_cpu.c
@@ -52,10 +52,9 @@ static void openrisc_pic_cpu_handler(void *opaque, int irq, int level)
 void cpu_openrisc_pic_init(OpenRISCCPU *cpu)
 {
     int i;
-    qemu_irq *qi;
-    qi = qemu_allocate_irqs(openrisc_pic_cpu_handler, cpu, NR_IRQS);
+    qdev_init_gpio_in(DEVICE(cpu), openrisc_pic_cpu_handler, NR_IRQS);
 
     for (i = 0; i < NR_IRQS; i++) {
-        cpu->env.irq[i] = qi[i];
+        cpu->env.irq[i] = qdev_get_gpio_in(DEVICE(cpu), i);
     }
 }
-- 
2.21.1


