Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E830C76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 05:40:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C75F2173E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 05:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8YGip2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C75F2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hncg8-0002vL-SP
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 01:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50082)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hncfm-0001jU-Fd
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 01:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hncfl-0005BV-1H
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 01:40:14 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:40578)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hncfh-00057i-TD; Wed, 17 Jul 2019 01:40:10 -0400
Received: by mail-pl1-x633.google.com with SMTP id a93so11323910pla.7;
 Tue, 16 Jul 2019 22:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=atW5I4YD/hFTgJhT3+aIQwl9ooO+YMNr7JDDvzKgaMs=;
 b=Y8YGip2taz5pqSqtiZlZ3elzi7BmnpvTf9SDogawqj8SYN/JxZiyz5kqam3FOevzg+
 R74YQiqJrmsIYYFPHpdlVKVSsApYZvRTK4A45iLVf0Av45I4IJQpZnX0cN38AU5uOuFJ
 jKzyGJQ6WNgI+yXALmcX5Gr6gNBzQnzgNADevUeAkJYbKc0Lda53u0ufaWN6efR0PyF2
 H9NCVN1Y/bXhI+M7RxDj1ToFuEMwkH3NcQgZMcQKvWQXuaMQ86t1Q0NVHhBMdZFxRuPa
 9KUgEv7ZvBrxSSySGTI+tZfjBawqhsRUOq/Oybj/A3Jj14Sz/23YEVsqXG39kGWNAJmJ
 Mjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=atW5I4YD/hFTgJhT3+aIQwl9ooO+YMNr7JDDvzKgaMs=;
 b=uBY8MZlzjQloPz+9AVed5NXMS6E84grbCz42KsuQHqcstfl1h5awPJlSrdmJqn8E1h
 QlwGB2g9+HAhN0n22JQv+Xvk2hpqxA5yInW0JJlHCAUeqQ5vd32mHHvciIIUZMOyy67g
 PG791WMNM0dgkQSJIB65TXv9I6M53OWjRS+Gu4G4NY79c1SBg8YWAnqLkI/llouKAIDU
 wdKmOTqy2jqWLEdSggCG/ymkd8nKhoA+UUMmE/22Ai6IuKpNoLJahnkeoUNZ3gsen0BL
 J6kRQycKw3PVPQI8c6FHNmnP7LiN2yr788Z9aAZwA0++0Po9Wem6tP2A3fyNdw82mWxc
 CEfw==
X-Gm-Message-State: APjAAAWATDELqkap8iBphIRWBLI9BjSRnohKDDmgSiuwu4GYtvrBw4bY
 HifFNBR9hewbCCkim2PCQQM=
X-Google-Smtp-Source: APXvYqwuURFtr74gcAdxuhdOUMJT8Mw0FVcPIAOmsEx09f3Es7Yny0i9Cs0ALvPBBKyP2FQHEdEIIQ==
X-Received: by 2002:a17:902:28e9:: with SMTP id
 f96mr39314127plb.114.1563342008884; 
 Tue, 16 Jul 2019 22:40:08 -0700 (PDT)
Received: from bobo.local0.net ([203.220.8.141])
 by smtp.gmail.com with ESMTPSA id g18sm39322656pgm.9.2019.07.16.22.40.05
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 16 Jul 2019 22:40:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 17 Jul 2019 15:39:49 +1000
Message-Id: <20190717053952.13729-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717053952.13729-1-npiggin@gmail.com>
References: <20190717053952.13729-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::633
Subject: [Qemu-devel] [PATCH v5 1/4] spapr: Implement VPA dispatch counter
 and prod bit on tcg
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
Cc: Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement cpu_exec_enter/exit on ppc which calls into new methods of
the same name in PPCVirtualHypervisorClass. These are used by spapr
to implement these splpar elements, used in subsequent changes.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Changes since v4:
- Store to VPA on the way out as well.
- Increment the dispatch counter directly in the VPA, which means it will
  migrate with guest memory the same as KVM.
- Prod need not be migrated, add a comment.

 hw/ppc/spapr.c                  | 41 +++++++++++++++++++++++++++++++++
 hw/ppc/spapr_cpu_core.c         |  4 +++-
 hw/ppc/spapr_hcall.c            |  5 ----
 include/hw/ppc/spapr.h          |  7 ++++++
 include/hw/ppc/spapr_cpu_core.h |  1 +
 target/ppc/cpu.h                |  2 ++
 target/ppc/translate_init.inc.c | 25 ++++++++++++++++++++
 7 files changed, 79 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 821f0d4a49..13c423347e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4302,6 +4302,45 @@ PowerPCCPU *spapr_find_cpu(int vcpu_id)
     return NULL;
 }
 
