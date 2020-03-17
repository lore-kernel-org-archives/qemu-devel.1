Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F895C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:07:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59DAE20674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwbyvZHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59DAE20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52909 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE4Ro-0004D2-HQ
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 01:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jE4OB-0007Fo-Ir
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jE4OA-0003aa-2Z
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:03:39 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:56068)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jE4O6-0003GO-PT; Tue, 17 Mar 2020 01:03:34 -0400
Received: by mail-pj1-x1042.google.com with SMTP id mj6so9360921pjb.5;
 Mon, 16 Mar 2020 22:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AisOrh8tGWpQt/xWqL0k/5hGpgBWGNSTT7SWHsAxBR0=;
 b=OwbyvZHDOCm5Ty0gGYoo3ekY95bu0rdU6Mc1QVyp6HCd/Zhm6Ak6SqTLXFcNrWemGG
 LoCU7s+/Cx2o3f3u0KGBSeywURzKrtrT8J8I43urGompCp09s1VPGZU2HcYrfSyxmP2d
 aedtGX90CLle7X2DACgu01PqgeMKETvc6IrS4xoMfcsVtzMyLQ4nvKcRjfw3jt45+B6K
 KYZWSopEkBZeK6vNcbtMGluB8LE4jWGzIHYaGGOmyzx5PpnFBguMgp89zzcPmYm8Zz8H
 1qC7cD3Hxbxgu+0+njIeZ5tYq012gfVH7Xt/db26GGUcnX5JaAWLYVPmxXDgMISKtNPc
 wL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AisOrh8tGWpQt/xWqL0k/5hGpgBWGNSTT7SWHsAxBR0=;
 b=eC6/AuwMbKTgBJN+QmXeAFOaEeVmiOJ95L9QTerzOpfUXnrwhdA3OqSt1pd4YAbMDE
 Y+S/TVfEbKlMDlnwPzKu1yW8gCjn1UuWTDWIY1ItqzxaQL+sOcSPsUTyBiWWQRvjqur0
 1qk/YLGto0RO2/J72EwRuB/sz9Qn5TxOa5OCRNy/qQUjzipO1em/z0BCx7+3AZzhjf2x
 y3lOIUP0VsAobXamE9h+0vq17r8orvVT/uwlLxMPCSUwxa4ePwIuMvhdJcsGu1FSbFC8
 Ph/nAeuu1BLsoS/toWfuxLn/55Vv6yGbypigLYQ8tWRUAlKhag54alrGa5LegH+Jvbtd
 5b9w==
X-Gm-Message-State: ANhLgQ27Zs4f2z8D16Tozvf/0LOJHpVWlZsGBpxU7MfDWuNOjDtpChCa
 KTHzR5FUfb3TahQIJKTQKW4y1sm7i3c=
X-Google-Smtp-Source: ADFU+vvCoiBLNSdw29T7DuiO+K6qm1rt9YqLxzqWjMyc/NgXmYMYSX+Z0Ko8Md93xcbwtLuL9R2IVQ==
X-Received: by 2002:a17:902:ac83:: with SMTP id
 h3mr2653884plr.86.1584421413045; 
 Mon, 16 Mar 2020 22:03:33 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (14-202-190-183.tpgi.com.au.
 [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id k67sm994803pga.91.2020.03.16.22.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 22:03:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH 5/5] target/ppc: Implement simple monitor mce injection
Date: Tue, 17 Mar 2020 15:02:15 +1000
Message-Id: <20200317050215.159334-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200317050215.159334-1-npiggin@gmail.com>
References: <20200317050215.159334-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This enables the mce monitor command for ppc, and adds a spapr
facility to inject machine check exception to a CPU by setting
low level registers.

  (qemu) mce 0 0x200000 0x80 0xdeadbeef 1

    Disabling lock debugging due to kernel taint
    MCE: CPU0: machine check (Severe) Host SLB Multihit [Recovered]
    MCE: CPU0: PID: 495 Comm: a NIP: [0000000130ee07c8]
    MCE: CPU0: Initiator CPU
    MCE: CPU0: Unknown

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hmp-commands.hx        | 20 +++++++++++++++++++-
 hw/ppc/spapr.c         | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  3 +++
 target/ppc/cpu.h       |  3 +++
 target/ppc/monitor.c   | 26 ++++++++++++++++++++++++++
 5 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 7f0f3974ad..4a9089b431 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1581,12 +1581,30 @@ ERST
         .cmd        = hmp_mce,
     },
 
-#endif
 SRST
 ``mce`` *cpu* *bank* *status* *mcgstatus* *addr* *misc*
   Inject an MCE on the given CPU (x86 only).
 ERST
 
