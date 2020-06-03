Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6200FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA252072F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3TJV5nC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA252072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgI6e-0004E1-C6
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyT-0003yC-9e
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:45 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyL-0003Yx-Pt
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:43 -0400
Received: by mail-pl1-x642.google.com with SMTP id y11so187072plt.12
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0EIkcVZM7CTGPx7yRFPLzi2q/BnEPgFyUzrQe3RUVmw=;
 b=A3TJV5nCnr3oYovFU1ADFd+5yfFGhL0YsAB6KWudClLp1wvvmNicYYxE+o0VmSob5o
 p138YpdPOZiQNyBhJmc2bHHEra6CcwLLkoatJTvmxsPrgGSSvEAF+e1+6S886KwhNE9q
 DOSTP2M15CU1MV1HQMlQ4H9byezhmyDDVF6j6FHTcFkBsx+AIvklRPWXzbStPUSYl116
 vacfPn1/3C3TUSMtjVRqiATU/ah4CEfQA/3gnBiXw7lLJwoW8+9ldG9hbcDDQGl27Vmu
 SBfWVCdk6F4oUAXCg0bSLVlM2TKvyudy1T/vvlfpgnwX87pb8GtZY9kwnZp4SzUsQ2iq
 6xLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0EIkcVZM7CTGPx7yRFPLzi2q/BnEPgFyUzrQe3RUVmw=;
 b=Pww4HSDBFug91K8TdPhrTiA8WkwGWrZqxZRAxq4xulafm1SPNsScZnqVX32TKMzb9p
 qzf+JZe0rmSD2f+L47kS7mr4t+Xpwlf9KSoGdod56VWJBKgRrc3NZy66kzFGBrn/Fpsm
 IDejndqRGN8wVirl/HQZRYmgKb2HErW627bDm92DoM+WjVgxiYym0IuKEuXzdo9n3aC3
 XX1zZ2s5rrwQbXmLvgQmeUsSs4gSJENJKDmPvFx+TTEYNAf4pDRAQjkqCfzip30hp9+G
 IIEpSqIqfTdiGdoit7vosVq0Rok5WV1cD/tgzOlPMTN2drNIbkcP0ZdTlN2HQjysi06f
 ZGmA==
X-Gm-Message-State: AOAM533JIAcsULGHFEZav9g2uBwwHkhZza19h73AUiWg0SlF4zABtUTf
 8rqMuZ6wRwX37lnUWfDP52Lzi+1QDYU=
X-Google-Smtp-Source: ABdhPJxj75AWN3JjHFuU/NdahAR477GvhYB0KuLBtQgEKVMbdptKd0EFLATyxPeSXlZvL5U9+tJ5RQ==
X-Received: by 2002:a17:902:8218:: with SMTP id
 x24mr27620797pln.150.1591146815640; 
 Tue, 02 Jun 2020 18:13:35 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:13:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 13/42] target/arm: Define arm_cpu_do_unaligned_access for
 user-only
Date: Tue,  2 Jun 2020 18:12:48 -0700
Message-Id: <20200603011317.473934-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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

We need this to raise unaligned exceptions from user mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v6: Use EXCP_UNALIGNED for user-only and update cpu_loop.c.
---
 linux-user/aarch64/cpu_loop.c |  7 ++++++
 linux-user/arm/cpu_loop.c     |  7 ++++++
 target/arm/cpu.c              |  2 +-
 target/arm/tlb_helper.c       | 41 ++++++++++++++++++++++-------------
 4 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index bbe9fefca8..3cca637bb9 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -121,6 +121,13 @@ void cpu_loop(CPUARMState *env)
             info._sifields._sigfault._addr = env->exception.vaddress;
             queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
+        case EXCP_UNALIGNED:
+            info.si_signo = TARGET_SIGBUS;
+            info.si_errno = 0;
+            info.si_code = TARGET_BUS_ADRALN;
+            info._sifields._sigfault._addr = env->exception.vaddress;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
         case EXCP_DEBUG:
         case EXCP_BKPT:
             info.si_signo = TARGET_SIGTRAP;
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 13629ee1f6..0d568d2d69 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -411,6 +411,13 @@ void cpu_loop(CPUARMState *env)
                 queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             }
             break;
+        case EXCP_UNALIGNED:
+            info.si_signo = TARGET_SIGBUS;
+            info.si_errno = 0;
+            info.si_code = TARGET_BUS_ADRALN;
+            info._sifields._sigfault._addr = env->exception.vaddress;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
         case EXCP_DEBUG:
         case EXCP_BKPT:
         excp_debug:
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 32bec156f2..0f1a46f531 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2166,8 +2166,8 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->tlb_fill = arm_cpu_tlb_fill;
     cc->debug_excp_handler = arm_debug_excp_handler;
     cc->debug_check_watchpoint = arm_debug_check_watchpoint;
-#if !defined(CONFIG_USER_ONLY)
     cc->do_unaligned_access = arm_cpu_do_unaligned_access;
+#if !defined(CONFIG_USER_ONLY)
     cc->do_transaction_failed = arm_cpu_do_transaction_failed;
     cc->adjust_watchpoint_address = arm_adjust_watchpoint_address;
 #endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
diff --git a/target/arm/tlb_helper.c b/target/arm/tlb_helper.c
index 7388494a55..d4e6d37f4f 100644
--- a/target/arm/tlb_helper.c
+++ b/target/arm/tlb_helper.c
@@ -107,21 +107,6 @@ static void QEMU_NORETURN arm_deliver_fault(ARMCPU *cpu, vaddr addr,
     raise_exception(env, exc, syn, target_el);
 }
 
-/* Raise a data fault alignment exception for the specified virtual address */
-void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
-                                 MMUAccessType access_type,
-                                 int mmu_idx, uintptr_t retaddr)
-{
-    ARMCPU *cpu = ARM_CPU(cs);
-    ARMMMUFaultInfo fi = {};
-
-    /* now we have a real cpu fault */
-    cpu_restore_state(cs, retaddr, true);
-
-    fi.type = ARMFault_Alignment;
-    arm_deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
-}
-
 /*
  * arm_cpu_do_transaction_failed: handle a memory system error response
  * (eg "no device/memory present at address") by raising an external abort
@@ -198,3 +183,29 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     }
 #endif
 }
+
+/* Raise a data fault alignment exception for the specified virtual address */
+void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
+                                 MMUAccessType access_type,
+                                 int mmu_idx, uintptr_t retaddr)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+
+#ifdef CONFIG_USER_ONLY
+    cpu->env.exception.vaddress = vaddr;
+    /*
+     * For HW, this is EXCP_DATA_ABORT with a proper syndrome.
+     * Make it easier for ourselves in linux-user/arm/cpu_loop.c.
+     */
+    cs->exception_index = EXCP_UNALIGNED;
+    cpu_loop_exit_restore(cs, retaddr);
+#else
+    ARMMMUFaultInfo fi = {};
+
+    /* now we have a real cpu fault */
+    cpu_restore_state(cs, retaddr, true);
+
+    fi.type = ARMFault_Alignment;
+    arm_deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
+#endif
+}
-- 
2.25.1


