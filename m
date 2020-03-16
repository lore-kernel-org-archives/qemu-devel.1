Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2D0C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:30:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A201120663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1oCZM/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A201120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDsdE-00045E-ME
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jDqi4-0007WM-8e
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jDqi2-0003Cg-NX
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:27:16 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:34619)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jDqhy-0002Xu-Ui; Mon, 16 Mar 2020 10:27:11 -0400
Received: by mail-pj1-x1041.google.com with SMTP id q16so1425713pje.1;
 Mon, 16 Mar 2020 07:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pT1O+TzB8Xyv415llsLIfaB9uRO4q6lP+I0js9hZp3k=;
 b=a1oCZM/PDpcWxkLM7UaR/3r59DeSt0/julv/MUaUMET2XRidcHHPlpXHiOjn9lQu+a
 XbJVPzmmf5jCZuUgbyqoXmUVqppIl+pVUXkxIe5EDKhum9rqXwjjNTiNNWRothd3I4od
 zXq+vtHbyAeJHQpq7QNsZhYFXlqc7BlxYhEsC7Fs40qRqFi8WYWJd0ByaOdItUzmj0P+
 1TwGbdlea+3RFX69Y1LpAiIN6DZTJbUHhU4LoA688XLMj6UnaKroRsWmp1n6MPtbXs6a
 fEb2tfgPcyL5dxqd2q8XkJXNp0W4HEP1U6QUHW2nJQfK/pW6/10LU4Xqd19+oWG1uaBX
 4QFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pT1O+TzB8Xyv415llsLIfaB9uRO4q6lP+I0js9hZp3k=;
 b=paw26PgnorZO+RYGGctFoEWZHoX8cV95VFkKPn60HD+KwQ0Zeay17sMTi034TZpxE1
 PxsW5jj4lN+Sf8mBqbyxVvjSEyyt7bsRJKqHeSy13iqlc7NJOOK9X2yLLDEI5UR9+CFo
 sIiiMJ9ALG6zyBfWYHHgeRYKNfYQWfv1+1AhJg8rflf9Sf5ngyI8F9WFYiqC1ikneSo2
 EGHcduu1A4pg28mprRill6N0MpiHs9iFdUVD3sv9IuNXzhxnpnK7Iokw1wdu8BnDZvo3
 L2Eo8aAEEM/QtzcCb/fMD6jEYXbAkvir35ESSvjuKePFhlYiWhmFtXmOfKNPqAEGrsb8
 Krjg==
X-Gm-Message-State: ANhLgQ2rui4LyUPSaZmJ6Gk59w01K3ETYr8FmcE2BD2X2IfxqT5103gu
 SbwN0xRwMLugBnUVYX7WlytWVAZDM88=
X-Google-Smtp-Source: ADFU+vtYdywPM9qSMPvJOOIuvDsFkQlRCgfc3nGp/aHT/pGWKMnSGtMe38th/C5EjQy2GdbUd8ew0w==
X-Received: by 2002:a17:902:d705:: with SMTP id
 w5mr27069814ply.68.1584368829724; 
 Mon, 16 Mar 2020 07:27:09 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.63.160.49])
 by smtp.gmail.com with ESMTPSA id v1sm45564pjy.35.2020.03.16.07.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 07:27:09 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v2 4/8] ppc/spapr: Fix FWNMI machine check interrupt delivery
Date: Tue, 17 Mar 2020 00:26:09 +1000
Message-Id: <20200316142613.121089-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200316142613.121089-1-npiggin@gmail.com>
References: <20200316142613.121089-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

FWNMI machine check delivery misses a few things that will make it fail
with TCG at least (which we would like to allow in future to improve
testing).

It's not nice to scatter interrupt delivery logic around the tree, so
move it to excp_helper.c and share code where possible.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_events.c    | 24 +++----------
 target/ppc/cpu.h         |  1 +
 target/ppc/excp_helper.c | 74 ++++++++++++++++++++++++++++------------
 3 files changed, 57 insertions(+), 42 deletions(-)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 27ba8a2c19..323fcef4aa 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -785,28 +785,13 @@ static uint32_t spapr_mce_get_elog_type(PowerPCCPU *cpu, bool recovered,
 static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
-    uint64_t rtas_addr;
+    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
-    target_ulong msr = 0;
+    uint64_t rtas_addr;
     struct rtas_error_log log;
     struct mc_extended_log *ext_elog;
     uint32_t summary;
 
-    /*
-     * Properly set bits in MSR before we invoke the handler.
-     * SRR0/1, DAR and DSISR are properly set by KVM
-     */
-    if (!(*pcc->interrupts_big_endian)(cpu)) {
-        msr |= (1ULL << MSR_LE);
-    }
-
-    if (env->msr & (1ULL << MSR_SF)) {
-        msr |= (1ULL << MSR_SF);
-    }
-
-    msr |= (1ULL << MSR_ME);
-
     ext_elog = g_malloc0(sizeof(*ext_elog));
     summary = spapr_mce_get_elog_type(cpu, recovered, ext_elog);
 
@@ -834,12 +819,11 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
     cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSET +
                               sizeof(env->gpr[3]) + sizeof(log), ext_elog,
                               sizeof(*ext_elog));
