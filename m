Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA57FC5517A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:50:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D02722263
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HlCPsAQ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D02722263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNUX-0004ui-8e
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPZ-0001MG-KA
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:09 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39943)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPR-0004UV-Dc
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:08 -0400
Received: by mail-wm1-x341.google.com with SMTP id k18so1100115wmj.5
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=N2nDrwJVyehCGyLz8KWzuVOcysD0Qufd0lwzlgeBJ3E=;
 b=HlCPsAQ4O0ByfQOuBEMv0sznze0wysx00252a0gWlHo22IwAcMvaRoJj2E2e13SSbJ
 gwkOu6KLR/DEMKvvWIsrFiN4zDLByMNz2jQeAnSiAspwDxygEWa6RhlbqpzAovKHZQRB
 NJR+9zSH4ptOMJGLBnYpWNbTW7o+naniQVyo+N+cSAOqcsQ0ngM4LPkcUCHiMQ//YofR
 xreagZdj4O3SgpJbsfu50T0qqWC51RMndi43cVlsBO/ML0u9UCAUuJJuUDT1NR4Fq+2I
 b1ZdJzo0HuIAzan7WzNgxHGXj+jyyXSR+bKPu3dEhdpN7AI3gfx6/zD23qWIiMTf6M4w
 Y4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N2nDrwJVyehCGyLz8KWzuVOcysD0Qufd0lwzlgeBJ3E=;
 b=oEUNNyvIoeG7uGuGv/gYCgcUyhcvlVs3Y4kWFbznK+LRhc2/bvW53WoUuSAKZX0CHX
 JyLmAAFYnfLXLs15Uu6jM3HnJilpdQM1s+KHkYlmmWujrcJumQGhBdAdEjzByjvuDzSa
 tL0f9YgOoixbcVbAoFAFpT2LzKKXA31Rqc94GjgEqFDN/80UKgaPKoMHqW7c3lmgpqZA
 cCDtKPUGOh/yBvT+8cxwxkYhWUT+2+86IBwLQOol4ln9nzV0lJPZ9hU5DIydc3GFIroo
 2ccXVggwN8J6rTy94U+3vAzsvU4OghkdVGBPAOWO82TVbzcqZ1u5UqwGmp4drDWiB1Ef
 Dxug==
X-Gm-Message-State: AOAM533lci9DwTsv04PlvASGnSSrKIJwRZrvniGDzRzFPXokmf1iS5Xb
 FMVZXa87ylozQy9Ex14BBfbn85uMmOVFhA==
X-Google-Smtp-Source: ABdhPJxXS9RVLCdfDKn5291eaz9lWrRpuHQlVapv2k2YcnIWnumIl270EjU1sgPConlf/1DkGiMk5w==
X-Received: by 2002:a7b:cc85:: with SMTP id p5mr2247575wma.24.1603799099600;
 Tue, 27 Oct 2020 04:44:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.44.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:44:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/48] Move npcm7xx_timer_reached_zero call out of
 npcm7xx_timer_pause
Date: Tue, 27 Oct 2020 11:44:05 +0000
Message-Id: <20201027114438.17662-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Havard Skinnemoen <hskinnemoen@google.com>

This allows us to reuse npcm7xx_timer_pause for the watchdog timer.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/npcm7xx_timer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/timer/npcm7xx_timer.c b/hw/timer/npcm7xx_timer.c
index 5703e43d404..2df9e3e4969 100644
--- a/hw/timer/npcm7xx_timer.c
+++ b/hw/timer/npcm7xx_timer.c
@@ -157,9 +157,6 @@ static void npcm7xx_timer_pause(NPCM7xxTimer *t)
     timer_del(&t->qtimer);
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     t->remaining_ns = t->expires_ns - now;
-    if (t->remaining_ns <= 0) {
-        npcm7xx_timer_reached_zero(t);
-    }
 }
 
 /*
@@ -239,6 +236,9 @@ static void npcm7xx_timer_write_tcsr(NPCM7xxTimer *t, uint32_t new_tcsr)
         } else {
             t->tcsr &= ~NPCM7XX_TCSR_CACT;
             npcm7xx_timer_pause(t);
+            if (t->remaining_ns <= 0) {
+                npcm7xx_timer_reached_zero(t);
+            }
         }
     }
 }
-- 
2.20.1


