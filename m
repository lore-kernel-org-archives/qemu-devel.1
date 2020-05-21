Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAC5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E0420759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cKtTSVcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E0420759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbofM-0002GX-J4
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJH-0004YG-3G
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:43 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:43435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJF-0006l6-CD
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:42 -0400
Received: by mail-qk1-x742.google.com with SMTP id i14so7816886qka.10
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VF7BD2whUFR8MWRbhBIqKLqcFA5T5WPcm/utxP5IxZE=;
 b=cKtTSVcTuHFg4AgrSgyFw+NjxSSeQxb4iUmg9alZt9c42owUxVIqYidjp6XfGiUdI5
 h3/wEWpa8mFUoJrbDC2e2VK/E3vorawcAGDLnhCtANxr7OptRUtvGnXfYVRww7+OBHrU
 ycSufMA28vVlidWfKqP9PEfKp+WYuLf2n+H0w5DpQgzblvfy0fmm9jL2/EUB9kqo22ww
 vlb/Vuw4V1lXgkyDTv2IIHyNPlrF/0hnJCqk2RTpyIduaUJFN85b0eVaaVmDlLUuWAbn
 8vDgWEDpF2Ol65IXhFbkLlwNj9MQISmqyvEENh3pP+8HhLUzU0IQPPN9X2wnhwDl+zYZ
 ZlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VF7BD2whUFR8MWRbhBIqKLqcFA5T5WPcm/utxP5IxZE=;
 b=ad0QZ9HzFC5XUUS+NQd5DYwWkvGvkI/ERtYEdKBZJrgFr4esX35TXsMSWPHcDGzX/V
 KEIEGSJK3l+lhQnC5ywgBCKpiDRVRU1wp7EYxlYDccuuma/tE7c5ktX/Xqr4Cpd3hxAT
 LJAB2DvkdVSXyY3aEo+HkEkONyFwNtGh1kB3A5xfU9E+gCIh9/MruYnfoF+7Q2ZWwIap
 CxIDreav/Epqt+bVeBUC3WKWtDPKy9C7lp6jmizewZyHOnlxcRLCvxNEcyssfgp5MF7+
 9VAoyh/ovjNwWAkCbUEtkLqz/LbbRb+ETe9JAnWEQyO7H+zA9dsftbsJwKChDvfjjkwH
 SPwA==
X-Gm-Message-State: AOAM533BuwWlS507EfihURL1hves0qwfXtKlfIrlwWIW5pBXPOGg0N/M
 b+ImxX6ymfYDOco/zHf5jGgULal4tp/0yA==
X-Google-Smtp-Source: ABdhPJy/vBFlrhfn3FKIHC+iiqJkYk9iASmktnvneJiq6VgHPiGq/WU1W9kDqGd50MvSSe1vKSNfkA==
X-Received: by 2002:a37:8d85:: with SMTP id p127mr9864351qkd.35.1590079480259; 
 Thu, 21 May 2020 09:44:40 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:39 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 64/74] ppc: convert to cpu_has_work_with_iothread_lock
Date: Thu, 21 May 2020 12:40:01 -0400
Message-Id: <20200521164011.638-65-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x742.google.com
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org, cota@braap.org,
 qemu-ppc@nongnu.org, peter.puhov@linaro.org, alex.bennee@linaro.org
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
index e61ba39982..0aeddf3eef 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8539,6 +8539,8 @@ static bool cpu_has_work_POWER7(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
+    g_assert(qemu_mutex_iothread_locked());
+
     if (cpu_halted(cs)) {
         if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
             return false;
@@ -8581,7 +8583,7 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data)
     pcc->pcr_supported = PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
     pcc->init_proc = init_proc_POWER7;
     pcc->check_pow = check_pow_nocheck;
-    cc->has_work = cpu_has_work_POWER7;
+    cc->has_work_with_iothread_lock = cpu_has_work_POWER7;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -8701,6 +8703,8 @@ static bool cpu_has_work_POWER8(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
+    g_assert(qemu_mutex_iothread_locked());
+
     if (cpu_halted(cs)) {
         if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
             return false;
@@ -8751,7 +8755,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
     pcc->pcr_supported = PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
     pcc->init_proc = init_proc_POWER8;
     pcc->check_pow = check_pow_nocheck;
-    cc->has_work = cpu_has_work_POWER8;
+    cc->has_work_with_iothread_lock = cpu_has_work_POWER8;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -8901,6 +8905,8 @@ static bool cpu_has_work_POWER9(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
+    g_assert(qemu_mutex_iothread_locked());
+
     if (cpu_halted(cs)) {
         uint64_t psscr = env->spr[SPR_PSSCR];
 
@@ -8968,7 +8974,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
                          PCR_COMPAT_2_05;
     pcc->init_proc = init_proc_POWER9;
     pcc->check_pow = check_pow_nocheck;
-    cc->has_work = cpu_has_work_POWER9;
+    cc->has_work_with_iothread_lock = cpu_has_work_POWER9;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -9117,6 +9123,7 @@ static bool cpu_has_work_POWER10(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
+    g_assert(qemu_mutex_iothread_locked());
     if (cpu_halted(cs)) {
         uint64_t psscr = env->spr[SPR_PSSCR];
 
@@ -9185,7 +9192,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
                          PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
     pcc->init_proc = init_proc_POWER10;
     pcc->check_pow = check_pow_nocheck;
-    cc->has_work = cpu_has_work_POWER10;
+    cc->has_work_with_iothread_lock = cpu_has_work_POWER10;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -10655,6 +10662,8 @@ static bool ppc_cpu_has_work(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
+    g_assert(qemu_mutex_iothread_locked());
+
     return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
 }
 
@@ -10879,7 +10888,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
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