+    g_free(ext_elog);
 
     env->gpr[3] = rtas_addr + RTAS_ERROR_LOG_OFFSET;
-    env->msr = msr;
-    env->nip = spapr->fwnmi_machine_check_addr;
 
-    g_free(ext_elog);
+    ppc_cpu_do_fwnmi_machine_check(cs, spapr->fwnmi_machine_check_addr);
 }
 
 void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 5a55fb02bd..3953680534 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1221,6 +1221,7 @@ int ppc32_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
                                int cpuid, void *opaque);
 #ifndef CONFIG_USER_ONLY
 void ppc_cpu_do_system_reset(CPUState *cs);
+void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector);
 extern const VMStateDescription vmstate_ppc_cpu;
 #endif
 
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 027f54c0ed..7f2b5899d3 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -128,6 +128,37 @@ static uint64_t ppc_excp_vector_offset(CPUState *cs, int ail)
     return offset;
 }
 
+static inline void powerpc_set_excp_state(PowerPCCPU *cpu,
+                                          target_ulong vector, target_ulong msr)
+{
+    CPUState *cs = CPU(cpu);
+    CPUPPCState *env = &cpu->env;
+
+    /*
+     * We don't use hreg_store_msr here as already have treated any
+     * special case that could occur. Just store MSR and update hflags
+     *
+     * Note: We *MUST* not use hreg_store_msr() as-is anyway because it
+     * will prevent setting of the HV bit which some exceptions might need
+     * to do.
+     */
+    env->msr = msr & env->msr_mask;
+    hreg_compute_hflags(env);
+    env->nip = vector;
+    /* Reset exception state */
+    cs->exception_index = POWERPC_EXCP_NONE;
+    env->error_code = 0;
+
+    /* Reset the reservation */
+    env->reserve_addr = -1;
+
+    /*
+     * Any interrupt is context synchronizing, check if TCG TLB needs
+     * a delayed flush on ppc64
+     */
+    check_tlb_flush(env, false);
+}
+
 /*
  * Note that this function should be greatly optimized when called
  * with a constant excp, from ppc_hw_interrupt
@@ -768,29 +799,8 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
         }
     }
 #endif
-    /*
-     * We don't use hreg_store_msr here as already have treated any
-     * special case that could occur. Just store MSR and update hflags
-     *
-     * Note: We *MUST* not use hreg_store_msr() as-is anyway because it
-     * will prevent setting of the HV bit which some exceptions might need
-     * to do.
-     */
-    env->msr = new_msr & env->msr_mask;
-    hreg_compute_hflags(env);
-    env->nip = vector;
-    /* Reset exception state */
-    cs->exception_index = POWERPC_EXCP_NONE;
-    env->error_code = 0;
 
-    /* Reset the reservation */
-    env->reserve_addr = -1;
-
-    /*
-     * Any interrupt is context synchronizing, check if TCG TLB needs
-     * a delayed flush on ppc64
-     */
-    check_tlb_flush(env, false);
+    powerpc_set_excp_state(cpu, vector, new_msr);
 }
 
 void ppc_cpu_do_interrupt(CPUState *cs)
@@ -958,6 +968,26 @@ void ppc_cpu_do_system_reset(CPUState *cs)
 
     powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_RESET);
 }
+
+void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    target_ulong msr = 0;
+
+    /*
+     * Set MSR and NIP for the handler, SRR0/1, DAR and DSISR have already
+     * been set by KVM.
+     */
+    msr = (1ULL << MSR_ME);
+    msr |= env->msr & (1ULL << MSR_SF);
+    if (!(*pcc->interrupts_big_endian)(cpu)) {
+        msr |= (1ULL << MSR_LE);
+    }
+
+    powerpc_set_excp_state(cpu, vector, msr);
+}
 #endif /* !CONFIG_USER_ONLY */
 
 bool ppc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
-- 
2.23.0


