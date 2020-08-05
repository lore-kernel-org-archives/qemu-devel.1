Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124E8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:20:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C070822CA0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v+BBqbP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C070822CA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3O1k-00011J-Tj
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 14:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nyr-0004Xl-7W
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:37 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:38336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nyo-0006UG-Pf
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:36 -0400
Received: by mail-pl1-x634.google.com with SMTP id t11so5929693plr.5
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 11:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cutmHWKlIHi21iMgNNh40sQAOAMRR/Z5ERVDwteMD+o=;
 b=v+BBqbP/zW2O/aI07r/sbKM8b2Sp0TgB9piY0V+HeJHhVB+wiSGb/WRhBgFldUSd/a
 EzSPZ4gGRNoa932xDw9+piLUL06pF531fpIDQjcwibiCf5kitz+az5+qGlEfENoeXSRA
 XycLxXEOiipVissdBxlfDy42+Hpp6yNuC9dvhImwAlsv6yyEzSmZrz4g/Tt8E8LJx764
 Nub09SWSChP2uf2RGNEIyQawZOTWr3rTymr/E1Fc0vqvimGwDgS82qN5M+8w4Ln5Ezcv
 1hXKLnRB/SNOlFuew7+kYwClUkuHds//regjqEzuH6Yucl3voHWOb8nnWp/usgdOsyaQ
 VSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cutmHWKlIHi21iMgNNh40sQAOAMRR/Z5ERVDwteMD+o=;
 b=tOQVIXrgjgKqxXVL9UR7Z48x3H/AnYo8Ix486K8QuWCPrL3TuQKlYFiEOwXOVfzuXM
 NzYTdfWfUuKBFVcebvc5LgkTDWWvplEMHSRr9QrlP1uBnP3D/Xiwej13G97uPMOCdpAM
 lT13L1BTHmCtfrIh7jDRNwDGUQPglGuooWMttUSpA4nUxyRJ0KVZHZaOaH4uqv2bNwgq
 /z8wYxBoGoqG7kx5SmdZTLv7KXtnmr0Qwby8EOzfyC7FUVwSRT0A2+vVAzkYsu9RvehS
 R9R90YWK9pawwhzC4f/4kJdOxijz78OWhIn7VRJH70SnZ52wMD6aMhoJQC87m1hIva8f
 2PmQ==
X-Gm-Message-State: AOAM531msnf26qpcZDa4kO7QwZnq9gnqiPP/tlXHUPPb98odf6BTGuGD
 QcqUnjMnLAPFEWF1XZJ+3TVa4YjMq4s=
X-Google-Smtp-Source: ABdhPJw7gffbpSB5icFictoWkKXrDNV73GWso+3knCJVPqKcQQYhfw39NpKw0F0VHa5PCux6kFWbAQ==
X-Received: by 2002:a17:90b:19d2:: with SMTP id
 nm18mr4588554pjb.124.1596651453081; 
 Wed, 05 Aug 2020 11:17:33 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:38ab:50b1:ff8a:26ef])
 by smtp.gmail.com with ESMTPSA id a15sm3670196pfo.185.2020.08.05.11.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 11:17:32 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 12/21] target/nios2: add BQL to do_interrupt and
 cpu_exec_interrupt
Date: Wed,  5 Aug 2020 14:12:54 -0400
Message-Id: <20200805181303.7822-13-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805181303.7822-1-robert.foley@linaro.org>
References: <20200805181303.7822-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x634.google.com
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
Cc: Marek Vasut <marex@denx.de>, robert.foley@linaro.org,
 Chris Wulff <crwulff@gmail.com>, cota@braap.org, peter.puhov@linaro.org,
 pbonzini@redhat.com, alex.bennee@linaro.org
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
 target/nios2/cpu.c    | 3 +++
 target/nios2/helper.c | 8 +++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index fe5fd9adfd..fd05406eac 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -102,13 +102,16 @@ static bool nios2_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     Nios2CPU *cpu = NIOS2_CPU(cs);
     CPUNios2State *env = &cpu->env;
+    qemu_mutex_lock_iothread();
 
     if ((interrupt_request & CPU_INTERRUPT_HARD) &&
         (env->regs[CR_STATUS] & CR_STATUS_PIE)) {
         cs->exception_index = EXCP_IRQ;
         nios2_cpu_do_interrupt(cs);
+        qemu_mutex_unlock_iothread();
         return true;
     }
+    qemu_mutex_unlock_iothread();
     return false;
 }
 
diff --git a/target/nios2/helper.c b/target/nios2/helper.c
index 57c97bde3c..46d53551d4 100644
--- a/target/nios2/helper.c
+++ b/target/nios2/helper.c
@@ -52,7 +52,10 @@ void nios2_cpu_do_interrupt(CPUState *cs)
 {
     Nios2CPU *cpu = NIOS2_CPU(cs);
     CPUNios2State *env = &cpu->env;
-
+    bool bql = !qemu_mutex_iothread_locked();
+    if (bql) {
+        qemu_mutex_lock_iothread();
+    }
     switch (cs->exception_index) {
     case EXCP_IRQ:
         assert(env->regs[CR_STATUS] & CR_STATUS_PIE);
@@ -198,6 +201,9 @@ void nios2_cpu_do_interrupt(CPUState *cs)
                   cs->exception_index);
         break;
     }
+    if (bql) {
+        qemu_mutex_unlock_iothread();
+    }
 }
 
 hwaddr nios2_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
-- 
2.17.1


