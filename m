Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5050BC433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:26:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC9D22D05
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tds7I/U9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC9D22D05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3O78-0002Dd-Ce
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 14:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nyv-0004cZ-Md
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:42 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:42201)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nyt-0006Us-OH
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:41 -0400
Received: by mail-pg1-x52e.google.com with SMTP id j21so6223070pgi.9
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 11:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cGAJoan4B9O593ZoXcT9RzOP5KLkia4jZDLI7E+9tcU=;
 b=Tds7I/U9g+SuWu3CENUS8yD1R6zMlB5mTn7dhl0J0a5fepdDTWILnXeyycKssYyR2r
 gS045Vy0TsdF0SLOnqf51zEBNnC/x0tPThj0r7n46eo0/4F+qsOANI5opv8ulp7TjDmW
 tBAJ8LEqnfuKVpkzk+BxmNDGJMkY640ScQuFp50gZqK1OaHl7tpCkOd+HonCIg20gglx
 /LOJKlwm0Dv3ukxOlh6KKBWUISpTxqQ4+OGDw5B4CdBFqr6o+F88rQTXs38z9SqKWAWc
 uAoWwbVhk89ILt5RKpBBbpt1qWoOYvfQgTx5Jk0hlPL3inrbVCRhnNimA7V3VqBEjQnj
 +RRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cGAJoan4B9O593ZoXcT9RzOP5KLkia4jZDLI7E+9tcU=;
 b=RqUiGnCV4wcJuuC8Xz+XLLvsYJexU573pj8pGah9XB9AADT86CVtnrZmgpg54cmPy/
 s3f/qZNGxHkw0fZyJYxBfbPpphjSvbPw16S4BfBxsOYEHWdJ9A0q8moWIhfDnYDWunVL
 3dRzm1UgxCX6eY+rTEywBI8VrKmF7zp8ONOLTj8G2zOkOHa295vVQoRUAj79aJqpQMpm
 b3VkC6LmY9F3ZQgNSC1YsTGqKr44vjOzpoJ3iyTdslAqCeK3tjdMtMXLEZsiPWw+1Agm
 SBIzKBfPiQ5K0B9Utihy2zTZzv4V18BKZBycjvztMarcy3xF0rkg8MXhLfxQvrTs463m
 FGZQ==
X-Gm-Message-State: AOAM532A2EINgLyh+NwkalLbXmxdFYXMenEERr6osAKJu5MKaUwvC+Ay
 yCkALre1P0/fxf/ccHaZTtRc47kzW34=
X-Google-Smtp-Source: ABdhPJz0OSyl7nFicaKz0+iHBOiHgfPfj7CRaS3tJ3x9hd/JNRvfVF1ZQg0/4ZpNfjdKNdM+5+O93Q==
X-Received: by 2002:a62:1901:: with SMTP id 1mr1143829pfz.160.1596651457654;
 Wed, 05 Aug 2020 11:17:37 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:38ab:50b1:ff8a:26ef])
 by smtp.gmail.com with ESMTPSA id a15sm3670196pfo.185.2020.08.05.11.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 11:17:36 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 14/21] target/ppc: add BQL to do_interrupt and
 cpu_exec_interrupt
Date: Wed,  5 Aug 2020 14:12:56 -0400
Message-Id: <20200805181303.7822-15-robert.foley@linaro.org>
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
Cc: robert.foley@linaro.org, cota@braap.org,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>, peter.puhov@linaro.org,
 pbonzini@redhat.com, alex.bennee@linaro.org,
 David Gibson <david@gibson.dropbear.id.au>
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
 target/ppc/excp_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index bf9e1e27e9..4530230d65 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -870,7 +870,9 @@ void ppc_cpu_do_interrupt(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
+    qemu_mutex_lock_iothread();
     powerpc_excp(cpu, env->excp_model, cs->exception_index);
+    qemu_mutex_unlock_iothread();
 }
 
 static void ppc_hw_interrupt(CPUPPCState *env)
@@ -1056,14 +1058,17 @@ bool ppc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
+    qemu_mutex_lock_iothread();
 
     if (interrupt_request & CPU_INTERRUPT_HARD) {
         ppc_hw_interrupt(env);
         if (env->pending_interrupts == 0) {
             cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
         }
+        qemu_mutex_unlock_iothread();
         return true;
     }
+    qemu_mutex_unlock_iothread();
     return false;
 }
 
-- 
2.17.1


