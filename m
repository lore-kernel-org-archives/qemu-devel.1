Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA48CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:22:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A650422CA0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pgFeFCV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A650422CA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3O3H-0003vQ-Qa
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 14:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nyj-0004KP-Fn
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:29 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33108)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nyh-0006Tj-JI
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:29 -0400
Received: by mail-pl1-x642.google.com with SMTP id g19so13194188plq.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 11:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sAMCBrWOlvhWHRQfoPG7nat7D/DsWHPnezgCzgjj800=;
 b=pgFeFCV28gv4EmomjDuouj08WrzlGGVyl4HrPVq1A3OBVWQzCKx+H0SQ2lKMKrK4qB
 iYDKiZEQZyN+dAjIVCioY7q3XGkOccA7zxrTa6Ja65AOxlrmsc5OL/tjdRMEp9v3GVT0
 WuSLnKaAEzF08yAqcEH4H9lnkDmoEOznYUMkkpbvBphq/d+/Rs1s55MVY8dea7f7GgoB
 Fmr9G3RH4BoP9n2JxESNitGRDzFpmBz1kktdOYn+r/Q6X1ycGAnwoMrKmXJdPvGhx+FD
 /SqQeV2GwaYLI6bDeG6luXUT56l7fT4xHIv0eTPhUr8WPaW4+iY2brd7k0A1RGXQ+6ee
 ViGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sAMCBrWOlvhWHRQfoPG7nat7D/DsWHPnezgCzgjj800=;
 b=mQBpVQu6GB491I14rxRgY7M0kYi3IlbnNGy8s7/Fom/lHfB7Et9+Rl48/sQLvrgMIj
 YSYEF5yt1xSxG2bgt3B+DsmUyqkmuVwShuu0XIBLHiBDSLItV3z36dxOboUoh9xydBQl
 ZMq8/IsXcO+UtSsu6CQ7cZpRIiqerEqRVBZHjojv+BnzxKcYM2+qv1hr+ZUm74sM/Ho0
 JtkTgENo/EvzZBMkHFGHEveUJL4l/30red/hnkYrbO+PcUcGCU62hctrfdmaCIHOsUVr
 YTXJj8paEC+vDHiYgnImUcnkgRVdOaHB4GiWdC29ZnQIxLwv8FhaIbbTDql1uyX9jzu3
 JRvg==
X-Gm-Message-State: AOAM532wOidjrJM3tV1erUAHb6dovTY9kyRLn3QYiqoSB9ZIP/24caol
 QTtZwVarLpy//viGcBESynvdUoj00s8=
X-Google-Smtp-Source: ABdhPJzDneRVJGQlpi0AXr3Q4Oqc1LhHMlOzGzmZ8ep7wXdXwe09mymA12VoEfGNS62OZGhR6C8+vg==
X-Received: by 2002:a17:902:7d84:: with SMTP id
 a4mr4286651plm.44.1596651445773; 
 Wed, 05 Aug 2020 11:17:25 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:38ab:50b1:ff8a:26ef])
 by smtp.gmail.com with ESMTPSA id a15sm3670196pfo.185.2020.08.05.11.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 11:17:25 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 09/21] target/m68k: add BQL to do_interrupt and
 cpu_exec_interrupt
Date: Wed,  5 Aug 2020 14:12:51 -0400
Message-Id: <20200805181303.7822-10-robert.foley@linaro.org>
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
Cc: robert.foley@linaro.org, Laurent Vivier <laurent@vivier.eu>, cota@braap.org,
 peter.puhov@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org
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
 target/m68k/op_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 4a032a150e..0c3333476a 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -448,7 +448,9 @@ void m68k_cpu_do_interrupt(CPUState *cs)
     M68kCPU *cpu = M68K_CPU(cs);
     CPUM68KState *env = &cpu->env;
 
+    qemu_mutex_lock_iothread();
     do_interrupt_all(env, 0);
+    qemu_mutex_unlock_iothread();
 }
 
 static inline void do_interrupt_m68k_hardirq(CPUM68KState *env)
@@ -508,6 +510,7 @@ bool m68k_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     M68kCPU *cpu = M68K_CPU(cs);
     CPUM68KState *env = &cpu->env;
+    qemu_mutex_lock_iothread();
 
     if (interrupt_request & CPU_INTERRUPT_HARD
         && ((env->sr & SR_I) >> SR_I_SHIFT) < env->pending_level) {
@@ -519,8 +522,10 @@ bool m68k_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
          */
         cs->exception_index = env->pending_vector;
         do_interrupt_m68k_hardirq(env);
+        qemu_mutex_unlock_iothread();
         return true;
     }
+    qemu_mutex_unlock_iothread();
     return false;
 }
 
-- 
2.17.1


