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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457FDC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7D6220679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVSvbXW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D6220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDswu-0001tD-MZ
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jDqiG-0007bm-J2
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:27:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jDqiF-00055b-Ft
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:27:28 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35944)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jDqiC-0004bo-8Z; Mon, 16 Mar 2020 10:27:24 -0400
Received: by mail-pl1-x641.google.com with SMTP id g2so5584557plo.3;
 Mon, 16 Mar 2020 07:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IwXPy4HQuuWGCAq2XrwIVJ4D8opXygGPCnzLpk/UyHs=;
 b=LVSvbXW52IRJUcxBmV/2bU+6i04Qc564XOEHjJZlKJ5lGW4Xvy/8O8oXk9hGOcHUxB
 3o26DGyfH+mO9r1KLV6Qe4sAP2zHt9zm4s9vF6jeXyADhLnWvOycBpIXlhVjoS3RQ1OL
 wi/3wd3gQ2oGRcVC1pkMI5Od2mvAdlCBwlEETjz14yiNdhAAt0M3LZNpirYQZ7+i35wS
 V1oJYggyfcLzUiQQAMIZ2jiNouUSGTMOP8lN4YLDyRt5b1ZJ6U1BMJu3RHqdyJUOQNtZ
 xu3p2F22QNQ2T4y8Sre/VWQgftQ7leafsCykbn/T2x305xGJjgOYxKWkITAPCDmzX/ji
 hg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IwXPy4HQuuWGCAq2XrwIVJ4D8opXygGPCnzLpk/UyHs=;
 b=NEYrP7lgxPqNz4Bq1YExLnq2vdYSvvsTTd7eTUWyFU527dCL7L1oVxTMfgNSabhkmE
 EYPMP52h6flnX2rXqj55XAbrxygfdm3dotbK2J7KjEFoAtr+Bn5OVzynMgBaJP7SxaGl
 NcCj5y4WsBlaEUDD662I37ynXOrRzSkMRsDB4tR0OWFMYzy+mREnDsy76dkAJBszfp10
 wm3fX8L/6SGu0QmEwVA33yXAmNKWI6xbesEHPch2H4+p+Kat7BvHjBGoP80TiKgVKjJ2
 dIIgpsgKIx7TOsOkPur/8X0zIr/ARWFX248Hd4TLQnhmJUsza6cKo2HgHtRf4Joy0Hss
 ZDeg==
X-Gm-Message-State: ANhLgQ30McZCUryWj87shfllUlG3VJ3MDV5ogkVPVW6lbI6MQj8DfPcP
 nwzyPUhdyHYlD6p1VaHas1j2oNNm4hw=
X-Google-Smtp-Source: ADFU+vuWINuJLu/J78N+ZxLIWLzVNRaLPV0oVKU90irv1yMC+rhXB5bJWtehKVo2MT/CJckiHk+xuw==
X-Received: by 2002:a17:902:9a48:: with SMTP id
 x8mr27809987plv.14.1584368843025; 
 Mon, 16 Mar 2020 07:27:23 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.63.160.49])
 by smtp.gmail.com with ESMTPSA id v1sm45564pjy.35.2020.03.16.07.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 07:27:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v2 7/8] ppc/spapr: Implement FWNMI System Reset delivery
Date: Tue, 17 Mar 2020 00:26:12 +1000
Message-Id: <20200316142613.121089-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200316142613.121089-1-npiggin@gmail.com>
References: <20200316142613.121089-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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

PAPR requires that if "ibm,nmi-register" succeeds, then the hypervisor
delivers all system reset and machine check exceptions to the registered
addresses.

System Resets are delivered with registers set to the architected state,
and with no interlock.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 25221d843c..78e649f47d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -967,7 +967,29 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
     _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
                      maxdomains, sizeof(maxdomains)));
 
-    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size", RTAS_SIZE));
+    /*
+     * FWNMI reserves RTAS_ERROR_LOG_MAX for the machine check error log,
+     * and 16 bytes per CPU for system reset error log plus an extra 8 bytes.
+     *
+     * The system reset requirements are driven by existing Linux and PowerVM
+     * implementation which (contrary to PAPR) saves r3 in the error log
+     * structure like machine check, so Linux expects to find the saved r3
+     * value at the address in r3 upon FWNMI-enabled sreset interrupt (and
+     * does not look at the error value).
+     *
+     * System reset interrupts are not subject to interlock like machine
+     * check, so this memory area could be corrupted if the sreset is
+     * interrupted by a machine check (or vice versa) if it was shared. To
+     * prevent this, system reset uses per-CPU areas for the sreset save
+     * area. A system reset that interrupts a system reset handler could
+     * still overwrite this area, but Linux doesn't try to recover in that
+     * case anyway.
+     *
+     * The extra 8 bytes is required because Linux's FWNMI error log check
+     * is off-by-one.
+     */
+    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size", RTAS_ERROR_LOG_MAX +
+			  ms->smp.max_cpus * sizeof(uint64_t)*2 + sizeof(uint64_t)));
     _FDT(fdt_setprop_cell(fdt, rtas, "rtas-error-log-max",
                           RTAS_ERROR_LOG_MAX));
     _FDT(fdt_setprop_cell(fdt, rtas, "rtas-event-scan-rate",
@@ -3399,8 +3421,28 @@ static void spapr_machine_finalizefn(Object *obj)
 
 void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg)
 {
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+
     cpu_synchronize_state(cs);
-    ppc_cpu_do_system_reset(cs, -1);
+    /* If FWNMI is inactive, addr will be -1, which will deliver to 0x100 */
+    if (spapr->fwnmi_system_reset_addr != -1) {
+        uint64_t rtas_addr, addr;
+        PowerPCCPU *cpu = POWERPC_CPU(cs);
+        CPUPPCState *env = &cpu->env;
+
+        /* get rtas addr from fdt */
+        rtas_addr = spapr_get_rtas_addr();
+        if (!rtas_addr) {
+            qemu_system_guest_panicked(NULL);
+            return;
+        }
+
+        addr = rtas_addr + RTAS_ERROR_LOG_MAX + cs->cpu_index * sizeof(uint64_t)*2;
+        stq_be_phys(&address_space_memory, addr, env->gpr[3]);
+        stq_be_phys(&address_space_memory, addr + sizeof(uint64_t), 0);
+        env->gpr[3] = addr;
+    }
+    ppc_cpu_do_system_reset(cs, spapr->fwnmi_system_reset_addr);
 }
 
 static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
-- 
2.23.0