+#endif
+
+#if defined(TARGET_PPC)
+
+    {
+        .name       = "mce",
+        .args_type  = "cpu_index:i,srr1_mask:l,dsisr:i,dar:l,recovered:i",
+        .params     = "cpu srr1_mask dsisr dar recovered",
+        .help       = "inject a MCE on the given CPU",
+        .cmd        = hmp_mce,
+    },
+
+SRST
+``mce`` *cpu* *srr1_mask* *dsisr* *dar* *recovered*
+  Inject an MCE on the given CPU (PPC only).
+ERST
+
+#endif
+
     {
         .name       = "getfd",
         .args_type  = "fdname:s",
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 78e649f47d..d83245c438 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3454,6 +3454,47 @@ static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
     }
 }
 
+typedef struct MCEInjectionParams {
+    uint64_t srr1_mask;
+    uint32_t dsisr;
+    uint64_t dar;
+    bool recovered;
+} MCEInjectionParams;
+
+static void spapr_do_mce_on_cpu(CPUState *cs, run_on_cpu_data data)
+{
+    MCEInjectionParams *params = data.host_ptr;
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+    uint64_t srr1_mce_bits = PPC_BITMASK(42,45) | PPC_BIT(36); /* POWER9 bits */
+
+    cpu_synchronize_state(cs);
+
+    env->spr[SPR_SRR0] = env->nip;
+    env->spr[SPR_SRR1] = (env->msr & ~srr1_mce_bits) |
+                         (params->srr1_mask & srr1_mce_bits);
+    if (params->dsisr) {
+        env->spr[SPR_DSISR] = params->dsisr;
+        env->spr[SPR_DAR] = params->dar;
+    }
+
+    spapr_mce_req_event(cpu, params->recovered);
+}
+
+static void spapr_cpu_mce_inject(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
+                                 uint64_t srr1_mask, uint32_t dsisr,
+                                 uint64_t dar, bool recovered)
+{
+    CPUState *cs = CPU(cpu);
+    MCEInjectionParams params = {
+        .srr1_mask = srr1_mask,
+        .dsisr = dsisr,
+        .dar = dar,
+        .recovered = recovered,
+    };
+    run_on_cpu(cs, spapr_do_mce_on_cpu, RUN_ON_CPU_HOST_PTR(&params));
+}
+
 int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                           void *fdt, int *fdt_start_offset, Error **errp)
 {
@@ -4556,6 +4597,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     vhc->encode_hpt_for_kvm_pr = spapr_encode_hpt_for_kvm_pr;
     vhc->cpu_exec_enter = spapr_cpu_exec_enter;
     vhc->cpu_exec_exit = spapr_cpu_exec_exit;
+    vhc->cpu_mce_inject = spapr_cpu_mce_inject;
     xic->ics_get = spapr_ics_get;
     xic->ics_resend = spapr_ics_resend;
     xic->icp_get = spapr_icp_get;
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 42d64a0368..72f86a2ee8 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -929,4 +929,7 @@ void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
 
 void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
 hwaddr spapr_get_rtas_addr(void);
+
+void spapr_mce_inject(CPUState *cs, uint64_t srr1_mask, uint32_t dsisr,
+                      uint64_t dar, bool recovered);
 #endif /* HW_SPAPR_H */
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index f8c7d6f19c..ed8d2015bd 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1189,6 +1189,9 @@ struct PPCVirtualHypervisorClass {
 #ifndef CONFIG_USER_ONLY
     void (*cpu_exec_enter)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
     void (*cpu_exec_exit)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
+    void (*cpu_mce_inject)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
+                           uint64_t srr1_mask, uint32_t dsisr, uint64_t dar,
+                           bool recovered);
 #endif
 };
 
diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
index a5a177d717..ec997ce673 100644
--- a/target/ppc/monitor.c
+++ b/target/ppc/monitor.c
@@ -28,6 +28,7 @@
 #include "qemu/ctype.h"
 #include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
+#include "qapi/qmp/qdict.h"
 
 static target_long monitor_get_ccr(const struct MonitorDef *md, int val)
 {
@@ -72,6 +73,31 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
     dump_mmu(env1);
 }
 
+void hmp_mce(Monitor *mon, const QDict *qdict)
+{
+    CPUState *cs;
+    int cpu_index = qdict_get_int(qdict, "cpu_index");
+    uint64_t srr1_mask = qdict_get_int(qdict, "srr1_mask");
+    uint32_t dsisr = qdict_get_int(qdict, "dsisr");
+    uint64_t dar = qdict_get_int(qdict, "dar");
+    bool recovered = qdict_get_int(qdict, "recovered");
+
+    cs = qemu_get_cpu(cpu_index);
+
+    if (cs != NULL) {
+        PowerPCCPU *cpu = POWERPC_CPU(cs);
+
+        if (cpu->vhyp) {
+            PPCVirtualHypervisorClass *vhc =
+                PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+            if (vhc->cpu_mce_inject) {
+                vhc->cpu_mce_inject(cpu->vhyp, cpu,
+                                    srr1_mask, dsisr, dar, recovered);
+            }
+        }
+    }
+}
+
 const MonitorDef monitor_defs[] = {
     { "fpscr", offsetof(CPUPPCState, fpscr) },
     /* Next instruction pointer */
-- 
2.23.0


