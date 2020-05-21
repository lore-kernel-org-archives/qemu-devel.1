Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE68C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C42320884
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RDIeoaKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C42320884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboVd-00050q-78
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIT-00030Z-Np
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:53 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832]:35551)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIS-0006Yr-IY
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:53 -0400
Received: by mail-qt1-x832.google.com with SMTP id z18so6021834qto.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eHaQBXlGwYEJ+LUDpIzgk48KJ4nxL6vb+7Ag6IrpPa0=;
 b=RDIeoaKVwO60kH/bb4xqU79wAH4A5kAGqh6pg4mG3qUN081R0/NYSQKrYxa7PN2667
 UtmNc34vJIS+NZoY7Afx3SgzYhhBxicmb9jME1fbIiqpJX/IFyAWI43BiXziV1rMYwSU
 EeN+ttXpYvKcKJYnU1vdoSe+3/PIrxGCz7D9Q3eBPJH1Bnh3GaOBQ/4p+3SRt38ppu5T
 9z6zLy/f30lhlXCpg3B4zGqRbCZJ02dfUosiCdFiTZl3pa5OCFgeG257UjLD7p7BcBJ/
 k4gW8DxwJog+JPsMPoEOuINiOa1yq/ZIuvzqxT7bugiUoQqdWcEFIYkAUF9vEkKtAQPr
 zJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eHaQBXlGwYEJ+LUDpIzgk48KJ4nxL6vb+7Ag6IrpPa0=;
 b=osbgRicbre7dyhmxSN+RjDemT+xwST1YazoWdhAaQNguwDY+3eaCTJPL3bcOCDb4jq
 fqo8ixQDFCiGKzWHvzbUzT1S5XukMXVkLKIbUsaiIjTQti3YqT3UTxsCYUeoxGrqE2O1
 tsmYjFv1elgh4u7XBKHZUtJxr/5gU4AlBnypSvgTx6bjcuWnhZchiVlMb5u41cfyu0Nd
 ODbG8Z6610rmNyhprn5oB9NhPQvdqixYEYcxANJ8BgLgEoimA19R1zVfQ5F3AclfhHJC
 42jqJf41glAVNQJCNMd/NyPA/ZuG4QrszMoYsIbaefewlJ+Zlda/TXY1kIAfORS3fSL1
 QPmA==
X-Gm-Message-State: AOAM532TrWnrIStI9jRv8XByqG9ibXZ7ZZT7GDUR/4aaiT74QY7k+tru
 6LDw+iJJfy0QR5kFgdZWAorMh1NwPLSjAQ==
X-Google-Smtp-Source: ABdhPJwYYZXBuUGYIr+NMmiNDPXHRgaTGxjjaIflF4Jg2U0bJb+DXHma+tBagKJqKmP3o7ddWaq2YQ==
X-Received: by 2002:aed:20d1:: with SMTP id 75mr11676981qtb.1.1590079431267;
 Thu, 21 May 2020 09:43:51 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:43:50 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 27/74] sparc: convert to cpu_halted
Date: Thu, 21 May 2020 12:39:24 -0400
Message-Id: <20200521164011.638-28-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x832.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org,
 Fabien Chouteau <chouteau@adacore.com>, cota@braap.org, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Artyom Tarasenko <atar4qemu@gmail.com>
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
index 8f024dab7b..00d1efd430 100644
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
index 8dda3f7292..e189ba5395 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -192,7 +192,7 @@ static void cpu_kick_irq(SPARCCPU *cpu)
     CPUSPARCState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
 
-    cs->halted = 0;
+    cpu_halted_set(cs, 0);
     cpu_check_irqs(env);
     qemu_cpu_kick(cs);
 }
@@ -223,7 +223,7 @@ static void main_cpu_reset(void *opaque)
     CPUState *cs = CPU(cpu);
 
     cpu_reset(cs);
-    cs->halted = 0;
+    cpu_halted_set(cs, 0);
 }
 
 static void secondary_cpu_reset(void *opaque)
@@ -232,7 +232,7 @@ static void secondary_cpu_reset(void *opaque)
     CPUState *cs = CPU(cpu);
 
     cpu_reset(cs);
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
 }
 
 static void cpu_halt_signal(void *opaque, int irq, int level)
@@ -831,7 +831,7 @@ static void cpu_devinit(const char *cpu_type, unsigned int id,
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


