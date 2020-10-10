Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953A3C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:56:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1569E207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDItqzi+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1569E207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRLuu-0006iA-VW
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 16:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLia-0000sQ-8p
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:52 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:33441)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLiU-0007WS-Cc
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:47 -0400
Received: by mail-wm1-x335.google.com with SMTP id z22so11264504wmi.0
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 13:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ctIQLLW1NZgbCK7+6hoccFr7568Qu3bl/1p5Xwlr1Ic=;
 b=tDItqzi+wPveELUj41A3mnXNitrGm8FN/ffYq/Xp0u/VH0xXLm5OKqhLlTv5jTJndj
 /BCnzXXBfE2kr4BCfXQDolGeYlP7Dpwre3D7j51PR4p9lNyUAHdxSBK1yz3W+buC+7zk
 PrTYyUubixwhvWOolhb8+y15WCW0Gkd0qpzAJ9CYvpxkfiJx3Z4gpjuBsjG7hMbiZkR8
 ElkWGG1hoVpgg/lCzUR2H7Eyaaf8eo+hB350QUKW6NwCj2/s2y8VS2kfFpoqTe6bMSYR
 dfpFfqQdoJcKsxnVdQvCmyuKpCYQJaVs9wRlF5276pUnCI5Qp0QX5ADK7jriVUXdcOoz
 lBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ctIQLLW1NZgbCK7+6hoccFr7568Qu3bl/1p5Xwlr1Ic=;
 b=gKgOqhPNolwYUIkZx1p4EK6hK67ai8rfPL3eAOEpnVHokYNRFY4LMcpUWvbjY01Moy
 LJ9ZpAxB9scWkJW5B5GfOgNuKJuXBtcbn9QTQijJKqTac1cUD3Gr8IRL8Od7M3EWgRVb
 6DIOYZM8f0TeCVfOkx4N/tyOfYhxAfRmvEHonyGLtFOJGORh8PNYDAL9bb5GsG5QCjsO
 wxbQbagUsa9JRIbb6RXCEBBMqDICih3APd4DOUKVhJeCZ6i/q4H8D1WSUUIQzM6dsc6N
 YtpNsh57CFpMYMZKu+S7jymvaq8I6hoEhjXAwi0xTMln5KIZzmQizh/LEHwAFwf+HVpj
 JgxQ==
X-Gm-Message-State: AOAM530CnMG3Svp/xe8Bxle9xxi9JGaXmGe8T8nCrWcgri9XcOwOWGrl
 xOj9E/jG3zu6Pys0NER9c93Vqjv7sy8=
X-Google-Smtp-Source: ABdhPJzRwynQDks/MLMvw+sHPH3Vr+5IXy9IL0G8cqpFsPPn1hDmZKbhg7zJYpbVeYoY6WYAoSS/7g==
X-Received: by 2002:a1c:5401:: with SMTP id i1mr3936604wmb.124.1602362623887; 
 Sat, 10 Oct 2020 13:43:43 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 205sm2705471wme.38.2020.10.10.13.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 13:43:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 16/20] hw/mips/cps: Expose input clock and connect it to
 CPU cores
Date: Sat, 10 Oct 2020 22:43:15 +0200
Message-Id: <20201010204319.3119239-17-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010204319.3119239-1-f4bug@amsat.org>
References: <20201010204319.3119239-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Expose a qdev input clock named 'clk-in', and connect it to each
core to forward-propagate the clock.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/mips/cps.h | 2 ++
 hw/mips/cps.c         | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/hw/mips/cps.h b/include/hw/mips/cps.h
index 9e35a881366..859a8d4a674 100644
--- a/include/hw/mips/cps.h
+++ b/include/hw/mips/cps.h
@@ -21,6 +21,7 @@
 #define MIPS_CPS_H
 
 #include "hw/sysbus.h"
+#include "hw/clock.h"
 #include "hw/misc/mips_cmgcr.h"
 #include "hw/intc/mips_gic.h"
 #include "hw/misc/mips_cpc.h"
@@ -43,6 +44,7 @@ struct MIPSCPSState {
     MIPSGICState gic;
     MIPSCPCState cpc;
     MIPSITUState itu;
+    Clock *clock;
 };
 
 qemu_irq get_cps_irq(MIPSCPSState *cps, int pin_number);
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 23c0f87e41a..915655b91e0 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -22,6 +22,7 @@
 #include "qemu/module.h"
 #include "hw/mips/cps.h"
 #include "hw/mips/mips.h"
+#include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/mips/cpudevs.h"
 #include "sysemu/kvm.h"
@@ -38,6 +39,7 @@ static void mips_cps_init(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     MIPSCPSState *s = MIPS_CPS(obj);
 
+    s->clock = qdev_init_clock_in(DEVICE(obj), "clk-in", NULL, NULL);
     /*
      * Cover entire address space as there do not seem to be any
      * constraints for the base address of CPC and GIC.
@@ -80,6 +82,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
                                       errp)) {
             return;
         }
+        qdev_connect_clock_in(DEVICE(cpu), "clk-in", s->clock);
 
         if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
             return;
-- 
2.26.2


