Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167D2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B932084D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZnxLxPvT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B932084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3O02-00064H-2k
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 14:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3NyY-0003ru-36
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:18 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:45068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3NyW-0006Sj-4f
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:17 -0400
Received: by mail-pg1-x52e.google.com with SMTP id x6so9766927pgx.12
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 11:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4uh7S5GyruOrvvkqIbxUUTQpHZU58D4UbwkDmUFW2EA=;
 b=ZnxLxPvTb1uw8jQEnCyTstBMiwJm1/3Hl5RcLjNylUbP9/6AOq2w5dNVAGoC8x+e43
 AIlfcnpoi2Cv+edm2msmYD/sD8fKh1CstKZj1C/1ZxNTHuKRQyQ1AG9AMW+jHI8tLjOJ
 p6Iz7Dx19IeWyqCKa279WT21uor8x4+qK1j/2TkXiHwTFyM/foCngQTVm/CgOdAsbnK+
 Hb/7j6fJRNtC/poUI1E8loeEGyMmjNjnAhmdXQ1bRCpieaa22khzfeZdViZKszShZDZp
 aut/LmiurlyLJaAMk/jwbT4nxZehEtJbl+lpHgFw61LjMG7UtqJsARtS1C2ptPxjXRb1
 xhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4uh7S5GyruOrvvkqIbxUUTQpHZU58D4UbwkDmUFW2EA=;
 b=gi1lkYLtIkr/mpnXruoRTO9fHniQWVgKtZM/zTxB7pieoAfEa1bUfNnLhfTfSo5sHt
 2D62/C6uT27WivudjJQAeGzA6nnHy9enddFfwuZXve8p/8oh3l9q3k1UYBts0WNbe+YW
 SfUOfaYrIhiCngvzLpAJNrTherx0M7JKE9B5A+FkDXN5XXDY3kmbjyoYSdmx1LbY00ur
 X92gjC0EI/RzqCKno/Vx6bMxJdQTs6v2gnks+eyEeC0xkXeJ5Nr+j9QJsCpDk2CddhnC
 PdWsN03eheYGEJ/dDhDYOvv2aq8dLm+mTz8XEhA9XDmaWcwpihpS52incn+MCLJDvEHm
 h0DA==
X-Gm-Message-State: AOAM531HpeGfWsZXZRolAFpikdaGs0Yb4rsoFFaGHq8A2/oNhbnesw5i
 /A8QhAPX6Jqqcj8oHuu0qTYnrPAtLVY=
X-Google-Smtp-Source: ABdhPJx/ZasY6bvOdsE4vYzNmekb0VWj1du8DZv1XJhh5W87VTVb3uk4uD9sU+kPEP3G/R+7zlY9ng==
X-Received: by 2002:aa7:8c19:: with SMTP id c25mr4597482pfd.17.1596651434328; 
 Wed, 05 Aug 2020 11:17:14 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:38ab:50b1:ff8a:26ef])
 by smtp.gmail.com with ESMTPSA id a15sm3670196pfo.185.2020.08.05.11.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 11:17:13 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 04/21] target/avr: add BQL to do_interrupt and
 cpu_exec_interrupt
Date: Wed,  5 Aug 2020 14:12:46 -0400
Message-Id: <20200805181303.7822-5-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805181303.7822-1-robert.foley@linaro.org>
References: <20200805181303.7822-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=robert.foley@linaro.org; helo=mail-pg1-x52e.google.com
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, robert.foley@linaro.org,
 cota@braap.org, Michael Rolnik <mrolnik@gmail.com>, peter.puhov@linaro.org,
 pbonzini@redhat.com, alex.bennee@linaro.org
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
 target/avr/helper.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/avr/helper.c b/target/avr/helper.c
index d96d14372b..f0d625c195 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -30,6 +30,7 @@ bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     CPUClass *cc = CPU_GET_CLASS(cs);
     AVRCPU *cpu = AVR_CPU(cs);
     CPUAVRState *env = &cpu->env;
+    qemu_mutex_lock_iothread();
 
     if (interrupt_request & CPU_INTERRUPT_RESET) {
         if (cpu_interrupts_enabled(env)) {
@@ -53,6 +54,7 @@ bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
             ret = true;
         }
     }
+    qemu_mutex_unlock_iothread();
     return ret;
 }
 
@@ -61,10 +63,15 @@ void avr_cpu_do_interrupt(CPUState *cs)
     AVRCPU *cpu = AVR_CPU(cs);
     CPUAVRState *env = &cpu->env;
 
-    uint32_t ret = env->pc_w;
+    uint32_t ret;
     int vector = 0;
     int size = avr_feature(env, AVR_FEATURE_JMP_CALL) ? 2 : 1;
     int base = 0;
+    bool bql = !qemu_mutex_iothread_locked();
+    if (bql) {
+        qemu_mutex_lock_iothread();
+    }
+    ret = env->pc_w;
 
     if (cs->exception_index == EXCP_RESET) {
         vector = 0;
@@ -87,6 +94,9 @@ void avr_cpu_do_interrupt(CPUState *cs)
     env->sregI = 0; /* clear Global Interrupt Flag */
 
     cs->exception_index = -1;
+    if (bql) {
+        qemu_mutex_unlock_iothread();
+    }
 }
 
 int avr_cpu_memory_rw_debug(CPUState *cs, vaddr addr, uint8_t *buf,
-- 
2.17.1


