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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC37C54FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:44:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8867220775
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtaq9j1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8867220775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7H2-0007KW-N3
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 10:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jH7FG-0004Oe-RF
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jH7FF-0005lM-FF
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:43:02 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jH7FC-0005ik-L5; Wed, 25 Mar 2020 10:42:58 -0400
Received: by mail-pl1-x644.google.com with SMTP id e1so868024plt.9;
 Wed, 25 Mar 2020 07:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xC2tnZoYkPikXWD+v0w7eZk0ARUbcYtItYPE5B/2aAQ=;
 b=qtaq9j1Lw+OUiIlYicY9WZc6xNxehVyAVbP1vzBN77WJFIxqZK8qikx/4KekDdUTbt
 5oDpuYr1KJ6/VPiRtN2bjlv+qVzi+qx9cJOi/LETi9cP21MxxWhFEgyVImCVGjdRMxzi
 J5Wm+80liTnoGhnTy1NqaAnG3rcLPoKSu1gnCC/tkpbnAis7j7yPQIV5qhjznyWlBn7P
 7keVcoJTjT+MPk/1LZBuWyJ5pwqzVlr132YRRaEFvOJ7zyHqje0yh1UvYLus0aWP4fiW
 uEUG0eDIE8BxOYnVp8HmZs99kIUEzPGgyQRVLxSxicTsGdQSgT/opLGzO38rM82jpNfv
 Apvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xC2tnZoYkPikXWD+v0w7eZk0ARUbcYtItYPE5B/2aAQ=;
 b=gnC5rOB8Wy4QWMoxdryXK1y/tGqswRe+Dn2W2291TwdkGsNWlZ3aBJExgUdjDZYOJG
 YwSmx8zOZQoTyuTGhhVMLpLdVBi8Krv1p4ah7dkora2unvx2Z/J4oCvK6gk8MMxNXpl0
 NFWJErIOP8HJy5a1EWk7YuL5DscAq2WgcB666aqDHzoYxJXgtap8ZvAqD7d7ISZtVACo
 z2iDBrUuwNUq5pZqGqYC6wq3QfzG68qGW/g54tFAG0jIcV7vrwB/MN/Sn1x+PScvbab2
 gupRaqLlkNiGTE3/Y5koc94hbWGe0zWg5E8Dl/uslY3tesItixWMaOLAz1TltLABOcUa
 GTyg==
X-Gm-Message-State: ANhLgQ2RM/7SjI7Tt1tPqm2Ppgm2hPzc05mOXIXBEexK53q8IjrT07v5
 oDH5wogAktGNiI/nn2dcpQK5PWvQ
X-Google-Smtp-Source: ADFU+vtosPx/t1qphpGti1wKykuCE6+FvkOVxZWKwS6BkpdxMc0LzSktC7viVQzjeuVLdKZPg0EOTg==
X-Received: by 2002:a17:90a:9f88:: with SMTP id
 o8mr4066521pjp.145.1585147377196; 
 Wed, 25 Mar 2020 07:42:57 -0700 (PDT)
Received: from bobo.ibm.com (14-202-190-183.tpgi.com.au. [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id 93sm4609599pjo.43.2020.03.25.07.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 07:42:56 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH 5/5] ppc/pnv: Implement mce injection
Date: Thu, 26 Mar 2020 00:41:47 +1000
Message-Id: <20200325144147.221875-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200325144147.221875-1-npiggin@gmail.com>
References: <20200325144147.221875-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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

This implements mce injection for pnv.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c             | 55 ++++++++++++++++++++++++++++++++++++++++
 target/ppc/cpu.h         |  1 +
 target/ppc/excp_helper.c | 12 +++++++++
 3 files changed, 68 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 671535ebe6..9c515bfeed 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -38,6 +38,7 @@
 #include "hw/nmi.h"
 #include "exec/address-spaces.h"
 #include "qapi/visitor.h"
+#include "qapi/qmp/qdict.h"
 #include "monitor/monitor.h"
 #include "hw/intc/intc.h"
 #include "hw/ipmi/ipmi.h"
@@ -1981,11 +1982,63 @@ static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
     }
 }
 
