Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D670C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:36:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 628662085B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z7nPbxN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628662085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfjO-0005bF-Ss
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEO-0003to-Ts
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:24 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:34515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEN-0000J1-2z
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:24 -0400
Received: by mail-qv1-xf44.google.com with SMTP id fc4so1776123qvb.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cJAv+EbsefdW66yr8LjRtj+7g6Sr3jeK6hHxTVUkhJA=;
 b=Z7nPbxN9nrVvlMAqzjDNaj7kD9CZdQv9dyywyXt+Ph1BM/q33gxGtkIo2dCblV9zOU
 G+TubiU7MZCinD1HWYpJ0N0L/1R8N0wgimpk/H4fy1yW8XvPn9Ak3dUE0nCK5Hpmwb3V
 KAem1secs41VxsXUxefQL1BK/uVozQXpFefh1v3rLB1VcpNsrfo6qKACtcVbe5NoCSxD
 Qrou6/svXhi8H8xvbkKMl5XRi8b3ga6tU8OhHQ+5tPgWlEVYabuzcEFFaGoyVDGZTCd0
 zG/Ce1+Gy3nKaR8YeF77hG5ktujcKP4+w+bSzIWUpESXwB3YZ/csxKc3OJj9c1ZqqMjz
 gagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cJAv+EbsefdW66yr8LjRtj+7g6Sr3jeK6hHxTVUkhJA=;
 b=IegCyd8PKhDNZVOl+JjlAuwjhj9BIvH0yUn/4pqxj++J65Nz+Mu7BdGf7rDYQ1sjw4
 brWjN2FnoS73Z0BQwMLENOR3KoRnw1igpPzQWQ2sTkky95q8xcZR5NjvQ1ykCuYQVcKo
 /Zp3xkA7yrmJPUCLSDEPh2nY501Ciw4OzwO2VS4nHdmsPaNCbkRMo3tv4TIetIHPNHab
 ba/x/PCMQSLiL3ziYAO/NxIRjgk/UuWiN1wy5voavNlA3neMDU/ogjiGOojgVJQsYhBl
 bnhWyijspdqKGFfUHlX75qBxl/OkkTDvNBW8DNJ+arAijrtf7Co+qi77NdO1h9SusfPv
 O3YQ==
X-Gm-Message-State: AOAM531DdqLoZJiBmhzEUD7LZ7z3vruqBGCjKQUxt3GL67i8ILLPPRRh
 D2yD3IyN7is7CxEWOCLGquASom3O/pfgMQ==
X-Google-Smtp-Source: ABdhPJxYV3yaUAovRK41PP3Qo7LV9GbVJ8hNhPHC6zuDNA5ZR/421XqHVubbGWH9FCe12abmYZraTQ==
X-Received: by 2002:a0c:9ae2:: with SMTP id k34mr519566qvf.247.1592427861880; 
 Wed, 17 Jun 2020 14:04:21 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:21 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 45/73] sh4: convert to cpu_interrupt_request
Date: Wed, 17 Jun 2020 17:02:03 -0400
Message-Id: <20200617210231.4393-46-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f44;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 cota@braap.org, peter.puhov@linaro.org, alex.bennee@linaro.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/sh4/cpu.c    | 2 +-
 target/sh4/helper.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 3c68021c56..18f3448183 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -44,7 +44,7 @@ static void superh_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
 
 static bool superh_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & CPU_INTERRUPT_HARD;
+    return cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD;
 }
 
 static void superh_cpu_reset(DeviceState *dev)
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 408478ce5d..1e32365c75 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -62,7 +62,7 @@ void superh_cpu_do_interrupt(CPUState *cs)
 {
     SuperHCPU *cpu = SUPERH_CPU(cs);
     CPUSH4State *env = &cpu->env;
-    int do_irq = cs->interrupt_request & CPU_INTERRUPT_HARD;
+    int do_irq = cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD;
     int do_exp, irq_vector = cs->exception_index;
 
     /* prioritize exceptions over interrupts */
-- 
2.17.1


