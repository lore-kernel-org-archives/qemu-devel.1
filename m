Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E8EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 125B822D70
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kXpbP+C2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 125B822D70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3O7X-0002ip-Ba
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 14:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nyh-0004F7-39
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:27 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nyf-0006TU-2K
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:26 -0400
Received: by mail-pl1-x644.google.com with SMTP id r4so15134267pls.2
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 11:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sPSOE7FlbJqSNOCq29FKQeTA9v1eH7Mn/6Yq8WOQ91Q=;
 b=kXpbP+C2n9auaXiYPp+Eepc+/rRmw8U+C30wKtE2ujwOqJQ42A5YToUA29b835eoOm
 NlCqlIgtLVJ9DkqYSuGUaUlQfKH8pCwTkvKrRX2CvNXpH26YOsMSDtzvJ4f+rdthJkeQ
 w91ZUKT0reTrfrDWByWFl/Fmgu+xGROindsnV1xOI1B/aIWeXGwU5L/kMGEyd7lv/jCl
 TAyRCW99BtjAWsMnEoavx3aoHZfPvBttjDEc34wa5nR+cbpB4Drxv+2uJjGVhc64cXNr
 Q0v587VqLJj8Zk5Lo203XbczOIUpjEruNmb97Nwxb+jeHXjvhBfg/YA1XKwXiLMMtJ7D
 Lf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sPSOE7FlbJqSNOCq29FKQeTA9v1eH7Mn/6Yq8WOQ91Q=;
 b=sg0DwxdiQLWqyR1LF5A4MNttmeXVP/tlcNHNsQJI1MrXxjTcM0sAQoKY22Ze9qgSUz
 xOPD3PuY1xrkEWHz1p5ciw/C66repThQ5miwXjRpbvK6gRYdSZmHyWUhIazsj7TBJFnA
 yTuTJ2elZfwu5Rb8iw9FQsvsixc7kwFU5APCKATiVbKMsBSiVOoeCRoKxRHS4562me3G
 97A+mVTV2dqOle/k8VuWqeNnzLGtG3+GKbjVyfaY30aIKTmSLsmev0KF9yjnoPNetPbg
 lwkJuP6s8g/RlLJOCH1HRpebXnmG5nHpH5hWWBijacfsfE3Krq5306ET9jPzl9ksBAgy
 qQFQ==
X-Gm-Message-State: AOAM533ox/ymzTXZQdwsYzvjfTYDFx1VHpqLsPKgXdVNhbrEdsn+0iC0
 HD64c7c+zEPuQLMwuqpn8klhVy52xA4=
X-Google-Smtp-Source: ABdhPJw57bBafTcrbeEn9KTju0Fby9+jOLCrQjaT0w6KEmbO2yygSwn+uonyHxDc68CyPrMYV9U/Jw==
X-Received: by 2002:a17:902:a607:: with SMTP id
 u7mr4360104plq.45.1596651443512; 
 Wed, 05 Aug 2020 11:17:23 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:38ab:50b1:ff8a:26ef])
 by smtp.gmail.com with ESMTPSA id a15sm3670196pfo.185.2020.08.05.11.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 11:17:22 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 08/21] target/lm32: add BQL to do_interrupt and
 cpu_exec_interrupt
Date: Wed,  5 Aug 2020 14:12:50 -0400
Message-Id: <20200805181303.7822-9-robert.foley@linaro.org>
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
Cc: robert.foley@linaro.org, Michael Walle <michael@walle.cc>, cota@braap.org,
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
 target/lm32/helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/lm32/helper.c b/target/lm32/helper.c
index 1130fc8884..4439b06ecc 100644
--- a/target/lm32/helper.c
+++ b/target/lm32/helper.c
@@ -152,6 +152,10 @@ void lm32_cpu_do_interrupt(CPUState *cs)
 {
     LM32CPU *cpu = LM32_CPU(cs);
     CPULM32State *env = &cpu->env;
+    bool bql = !qemu_mutex_iothread_locked();
+    if (bql) {
+        qemu_mutex_lock_iothread();
+    }
 
     qemu_log_mask(CPU_LOG_INT,
             "exception at pc=%x type=%x\n", env->pc, cs->exception_index);
@@ -196,18 +200,24 @@ void lm32_cpu_do_interrupt(CPUState *cs)
                   cs->exception_index);
         break;
     }
+    if (bql) {
+        qemu_mutex_unlock_iothread();
+    }
 }
 
 bool lm32_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     LM32CPU *cpu = LM32_CPU(cs);
     CPULM32State *env = &cpu->env;
+    qemu_mutex_lock_iothread();
 
     if ((interrupt_request & CPU_INTERRUPT_HARD) && (env->ie & IE_IE)) {
         cs->exception_index = EXCP_IRQ;
         lm32_cpu_do_interrupt(cs);
+        qemu_mutex_unlock_iothread();
         return true;
     }
+    qemu_mutex_unlock_iothread();
     return false;
 }
 
-- 
2.17.1


