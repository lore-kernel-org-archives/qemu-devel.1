Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A57EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:20:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5884622CA0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cIZjaXa9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5884622CA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3O1V-0000Ty-Kk
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 14:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nyc-00045M-U8
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:22 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:45788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nya-0006T5-Qg
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:22 -0400
Received: by mail-pf1-x434.google.com with SMTP id f193so12811385pfa.12
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 11:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=aWTfVEr9viFrQ6JCbNZOP6prnRfgRwiZmrjVsEZMWCQ=;
 b=cIZjaXa9hCmfhlDZimPZ7RTB0p8QjdV+aDkQ3YeAXdeQA1ABzzYQLs0zaTRszYaR8m
 /wtrkc1vQCGe3N/Paa5axVhKP4MCoAKnZgltYzS/cFw986qNp91/lHYc0bO6QgRauwEh
 grjmKawATF0BOtBwvIwNK6TtyuO4w/QNfMiqLvj0Szky98MJRKC5wIaO3k9SsXTx4cyo
 9qIfIlvitWZXDazwY0jHL6lXBygihw5WxhimwIPDiipJIyF2hK9KIWnlNsTp/hFlmB2p
 Jn9sNFHcgTK7WtkDMdKyjKFdsEMXdFl8V3/jxksA/ta/Ugf2ubdCngi3B1ymhGZLm6Wh
 KPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=aWTfVEr9viFrQ6JCbNZOP6prnRfgRwiZmrjVsEZMWCQ=;
 b=NLfUdGk1O23U5TYbi46E59P69Mj2fHmNOJ+nsduTwnrSyxV8ogmWmfdTogXWIo0aLr
 yeu9JkVX7pUpB5uGV0dgxldxuWZqLoG7XkLOk20bkLUzqI1pG65SwiBNxvHYO4iHefwL
 VxuJ2MbNDzn+Nd34u2bvEUMDG52KsWZaMNnyIl8nMm5Ap/pCdLIJaKb3BPBYtm6UUQtS
 zDc0D/xEte6DDrT256mcaPMVovmoUXMiutHZoSImA/DjwnvIqYuQGKkIvzkT77HnRJOB
 liuSwEG3MWSPGXGKAkA4qIPG7IjFQBD6kYKEIthaCbYi37+FG8BD6KS8+1bJNym/ZrRq
 RohQ==
X-Gm-Message-State: AOAM532TF1CJ80j9NqkKx5w0kbVtrqod/NrOxloxaEm000jMiL1gdbDR
 P8hVgkdBg/F4hnhesDCH79YGHO0Tfjw=
X-Google-Smtp-Source: ABdhPJxrozRL954sZkjObw8MLIG8suUN+0VxlDWhcSrtjgZUynlTnFWQ49c8jOF/fLPydX5ssZCkug==
X-Received: by 2002:a63:d446:: with SMTP id i6mr3893370pgj.438.1596651439003; 
 Wed, 05 Aug 2020 11:17:19 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:38ab:50b1:ff8a:26ef])
 by smtp.gmail.com with ESMTPSA id a15sm3670196pfo.185.2020.08.05.11.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 11:17:18 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 06/21] target/hppa: add BQL to do_interrupt and
 cpu_exec_interrupt
Date: Wed,  5 Aug 2020 14:12:48 -0400
Message-Id: <20200805181303.7822-7-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805181303.7822-1-robert.foley@linaro.org>
References: <20200805181303.7822-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=robert.foley@linaro.org; helo=mail-pf1-x434.google.com
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
 pbonzini@redhat.com, alex.bennee@linaro.org,
 Richard Henderson <rth@twiddle.net>
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
 target/hppa/int_helper.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 462747baf8..eda40bc5d9 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -94,12 +94,20 @@ void hppa_cpu_do_interrupt(CPUState *cs)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
-    int i = cs->exception_index;
-    target_ureg iaoq_f = env->iaoq_f;
-    target_ureg iaoq_b = env->iaoq_b;
-    uint64_t iasq_f = env->iasq_f;
-    uint64_t iasq_b = env->iasq_b;
-
+    int i;
+    target_ureg iaoq_f;
+    target_ureg iaoq_b;
+    uint64_t iasq_f;
+    uint64_t iasq_b;
+    bool bql = !qemu_mutex_iothread_locked();
+    if (bql) {
+        qemu_mutex_lock_iothread();
+    }
+    i = cs->exception_index;
+    iaoq_f = env->iaoq_f;
+    iaoq_b = env->iaoq_b;
+    iasq_f = env->iasq_f;
+    iasq_b = env->iasq_b;
 #ifndef CONFIG_USER_ONLY
     target_ureg old_psw;
 
@@ -244,6 +252,9 @@ void hppa_cpu_do_interrupt(CPUState *cs)
                                env->cr[CR_IOR]));
     }
     cs->exception_index = -1;
+    if (bql) {
+        qemu_mutex_unlock_iothread();
+    }
 }
 
 bool hppa_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
@@ -251,6 +262,7 @@ bool hppa_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 #ifndef CONFIG_USER_ONLY
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
+    qemu_mutex_lock_iothread();
 
     /* If interrupts are requested and enabled, raise them.  */
     if ((env->psw & PSW_I) && (interrupt_request & CPU_INTERRUPT_HARD)) {
@@ -258,6 +270,7 @@ bool hppa_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
         hppa_cpu_do_interrupt(cs);
         return true;
     }
+    qemu_mutex_unlock_iothread();
 #endif
     return false;
 }
-- 
2.17.1


