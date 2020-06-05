Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F047DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:20:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9DC4206E6
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GVjk9AlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9DC4206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh3qa-0002wc-SI
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 00:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3nk-0004ha-E0
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:53 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37554)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3nj-0000lf-MB
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:52 -0400
Received: by mail-pf1-x443.google.com with SMTP id j1so4152821pfe.4
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 21:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OzYHxasinbK12hHGjXt3IY3GTdvR0p0In8jS7714bjc=;
 b=GVjk9AlOfDA0AZJUKWECc3CSMsveyiA9UBLqrsI9qYIAP5YcDDgPKCt1+Vgy6YKY6Z
 Fv1/jsK7UcR4d9GPSIJyCQO4UCp2N4d6hOxX0wAfvRLa6JQ4wOvblIVTvWF8UGilXXAA
 0pjwRpf19EidPalvapvrOUklORbg/MmOQQt2jP6Xh1jIUvQEVXCwdx0evxQqXQus3nsV
 LP6uuSic/UITigTWMufeWl+7k1JSJOZPHx0xj9Avkfd5/tTFf/sSdRZJaIDF0riPuhTk
 KyQNKvx8W8GKpIC5FwG6sIBJ4+eifZzXx40EXeF5jT/Fn5viBvZVqX1kBeWYM13RVhcs
 Wevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OzYHxasinbK12hHGjXt3IY3GTdvR0p0In8jS7714bjc=;
 b=N4f9KneHnRt3xA6VxygjhdThoe3oakSv4WzZIhXNoKMHEXdHknC3QcP8bXlTCry5rn
 lH+DvVPB1f2qJhYavJdF1WOW6w6YACoERzEuhBbnZjt1xnyeInGFDovoOVZP/fcWY7rF
 /QGRn0HMyyZvFQ00qWxVg33v/LZoAK5J+63G3oUiIEpooFQKuPWSv1DfAybWhwocXdds
 EUpHsvMw4COQazPbbgXOHCqHrIkMCUd+yTulxBqb0aUwGC7CtBBEBpkOZ2MTP5Os9XhF
 yiByC4XSYLa0JWNSARvBHVt8GBsMwMyNFirR3YQu7B9rNdc1FnW6BhIP0rYkx3oIqCWj
 cj8w==
X-Gm-Message-State: AOAM532YOqLmPML2W6TYSKVsfyEh4vyoZHTFZ26ohqRq0dV6Y5NW9Tz7
 rU0d9/GUkdNuqHIi28wMzhvd5eMGnTQ=
X-Google-Smtp-Source: ABdhPJwoZl4kXIFIUzS4JICf1Nr069Ii8sMEWHiLmCCZSm1NX2qAWOHAZFrsXrDCCs5jXPho7JPHeA==
X-Received: by 2002:a63:c5a:: with SMTP id 26mr7460938pgm.270.1591330669986;
 Thu, 04 Jun 2020 21:17:49 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h15sm5440902pgl.12.2020.06.04.21.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 21:17:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/17] linux-user/aarch64: Pass syndrome to EXC_*_ABORT
Date: Thu,  4 Jun 2020 21:17:28 -0700
Message-Id: <20200605041733.415188-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605041733.415188-1-richard.henderson@linaro.org>
References: <20200605041733.415188-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A proper syndrome is required to fill in the proper si_code.
Use page_get_flags to determine permission vs translation
for user-only.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/cpu_loop.c | 23 ++++++++++++++++++++---
 target/arm/tlb_helper.c       | 27 +++++++++++++++++++++------
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 3cca637bb9..ce56e15be2 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -75,7 +75,7 @@
 void cpu_loop(CPUARMState *env)
 {
     CPUState *cs = env_cpu(env);
-    int trapnr;
+    int trapnr, ec, fsc;
     abi_long ret;
     target_siginfo_t info;
 
@@ -116,9 +116,26 @@ void cpu_loop(CPUARMState *env)
         case EXCP_DATA_ABORT:
             info.si_signo = TARGET_SIGSEGV;
             info.si_errno = 0;
-            /* XXX: check env->error_code */
-            info.si_code = TARGET_SEGV_MAPERR;
             info._sifields._sigfault._addr = env->exception.vaddress;
+
+            /* We should only arrive here with EC in {DATAABORT, INSNABORT}. */
+            ec = extract32(env->exception.syndrome, 26, 6);
+            assert(ec == 0x24 || ec == 0x20);
+
+            /* Both EC have the same format for FSC, or close enough. */
+            fsc = extract32(env->exception.syndrome, 0, 6);
+            switch (fsc) {
+            case 0x04 ... 0x07: /* Translation fault, level {0-3} */
+                info.si_code = TARGET_SEGV_MAPERR;
+                break;
+            case 0x09 ... 0x0b: /* Access flag fault, level {1-3} */
+            case 0x0d ... 0x0f: /* Permission fault, level {1-3} */
+                info.si_code = TARGET_SEGV_ACCERR;
+                break;
+            default:
+                g_assert_not_reached();
+            }
+
             queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
         case EXCP_UNALIGNED:
diff --git a/target/arm/tlb_helper.c b/target/arm/tlb_helper.c
index d4e6d37f4f..35d84ac24f 100644
--- a/target/arm/tlb_helper.c
+++ b/target/arm/tlb_helper.c
@@ -10,8 +10,6 @@
 #include "internals.h"
 #include "exec/exec-all.h"
 
-#if !defined(CONFIG_USER_ONLY)
-
 static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
                                             unsigned int target_el,
                                             bool same_el, bool ea,
@@ -51,6 +49,8 @@ static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
     return syn;
 }
 
+#if !defined(CONFIG_USER_ONLY)
+
 static void QEMU_NORETURN arm_deliver_fault(ARMCPU *cpu, vaddr addr,
                                             MMUAccessType access_type,
                                             int mmu_idx, ARMMMUFaultInfo *fi)
@@ -138,13 +138,28 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     ARMCPU *cpu = ARM_CPU(cs);
 
 #ifdef CONFIG_USER_ONLY
+    int flags, fsc, exc;
+    unsigned syn;
+
     cpu->env.exception.vaddress = address;
-    if (access_type == MMU_INST_FETCH) {
-        cs->exception_index = EXCP_PREFETCH_ABORT;
+
+    flags = page_get_flags(useronly_clean_ptr(address));
+    if (flags & PAGE_VALID) {
+        fsc = 0xf; /* permission fault, level 3 */
     } else {
-        cs->exception_index = EXCP_DATA_ABORT;
+        fsc = 0x7; /* translation fault, level 3 */
     }
-    cpu_loop_exit_restore(cs, retaddr);
+
+    cpu_restore_state(cs, retaddr, true);
+    if (access_type == MMU_INST_FETCH) {
+        exc = EXCP_PREFETCH_ABORT;
+        syn = syn_insn_abort(0, 0, 0, fsc);
+    } else {
+        exc = EXCP_DATA_ABORT;
+        syn = merge_syn_data_abort(cpu->env.exception.syndrome, 1, 0, 0, 0,
+                                   access_type == MMU_DATA_STORE, fsc);
+    }
+    raise_exception(&cpu->env, exc, syn, 1);
 #else
     hwaddr phys_addr;
     target_ulong page_size;
-- 
2.25.1


