Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E47C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A37322CE3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sfLqYx+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A37322CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3O94-0004Zo-DC
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 14:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nz4-0004k6-2A
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:50 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46390)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nz1-0006W2-3h
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:49 -0400
Received: by mail-pf1-x442.google.com with SMTP id 74so14954298pfx.13
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 11:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WMl3AIWSt1TrS8ub7e6y3EFYj5c+15bBo75uZcYRAVU=;
 b=sfLqYx+CkXOIMiam4y4J2nto/nWPmU5jv63NiJXbtzGqxWnx4fB+7shF6g9Rz13k8M
 fYfP76nihiooh7VefqazSomDmyeVijTSJZvlctSiEGBZp03HWfU8CKghim03v6KYlqMc
 fPjGzi9LIFGSFuZMXCMsNSu4KwTgwv7VIcmA3ymkqIe4n38leNb07q7YkyCyuzYayE0l
 WmIdT7ELxsFjXnulpdDSv+EmD9VSsJ6yk9MVcdmFCcjmedIbQKUF0jfPJdmz0vyiQQoU
 BUSY+y16Z4l6ZbaC16/9yqGZlnJ0UemWrj5q/Y+JFfNitXsijE50lrylaby3U6FiJL0n
 KuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=WMl3AIWSt1TrS8ub7e6y3EFYj5c+15bBo75uZcYRAVU=;
 b=ho+Uwly4co1L1sIa4rIFY183RfJJxkXLwWmK9qNz9K13wAHSd09oLeVcCDcYVCUeSN
 a/L3ie8sYnEvjRFRzpmBqqyFbuEoa9PJ2waLN5KE/Sfty3t17LGa5q66sJssWTQAvdIN
 NcrPCldY4/Buu6GdNq3FFef4yPItv6Bp0z7xzpC2Wm3wfRxIk9XPluEEnMfuTS/I7rvx
 +JI0mKBI0w/aiC5HTsMMkHtVsulWImKu8qwjcdr2tfqFGqhR0DCYYNNTZxf3yL+Xm0QK
 sCWZlKeRw3Kv0bhMJw+ikQu3l7ocFeo9THIi+cwbkXJ9LmKwSSelPFnA5f0vWrFE2yYL
 wDhw==
X-Gm-Message-State: AOAM5339pjQllsQb/7MgdUSzf/VWumVu6qsHvPqaG/EryhiSe6Cat2Cz
 yvqES760o1ADlyMa0uYU5NBX2I1oBjg=
X-Google-Smtp-Source: ABdhPJwc9cazGiwWPYv78LG7ZqWIfNSQgGf/yeeT/1FRiKN8tF/u3yj4TGQpwlr0MeUTUafARWUmAQ==
X-Received: by 2002:a63:338c:: with SMTP id z134mr3990719pgz.245.1596651465440; 
 Wed, 05 Aug 2020 11:17:45 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:38ab:50b1:ff8a:26ef])
 by smtp.gmail.com with ESMTPSA id a15sm3670196pfo.185.2020.08.05.11.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 11:17:44 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 17/21] target/s390x: add BQL to do_interrupt and
 cpu_exec_interrupt
Date: Wed,  5 Aug 2020 14:12:59 -0400
Message-Id: <20200805181303.7822-18-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805181303.7822-1-robert.foley@linaro.org>
References: <20200805181303.7822-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=robert.foley@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, robert.foley@linaro.org,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>, cota@braap.org,
 peter.puhov@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
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
 target/s390x/excp_helper.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index dde7afc2f0..b215b4a4a7 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -470,7 +470,10 @@ void s390_cpu_do_interrupt(CPUState *cs)
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
     bool stopped = false;
-
+    bool bql = !qemu_mutex_iothread_locked();
+    if (bql) {
+        qemu_mutex_lock_iothread();
+    }
     qemu_log_mask(CPU_LOG_INT, "%s: %d at psw=%" PRIx64 ":%" PRIx64 "\n",
                   __func__, cs->exception_index, env->psw.mask, env->psw.addr);
 
@@ -541,10 +544,14 @@ try_deliver:
         /* unhalt if we had a WAIT PSW somehwere in our injection chain */
         s390_cpu_unhalt(cpu);
     }
+    if (bql) {
+        qemu_mutex_unlock_iothread();
+    }
 }
 
 bool s390_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
+    qemu_mutex_lock_iothread();
     if (interrupt_request & CPU_INTERRUPT_HARD) {
         S390CPU *cpu = S390_CPU(cs);
         CPUS390XState *env = &cpu->env;
@@ -552,10 +559,12 @@ bool s390_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
         if (env->ex_value) {
             /* Execution of the target insn is indivisible from
                the parent EXECUTE insn.  */
+            qemu_mutex_unlock_iothread();
             return false;
         }
         if (s390_cpu_has_int(cpu)) {
             s390_cpu_do_interrupt(cs);
+            qemu_mutex_unlock_iothread();
             return true;
         }
         if (env->psw.mask & PSW_MASK_WAIT) {
@@ -564,6 +573,7 @@ bool s390_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
             cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HALT);
         }
     }
+    qemu_mutex_unlock_iothread();
     return false;
 }
 
-- 
2.17.1


