Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3D1C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 06:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4922089F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 06:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUt5ecBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4922089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48154 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfI6a-0007OF-AK
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 02:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35879)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sjitindarsingh@gmail.com>) id 1hfHzp-0003Yd-1z
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 01:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sjitindarsingh@gmail.com>) id 1hfHzn-0005zn-O5
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 01:58:28 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36795)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
 id 1hfHzk-0005wp-0r; Mon, 24 Jun 2019 01:58:24 -0400
Received: by mail-pf1-x442.google.com with SMTP id r7so6870312pfl.3;
 Sun, 23 Jun 2019 22:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=e1sCAFcw0EvnjOzpHw97/K0fRePmkZE8GMoO+SZykS0=;
 b=GUt5ecBzxgnbVLwWuVs+RcvW3DvNrqnRwZ+Fg2HiTr2GEVQhxSkpTRG/V7G2hNlcGq
 SnA3/h73O/eKLOm9VddjrDlxwF8dceHYh85NsioWqck2Eh4+gQ7IhCNNkddtNwBdI4Qi
 iLbgvJ08zYmNE5b/EVwuT41uKClJzb6TGUqERY3NP5zh+JI7V1N6D6qHfZhG7NcGsTX1
 fg3nFobLMRKhIMGPsp17qgy28hD3N1YZBBbsVqJ2OYXnn/Xnia8FF44rUDy4GUwvh9uL
 aNrJNGhhSZODGA/eN66i3D+1hXmxY/DV/WLNP0jjIQwGKrG/gTPr6CEpCCThwwExLu/W
 YCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=e1sCAFcw0EvnjOzpHw97/K0fRePmkZE8GMoO+SZykS0=;
 b=IgwOhszau7MxwlxymTeBs3XlPqHFBPksm2iFHd6ptCgEZFnObOcatC0f+dlaI8ovmp
 pYrMOMsTSlrdt4aoGWYh2SdrVAnQ1LdiBH2fGKrxzBBX5z5cksCx3CFM/33jrIl50eqt
 wO7grBTXvl6gjKqVP+Z0IwCWNkSGj8fY7O92+IYAREpuVNGmDsG+OVG/Nlfd2qefr7eP
 tDEdtG97oXS3fwzgWw17EykHL8X3rxjKTOF+279ddub6uRVFonxmYDQMAuwp1AfTeO0n
 Du8jabkFrgtB8nISLMA88DHIn83IVmW+zvw8JNgh0Xd43hgvJmz9HFPoXundw94YrcMV
 vvug==
X-Gm-Message-State: APjAAAXD/A1dwMmPnhbnbMhB4OgDANi+Czj2BfOzEtHivGkAtiLDOaPm
 XY4winoCqDafm5V09M/utNjpzzg2
X-Google-Smtp-Source: APXvYqxXNLJLs/cXf50gfS8EdmTPuXi6RewIEFUg+msRrrSZ8Ot09TqtLDM3pozlFX8Kfzq35e+EKg==
X-Received: by 2002:a63:d211:: with SMTP id a17mr31184187pgg.269.1561355902273; 
 Sun, 23 Jun 2019 22:58:22 -0700 (PDT)
Received: from surajjs2.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id s15sm12579335pfd.183.2019.06.23.22.58.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 23 Jun 2019 22:58:21 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: qemu-ppc@nongnu.org
Date: Mon, 24 Jun 2019 15:58:11 +1000
Message-Id: <20190624055812.3906-1-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 1/2] ppc/spapr: Add implementation
 of hcall H_PURR
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
Cc: qemu-devel@nongnu.org, sjitindarsingh@gmail.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The hcall H_PURR is used by a guest to read the PURR (processor
utilisation of resources register). A guest expects that this register
will count at a rate of timebase scaled by the number of guest vcpus
present in the vcore. That is the per vcpu purr will count at a rate of
timebase / # vcpus per vcore.

Implement a handler for the H_PURR hcall and return the purr value
divided by smp_threads so that the sum of the purr deltas across the
vcpus of a vcore equals the timebase delta

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr_hcall.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index aae9fd2b3e..88b3343f04 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1819,6 +1819,27 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_SUCCESS;
 }
 
+static target_ulong h_purr(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    CPUPPCState *env = &cpu->env;
+    target_ulong purr;
+
+    if (kvm_enabled()) {
+        cpu_synchronize_state(CPU(cpu));
+        /*
+         * Divide by smp_threads so that the sum of the purr deltas across the
+         * vcpus of a vcore equal the timebase delta.
+         */
+        purr = env->spr[SPR_PURR] / smp_threads;
+    } else {
+        purr = cpu_ppc_load_purr(env);
+    }
+    args[0] = purr;
+
+    return H_SUCCESS;
+}
+
 static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
 static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_HCALL_BASE + 1];
 
@@ -1915,6 +1936,9 @@ static void hypercall_register_types(void)
     spapr_register_hypercall(H_LOGICAL_DCBF, h_logical_dcbf);
     spapr_register_hypercall(KVMPPC_H_LOGICAL_MEMOP, h_logical_memop);
 
+    /* hcall-purr */
+    spapr_register_hypercall(H_PURR, h_purr);
+
     /* qemu/KVM-PPC specific hcalls */
     spapr_register_hypercall(KVMPPC_H_RTAS, h_rtas);
 
-- 
2.13.6


