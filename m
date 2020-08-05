Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF68FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B148D22D05
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MBm7lEit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B148D22D05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3O7A-0002IC-Tl
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 14:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nz9-0004tr-H0
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:55 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:37759)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nz7-0006Wv-M6
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:55 -0400
Received: by mail-pj1-x1041.google.com with SMTP id mw10so1079426pjb.2
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 11:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BjiLVDDEqoIBJt1y3HRzPMRPdgMoMf8GueSFlFqkhhc=;
 b=MBm7lEitcGCY7AbHi6skbhjWbJ/rDY+d8AUujZEUhFJ8g19yEdbJIoVDsPDn6k6fEz
 5oE5FQGhaA3JmmjbA3LNwzd6R3PCZcho9Lfb20LqUmUWp7f9lkOofRe96DwyU2SwkxfP
 GlcNfoVRXZCamvXErM63U6dD3Fsl+PV+cC5qOKoYp7UuNFbmmSSPlYUpXaVtxHnnYmGt
 eU7aK7VUeJvV+4LYVekRDiGmP6t03D75lEnnTDPYGQUbMarPhNfOeVeJL+pkHgJFSFko
 WWAjrJeQ/fol9wpFzihe09Rn9OOW1N1YVgSxbMJAqPLPldqkjbjt+P9EjLFQCnk2+0U3
 XO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BjiLVDDEqoIBJt1y3HRzPMRPdgMoMf8GueSFlFqkhhc=;
 b=KA3a/xFvPfiznAf2Sl3BgbKUgyEDxnng0fN08o1Ta9Fc5lWWFmTWomR+bhyojy3Za8
 MjS5dOfuRJwZM+aUfOI5ByqgxclGNxOo6uLmgUR/mCOJkYoanb6p4XTNoLrwa+SpDQjm
 CTCijVqurgK/xEDGFK351u6fBSsqcL/DNRdE0Es4j7FAbMeSTMvCrU/A0qlWF8KokrWq
 kd/O3iYwHzALwpsKrbxbN60mhYE44OFBgi6Gl2RY0gDjURbvlyCSx5w3j1df1w0sMcgw
 33PQND2YvHTGfc0sfwcq/yZ8KCaRHBOUUroEiDp6v/d02Ft/RVpa9JMGxzQNBPYvpXIx
 FzXA==
X-Gm-Message-State: AOAM5301nTUPfw9num3q1qB/4Cp4Any9POHuTU2oHDmuwpTyNFDWiyBT
 MWzfiQM6RnzPUBepuHxk6pvUkqbumDo=
X-Google-Smtp-Source: ABdhPJx8Il7vymRVwkEW2ud1RveHV9WNsGO5GpPmEm2CjdPywxgfoLQzXwmAylcakI9hvrhBvM5fgw==
X-Received: by 2002:a17:90b:1287:: with SMTP id
 fw7mr4323117pjb.218.1596651472139; 
 Wed, 05 Aug 2020 11:17:52 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:38ab:50b1:ff8a:26ef])
 by smtp.gmail.com with ESMTPSA id a15sm3670196pfo.185.2020.08.05.11.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 11:17:51 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 20/21] target/unicore32: add BQL to do_interrupt and
 cpu_exec_interrupt
Date: Wed,  5 Aug 2020 14:13:02 -0400
Message-Id: <20200805181303.7822-21-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805181303.7822-1-robert.foley@linaro.org>
References: <20200805181303.7822-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=robert.foley@linaro.org; helo=mail-pj1-x1041.google.com
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
Cc: robert.foley@linaro.org, cota@braap.org, peter.puhov@linaro.org,
 pbonzini@redhat.com, Guan Xuetao <gxt@mprc.pku.edu.cn>, alex.bennee@linaro.org
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
 target/unicore32/helper.c  | 3 +++
 target/unicore32/softmmu.c | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/target/unicore32/helper.c b/target/unicore32/helper.c
index 54c26871fe..d79284d224 100644
--- a/target/unicore32/helper.c
+++ b/target/unicore32/helper.c
@@ -169,6 +169,7 @@ void helper_cp1_putc(target_ulong regval)
 
 bool uc32_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
+    qemu_mutex_lock_iothread();
     if (interrupt_request & CPU_INTERRUPT_HARD) {
         UniCore32CPU *cpu = UNICORE32_CPU(cs);
         CPUUniCore32State *env = &cpu->env;
@@ -176,8 +177,10 @@ bool uc32_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
         if (!(env->uncached_asr & ASR_I)) {
             cs->exception_index = UC32_EXCP_INTR;
             uc32_cpu_do_interrupt(cs);
+            qemu_mutex_unlock_iothread();
             return true;
         }
     }
+    qemu_mutex_unlock_iothread();
     return false;
 }
diff --git a/target/unicore32/softmmu.c b/target/unicore32/softmmu.c
index 9660bd2a27..ca9b92aad0 100644
--- a/target/unicore32/softmmu.c
+++ b/target/unicore32/softmmu.c
@@ -81,6 +81,10 @@ void uc32_cpu_do_interrupt(CPUState *cs)
     CPUUniCore32State *env = &cpu->env;
     uint32_t addr;
     int new_mode;
+    bool bql = !qemu_mutex_iothread_locked();
+    if (bql) {
+        qemu_mutex_lock_iothread();
+    }
 
     switch (cs->exception_index) {
     case UC32_EXCP_PRIV:
@@ -118,6 +122,9 @@ void uc32_cpu_do_interrupt(CPUState *cs)
     env->regs[30] = env->regs[31];
     env->regs[31] = addr;
     cpu_interrupt_request_or(cs, CPU_INTERRUPT_EXITTB);
+    if (bql) {
+        qemu_mutex_unlock_iothread();
+    }
 }
 
 static int get_phys_addr_ucv2(CPUUniCore32State *env, uint32_t address,
-- 
2.17.1


