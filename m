Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5C2C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F5C622CA0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SQMq/9we"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5C622CA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3O5Q-0007yy-B2
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 14:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nyf-0004AC-1Q
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:25 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nyd-0006TM-1L
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:24 -0400
Received: by mail-pl1-x644.google.com with SMTP id w19so12780409plq.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 11:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7mh5d9hE+bxonA2bwtaQKP+LmgXiTqiWTHlCBZ977OU=;
 b=SQMq/9we4q+19/caWZFngtndjaN0uOziOTM4wIAbC/vnTqznC1Y3Gu/CGYE8A0GMqr
 NHEEPK+UnbNGEJgzFYXzCrrjrNtRXcTU0vkY4voIgj2BZMWKQtOXoTdu5pKF4l4g4bmH
 KMg1V+4sK8VRBcK+t5+vPaT6k0Ym2u2t2H+8/Cazx2c65T+xY1z1YL2uX/UpJBzBlW4i
 mqeUoSg3McCf0BCSUEfRnH7FBGyVwLvtFoqQ9REFw4seq6WdwTyphGQwsWQzdXETSUwf
 wfkzY9cKaTqYUshbYV5SjqSRtI5vKd57gkXacfTtyqxX7qzhcstDLr/qy9moLXrekVZq
 Nuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7mh5d9hE+bxonA2bwtaQKP+LmgXiTqiWTHlCBZ977OU=;
 b=JZUFpftpqNn1Kqn+4XHizndbv8SW8EqCsHJbgWkJzpz/t7TcBnxn9h4sLU/nYmjOXn
 RBGmU2cK+uyGvkTbdqnJpSH26tMAxBKz3ALhh+DbtOissa9lEaHqgR+DNl6Au0wTk3tf
 8nY1YMu3g6gDhIKFHzEPEfcPufoqhlXPVWPumYbGgj2fVF0z3+gwipW3l1WaGt8tHA3B
 bQZI0+2z2KMxZN1kCBc5kR8bXJVFu1yq7p9n9kepRa9nOzSKXMHxNUtWx6xxgqJzGhyx
 ro1zt4Kcg+o8lSl+0K/maTcWuVaVQjlTxhkQhMRqG7Oe0/H0ilNipXm9T6pKcvHU+Jvo
 7hag==
X-Gm-Message-State: AOAM5336hSYjEabgPY6YCTsRl5jwdbPmwrsLlmZ7yLf3Mos8N+g66HUP
 +wL1KL5rVNMawROFri4I1Es/E/0IpFk=
X-Google-Smtp-Source: ABdhPJz/wt6vOGXTf2OfCyYAFBAwV+q5kpCK3msmxcBKx/QaGLSXMKiqIAswp3UYnOfTOjM/uRc0Zw==
X-Received: by 2002:a17:90a:5a01:: with SMTP id
 b1mr4072906pjd.27.1596651441319; 
 Wed, 05 Aug 2020 11:17:21 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:38ab:50b1:ff8a:26ef])
 by smtp.gmail.com with ESMTPSA id a15sm3670196pfo.185.2020.08.05.11.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 11:17:20 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 07/21] target/i386: add BQL to do_interrupt and
 cpu_exec_interrupt
Date: Wed,  5 Aug 2020 14:12:49 -0400
Message-Id: <20200805181303.7822-8-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805181303.7822-1-robert.foley@linaro.org>
References: <20200805181303.7822-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x644.google.com
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
Cc: robert.foley@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 cota@braap.org, peter.puhov@linaro.org, pbonzini@redhat.com,
 alex.bennee@linaro.org, Richard Henderson <rth@twiddle.net>
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
 target/i386/seg_helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index 818f65f35f..114d4a0d24 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -1284,7 +1284,7 @@ void x86_cpu_do_interrupt(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
-
+    qemu_mutex_lock_iothread();
 #if defined(CONFIG_USER_ONLY)
     /* if user mode only, we simulate a fake exception
        which will be handled outside the cpu execution
@@ -1308,6 +1308,7 @@ void x86_cpu_do_interrupt(CPUState *cs)
         env->old_exception = -1;
     }
 #endif
+    qemu_mutex_unlock_iothread();
 }
 
 void do_interrupt_x86_hardirq(CPUX86State *env, int intno, int is_hw)
@@ -1320,9 +1321,10 @@ bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
     int intno;
-
+    qemu_mutex_lock_iothread();
     interrupt_request = x86_cpu_pending_interrupt(cs, interrupt_request);
     if (!interrupt_request) {
+        qemu_mutex_unlock_iothread();
         return false;
     }
 
@@ -1377,6 +1379,7 @@ bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     }
 
     /* Ensure that no TB jump will be modified as the program flow was changed.  */
+    qemu_mutex_unlock_iothread();
     return true;
 }
 
-- 
2.17.1


