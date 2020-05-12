Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95E4C54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:50:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ECB52078E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xo0nu1MJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ECB52078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYPgk-0003KQ-IV
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 03:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYPeI-0008Vf-TL; Tue, 12 May 2020 03:48:22 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYPeI-0002qk-61; Tue, 12 May 2020 03:48:22 -0400
Received: by mail-wm1-x343.google.com with SMTP id m12so15699524wmc.0;
 Tue, 12 May 2020 00:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gVc4pPl94gT2dO6tZ3Upozb9mh/UUaA4ooVvMaypxfs=;
 b=Xo0nu1MJaLKnDIdmvK/OW5erxX8uoJJL+tEBRaKeV6iXhd2EnBWY1fPVe9o4Ck8u4p
 ByRNW/A/fY4/AiCupJQT5gYoiiM90QkaHeKjfSNDpQTgKv+oaJxdFAQTO2VJZWMMAP5L
 pn/EBpTVCuqgwPVzjqnu1Ndq7NR7Z29sxkS4V9hWEv0DfQAACTB+5wkVTZ6iL6nbHLwV
 u51A3Td2x2gq2Z+lxHNUayxr/skDtNvq76BlH3OL6MVhsdp8ET2um1cEp7Oi40ApimXu
 RrQAbDtCoTEaBjIOtqVv9Ib0EYLFOxljifXnfYRbAlYzZkYBLtbXNiE5KAbFtOSl8u+O
 b3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=gVc4pPl94gT2dO6tZ3Upozb9mh/UUaA4ooVvMaypxfs=;
 b=fCV1qLIG7FoMVRFAmOeuxcYx/5DAMU4Q0h4lbH1uVdAzRBPFuo+K56d3eVRwZgUpeu
 57qvihASVB0rBQwIVmszvD8RFxziH3qsxrYWmxKKCiaI/jV3wVYI0R7bzoWzB20DPa4g
 e+THI+9lAzA7cUF1fZM3rupv6L1MPw2SpgQQvIOdqrKQQ/NJFsV0Bv3CB7jbLeMgB3Gy
 0YkdLgp2OXatlO5cQdDZtEcv1cFxWgvftZDjTb7dxqi73kMcAh63TWNimISZKiqnvCJw
 j9BvNH8cUoU3yW6R1X6lGa9SVVas4W5bz/VpxRcMw2uXk++ZWfaki2pytUfkD+K4w9Vs
 IgmQ==
X-Gm-Message-State: AOAM53091UuAXMsb+W2N2OkQwRCcxexVLQ/lRB+zfP62k5oZH9czuRjz
 X4YG+Kt1EP3IJfbhkrXRhutDKEQtUwA=
X-Google-Smtp-Source: ABdhPJxLr5qNckLQg1Evt9/7U45R9Jha6HyOniJv25pW9cRDJUr0XFySq20WtYHunaISp+RD1uUZEg==
X-Received: by 2002:a1c:81d0:: with SMTP id c199mr1963426wmd.125.1589269700216; 
 Tue, 12 May 2020 00:48:20 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id c7sm7783754wro.80.2020.05.12.00.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 00:48:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] hw/mips/mips_int: Use qdev gpio rather than
 qemu_allocate_irqs()
Date: Tue, 12 May 2020 09:48:12 +0200
Message-Id: <20200512074813.29992-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200512074813.29992-1-f4bug@amsat.org>
References: <20200512074813.29992-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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

Fixes: Coverity CID 1421934 RESOURCE_LEAK
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
2.21.3