+static void spapr_cpu_exec_enter(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
+{
+    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
+
+    /* These are only called by TCG, KVM maintains dispatch state */
+
+    spapr_cpu->prod = false;
+    if (spapr_cpu->vpa_addr) {
+        CPUState *cs = CPU(cpu);
+        unsigned int dispatch;
+
+        dispatch = ldl_be_phys(cs->as,
+                               spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER);
+        dispatch++;
+        if ((dispatch & 1) != 0) /* guest set the "wrong" value */
+            dispatch++;
+        stl_be_phys(cs->as,
+                    spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER, dispatch);
+    }
+}
+
+static void spapr_cpu_exec_exit(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
+{
+    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
+
+    if (spapr_cpu->vpa_addr) {
+        CPUState *cs = CPU(cpu);
+        unsigned int dispatch;
+
+        dispatch = ldl_be_phys(cs->as,
+                               spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER);
+        dispatch++;
+        if ((dispatch & 1) != 1) /* guest set the "wrong" value */
+            dispatch++;
+        stl_be_phys(cs->as,
+                    spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER, dispatch);
+    }
+}
+
 static void spapr_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -4358,6 +4397,8 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     vhc->hpte_set_r = spapr_hpte_set_r;
     vhc->get_pate = spapr_get_pate;
     vhc->encode_hpt_for_kvm_pr = spapr_encode_hpt_for_kvm_pr;
+    vhc->cpu_exec_enter = spapr_cpu_exec_enter;
+    vhc->cpu_exec_exit = spapr_cpu_exec_exit;
     xic->ics_get = spapr_ics_get;
     xic->ics_resend = spapr_ics_resend;
     xic->icp_get = spapr_icp_get;
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 5621fb9a3d..54abf5308c 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -261,6 +261,7 @@ error:
 static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
 {
     SpaprCpuCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(sc);
+    SpaprCpuState *spapr_cpu;
     CPUCore *cc = CPU_CORE(sc);
     Object *obj;
     char *id;
@@ -287,7 +288,8 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
         goto err;
     }
 
-    cpu->machine_data = g_new0(SpaprCpuState, 1);
+    spapr_cpu = g_new0(SpaprCpuState, 1);
+    cpu->machine_data = spapr_cpu;
 
     object_unref(obj);
     return cpu;
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 6808d4cda8..e615881ac4 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -874,11 +874,6 @@ unmap_out:
 #define FLAGS_DEREGISTER_DTL       0x0000c00000000000ULL
 #define FLAGS_DEREGISTER_SLBSHADOW 0x0000e00000000000ULL
 
-#define VPA_MIN_SIZE           640
-#define VPA_SIZE_OFFSET        0x4
-#define VPA_SHARED_PROC_OFFSET 0x9
-#define VPA_SHARED_PROC_VAL    0x2
-
 static target_ulong register_vpa(PowerPCCPU *cpu, target_ulong vpa)
 {
     CPUState *cs = CPU(cpu);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 60553d32c4..5d36eec9d0 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -525,6 +525,13 @@ void spapr_register_hypercall(target_ulong opcode, spapr_hcall_fn fn);
 target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
                              target_ulong *args);
 
+/* Virtual Processor Area structure constants */
+#define VPA_MIN_SIZE           640
+#define VPA_SIZE_OFFSET        0x4
+#define VPA_SHARED_PROC_OFFSET 0x9
+#define VPA_SHARED_PROC_VAL    0x2
+#define VPA_DISPATCH_COUNTER   0x100
+
 /* ibm,set-eeh-option */
 #define RTAS_EEH_DISABLE                 0
 #define RTAS_EEH_ENABLE                  1
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
index f9645a7290..a40cd08ea0 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -46,6 +46,7 @@ typedef struct SpaprCpuState {
     uint64_t vpa_addr;
     uint64_t slb_shadow_addr, slb_shadow_size;
     uint64_t dtl_addr, dtl_size;
+    bool prod; /* not migrated, only used to improve dispatch latencies */
     struct ICPState *icp;
     struct XiveTCTX *tctx;
 } SpaprCpuState;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index c9beba2a5c..78d6504acb 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1224,6 +1224,8 @@ struct PPCVirtualHypervisorClass {
     void (*hpte_set_r)(PPCVirtualHypervisor *vhyp, hwaddr ptex, uint64_t pte1);
     void (*get_pate)(PPCVirtualHypervisor *vhyp, ppc_v3_pate_t *entry);
     target_ulong (*encode_hpt_for_kvm_pr)(PPCVirtualHypervisor *vhyp);
+    void (*cpu_exec_enter)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
+    void (*cpu_exec_exit)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
 };
 
 #define TYPE_PPC_VIRTUAL_HYPERVISOR "ppc-virtual-hypervisor"
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 86fc8f2e31..58d4a93b23 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10473,6 +10473,28 @@ static bool ppc_cpu_is_big_endian(CPUState *cs)
 }
 #endif
 
+static void ppc_cpu_exec_enter(CPUState *cs)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+
+    if (cpu->vhyp) {
+        PPCVirtualHypervisorClass *vhc =
+            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+        vhc->cpu_exec_enter(cpu->vhyp, cpu);
+    }
+}
+
+static void ppc_cpu_exec_exit(CPUState *cs)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+
+    if (cpu->vhyp) {
+        PPCVirtualHypervisorClass *vhc =
+            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+        vhc->cpu_exec_exit(cpu->vhyp, cpu);
+    }
+}
+
 static void ppc_cpu_instance_init(Object *obj)
 {
     PowerPCCPU *cpu = POWERPC_CPU(obj);
@@ -10624,6 +10646,9 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
     cc->tcg_initialize = ppc_translate_init;
     cc->tlb_fill = ppc_cpu_tlb_fill;
 #endif
+    cc->cpu_exec_enter = ppc_cpu_exec_enter;
+    cc->cpu_exec_exit = ppc_cpu_exec_exit;
+
     cc->disas_set_info = ppc_disas_set_info;
 
     dc->fw_name = "PowerPC,UNKNOWN";
-- 
2.20.1


