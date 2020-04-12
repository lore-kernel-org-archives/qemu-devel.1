Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CC7C2D0EC
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 21:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A62206C3
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 21:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVimAW8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A62206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNkBp-0003Lr-Jx
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 17:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNkAp-0001lZ-I6
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 17:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNkAo-0006kB-Fm
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 17:29:51 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55609)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNkAo-0006jD-A5; Sun, 12 Apr 2020 17:29:50 -0400
Received: by mail-wm1-x341.google.com with SMTP id e26so7840227wmk.5;
 Sun, 12 Apr 2020 14:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0Gwk+omGQ520vgI5+JQYZuT2VgvX+0dicPgG2UZcDzk=;
 b=eVimAW8LJ/3xN40DXev6aOL40qLrsVif/IsVb6ny9/OwZqDC+VMIn70ECpdnTN3uQP
 F+Xoxh4izpZsb0+NLHgvxk52FzjcDsA52BYsZKrYCTVhwjhV7Z7AZ9CKN1zzWLFOBp+V
 PIf9Inf9RzZTxq3ClaKllBmEkeP6h2mfm5nJRPVQl1rJ+7uEvwx2iZNo8enFaF4vm3l8
 rgsVHfGeor8XCC/UlxbUqg+Ktxbqwi/0N4GElg0l4HH0VxB3FO5PuMqgPx5ZuWOH2n2x
 psIe7nyIMEqKO6lF0cGuSXfMteMM9c6hWBL3YTZv+Uh2cjkBNMWYdlGUTHM1HRKMsNA8
 Zasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0Gwk+omGQ520vgI5+JQYZuT2VgvX+0dicPgG2UZcDzk=;
 b=X5TNt+31ZXHAml+0dskDQZH4PFt4fHXKtYCzs/07uBV0tSJcvHLotnmUCzq9oi4Mxl
 j23wWt1UudVZc0JyeTQhAfgqXoh0CQ6iu1yJmWgaaAMDRUk7uNWmVXjhTUAhfW8Z0eTv
 DmFq9N0VLDh7pCT45MkGbkhNb8W/+av3y5EOI00H6PpiG3bC6+PTE+Lj4tBd0vY7cbEY
 b7PC9DZr+ncK+ZwK189pTPUApBjAlkmmOBcTEjQteMheZy9oATA/HqvAxAiiShubZDOS
 j47PhTnbRUphTRg0K3nkGzoyO+OLcaOSUNQdGaFh6JYsLigoNGYqShZF0C1/6WoYYk73
 8bkw==
X-Gm-Message-State: AGi0Pub91yTgiPkkRbihQsqvkIpUUrsVwMQsWynfJVGIaWpm94lezGa2
 YITRnTawW56H5zvCTpxSS2vM/YUXMhc=
X-Google-Smtp-Source: APiQypKfJyIo22oyMsO5+U7aw2dN66I1B2tx9eKMzXjP+oytyf38uq2SIyrHTIR3W8qlyCFOBBHtew==
X-Received: by 2002:a1c:750a:: with SMTP id o10mr15561640wmc.161.1586726989044; 
 Sun, 12 Apr 2020 14:29:49 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id r3sm12797798wrm.35.2020.04.12.14.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 14:29:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 2/3] hw/mips/mips_int: Use qdev gpio rather than
 qemu_allocate_irqs()
Date: Sun, 12 Apr 2020 23:29:42 +0200
Message-Id: <20200412212943.4117-3-f4bug@amsat.org>
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
qemu_allocate_irqs(). One step to eventually deprecate and
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
 hw/mips/mips_int.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
index 796730b11d..91788c51a9 100644
--- a/hw/mips/mips_int.c
+++ b/hw/mips/mips_int.c
@@ -74,14 +74,12 @@ static void cpu_mips_irq_request(void *opaque, int irq, int level)
 void cpu_mips_irq_init_cpu(MIPSCPU *cpu)
 {
     CPUMIPSState *env = &cpu->env;
-    qemu_irq *qi;
     int i;
 
-    qi = qemu_allocate_irqs(cpu_mips_irq_request, cpu, 8);
+    qdev_init_gpio_in(DEVICE(cpu), cpu_mips_irq_request, 8);
     for (i = 0; i < 8; i++) {
-        env->irq[i] = qi[i];
+        env->irq[i] = qdev_get_gpio_in(DEVICE(cpu), i);
     }
-    g_free(qi);
 }
 
 void cpu_mips_soft_irq(CPUMIPSState *env, int irq, int level)
-- 
2.21.1


