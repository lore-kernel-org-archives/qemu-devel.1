Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C31C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22D6620714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qByL82Fm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D6620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH75M-0004ij-9H
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 10:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jH72i-00029b-4i
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:30:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jH72g-0002eh-LL
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:30:04 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41223)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jH72d-0002Zq-Uc; Wed, 25 Mar 2020 10:30:00 -0400
Received: by mail-pf1-x444.google.com with SMTP id z65so1110708pfz.8;
 Wed, 25 Mar 2020 07:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vitaAIcV4SE+7Zrx0kH3CXztZqs8gVnOhGiQ7IdvpsY=;
 b=qByL82Fm3sganSMcuYZGu0z3pY0IKcsth7eUB7rjgHCZICkPFa9uDLCDMZV1FC8P9O
 +sN2MsG2LLpEtfJicG6uw/ROrkZXv3a9h9DQYIGUOf7K0jH0EfWrWX6AnMVapXpt8q5f
 gYQBt+gYeq2/JRgA7eja0Qz5DKLN20troKYXmdpOyfluQbWyIlD6AVk6hQBMGeGWLLix
 /znwe+LnyFy4WPA2hIMx3z32eW/jBVkZF8lXLBFg887mpE40DwCnPmXyw7aaDlkj/ctK
 CtoGxdFIR41ILLZktk8lW3F+5p3fDj800p9Wfoad7cJ5EygjN0sq6EqLS6WW4o2Mg2sO
 orDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vitaAIcV4SE+7Zrx0kH3CXztZqs8gVnOhGiQ7IdvpsY=;
 b=pFyfsHr8usL2O4RegAikYqNRpxKnYpUDNeo2KLRBOlhwPWgnz0SYs5ntqswjYej2Ut
 AKlqznfAWdHCJPisI/YPtaxf0gOKQ03kl/FzZJrpydxIG8/CNQMiyfJb0REijHDg4l3u
 Q/EqQ/K8LnGQiYchYpuIJuXLDACg3+hKyegEK6i7BBGb6Ij8aR6vsW1lOLUL5Rv5XCmE
 /oA82Apxl9roeimzwnl4K4DKelFYitB4tz/175Nkjc+WueEMZiHahL3VPyZ4XprfZ4DF
 45HZjboEitR3gwe2ECIhDEXXPejquSWxQcuJPJwvOH5griGq+kVvUpMP21ThD1UfmkFv
 2sUw==
X-Gm-Message-State: ANhLgQ2w4JY/AvvyImVOS/KgCEvoYoano9B5EmKsLY1vAJkfS8XmK3AS
 l6munL0k/T+7KhwmJGqhInqxcdGz
X-Google-Smtp-Source: ADFU+vuYnYXaF3yO3ylFsubESiHYvROEoBbeHjtZG1gCHV4MuDCT12UPhhYUORd0oSv4YS97UPbzYg==
X-Received: by 2002:a63:2:: with SMTP id 2mr3319504pga.102.1585146598704;
 Wed, 25 Mar 2020 07:29:58 -0700 (PDT)
Received: from bobo.ibm.com (14-202-190-183.tpgi.com.au. [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id i20sm10609622pfd.89.2020.03.25.07.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 07:29:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v2 1/4] ppc/spapr: KVM FWNMI should not be enabled until guest
 requests it
Date: Thu, 26 Mar 2020 00:29:03 +1000
Message-Id: <20200325142906.221248-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200325142906.221248-1-npiggin@gmail.com>
References: <20200325142906.221248-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The KVM FWNMI capability should be enabled with the "ibm,nmi-register"
rtas call. Although MCEs from KVM will be delivered as architected
interrupts to the guest before "ibm,nmi-register" is called, KVM has
different behaviour depending on whether the guest has enabled FWNMI
(it attempts to do more recovery on behalf of a non-FWNMI guest).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_caps.c  | 7 ++++---
 hw/ppc/spapr_rtas.c  | 7 +++++++
 target/ppc/kvm.c     | 7 +++++++
 target/ppc/kvm_ppc.h | 6 ++++++
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 679ae7959f..eb54f94227 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -517,9 +517,10 @@ static void cap_fwnmi_apply(SpaprMachineState *spapr, uint8_t val,
     }
 
     if (kvm_enabled()) {
-        if (kvmppc_set_fwnmi() < 0) {
-            error_setg(errp, "Firmware Assisted Non-Maskable Interrupts(FWNMI) "
-                             "not supported by KVM");
+        if (!kvmppc_get_fwnmi()) {
+            error_setg(errp,
+"Firmware Assisted Non-Maskable Interrupts(FWNMI) not supported by KVM.");
+            error_append_hint(errp, "Try appending -machine cap-fwnmi=off\n");
         }
     }
 }
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 9fb8c8632a..29abe66d01 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -437,6 +437,13 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
         return;
     }
 
+    if (kvm_enabled()) {
+        if (kvmppc_set_fwnmi() < 0) {
+            rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
+            return;
+        }
+    }
+
     spapr->fwnmi_system_reset_addr = sreset_addr;
     spapr->fwnmi_machine_check_addr = mce_addr;
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 597f72be1b..03d0667e8f 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -88,6 +88,7 @@ static int cap_ppc_safe_indirect_branch;
 static int cap_ppc_count_cache_flush_assist;
 static int cap_ppc_nested_kvm_hv;
 static int cap_large_decr;
+static int cap_fwnmi;
 
 static uint32_t debug_inst_opcode;
 
@@ -136,6 +137,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     kvmppc_get_cpu_characteristics(s);
     cap_ppc_nested_kvm_hv = kvm_vm_check_extension(s, KVM_CAP_PPC_NESTED_HV);
     cap_large_decr = kvmppc_get_dec_bits();
+    cap_fwnmi = kvm_vm_check_extension(s, KVM_CAP_PPC_FWNMI);
     /*
      * Note: setting it to false because there is not such capability
      * in KVM at this moment.
@@ -2064,6 +2066,11 @@ void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy)
     }
 }
 
+bool kvmppc_get_fwnmi(void)
+{
+    return cap_fwnmi;
+}
+
 int kvmppc_set_fwnmi(void)
 {
     PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 332fa0aa1c..fcaf745516 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -27,6 +27,7 @@ void kvmppc_enable_h_page_init(void);
 void kvmppc_set_papr(PowerPCCPU *cpu);
 int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
 void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
+bool kvmppc_get_fwnmi(void);
 int kvmppc_set_fwnmi(void);
 int kvmppc_smt_threads(void);
 void kvmppc_error_append_smt_possible_hint(Error *const *errp);
@@ -163,6 +164,11 @@ static inline void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy)
 {
 }
 
+static inline bool kvmppc_get_fwnmi(void)
+{
+    return false;
+}
+
 static inline int kvmppc_set_fwnmi(void)
 {
     return -1;
-- 
2.23.0


