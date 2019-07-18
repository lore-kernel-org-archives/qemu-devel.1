Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284D7C76195
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 03:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA3432077C
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 03:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1Epohxl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3432077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnxKO-0001zT-RQ
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 23:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40234)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hnxJf-0007Qx-PF
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 23:42:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hnxJe-0007Zq-Gw
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 23:42:47 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46760)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hnxJb-0007RD-VU; Wed, 17 Jul 2019 23:42:44 -0400
Received: by mail-pl1-x642.google.com with SMTP id c2so13073225plz.13;
 Wed, 17 Jul 2019 20:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CejO63wL9gdz+3FU2IitZ4WVmxu89QTV4nU9VjaG4QQ=;
 b=p1EpohxlijYxyGDtJtRzfbOQUFYswiG5O8vbwdDm5hQIHLBi8/7ZgLXIYG2NdUFT47
 AE8QtqIqd6dPZ3Grow61thTAuAov+j7LmonBl0OREB1fgD3sZ9kmahwmOpEW1TX6Ci7B
 aA7J4K43QwtdIHiVnq7/dRiXFEsA5WogUG3qFm9BawQVccThnmpJlWkCNsjFregnnH/Z
 UGiZ0tX3ZtsXZuJJcgxbyAyEXsHzyyE3JEJmiLTn84+WYaGGbKmf76sqY0vZD79k7ZXx
 c+bP7P/CcoMghTigxOWbgC40ZwkrGXXG0S+YitZrT7ylQZqXaZzR0XFRPt4zT8bipVNd
 GWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CejO63wL9gdz+3FU2IitZ4WVmxu89QTV4nU9VjaG4QQ=;
 b=kZxa4V0RyJPcTBAYiKMSPL0fVQ5n8SskJQfrgQN3ypf3LJE0gmqngttlmmib34QHfJ
 lNqABYNx1znNTsSFOEt5xJGZJM4k8aEZDtHEqn/O/XDXvplCMja6HMSFolQuMrvwQK0S
 OX0q/t91Eaalvswb+NufDHtsHShK5unASTvuv4qrXKxDPQGgFKiCxNno2QitoDrlKqr6
 ACzhyyGEcYpW+X3BZejd8RAEv5CfshP2vGZALhq+qcKdNG7UlHdbFzUTx14QeDaHsx/e
 GBIkMCLcx/diOTamMD2b9IUR3UQGeReK1uDb6kXB5RZUYo/T2uge6JxkxqeWAKkAawEP
 2GCg==
X-Gm-Message-State: APjAAAW9k+mZ4T1GX2j9pLb/Xoa2v951jFDvV6JBqrnu8wMhWV91AfU7
 XX842XnIj4BF9HLRz9B6dPY=
X-Google-Smtp-Source: APXvYqzIxHIxVHN8eC1CveSyebNhVUl0O/3Y4IuD6IofvrHLRd190VY5bKVbaYRWajO+L5hNgj3UuQ==
X-Received: by 2002:a17:902:1125:: with SMTP id
 d34mr47512356pla.40.1563421362869; 
 Wed, 17 Jul 2019 20:42:42 -0700 (PDT)
Received: from bobo.local0.net ([203.220.8.141])
 by smtp.gmail.com with ESMTPSA id b3sm38787612pfp.65.2019.07.17.20.42.39
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 20:42:42 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 18 Jul 2019 13:42:14 +1000
Message-Id: <20190718034214.14948-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190718034214.14948-1-npiggin@gmail.com>
References: <20190718034214.14948-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v6 4/4] spapr: Implement H_JOIN
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

This has been useful to modify and test the Linux pseries suspend
code but it requires modification to the guest to call it (due to
being gated by other unimplemented features). It is not otherwise
used by Linux yet, but work is slowly progressing there.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Changes since v5:
- Fix prod bit semantics.
- Factor out the h_confer_self common code

Changes since v4:
- Style

 hw/ppc/spapr.c       |  1 +
 hw/ppc/spapr_hcall.c | 74 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 68341c128d..00f7735a31 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1066,6 +1066,7 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
     add_str(hypertas, "hcall-tce");
     add_str(hypertas, "hcall-vio");
     add_str(hypertas, "hcall-splpar");
+    add_str(hypertas, "hcall-join");
     add_str(hypertas, "hcall-bulk");
     add_str(hypertas, "hcall-set-mode");
     add_str(hypertas, "hcall-sprg0");
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 7c659dc75c..9b72ea8b68 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1069,6 +1069,62 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_SUCCESS;
 }
 
+/*
+ * Confer to self, aka join. Cede could use the same pattern as well, if
+ * EXCP_HLT can be changed to ECXP_HALTED.
+ */
+static target_ulong h_confer_self(PowerPCCPU *cpu)
+{
+    CPUState *cs = CPU(cpu);
+    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
+
+    if (spapr_cpu->prod) {
+        spapr_cpu->prod = false;
+        return H_SUCCESS;
+    }
+    cs->halted = 1;
+    cs->exception_index = EXCP_HALTED;
+    cs->exit_request = 1;
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_join(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    CPUPPCState *env = &cpu->env;
+    CPUState *cs;
+    bool last_unjoined = true;
+
+    if (env->msr & (1ULL << MSR_EE)) {
+        return H_BAD_MODE;
+    }
+
+    /*
+     * Must not join the last CPU running. Interestingly, no such restriction
+     * for H_CONFER-to-self, but that is probably not intended to be used
+     * when H_JOIN is available.
+     */
+    CPU_FOREACH(cs) {
+        PowerPCCPU *c = POWERPC_CPU(cs);
+        CPUPPCState *e = &c->env;
+        if (c == cpu) {
+            continue;
+        }
+
+        /* Don't have a way to indicate joined, so use halted && MSR[EE]=0 */
+        if (!cs->halted || (e->msr & (1ULL << MSR_EE))) {
+            last_unjoined = false;
+            break;
+        }
+    }
+    if (last_unjoined) {
+        return H_CONTINUE;
+    }
+
+    return h_confer_self(cpu);
+}
+
 static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
@@ -1089,26 +1145,15 @@ static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
             return H_PARAMETER;
         }
 
-        spapr_cpu = spapr_cpu_state(target_cpu);
-
         /*
          * target == self is a special case, we wait until prodded, without
          * dispatch counter check.
          */
         if (cpu == target_cpu) {
-            if (spapr_cpu->prod) {
-                spapr_cpu->prod = false;
-
-                return H_SUCCESS;
-            }
-
-            cs->halted = 1;
-            cs->exception_index = EXCP_HALTED;
-            cs->exit_request = 1;
-
-            return H_SUCCESS;
+            return h_confer_self(cpu);
         }
 
+        spapr_cpu = spapr_cpu_state(target_cpu);
         if (!spapr_cpu->vpa_addr || ((dispatch & 1) == 0)) {
             return H_SUCCESS;
         }
@@ -1981,6 +2026,9 @@ static void hypercall_register_types(void)
     spapr_register_hypercall(H_CONFER, h_confer);
     spapr_register_hypercall(H_PROD, h_prod);
 
+    /* hcall-join */
+    spapr_register_hypercall(H_JOIN, h_join);
+
     spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
 
     /* processor register resource access h-calls */
-- 
2.20.1


