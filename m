Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA58C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1554822CA0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xTjpRxu7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1554822CA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3O3F-0003rW-Cp
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 14:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nyo-0004Qw-9S
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:34 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d]:51543)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nym-0006U5-91
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:33 -0400
Received: by mail-pj1-x102d.google.com with SMTP id c6so5024195pje.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 11:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TQf+kUTKaJ/snZqXoVWLiq9osz3e4ZNpxcetm6dWt8I=;
 b=xTjpRxu7HKdV2Bz9nOANpvgfUs9av4+RyFPXe/KiNgkf7fgIrqz9/1F52zNNifoO5f
 82J3UKbwrNjZUAa3+jG7R6TK2xl1OPijHaBNqyZGNb+oBoZQMR+rSVNYhGasTOkAmB6h
 UZcx2UZJWcXND+tXFwFmlkOjU4VfohT24F+Vs4MmWuZFq34ldRn/JSjO+zAvcKl83rCm
 u99vaeu/IrDe2qTMOyIGKnneHTo25v/7F2af1L/V15i5RVW4hjMyHosssy4LNpPFuvcx
 0lbHALvPRUHLpSotwcs5eDXV3pPmC8mYunvhI1d+RUIFmxP8eZQJ91cSreFrZ7xiJPJ4
 fX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=TQf+kUTKaJ/snZqXoVWLiq9osz3e4ZNpxcetm6dWt8I=;
 b=MWosaawdH3GfZ84Ma3jf4+IBirjZ0itduZq8qx6J+FMP30mim8PAQv6D93MgvBLubd
 zoQtnY6KVW85Ip1gAlR82Kf6SWQA6YQQtqvsR26gU3emEON5Xw/VOsQspgtkLNK88Pjr
 oF4A6NkNx28FpXLliWbhHJJt849VkFcXD9yqV7d5ynouJGE9hE0NYSs4CXo9F6c736oU
 pF5VFx8ZT6+ZyidauIeqkIKZfpP+fh+xVBwXiJ1zMaYFM9W4NPS1yva7J3eqv20dUl9w
 VLWSFInS+xOCpIU2XKR/KcMfHLVKKQp0nMkF3vYUgH/JzU4B40tU+cwPjuc9EQ5FzPTR
 FotA==
X-Gm-Message-State: AOAM531Zn7+QxSpB63DTYrG+KUI5Yew2ivskWzMEGM78HgE/EPgrA6KF
 AwiLs+RuMiuGwQ8v9ld6KOB3ovb8uXQ=
X-Google-Smtp-Source: ABdhPJzdfsJfzIWCvPO81S1GWX9CY4ctiQoHANbdnrz/V3t2SAGln5dbhnt7dYemgn/sw22nZid5gw==
X-Received: by 2002:a17:90a:3488:: with SMTP id
 p8mr4695488pjb.211.1596651450623; 
 Wed, 05 Aug 2020 11:17:30 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:38ab:50b1:ff8a:26ef])
 by smtp.gmail.com with ESMTPSA id a15sm3670196pfo.185.2020.08.05.11.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 11:17:29 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 11/21] target/mips: add BQL to do_interrupt and
 cpu_exec_interrupt
Date: Wed,  5 Aug 2020 14:12:53 -0400
Message-Id: <20200805181303.7822-12-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805181303.7822-1-robert.foley@linaro.org>
References: <20200805181303.7822-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=robert.foley@linaro.org; helo=mail-pj1-x102d.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, robert.foley@linaro.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, cota@braap.org,
 peter.puhov@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is part of a series of changes to remove the implied BQL
from the common code of cpu_handle_interrupt and
cpu_handle_exception.  As part of removing the implied BQL
from the common code, we are pushing the BQL holding
down into the per-arch implementation functions of
do_interrupt and cpu_exec_interrupt.

The purpose of this set of changes is to set the groundwork
so that an arch could move towards removing
the BQL from the cpu_handle_interrupt/exception paths.

This approach was suggested by Paolo Bonzini.
For reference, here are two key posts in the discussion, explaining
the reasoning/benefits of this approach.
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg08731.html
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00044.html

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/mips/helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index afd78b1990..6595d18702 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -1085,6 +1085,10 @@ static inline void set_badinstr_registers(CPUMIPSState *env)
 
 void mips_cpu_do_interrupt(CPUState *cs)
 {
+    bool bql = !qemu_mutex_iothread_locked();
+    if (bql) {
+        qemu_mutex_lock_iothread();
+    }
 #if !defined(CONFIG_USER_ONLY)
     MIPSCPU *cpu = MIPS_CPU(cs);
     CPUMIPSState *env = &cpu->env;
@@ -1396,10 +1400,14 @@ void mips_cpu_do_interrupt(CPUState *cs)
     }
 #endif
     cs->exception_index = EXCP_NONE;
+    if (bql) {
+        qemu_mutex_unlock_iothread();
+    }
 }
 
 bool mips_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
+    qemu_mutex_lock_iothread();
     if (interrupt_request & CPU_INTERRUPT_HARD) {
         MIPSCPU *cpu = MIPS_CPU(cs);
         CPUMIPSState *env = &cpu->env;
@@ -1410,9 +1418,11 @@ bool mips_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
             cs->exception_index = EXCP_EXT_INTERRUPT;
             env->error_code = 0;
             mips_cpu_do_interrupt(cs);
+            qemu_mutex_unlock_iothread();
             return true;
         }
     }
+    qemu_mutex_unlock_iothread();
     return false;
 }
 
-- 
2.17.1


