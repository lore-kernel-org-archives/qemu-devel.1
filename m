Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BB0C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D746821841
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rYl0g55d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D746821841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfMp-0003oL-3h
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfE5-0003FF-Kh
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:05 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735]:37882)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDy-0008Ut-3e
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:05 -0400
Received: by mail-qk1-x735.google.com with SMTP id b27so3509458qka.4
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P/Z/EXXqAnjV0sexMMAA4/Iljvg21zFf1h2uuTezcCs=;
 b=rYl0g55datJBDFOzYMAmY/qRs0L2+E1EYtDPb3ksHvVLJcqUHrpW8wYokoG5DNO+Fi
 bIjE8ztfakJGXq7daiaJCguXuZUr9mFHSQI13yB6Gq4DLYnenjL/s5GHkfN0EqJ3hcnv
 qsxtamP9muOpEFwv2WCSvuUd32Gv44hUp43M5UtYygsJn1gIxvmb14fS4M8IDIFMsonY
 L5dJ+I0fJ6UTJiUbWaXWfxVEedsI+iviFZ6TOPxyM6Tv7B6N2y3kAtEhHrne1R4LMhj2
 OYYltDDj9mEFHAbaUuHZ5rbBbPhQTqJ7jKjHJGpwjhopaW23i0wV4zUx766vuUXMFAj7
 WJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P/Z/EXXqAnjV0sexMMAA4/Iljvg21zFf1h2uuTezcCs=;
 b=mHUGu6OBDjucRaUMOMWhD2JtBulkxG0vtOyI+4YVyaDZIHavZ6yZ5vp5dcTkjALs0u
 MwNPGnNmjOSkbYfKnkpxWb649jQ1C4nFsO2pRSiUQPFEllPsXDCwLnbRC2HdnS7uWKPT
 PftSTy6SkTmk1HJmdFANZj2PzjPAhsKCa6LWZeBovi0LbTkppOGfZLKPsoY4yeER7ek3
 biNdcJQuzuARxgsgQviaM9FPXWhcOzGOVRPIsggQeP3FP59ETyCx1ABA+wopd7zoPSvn
 hZmjyD4IZiXXYJN92d99ESIC58wp018zrrW0LWKJbffD/WCllQQCoc3Er1PH7YolrZ68
 QzDQ==
X-Gm-Message-State: AOAM533ye0HsY2QqPZ8rcKMzc6V++3MoTUPGA5OwYHDKQhtHEp0tBjs1
 DGKrKX88vr2gikmAhibWKRb+/+/r13hEyg==
X-Google-Smtp-Source: ABdhPJyriGqbN04M4QQNoNrZwND12p2JQjyvNPY62On3fXEpCBEG+5rxR+7OWtR8gmWmV5tpI68M5A==
X-Received: by 2002:a05:620a:14b8:: with SMTP id
 x24mr532712qkj.284.1592427834123; 
 Wed, 17 Jun 2020 14:03:54 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:53 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 26/73] sparc: convert to cpu_halted
Date: Wed, 17 Jun 2020 17:01:44 -0400
Message-Id: <20200617210231.4393-27-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x735.google.com
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
Cc: robert.foley@linaro.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, cota@braap.org,
 peter.puhov@linaro.org, alex.bennee@linaro.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Fabien Chouteau <chouteau@adacore.com>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 hw/sparc/leon3.c      | 2 +-
 hw/sparc/sun4m.c      | 8 ++++----
 hw/sparc64/sparc64.c  | 4 ++--
 target/sparc/helper.c | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index d40b7891f6..aea1b4200f 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -132,7 +132,7 @@ static void main_cpu_reset(void *opaque)
 
     cpu_reset(cpu);
 
-    cpu->halted = 0;
+    cpu_halted_set(cpu, 0);
     env->pc     = s->entry;
     env->npc    = s->entry + 4;
     env->regbase[6] = s->sp;
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index ee52b5cbbc..12f9ac1b61 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -193,7 +193,7 @@ static void cpu_kick_irq(SPARCCPU *cpu)
     CPUSPARCState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
 
-    cs->halted = 0;
+    cpu_halted_set(cs, 0);
     cpu_check_irqs(env);
     qemu_cpu_kick(cs);
 }
@@ -224,7 +224,7 @@ static void main_cpu_reset(void *opaque)
     CPUState *cs = CPU(cpu);
 
     cpu_reset(cs);
-    cs->halted = 0;
+    cpu_halted_set(cs, 0);
 }
 
 static void secondary_cpu_reset(void *opaque)
@@ -233,7 +233,7 @@ static void secondary_cpu_reset(void *opaque)
     CPUState *cs = CPU(cpu);
 
     cpu_reset(cs);
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
 }
 
 static void cpu_halt_signal(void *opaque, int irq, int level)
@@ -832,7 +832,7 @@ static void cpu_devinit(const char *cpu_type, unsigned int id,
     } else {
         qemu_register_reset(secondary_cpu_reset, cpu);
         cs = CPU(cpu);
-        cs->halted = 1;
+        cpu_halted_set(cs, 1);
     }
     *cpu_irqs = qemu_allocate_irqs(cpu_set_irq, cpu, MAX_PILS);
     env->prom_addr = prom_addr;
diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index 100b2fab17..fe9c678459 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -101,7 +101,7 @@ static void cpu_kick_irq(SPARCCPU *cpu)
     CPUState *cs = CPU(cpu);
     CPUSPARCState *env = &cpu->env;
 
-    cs->halted = 0;
+    cpu_halted_set(cs, 0);
     cpu_check_irqs(env);
     qemu_cpu_kick(cs);
 }
@@ -116,7 +116,7 @@ void sparc64_cpu_set_ivec_irq(void *opaque, int irq, int level)
         if (!(env->ivec_status & 0x20)) {
             trace_sparc64_cpu_ivec_raise_irq(irq);
             cs = CPU(cpu);
-            cs->halted = 0;
+            cpu_halted_set(cs, 0);
             env->interrupt_index = TT_IVEC;
             env->ivec_status |= 0x20;
             env->ivec_data[0] = (0x1f << 6) | irq;
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 07d87efa4e..90dfb1e92f 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -244,7 +244,7 @@ void helper_power_down(CPUSPARCState *env)
 {
     CPUState *cs = env_cpu(env);
 
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     cs->exception_index = EXCP_HLT;
     env->pc = env->npc;
     env->npc = env->pc + 4;
-- 
2.17.1


