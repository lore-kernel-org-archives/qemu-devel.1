Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BD0C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D056217F5
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEj2MMjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D056217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2TZE-0007G1-QL
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 00:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sjitindarsingh@gmail.com>) id 1i2TYW-0006hv-Ja
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sjitindarsingh@gmail.com>) id 1i2TYV-0004hw-EU
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:58:08 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:36786)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
 id 1i2TYS-0004e7-Id; Tue, 27 Aug 2019 00:58:04 -0400
Received: by mail-pl1-x641.google.com with SMTP id f19so11146657plr.3;
 Mon, 26 Aug 2019 21:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=P25ICHlvC9T2Gq4NKXejplGEdwCcHrENc9J7umEtneY=;
 b=gEj2MMjtrUKk35Id62KIdE4iZ3VhdM6oF+p5AqVXcEtWOJtyIztJPz+5rTrg4429VX
 TwraiyUA0OVQXBYi/U84KWf6G1LbUGXSrtnEPKerbrtKOXCVQ9hNQkNSiBg1SWeZ1JQr
 vt1tdR65IqIKqt7Ou+0X1USSpvJUXrQEvZ279bZkum5Oy8fg0hN7hrt0elm6Ui7aijQg
 4BBzkZB0M9NIQUC8y6yktevXikEzyf8Jka1puUwAuTY0S73P2eHzi1ovEsrVtxSPxmpW
 9eQ4sPUkXUNgCP3HMMC7OzQ2SeW/jVDLOL1GA7pt6DiQ5/6t1fvIj+axbu/W1r+cr12n
 XUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=P25ICHlvC9T2Gq4NKXejplGEdwCcHrENc9J7umEtneY=;
 b=EK8ASxUQ8iDOWkARu4pVUlI/sCR+ZKe3Vai3tjvc3ioFl/lHeVRfkLIQwu1TmmuM7e
 O9lgDNKcHQnql/cL5aell9IWrNgEGivIB3i023qyKwHOdnDXrH2+OvrB6wt3FmNkRWI5
 cFT3O6WH6pZb1Va6l12zekcYI+BNztG9wjPXekDnsu/Cx3o5WbbSpc2dDQhUDc5Vu6J1
 ebPvH6W+zdEZV2RoYqz/zqQD15ZhrPcdF6jJMw3FW2Wt8Ed7SmSQ3KWbfb2RSZoSvLNA
 8scFZAt1M7nmP3oxvM9Uqb63QiRTjfxqcr4RhJf0vVAkhWTi0EagAMfhSiugVENggdMk
 n0FQ==
X-Gm-Message-State: APjAAAWq1Dh5DzADP+3Sp1ExuIiblkohUMJGXUXOkRm+rZHyQLuDvXFX
 JlAKJSlkkWQ3ninU8/0Ejc/KTdPC
X-Google-Smtp-Source: APXvYqxeP5e+pEEzTAsCdlsa8i7Ma5v0KK2GnWtla/b3XyWV7wVtK3DhN5QN6Xq/Hf69mV/unS6SAw==
X-Received: by 2002:a17:902:a410:: with SMTP id
 p16mr22519249plq.150.1566881882515; 
 Mon, 26 Aug 2019 21:58:02 -0700 (PDT)
Received: from localhost.majoof.com (150.24.220.111.sta.wbroadband.net.au.
 [111.220.24.150])
 by smtp.gmail.com with ESMTPSA id t189sm14535883pfd.58.2019.08.26.21.58.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 26 Aug 2019 21:58:01 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: qemu-ppc@nongnu.org
Date: Tue, 27 Aug 2019 14:57:51 +1000
Message-Id: <20190827045751.22123-1-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [QEMU-PPC] [PATCH V4] powerpc/spapr: Add host threads
 parameter to ibm, get_system_parameter
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
Cc: qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ibm,get_system_parameter rtas call is used by the guest to retrieve
data relating to certain parameters of the system. The SPLPAR
characteristics option (token 20) is used to determine characteristics of
the environment in which the lpar will run.

It may be useful for a guest to know the number of physical host threads
present on the underlying system where it is being run. Add the
characteristic "HostThrs" to the SPLPAR Characteristics
ibm,get_system_parameter rtas call to expose this information to a
guest. Add a n_host_threads property to the processor class which is
then used to retrieve this information and define it for POWER8 and
POWER9. Other processors will default to 0 and the charateristic won't
be added.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

---

V1 -> V2:
- Take into account that the core may be operating in split core mode
  meaning a single core may be split into multiple subcores.
V2 -> V3:
- Add curly braces for single line if statements
V3 -> V4;
- Add a host threads property to the processor class and use this to
  derive the information rather than the device tree.
---
 hw/ppc/spapr_rtas.c             | 15 +++++++++++++++
 target/ppc/cpu-qom.h            |  1 +
 target/ppc/translate_init.inc.c |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 526b489297..bee3835214 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -266,6 +266,7 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
                                           target_ulong args,
                                           uint32_t nret, target_ulong rets)
 {
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     MachineState *ms = MACHINE(qdev_get_machine());
     unsigned int max_cpus = ms->smp.max_cpus;
     target_ulong parameter = rtas_ld(args, 0);
@@ -283,6 +284,20 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
                                           current_machine->ram_size / MiB,
                                           ms->smp.cpus,
                                           max_cpus);
+        if (pcc->n_host_threads > 0) {
+            char *hostthr_val, *old = param_val;
+
+            /*
+             * Add HostThrs property. This property is not present in PAPR but
+             * is expected by some guests to communicate the number of physical
+             * host threads per core on the system so that they can scale
+             * information which varies based on the thread configuration.
+             */
+            hostthr_val = g_strdup_printf(",HostThrs=%d", pcc->n_host_threads);
+            param_val = g_strconcat(param_val, hostthr_val, NULL);
+            g_free(hostthr_val);
+            g_free(old);
+        }
         ret = sysparm_st(buffer, length, param_val, strlen(param_val) + 1);
         g_free(param_val);
         break;
diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index 7ffdb0a706..e499575dc8 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -191,6 +191,7 @@ typedef struct PowerPCCPUClass {
     const PPCHash64Options *hash64_opts;
     struct ppc_radix_page_info *radix_page_info;
     uint32_t lrg_decr_bits;
+    int n_host_threads;
     void (*init_proc)(CPUPPCState *env);
     int  (*check_pow)(CPUPPCState *env);
     int (*handle_mmu_fault)(PowerPCCPU *cpu, vaddr eaddr, int rwx, int mmu_idx);
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 4a21ed7289..41f77b7ef8 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8770,6 +8770,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
     pcc->handle_mmu_fault = ppc_hash64_handle_mmu_fault;
     pcc->hash64_opts = &ppc_hash64_opts_POWER7;
     pcc->lrg_decr_bits = 32;
+    pcc->n_host_threads = 8;
 #endif
     pcc->excp_model = POWERPC_EXCP_POWER8;
     pcc->bus_model = PPC_FLAGS_INPUT_POWER7;
@@ -8981,6 +8982,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
     pcc->hash64_opts = &ppc_hash64_opts_POWER7;
     pcc->radix_page_info = &POWER9_radix_page_info;
     pcc->lrg_decr_bits = 56;
+    pcc->n_host_threads = 4;
 #endif
     pcc->excp_model = POWERPC_EXCP_POWER9;
     pcc->bus_model = PPC_FLAGS_INPUT_POWER9;
-- 
2.13.6


