Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C5AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF6A62310A
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jw+hFPvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6A62310A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3O9e-000530-1E
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 14:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nz2-0004hY-4u
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:48 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:33227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nyy-0006VW-IX
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:47 -0400
Received: by mail-pf1-x42c.google.com with SMTP id u20so1266839pfn.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 11:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JzRY4u611ZdJJJ8DEPsiNDmT76OIm6iIPSor9aPp4Js=;
 b=Jw+hFPvo12d3SzroLf6sE8yRIdWsovt/PtjWwfq///ibh32KL/jD2mtDE/rxSh1ogT
 SyooaIom4hPIWQOo6gg2z7xP1SpuyMmWTsJxrc+CTK50OOG6cGha3uFswAlSR4cP3+uQ
 nSJp+30fuqRJgnij/j54TCYnshNHDjmwswEEYl9+y4HuY2171QHH6sI+XTQYVXswswM2
 BMIv9lw61gcPkLqKWxyncXWumq+KcJyD46gKFnY1QViGouHuEthZPHBrmlMkLHe6J6aE
 xblHOaOzILnVytoOYF1B05xJYN1lY3xNuZyOxvHROVAoQegFk2MGCGbDmMPzHwwSZzu3
 VnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JzRY4u611ZdJJJ8DEPsiNDmT76OIm6iIPSor9aPp4Js=;
 b=WNCaP8PRP0rkH+f5cQQbZVlOgYdfF1t7fdAUKqurOM3V9cFc547Rvnzgkzw8A+tZEw
 WChY+Yr+Rc4py+PS0EnUEYRLGw5Cx3WzHd/9KB9MJGUyi7Qhk15mSp2J2wuhAHt0Gkb9
 lPbQqXh/c9LOVmdgyhlFxYFBNg7Y7qsgN8+rdenPSvCWfnPVaXUKLfTVceCF3yYHzbQX
 qUMN2lbRE0tJaRZ3QSG4vdXlijrI7hrH19VaetCBDQs1J2f1wflwYt3CqVKusrT9IjPk
 qUZuJY07xy6K34xkChQIEtj4qqPlcFRBbieAG+uAYtUCEmbooNJ0+4iqxZ+huDdpTHrz
 yLnQ==
X-Gm-Message-State: AOAM530jxP5bpPVY377bkwv0/sqV4spd9dwoI25Qm7QtQUJmzyYNblb1
 7gtom9mIkC3mHWIhQO2FHW7T6vc4Qa8=
X-Google-Smtp-Source: ABdhPJx/AW+EHhwLcrEOO45nyLyUnDkbKDWiA+7hiCpLk5p0G8iMv8chARC97f4c5P9Z9jwn29HXQw==
X-Received: by 2002:a63:1a44:: with SMTP id a4mr4130118pgm.281.1596651462691; 
 Wed, 05 Aug 2020 11:17:42 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:38ab:50b1:ff8a:26ef])
 by smtp.gmail.com with ESMTPSA id a15sm3670196pfo.185.2020.08.05.11.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 11:17:41 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 16/21] target/rx: add BQL to do_interrupt and
 cpu_exec_interrupt
Date: Wed,  5 Aug 2020 14:12:58 -0400
Message-Id: <20200805181303.7822-17-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805181303.7822-1-robert.foley@linaro.org>
References: <20200805181303.7822-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=robert.foley@linaro.org; helo=mail-pf1-x42c.google.com
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
Cc: robert.foley@linaro.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 cota@braap.org, peter.puhov@linaro.org, pbonzini@redhat.com,
 alex.bennee@linaro.org
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
 target/rx/helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/rx/helper.c b/target/rx/helper.c
index a6a337a311..a456b727ed 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -48,6 +48,10 @@ void rx_cpu_do_interrupt(CPUState *cs)
     CPURXState *env = &cpu->env;
     int do_irq = cs->interrupt_request & INT_FLAGS;
     uint32_t save_psw;
+    bool bql = !qemu_mutex_iothread_locked();
+    if (bql) {
+        qemu_mutex_lock_iothread();
+    }
 
     env->in_sleep = 0;
 
@@ -117,6 +121,9 @@ void rx_cpu_do_interrupt(CPUState *cs)
                       (vec & 0xff), expname);
     }
     env->regs[0] = env->isp;
+    if (bql) {
+        qemu_mutex_unlock_iothread();
+    }
 }
 
 bool rx_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
@@ -124,6 +131,7 @@ bool rx_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     RXCPU *cpu = RXCPU(cs);
     CPURXState *env = &cpu->env;
     int accept = 0;
+    qemu_mutex_lock_iothread();
     /* hardware interrupt (Normal) */
     if ((interrupt_request & CPU_INTERRUPT_HARD) &&
         env->psw_i && (env->psw_ipl < env->req_ipl)) {
@@ -138,8 +146,10 @@ bool rx_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     }
     if (accept) {
         rx_cpu_do_interrupt(cs);
+        qemu_mutex_unlock_iothread();
         return true;
     }
+    qemu_mutex_unlock_iothread();
     return false;
 }
 
-- 
2.17.1