+typedef struct MCEInjectionParams {
+    uint64_t srr1_mask;
+    uint32_t dsisr;
+    uint64_t dar;
+    bool recovered;
+} MCEInjectionParams;
+
+static void pnv_do_mce_on_cpu(CPUState *cs, run_on_cpu_data data)
+{
+    MCEInjectionParams *params = data.host_ptr;
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+    uint64_t srr1_mce_bits = PPC_BITMASK(42, 45) | PPC_BIT(36);
+
+    cpu_synchronize_state(cs);
+    ppc_cpu_do_machine_check(cs);
+
+    env->spr[SPR_SRR1] |= (params->srr1_mask & srr1_mce_bits);
+    if (params->dsisr) {
+        env->spr[SPR_DSISR] = params->dsisr;
+        env->spr[SPR_DAR] = params->dar;
+    }
+
+    if (!params->recovered) {
+        env->msr &= ~MSR_RI;
+    }
+}
+
+static void pnv_mce(MCEState *m, const QDict *qdict, Error **errp)
+{
+    int cpu_index = qdict_get_int(qdict, "cpu_index");
+    uint64_t srr1_mask = qdict_get_int(qdict, "srr1_mask");
+    uint32_t dsisr = qdict_get_int(qdict, "dsisr");
+    uint64_t dar = qdict_get_int(qdict, "dar");
+    bool recovered = qdict_get_int(qdict, "recovered");
+    CPUState *cs;
+
+    cs = qemu_get_cpu(cpu_index);
+
+    if (cs != NULL) {
+        MCEInjectionParams params = {
+            .srr1_mask = srr1_mask,
+            .dsisr = dsisr,
+            .dar = dar,
+            .recovered = recovered,
+        };
+
+        run_on_cpu(cs, pnv_do_mce_on_cpu, RUN_ON_CPU_HOST_PTR(&params));
+    }
+}
+
 static void pnv_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     InterruptStatsProviderClass *ispc = INTERRUPT_STATS_PROVIDER_CLASS(oc);
     NMIClass *nc = NMI_CLASS(oc);
+    MCEClass *mcec = MCE_CLASS(oc);
 
     mc->desc = "IBM PowerNV (Non-Virtualized)";
     mc->init = pnv_init;
@@ -2003,6 +2056,7 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_id = "pnv.ram";
     ispc->print_info = pnv_pic_print_info;
     nc->nmi_monitor_handler = pnv_nmi;
+    mcec->mce_monitor_handler = pnv_mce;
 
     object_class_property_add_bool(oc, "hb-mode",
                                    pnv_machine_get_hb, pnv_machine_set_hb,
@@ -2067,6 +2121,7 @@ static const TypeInfo types[] = {
         .interfaces = (InterfaceInfo[]) {
             { TYPE_INTERRUPT_STATS_PROVIDER },
             { TYPE_NMI },
+            { TYPE_MCE },
         },
     },
     {
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index f4a5304d43..9be27f59c5 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1221,6 +1221,7 @@ int ppc32_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
                                int cpuid, void *opaque);
 #ifndef CONFIG_USER_ONLY
 void ppc_cpu_do_system_reset(CPUState *cs);
+void ppc_cpu_do_machine_check(CPUState *cs);
 void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector);
 extern const VMStateDescription vmstate_ppc_cpu;
 #endif
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 7f2b5899d3..81dd8b6f8e 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -279,6 +279,10 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
             cs->halted = 1;
             cpu_interrupt_exittb(cs);
         }
+        if (msr_pow) {
+            /* indicate that we resumed from power save mode */
+            msr |= 0x10000;
+        }
         if (env->msr_mask & MSR_HVB) {
             /*
              * ISA specifies HV, but can be delivered to guest with HV
@@ -969,6 +973,14 @@ void ppc_cpu_do_system_reset(CPUState *cs)
     powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_RESET);
 }
 
+void ppc_cpu_do_machine_check(CPUState *cs)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+
+    powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_MCHECK);
+}
+
 void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
-- 
2.23.0


