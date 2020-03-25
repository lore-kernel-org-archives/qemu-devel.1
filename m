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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D40C54FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F61D208E0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vI8ipzUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F61D208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7Fz-0005IJ-F5
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 10:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jH7Ex-0003hP-Ux
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jH7Ew-0005XO-Pk
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:42:43 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46537)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jH7Eu-0005UW-AJ; Wed, 25 Mar 2020 10:42:40 -0400
Received: by mail-pf1-x442.google.com with SMTP id q3so1111159pff.13;
 Wed, 25 Mar 2020 07:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gu6pywT46+NIJtDkxdkhjr7/9oPHNs5B3YjgwAQz2ZQ=;
 b=vI8ipzUtsfog2UdLfSd5QT65v3aV84AxI7Gea2Vamm2LvotNHN9DSH4miIblyhYjKl
 Hg0SkNw6L5O8mdhEmdz78AhtSK+utjj0OMqOi4H4HB1JV7bceji2NUTJEqd2hcQxxI6J
 oO/3EdSCOGLCk8XSJWmEG4q/b+f4Lot8x+oeq8NVeeGYhLsS7h95prQA2+hKr3Z+Qzn0
 r53Pt6H5fnLUSrAY3xRm8ksHD4zILH8NyETW/ReMALKM5KPfdMRLJSRDfFMNFK+xi2hI
 5WwRXnrxoafQmDVMdUzp8MW/TNtuENTX20Goj1ygVbpKx8LgakBBt8gzqudLypzOK2rg
 ZzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gu6pywT46+NIJtDkxdkhjr7/9oPHNs5B3YjgwAQz2ZQ=;
 b=BFrILBE5EXW9swC1NwSuti0pGdKEBhqTXdEYjphTZlMhG9dSO5KfDzJfD2f/rl/FVz
 8ETujjfy0kVGbgC1rELwevKGl08BICZF5TDWYVRwc62BS0TVnl0XHYTAQQfPT//7ImHp
 YFqi8NsjpkUwckfQiNUE7ibClGKGfY611HtZon5Qq+xD4f0c/LlArDaq2aip6WoneBQ1
 /tdyOIHzy+7OoRJEKj5leowb7lNiRAva3qNZNSuCR4Cv2uj3QhGFICIdrLpgD8LFHLzU
 YWFeisF4C0fOXjUnhQjSH1yFf8/tyG7piNDEZXZ1ntThSt/5QahDVN6DHuqifZwiPAHB
 WRqQ==
X-Gm-Message-State: ANhLgQ1T7yuikrD2zJ2/AZCpqEIKSaC1SqEAQDzfFmQJInMVgHRx6BqH
 zZyzFRijlq6FjwR4q0B+z6eQLTYA
X-Google-Smtp-Source: ADFU+vum9tWbJL7v6l867URB0a+AVony1Jv78gtbKJrzMFbsfUflKX8VJYHQTQLPZJtO1kp/gsbgBQ==
X-Received: by 2002:a63:e56:: with SMTP id 22mr3429177pgo.173.1585147359098;
 Wed, 25 Mar 2020 07:42:39 -0700 (PDT)
Received: from bobo.ibm.com (14-202-190-183.tpgi.com.au. [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id 93sm4609599pjo.43.2020.03.25.07.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 07:42:38 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH 1/5] ppc/spapr: tweak change system reset helper
Date: Thu, 26 Mar 2020 00:41:43 +1000
Message-Id: <20200325144147.221875-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200325144147.221875-1-npiggin@gmail.com>
References: <20200325144147.221875-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rather than have the helper take an optional vector address
override, instead have its caller modify env->nip itself.
This is more consistent when adding pnv nmi support, and also
with mce injection added later.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c           | 9 ++++++---
 target/ppc/cpu.h         | 2 +-
 target/ppc/excp_helper.c | 5 +----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9a2bd501aa..785c41d205 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3385,13 +3385,13 @@ static void spapr_machine_finalizefn(Object *obj)
 void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
 
     cpu_synchronize_state(cs);
     /* If FWNMI is inactive, addr will be -1, which will deliver to 0x100 */
     if (spapr->fwnmi_system_reset_addr != -1) {
         uint64_t rtas_addr, addr;
-        PowerPCCPU *cpu = POWERPC_CPU(cs);
-        CPUPPCState *env = &cpu->env;
 
         /* get rtas addr from fdt */
         rtas_addr = spapr_get_rtas_addr();
@@ -3405,7 +3405,10 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg)
         stq_be_phys(&address_space_memory, addr + sizeof(uint64_t), 0);
         env->gpr[3] = addr;
     }
-    ppc_cpu_do_system_reset(cs, spapr->fwnmi_system_reset_addr);
+    ppc_cpu_do_system_reset(cs);
+    if (spapr->fwnmi_system_reset_addr != -1) {
+        env->nip = spapr->fwnmi_system_reset_addr;
+    }
 }
 
 static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 88d9449555..f4a5304d43 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1220,7 +1220,7 @@ int ppc64_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
 int ppc32_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
                                int cpuid, void *opaque);
 #ifndef CONFIG_USER_ONLY
-void ppc_cpu_do_system_reset(CPUState *cs, target_ulong vector);
+void ppc_cpu_do_system_reset(CPUState *cs);
 void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector);
 extern const VMStateDescription vmstate_ppc_cpu;
 #endif
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 08bc885ca6..7f2b5899d3 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -961,15 +961,12 @@ static void ppc_hw_interrupt(CPUPPCState *env)
     }
 }
 
-void ppc_cpu_do_system_reset(CPUState *cs, target_ulong vector)
+void ppc_cpu_do_system_reset(CPUState *cs)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
     powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_RESET);
-    if (vector != -1) {
-        env->nip = vector;
-    }
 }
 
 void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector)
-- 
2.23.0


