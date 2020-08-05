Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893D8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:18:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 597802084D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h/RqssUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597802084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Nzp-0005Yn-I5
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 14:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3NyU-0003ln-Ov
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:14 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:34929)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3NyR-0006Rz-RP
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:14 -0400
Received: by mail-pg1-x531.google.com with SMTP id o5so6956454pgb.2
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 11:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4mUrzxN38KgTWVnwLLnwWRuKmcxV8e0+CR7Czj1dxnk=;
 b=h/RqssUPjaOf96oNkU3g32Vos9LqhECbWbowgWHUFifSflEfsOn/kL93ShZCbnRynI
 FegZL/HBc1U88j37iHp+whCF6yPEuSytg9vaor99axMywu+MeXWi1ObiYFZ0YGeZkd79
 nOGihwnRZ7qP2tvlpripBITtBEnVQQNrtQGkOv3+3XxGILeEourfAS68aVvxZHtxaV43
 oVrO2P/A0g5T0tz5IAQM+1hlrMPBOjIWeOfkGCkJLQknVOAP8oJ+IlwX60LNS+N2L3c3
 kk4XQNCkZ1qpKRcW0LKd4iW6TIs579ChYJFaTKTiV5M3+jzJmu2bqibBQ7b8EwjGRDtf
 uIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4mUrzxN38KgTWVnwLLnwWRuKmcxV8e0+CR7Czj1dxnk=;
 b=NoIAWFCYabDTZTDm8yGpDLdljwcy3jxpoClq0xuKeBJs/nagAt6lzPp80A9R9oXzg5
 RHTQkVwgcRRr/OouJVKqJajy6yWTB5+ZQDWPTVnyRSAi2X0Nlo+ZnQlTfczRfummrtWy
 x42M3zQ1UeusCMccFSsNdAY/JwOVQm7xptowRlxusyApZCjocy0+oKstIXgxB1Irpc/V
 kLpMogJdTywZJ4C0D8yvM+lFoGa9EQ9dVquPievwAKvcXzqmIafoH3sxQqKJFenEAwNh
 CcOt5HGn/FEr337Y8KMvIxvRo2SRFohVctdDsxD+gmOEHkfL/KcdfhNMGWjf1YIZH9I5
 zhYg==
X-Gm-Message-State: AOAM532NmDemvKgDsvTPUg2fjpmownP1ZV2Q6h5wLQPv5lbtt1IPleC2
 1DipqCFxyWs/9Wzb9S6TVOwmfj8Qgsc=
X-Google-Smtp-Source: ABdhPJzghEfqgDSu9iPd9BgdRRnSqvLHwO6LTZCw0DUnUfZd5hh8KjrC+FSw9onmAbN/rJs67M2xRQ==
X-Received: by 2002:a63:f108:: with SMTP id f8mr3994297pgi.96.1596651429548;
 Wed, 05 Aug 2020 11:17:09 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:38ab:50b1:ff8a:26ef])
 by smtp.gmail.com with ESMTPSA id a15sm3670196pfo.185.2020.08.05.11.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 11:17:08 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 02/21] target/alpha: add BQL to do_interrupt and
 cpu_exec_interrupt
Date: Wed,  5 Aug 2020 14:12:44 -0400
Message-Id: <20200805181303.7822-3-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805181303.7822-1-robert.foley@linaro.org>
References: <20200805181303.7822-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=robert.foley@linaro.org; helo=mail-pg1-x531.google.com
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
 target/alpha/helper.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 55d7274d94..18169ae1c5 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -299,8 +299,12 @@ void alpha_cpu_do_interrupt(CPUState *cs)
 {
     AlphaCPU *cpu = ALPHA_CPU(cs);
     CPUAlphaState *env = &cpu->env;
-    int i = cs->exception_index;
-
+    int i;
+    bool bql = !qemu_mutex_iothread_locked();
+    if (bql) {
+        qemu_mutex_lock_iothread();
+    }
+    i = cs->exception_index;
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         static int count;
         const char *name = "<unknown>";
@@ -405,6 +409,9 @@ void alpha_cpu_do_interrupt(CPUState *cs)
     /* Switch to PALmode.  */
     env->flags |= ENV_FLAG_PAL_MODE;
 #endif /* !USER_ONLY */
+    if (bql) {
+        qemu_mutex_unlock_iothread();
+    }
 }
 
 bool alpha_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
@@ -412,9 +419,11 @@ bool alpha_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     AlphaCPU *cpu = ALPHA_CPU(cs);
     CPUAlphaState *env = &cpu->env;
     int idx = -1;
+    qemu_mutex_lock_iothread();
 
     /* We never take interrupts while in PALmode.  */
     if (env->flags & ENV_FLAG_PAL_MODE) {
+        qemu_mutex_unlock_iothread();
         return false;
     }
 
@@ -446,8 +455,10 @@ bool alpha_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
         cs->exception_index = idx;
         env->error_code = 0;
         alpha_cpu_do_interrupt(cs);
+        qemu_mutex_unlock_iothread();
         return true;
     }
+    qemu_mutex_unlock_iothread();
     return false;
 }
 
-- 
2.17.1


