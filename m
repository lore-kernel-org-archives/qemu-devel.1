Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC11EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:20:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86DD22250E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sowj/PvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86DD22250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3O1L-0000KL-QB
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 14:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nym-0004PB-Ep
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:32 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036]:39054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nyj-0006Tx-Qh
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:32 -0400
Received: by mail-pj1-x1036.google.com with SMTP id f9so4779659pju.4
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 11:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=AeDpfxqkdAEXeD0Us9Svn7h86jElbTJX/muq5WTwNbc=;
 b=sowj/PvItMmu8NBwvfGGeqmrW1OX1jqRjIyWgAzoKIwV8FNfxYd9wnclVR70+vRkRS
 Jon4BlDzbt/dVJrbMcTyBJM/GxzmidudqoS8DBKBj2D9S6LhTPZGFCUogaJ4DZH5xhFf
 aj4lbeqK3fz6cN5ycfFqTveISpgW1AldVb/uiWyO09TA3TP2HKOsCApmdKKEtHLSKXW8
 iVBqwbgp2ZbD5hFrxwyvq/n2/uqhrcT7xtsyE4mgXX2bZSa4sbpUuJVyP/61w7oKwKlU
 INCQMjkh5+/HLoqEGQRtlRnpaOdRcdFLWrIKzzlihL5KoJ0hJaGH1+9IBlJtObXZNI/7
 S0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=AeDpfxqkdAEXeD0Us9Svn7h86jElbTJX/muq5WTwNbc=;
 b=gqeNYMF7zIpzZ2AiRRyywkjpWUzzF4+2wVOIN2wQN7n994QHOFMSb9aOrIx6QZswmW
 owxKqd6KIjr/TaVyDgp9Uu27yAESwRTrqpvEM8ONmfJFuVg90gmr0GTQDsTW/w6SiZux
 7ZhIo+yb1PbAQgyr59sntIVcob1FjRYWTOJx78jiBv+Re9knTEK4mfyEcQGHH8dBCyDc
 iiOqfbzmQtrrPBXzo6GWOHPsv9/Nn/WHocLrdP/ymFaoJE1QFiPYMaYloUYp5p1nRMg8
 ceEEm7OMTc/Fs1qN3dXo084BAKJC4827fhyFuu01u7jVfSEUnAysJwL86Gc2+ul1Uub5
 0/OQ==
X-Gm-Message-State: AOAM5312AF1EGsRX0ZRCHjtIj5wQEbNswvVfMYT1SgdVGyV2bn0MeCim
 OltNB0xPTOJCXKJ6ZBWahtfbgCPrztY=
X-Google-Smtp-Source: ABdhPJwrPV0yaoOViRhr+N22GpjgeRHLeBaXFKz2BBst8GXbBUNPCJ1Mx0DgOJbpq3oxBIeKtTIu6A==
X-Received: by 2002:a17:902:40a:: with SMTP id
 10mr4238883ple.180.1596651448072; 
 Wed, 05 Aug 2020 11:17:28 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:38ab:50b1:ff8a:26ef])
 by smtp.gmail.com with ESMTPSA id a15sm3670196pfo.185.2020.08.05.11.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 11:17:27 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 10/21] target/microblaze: add BQL to do_interrupt and
 cpu_exec_interrupt
Date: Wed,  5 Aug 2020 14:12:52 -0400
Message-Id: <20200805181303.7822-11-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805181303.7822-1-robert.foley@linaro.org>
References: <20200805181303.7822-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=robert.foley@linaro.org; helo=mail-pj1-x1036.google.com
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
Cc: robert.foley@linaro.org, peter.puhov@linaro.org, cota@braap.org,
 pbonzini@redhat.com, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
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
 target/microblaze/helper.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index ab2ceeb055..ae8ff2bea4 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -32,10 +32,17 @@ void mb_cpu_do_interrupt(CPUState *cs)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
+    bool bql = !qemu_mutex_iothread_locked();
+    if (bql) {
+        qemu_mutex_lock_iothread();
+    }
 
     cs->exception_index = -1;
     env->res_addr = RES_ADDR_NONE;
     env->regs[14] = env->sregs[SR_PC];
+    if (bql) {
+        qemu_mutex_unlock_iothread();
+    }
 }
 
 bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
@@ -113,6 +120,10 @@ void mb_cpu_do_interrupt(CPUState *cs)
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
     uint32_t t;
+    bool bql = !qemu_mutex_iothread_locked();
+    if (bql) {
+        qemu_mutex_lock_iothread();
+    }
 
     /* IMM flag cannot propagate across a branch and into the dslot.  */
     assert(!((env->iflags & D_FLAG) && (env->iflags & IMM_FLAG)));
@@ -123,6 +134,9 @@ void mb_cpu_do_interrupt(CPUState *cs)
         case EXCP_HW_EXCP:
             if (!(env->pvr.regs[0] & PVR0_USE_EXC_MASK)) {
                 qemu_log_mask(LOG_GUEST_ERROR, "Exception raised on system without exceptions!\n");
+                if (bql) {
+                    qemu_mutex_unlock_iothread();
+                }
                 return;
             }
 
@@ -262,6 +276,9 @@ void mb_cpu_do_interrupt(CPUState *cs)
                       cs->exception_index);
             break;
     }
+    if (bql) {
+        qemu_mutex_unlock_iothread();
+    }
 }
 
 hwaddr mb_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
@@ -291,6 +308,7 @@ bool mb_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
+    qemu_mutex_lock_iothread();
 
     if ((interrupt_request & CPU_INTERRUPT_HARD)
         && (env->sregs[SR_MSR] & MSR_IE)
@@ -298,7 +316,9 @@ bool mb_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
         && !(env->iflags & (D_FLAG | IMM_FLAG))) {
         cs->exception_index = EXCP_IRQ;
         mb_cpu_do_interrupt(cs);
+        qemu_mutex_unlock_iothread();
         return true;
     }
+    qemu_mutex_unlock_iothread();
     return false;
 }
-- 
2.17.1


