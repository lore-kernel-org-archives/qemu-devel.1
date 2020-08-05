Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA02EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7B4722CA0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fCz3LSoj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B4722CA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3O5A-0007R3-T1
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 14:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nz8-0004rG-Gn
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:54 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:39350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nz6-0006Wk-Fc
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:54 -0400
Received: by mail-pf1-x429.google.com with SMTP id z188so15373864pfc.6
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 11:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8sH61aMZL0itQ+WBV8wzY8AM/bADwemnnaBh5BIpH6g=;
 b=fCz3LSojL/mhv5v3nckhBGWRUG7cyv9P8hKllNSQNhq8f9Xv6dxbBwSEWCKsgs4kPJ
 vY8LnZA2mEUhRIsytLFG+XaPY1P+1sGKasspAqdbIgH1MCP2slmtPiZTv28xTr8k9Q0W
 JFBNABFtTbIaveWNu20Tki6ptKy32MySBRw9QKR/xhbT3ZZPno/rGbH7R138sUfKUd4+
 wTYx2qWNAjGoy15zIOsf0j5MtOXw59FpU0SePvcpPR0wm4PZygbg9eKNXLC9dg0NXKHq
 0IX5A8qXPLLwEVXmxbMy/HLeCm5Uum6dMc/VYS36mlAbvzL2yZqZLfBb3qpF+y0yxPCI
 bKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8sH61aMZL0itQ+WBV8wzY8AM/bADwemnnaBh5BIpH6g=;
 b=Vfr2sY6hsz69kH+BMdOMA0Jt36xVw0vRpFCayjyHMmC+kZRiGattdOuCIIAZ/9hiJQ
 15o8iUjvdVd95sCwW+Ftii7tsjRLzpu4c0sgu853bKjM1dkBJQD6EZKbRhdEfz7OKpyK
 Ms/MmshAZgIes4N6slxUut2U258EWMqlrpcJwdPSldhCZl6az7/2feovF/P/xn02Necw
 Fgv05Zl/v49owqOkfPzfL+0yDpp6qYS0+g4WuWMfgxUCS+tgQfVP+AoResrXvTMdNcAQ
 Ol9nA3Hn9X6c0g+kigd/8hqxlaPbQrn7/ExtasT9g7ZV6BP7p7HJjMjjgHSS3EGUgSBn
 lLzw==
X-Gm-Message-State: AOAM530KRmwCQeAAs98OQX07YRdRDZJiausuycAGpPjPYTV9UrNSQFrd
 Jb62/8Q8/AP+EvrmgVUweHVRh0LQXAk=
X-Google-Smtp-Source: ABdhPJyZkc+7cxW/eMG/ca8UQi+8pgPeqbH3eG9XzMYMbweOA+4eRNvBmHrhiTYzmS6FiLU5p0cm9g==
X-Received: by 2002:a63:4281:: with SMTP id p123mr3853501pga.94.1596651469963; 
 Wed, 05 Aug 2020 11:17:49 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:38ab:50b1:ff8a:26ef])
 by smtp.gmail.com with ESMTPSA id a15sm3670196pfo.185.2020.08.05.11.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 11:17:49 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 19/21] target/sparc: add BQL to do_interrupt and
 cpu_exec_interrupt
Date: Wed,  5 Aug 2020 14:13:01 -0400
Message-Id: <20200805181303.7822-20-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805181303.7822-1-robert.foley@linaro.org>
References: <20200805181303.7822-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=robert.foley@linaro.org; helo=mail-pf1-x429.google.com
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
Cc: robert.foley@linaro.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 cota@braap.org, peter.puhov@linaro.org, pbonzini@redhat.com,
 alex.bennee@linaro.org, Artyom Tarasenko <atar4qemu@gmail.com>
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
 target/sparc/cpu.c          |  3 +++
 target/sparc/int32_helper.c | 13 ++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 20c7c0c434..13b5a038e8 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -79,6 +79,7 @@ static void sparc_cpu_reset(DeviceState *dev)
 
 static bool sparc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
+    qemu_mutex_lock_iothread();
     if (interrupt_request & CPU_INTERRUPT_HARD) {
         SPARCCPU *cpu = SPARC_CPU(cs);
         CPUSPARCState *env = &cpu->env;
@@ -90,10 +91,12 @@ static bool sparc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
             if (type != TT_EXTINT || cpu_pil_allowed(env, pil)) {
                 cs->exception_index = env->interrupt_index;
                 sparc_cpu_do_interrupt(cs);
+                qemu_mutex_unlock_iothread();
                 return true;
             }
         }
     }
+    qemu_mutex_unlock_iothread();
     return false;
 }
 
diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index 9a71e1abd8..3940e945ed 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -69,7 +69,12 @@ void sparc_cpu_do_interrupt(CPUState *cs)
 {
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
-    int cwp, intno = cs->exception_index;
+    int cwp, intno;
+    bool bql = !qemu_mutex_iothread_locked();
+    if (bql) {
+        qemu_mutex_lock_iothread();
+    }
+    intno = cs->exception_index;
 
     /* Compute PSR before exposing state.  */
     if (env->cc_op != CC_OP_FLAGS) {
@@ -115,6 +120,9 @@ void sparc_cpu_do_interrupt(CPUState *cs)
                           "Error state",
                       cs->exception_index, excp_name_str(cs->exception_index));
         }
+        if (bql) {
+            qemu_mutex_unlock_iothread();
+        }
         return;
     }
 #endif
@@ -136,6 +144,9 @@ void sparc_cpu_do_interrupt(CPUState *cs)
         env->qemu_irq_ack(env, env->irq_manager, intno);
     }
 #endif
+    if (bql) {
+        qemu_mutex_unlock_iothread();
+    }
 }
 
 #if !defined(CONFIG_USER_ONLY)
-- 
2.17.1


