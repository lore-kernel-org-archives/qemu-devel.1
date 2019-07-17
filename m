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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0387C76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 05:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E1262173E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 05:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZuKTF1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1262173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hncgX-0004kJ-B2
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 01:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50236)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hncfy-0002gc-Ub
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 01:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hncfx-0005Qx-QP
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 01:40:26 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36553)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hncfu-0005KX-2w; Wed, 17 Jul 2019 01:40:22 -0400
Received: by mail-pg1-x544.google.com with SMTP id l21so10580276pgm.3;
 Tue, 16 Jul 2019 22:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BR3uMip3p9rnfFlWfUdS1X+rAUOUHyRPq5JXUGBoDVk=;
 b=JZuKTF1NofW84NPlqpyLlE2jvAzxTfaIVkrLKspqqEi8tI/OY7PJiQKogecFs4xZpr
 EtmCMnphmqodt9fdLYNv3HxldWnE+pg1mAQyrME3SvzbYftPcRMXp1NyXo2GNvznG6TE
 6QyJH3CFLDwZm7MwioqlchxigqOjFeLeLlkz1VbDB5ZxB1Mu1c8FfZV0SXJ3uWQsBWS2
 qxLv13MLavT9aLa2EA2qex+um2EIB/OpWSpElKOydKc8+kjlsEe3LDYMp/kXFuRlrmFA
 eqZbgK9wQsPGwwWfA7J3A8Og+3a3gP9JihV70/VmegZhoPhYqzBIybLjU+T2fqh9jAAG
 zPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BR3uMip3p9rnfFlWfUdS1X+rAUOUHyRPq5JXUGBoDVk=;
 b=YptT89oZqMlqQ29T9P7zvhyy5tpGWf+GIHKvfKcQ3tdJb2QIU8kS2kgl+5+lCD43M4
 IzAdNoYcD6c7JiuPKwuKT02sq/0aGK2uLCd+oRxSyiiWnhZcpcjzrq/8unTglL8Z7IWu
 8/PovUWqKKSKQX7SzEwjjdWig42JCcTk0L/+FNjwyWsdqjL8dqTcNAKMTfEwBNqz3iwY
 Gwxu9oACphBbxXUekX5hyzuG8SDIbIhN9zk6iSSyqAN7wMkDLp0/QKFS3xlibXoCQ5es
 z3/Slan/7klvAfCWhxA3mKTSsufxSwy7YH8pfeL+93O6cBTSvFU+RXeTH6ASQEuvMb/+
 9Scw==
X-Gm-Message-State: APjAAAVmtWd/fBxKmGQ0jR+ToRIKpq8W4vfX6OMS7WtDm7OiXiqZVxZf
 QRhXMZVeREEq176EJB3zDQs=
X-Google-Smtp-Source: APXvYqxbz/xx7B65KB1HmeUsREU5sZOiaV4Z3iKyF9JK/pn+3JtnhvHhIaQ73rG2ze8c7596DJHu+g==
X-Received: by 2002:a63:4846:: with SMTP id x6mr2161685pgk.332.1563342021085; 
 Tue, 16 Jul 2019 22:40:21 -0700 (PDT)
Received: from bobo.local0.net ([203.220.8.141])
 by smtp.gmail.com with ESMTPSA id g18sm39322656pgm.9.2019.07.16.22.40.17
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 16 Jul 2019 22:40:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 17 Jul 2019 15:39:52 +1000
Message-Id: <20190717053952.13729-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717053952.13729-1-npiggin@gmail.com>
References: <20190717053952.13729-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v5 4/4] spapr: Implement H_JOIN
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
Changes since v4:
- Style

 hw/ppc/spapr.c       |  1 +
 hw/ppc/spapr_hcall.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 13c423347e..59cd24f9c3 100644
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
index 5e655172b2..57c1ee0fe1 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1069,6 +1069,48 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_SUCCESS;
 }
 
+static target_ulong h_join(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    CPUPPCState *env = &cpu->env;
+    CPUState *cs;
+    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
+    bool last_unjoined = true;
+
+    if (env->msr & (1ULL << MSR_EE)) {
+        return H_BAD_MODE;
+    }
+
+    if (spapr_cpu->prod) {
+        spapr_cpu->prod = false;
+        return H_SUCCESS;
+    }
+
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
+    cs = CPU(cpu);
+    cs->halted = 1;
+    cs->exception_index = EXCP_HALTED;
+    cs->exit_request = 1;
+
+    return H_SUCCESS;
+}
+
 static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
@@ -1979,6 +2021,9 @@ static void hypercall_register_types(void)
     spapr_register_hypercall(H_CONFER, h_confer);
     spapr_register_hypercall(H_PROD, h_prod);
 
+    /* hcall-join */
+    spapr_register_hypercall(H_JOIN, h_join);
+
     spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
 
     /* processor register resource access h-calls */
-- 
2.20.1


