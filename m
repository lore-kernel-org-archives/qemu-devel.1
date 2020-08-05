Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1009AC433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:24:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D73FC22CAF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wej9GzQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73FC22CAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3O5S-00082o-4C
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 14:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nz7-0004oi-Jb
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:53 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nz3-0006WX-DL
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:53 -0400
Received: by mail-pl1-x642.google.com with SMTP id f10so830593plj.8
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 11:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=eY79OI2NziyEJvuRHl1nh9tYXBtyJDeusaPNFa05tj8=;
 b=wej9GzQVC8LKvXsuCL2CxODp85b71XEKPDifhMVNT67NbQ+2Z9k5hnv+WVaFSv32mq
 thIhWIGJ0vgsECpMSD6yp/gBy/pMdnj+wdvdOGoS0hKk9vA5Az3HgnJtkqRUNC2XYJSl
 lm27BcNFgFC+9/K5H89eEmTY+uTTbvTJm/RMEFp14uv6sstlHBN70ueZsQv+HTrUvnsC
 T6TO27dbHpibU5Uv7pFgUZ4BYDu9danOngbv1KU9na4gJwMMaVW2MphempSv7dZooCKL
 KbZe0s8GFjzEkE6Ta0/gQxb4nn3UaWkievFiEKaukStJTNUnokcQPiD69wQK/XRCLotN
 91oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=eY79OI2NziyEJvuRHl1nh9tYXBtyJDeusaPNFa05tj8=;
 b=Jpc247q5vsIBaLVDroICMDE2Dn7d7KJ30N347CttRWAYLZm7NLg8LuUBf+bxx096Bp
 XXznSaDmeLq2qWrI/Vt29EllqXv9aGrneqDgn6pop7fkxOZii51SfUJsSMYzQYGsC6W6
 jkUVhWxESO39JIttESKp78y1aMlBuFUb3psD0PNbEq1aisBK9/zMwSaM2hxXm4WKGi0e
 UthRdbbv4ZDuEfGCrpOVJzAetdmG0mLCqKURIF5aUtqfflsUR7WgmTJa2bpAtjw+gT0x
 ykEVxrw1ff0QZuatkbEBIv70eOdHpzGF/EIYKflGMNUYsqukLADZN+yWb4mraCwMdaZ7
 SHbQ==
X-Gm-Message-State: AOAM531oyh9euUQ/urECIGQVCI6nRFoeviktDXL//oo4ahsSyTCyMzoE
 VPWOw/2CJyEp8tigSiuLQfNJU7Kqiyw=
X-Google-Smtp-Source: ABdhPJxkiEjJhtwDrsP26RCPB8iIiTN7NUGYU4YxbtjeUSuZhcjXcBEjfPVDwmbg3bOkNSQGhmyBMg==
X-Received: by 2002:a17:90b:285:: with SMTP id
 az5mr4509628pjb.118.1596651467681; 
 Wed, 05 Aug 2020 11:17:47 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:38ab:50b1:ff8a:26ef])
 by smtp.gmail.com with ESMTPSA id a15sm3670196pfo.185.2020.08.05.11.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 11:17:46 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 18/21] target/sh4: add BQL to do_interrupt and
 cpu_exec_interrupt
Date: Wed,  5 Aug 2020 14:13:00 -0400
Message-Id: <20200805181303.7822-19-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805181303.7822-1-robert.foley@linaro.org>
References: <20200805181303.7822-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x642.google.com
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
 target/sh4/helper.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 1e32365c75..c4d5b9a374 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -62,8 +62,11 @@ void superh_cpu_do_interrupt(CPUState *cs)
 {
     SuperHCPU *cpu = SUPERH_CPU(cs);
     CPUSH4State *env = &cpu->env;
-    int do_irq = cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD;
-    int do_exp, irq_vector = cs->exception_index;
+    int do_irq;
+    int do_exp, irq_vector;
+    qemu_mutex_lock_iothread();
+    do_irq = cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD;
+    irq_vector = cs->exception_index;
 
     /* prioritize exceptions over interrupts */
 
@@ -79,9 +82,11 @@ void superh_cpu_do_interrupt(CPUState *cs)
                should be loaded with the kernel entry point.
                qemu_system_reset_request takes care of that.  */
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+            qemu_mutex_unlock_iothread();
             return;
         }
         if (do_irq && !env->in_sleep) {
+            qemu_mutex_unlock_iothread();
             return; /* masked */
         }
     }
@@ -91,6 +96,7 @@ void superh_cpu_do_interrupt(CPUState *cs)
         irq_vector = sh_intc_get_pending_vector(env->intc_handle,
 						(env->sr >> 4) & 0xf);
         if (irq_vector == -1) {
+            qemu_mutex_unlock_iothread();
             return; /* masked */
 	}
     }
@@ -180,14 +186,17 @@ void superh_cpu_do_interrupt(CPUState *cs)
             env->pc = env->vbr + 0x100;
             break;
         }
+        qemu_mutex_unlock_iothread();
         return;
     }
 
     if (do_irq) {
         env->intevt = irq_vector;
         env->pc = env->vbr + 0x600;
+        qemu_mutex_unlock_iothread();
         return;
     }
+    qemu_mutex_unlock_iothread();
 }
 
 static void update_itlb_use(CPUSH4State * env, int itlbnb)
-- 
2.17.1


