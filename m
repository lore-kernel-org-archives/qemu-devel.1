Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D734EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A625D2168B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VaZgkRbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A625D2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfwC-0004pr-Qw
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEo-0004a8-Uf
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:51 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:35411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEl-0000OE-JT
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:50 -0400
Received: by mail-qk1-x743.google.com with SMTP id q2so3530862qkb.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Wzz0etTpNkLIVhXKsaNrdHJF+FQFmmiKYteH+ClsJ3Y=;
 b=VaZgkRbqExWZmfHzCi1ylCk2OTlGq4vZUGFz8454JcjhQz7U8XsVLAJhEjS86oc7YI
 aIT2qvw6nlnhOTcxuk8SVnV44NBHZzePlYGJAX5TdIbJgkpx1moTYkZcOXQDKXG9XHjC
 L3JiZMZxBV7VBqGv/oOqwgGOYBR1xEBX6MT/PF6hpHn1Z/XJCS4JkHOGgPebZezzmg9U
 KBk5TzEZoIvwdR54MhA0oPcnVdXjmR/MyaMitLvtcUbGlU9+4f0cRB5nMhGfQEuBFmdV
 i2wPNQO0YBZ4IrOqlXXFaiZFjONytjH3ilx2BIXW/O2jGYmlg3dqQaxLXZXtzeDA5kJ9
 x+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Wzz0etTpNkLIVhXKsaNrdHJF+FQFmmiKYteH+ClsJ3Y=;
 b=WFdl5v8aXNWQSwbqhMSjsopFyq8Fc8oUsYcJ3gVmg7OWdjJxon4VeXFBWDNCYozXs8
 2xWriMgpKrlmhr75C3V/yt73NIFw9rjJTqDxgLMluPRjFKx6Ryj3l0rgC9lY3tXdy+js
 UcMJB/lP4sEp23LUWz2qdJIkSB6TetIvMhhaS5C1TITvMp7mlmAqmbYt5mRvmhe6q84U
 nYP5i71l6WuxBK66GKNmJVZUcd1OFRdQszoWUZ4gqa14cNMfbKSsMZdfvTeGjBEOTRA3
 Dwgy1yQCyP0x4TzQGFlRRr8i+1JuD3hTursbgneL7kjP01QRWIuCn88ij45XzQDx3eOL
 PFig==
X-Gm-Message-State: AOAM533igE9RhEvZExxQxYALLN2IOs7VgvcjTbVOvXaIw4JQKbpLaToW
 xfG4Et5YeBD+o+dnRRgB9jgf7u5rBctUMg==
X-Google-Smtp-Source: ABdhPJxM6QYpcRkr9Oc35nOQvHJgtBtlSj0UtIwI8rlUvBY9sV4CeFovpAHG4xq1HcNUQ6mZvlmC+A==
X-Received: by 2002:a37:9684:: with SMTP id y126mr593877qkd.348.1592427886325; 
 Wed, 17 Jun 2020 14:04:46 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:45 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 63/73] ppc: convert to cpu_has_work_with_iothread_lock
Date: Wed, 17 Jun 2020 17:02:21 -0400
Message-Id: <20200617210231.4393-64-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x743.google.com
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
Cc: robert.foley@linaro.org, cota@braap.org, qemu-ppc@nongnu.org,
 peter.puhov@linaro.org, alex.bennee@linaro.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Soon we will call cpu_has_work without the BQL.

Cc: qemu-ppc@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Emilio G. Cota <cota@braap.org>
[RF: Converted new code related to POWER10]
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/ppc/translate_init.inc.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index d06d9ff204..60ee51c105 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8540,6 +8540,8 @@ static bool cpu_has_work_POWER7(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
+    g_assert(qemu_mutex_iothread_locked());
+
     if (cpu_halted(cs)) {
         if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
             return false;
@@ -8582,7 +8584,7 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data)
     pcc->pcr_supported = PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
     pcc->init_proc = init_proc_POWER7;
     pcc->check_pow = check_pow_nocheck;
-    cc->has_work = cpu_has_work_POWER7;
+    cc->has_work_with_iothread_lock = cpu_has_work_POWER7;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -8702,6 +8704,8 @@ static bool cpu_has_work_POWER8(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
+    g_assert(qemu_mutex_iothread_locked());
+
     if (cpu_halted(cs)) {
         if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
             return false;
@@ -8752,7 +8756,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
     pcc->pcr_supported = PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
     pcc->init_proc = init_proc_POWER8;
     pcc->check_pow = check_pow_nocheck;
-    cc->has_work = cpu_has_work_POWER8;
+    cc->has_work_with_iothread_lock = cpu_has_work_POWER8;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -8902,6 +8906,8 @@ static bool cpu_has_work_POWER9(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
+    g_assert(qemu_mutex_iothread_locked());
+
     if (cpu_halted(cs)) {
         uint64_t psscr = env->spr[SPR_PSSCR];
 
@@ -8969,7 +8975,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
                          PCR_COMPAT_2_05;
     pcc->init_proc = init_proc_POWER9;
     pcc->check_pow = check_pow_nocheck;
-    cc->has_work = cpu_has_work_POWER9;
+    cc->has_work_with_iothread_lock = cpu_has_work_POWER9;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -9118,6 +9124,7 @@ static bool cpu_has_work_POWER10(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
+    g_assert(qemu_mutex_iothread_locked());
     if (cpu_halted(cs)) {
         uint64_t psscr = env->spr[SPR_PSSCR];
 
@@ -9186,7 +9193,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
                          PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
     pcc->init_proc = init_proc_POWER10;
     pcc->check_pow = check_pow_nocheck;
-    cc->has_work = cpu_has_work_POWER10;
+    cc->has_work_with_iothread_lock = cpu_has_work_POWER10;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -10656,6 +10663,8 @@ static bool ppc_cpu_has_work(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
+    g_assert(qemu_mutex_iothread_locked());
+
     return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
 }
 
@@ -10880,7 +10889,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = ppc_cpu_class_by_name;
     pcc->parent_parse_features = cc->parse_features;
     cc->parse_features = ppc_cpu_parse_featurestr;
-    cc->has_work = ppc_cpu_has_work;
+    cc->has_work_with_iothread_lock = ppc_cpu_has_work;
     cc->do_interrupt = ppc_cpu_do_interrupt;
     cc->cpu_exec_interrupt = ppc_cpu_exec_interrupt;
     cc->dump_state = ppc_cpu_dump_state;
-- 
2.17.1


