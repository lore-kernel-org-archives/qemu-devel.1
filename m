Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C63C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2C322CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ecXrb467"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2C322CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3O3Y-0004VU-0h
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 14:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nya-0003zE-Er
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:20 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:44815)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3NyY-0006Sw-GA
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:20 -0400
Received: by mail-pf1-x436.google.com with SMTP id r11so15310039pfl.11
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 11:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=MJQQ/dt5YPVkuurfAkJuoHtRneXdeiakI4OjTjMGNhA=;
 b=ecXrb467asYl7YNp/vXs2aS0/5T8I2Ufg8BsI7f0Iu/Wml6ucV0bCY1gRFZryfvNXC
 fHFnJJZLoEumsYXCUB4GVPM6AWYKybYAf0QMT3BBs3l/BzKaiCPepUGMCghM1kaCeLHG
 LW5TPgjtunBMCgwE1CT0Jxk7XttdbIYYbcpDUBow+oNQv/cjCW62+hkGH4gXsHnIFQ7U
 mno2fSJ1KqlM8w079kPyFNzMnKXIk5QMLTLl5mrzPZ5xSoLuuMD4Tkij3L/2EKgC/a0O
 G8i8ijbCCBtodppYNmPQOp9ae768KAo507AzP9SSItMF3ckURhzj0hz520bka3ND5Y3k
 oaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=MJQQ/dt5YPVkuurfAkJuoHtRneXdeiakI4OjTjMGNhA=;
 b=TF6QDyqN3Wb5dgqz+KREPzUIV08zjTavJRZUNC1LmIEHBWKDGwXfg5Ngi9JhAat3kk
 OKjJ2UC4JhZyHKKoVdTDzSnHj0byKzUZvVt+bziHUAZw+53L+OHjYlacfnCLTXKOlGDp
 YRTrGFpEiBxc3Ykbaxv2X2o4Fh6Lg81VYwxInv3Al2J+vG6yu2+m64gVR2ja0jJ2Gl/L
 LhDQV0KEHCJCxSGftyAPXxjFMp9R2gVDARnOVQSOsPgLfC9+Jjl/ebO9VIjZh0HHyFD1
 txgnbBjJjfHLK9BXR/lyBls1WoON9Xd6fR1iR/zQNy5cz6srh7G4xXUahWTaAfyE2fiY
 WmLg==
X-Gm-Message-State: AOAM532lQF8yPHkL2++hNPb/WP6GyqHsV0bQUYIEDtU0aSe5WUBr3wh0
 E0ilfgLaUezuWXDUFyuISMxENZ963/s=
X-Google-Smtp-Source: ABdhPJxdUuFzb9zIkBqwhnwHnPROq9eLL1vi5jEf6DRKhkiPvrj7S4oQQpbTORBBiiVdWZ9z965Ttg==
X-Received: by 2002:aa7:9a4c:: with SMTP id x12mr4624405pfj.307.1596651436669; 
 Wed, 05 Aug 2020 11:17:16 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:38ab:50b1:ff8a:26ef])
 by smtp.gmail.com with ESMTPSA id a15sm3670196pfo.185.2020.08.05.11.17.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 11:17:15 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 05/21] target/cris: add BQL to do_interrupt and
 cpu_exec_interrupt
Date: Wed,  5 Aug 2020 14:12:47 -0400
Message-Id: <20200805181303.7822-6-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805181303.7822-1-robert.foley@linaro.org>
References: <20200805181303.7822-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=robert.foley@linaro.org; helo=mail-pf1-x436.google.com
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
 target/cris/helper.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/target/cris/helper.c b/target/cris/helper.c
index 67946d9246..22aecde0f5 100644
--- a/target/cris/helper.c
+++ b/target/cris/helper.c
@@ -45,8 +45,10 @@ void cris_cpu_do_interrupt(CPUState *cs)
     CRISCPU *cpu = CRIS_CPU(cs);
     CPUCRISState *env = &cpu->env;
 
+    qemu_mutex_lock_iothread();
     cs->exception_index = -1;
     env->pregs[PR_ERP] = env->pc;
+    qemu_mutex_unlock_iothread();
 }
 
 void crisv10_cpu_do_interrupt(CPUState *cs)
@@ -128,6 +130,10 @@ void crisv10_cpu_do_interrupt(CPUState *cs)
     CRISCPU *cpu = CRIS_CPU(cs);
     CPUCRISState *env = &cpu->env;
     int ex_vec = -1;
+    bool bql = !qemu_mutex_iothread_locked();
+    if (bql) {
+        qemu_mutex_lock_iothread();
+    }
 
     D_LOG("exception index=%d interrupt_req=%d\n",
           cs->exception_index,
@@ -183,6 +189,9 @@ void crisv10_cpu_do_interrupt(CPUState *cs)
                   env->pregs[PR_CCS],
                   env->pregs[PR_PID],
                   env->pregs[PR_ERP]);
+    if (bql) {
+        qemu_mutex_unlock_iothread();
+    }
 }
 
 void cris_cpu_do_interrupt(CPUState *cs)
@@ -190,6 +199,10 @@ void cris_cpu_do_interrupt(CPUState *cs)
     CRISCPU *cpu = CRIS_CPU(cs);
     CPUCRISState *env = &cpu->env;
     int ex_vec = -1;
+    bool bql = !qemu_mutex_iothread_locked();
+    if (bql) {
+        qemu_mutex_lock_iothread();
+    }
 
     D_LOG("exception index=%d interrupt_req=%d\n",
           cs->exception_index,
@@ -265,6 +278,9 @@ void cris_cpu_do_interrupt(CPUState *cs)
           env->pregs[PR_CCS],
           env->pregs[PR_PID],
           env->pregs[PR_ERP]);
+    if (bql) {
+        qemu_mutex_unlock_iothread();
+    }
 }
 
 hwaddr cris_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
@@ -294,6 +310,7 @@ bool cris_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     CRISCPU *cpu = CRIS_CPU(cs);
     CPUCRISState *env = &cpu->env;
     bool ret = false;
+    qemu_mutex_lock_iothread();
 
     if (interrupt_request & CPU_INTERRUPT_HARD
         && (env->pregs[PR_CCS] & I_FLAG)
@@ -315,6 +332,7 @@ bool cris_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
             ret = true;
         }
     }
+    qemu_mutex_unlock_iothread();
 
     return ret;
 }
-- 
2.17.1


