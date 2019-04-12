Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77E6C282CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 09:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEC99205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 09:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUrcz/2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC99205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33200 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEscU-00021g-KB
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 05:37:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hEsbh-0001dO-Cb
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 05:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hEsbg-0000eH-BC
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 05:36:25 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <npiggin@gmail.com>)
	id 1hEsbd-0000cP-P5; Fri, 12 Apr 2019 05:36:22 -0400
Received: by mail-pl1-x643.google.com with SMTP id bf11so4829741plb.12;
	Fri, 12 Apr 2019 02:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=e5Tq4xBFTNf7HAzlzjkJuHh48zYZ31dRiWs9tfjeC14=;
	b=TUrcz/2J9NXRd8uFGOi21qS5BO7tVG6Pd7LPXjyUe7WBAr8ABQpbf46zH9K7Xs6CtO
	xUe7HdxUZ2lZpDuX6YH7tC4Fld4aRt8p8eUdh+1dAchUowB1XKa7fXCudBHWboUY0HtR
	8JXKuCoMwFkASmjiIEZoBEp/TSMheceAiX+QUmlMRorR49Tyn0nm9sxZYlZl6FJzMKnV
	5ewdLwFJNynykh5J7vHJY8oq803Fnr/ZvAWz010E73lPTwv7R5crxtUutN6oX5Bjez/X
	mR+GvKX7gEVs0Ys6kx8Diipylp1BNOyMpryJBQ6KsbE1Ze4qYynfI57wWDkAIKHzvqLH
	nj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=e5Tq4xBFTNf7HAzlzjkJuHh48zYZ31dRiWs9tfjeC14=;
	b=bhDgCeqRF/Wr16KXXxTbZFwlzHnvtdoUfoUMtn4r2B6yV0zzDIk8s/H9zNrCSeQuY4
	mDrTMS5Tu+JuJYvMjrvB0v4X4uzGC8Xog+7mhs8di/6Su+TrE6xWkz63Tyro/r6kD6cf
	6W0nj5qDAtE8tLkZPGwa7eC7fWqibh6gxB92ouHDLOZ2/1qTLcNLJkK0OYOsszoxsb4v
	1OqHG2AYuyeQL1Aq7I8dFs5EZRTdcd1wiy2NwbcnxUlCcH+MgNb3DXVCxfE23HW2tYbO
	0UcGKjo+6ZXs12Wo2Pd73Z/uVMpsezerpGHkJaw6rnog9dM0Ry53vUqKiliqmXR3QOn8
	umWA==
X-Gm-Message-State: APjAAAW5mrktMm5cWgDPsziUMOj8Cjj7fsTaG9z6XaXCX9lcHgNdI87k
	SyrdeIasPY8RBqHc0WUCQKY=
X-Google-Smtp-Source: APXvYqxB+YxDJY9y6eAJJQKMVlrtV+K1NLXHP0DiEy6Fa9yNSPee9g5/mrKNCVuqIh1Cuu5CpvrKOQ==
X-Received: by 2002:a17:902:7e05:: with SMTP id
	b5mr56626496plm.127.1555061780333; 
	Fri, 12 Apr 2019 02:36:20 -0700 (PDT)
Received: from bobo.local0.net (115-64-237-195.tpgi.com.au. [115.64.237.195])
	by smtp.gmail.com with ESMTPSA id
	n82sm68564122pfi.63.2019.04.12.02.36.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 02:36:19 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 12 Apr 2019 19:36:03 +1000
Message-Id: <20190412093603.18232-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v2] spapr: add splpar hcalls H_JOIN, H_PROD,
 H_CONFER
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	Nicholas Piggin <npiggin@gmail.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412093603.kGocNhQbgS4Lu8upJ2EwdbcOfbYHq8ktNeDTuUIB1qU@z>

These implementations have a few deficiencies that are noted, but are
good enough for Linux to use.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

Cleaned up checkpatch warnings, sorry I didn't realise that exists.

 hw/ppc/spapr_hcall.c | 88 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8a736797b9..e985bb694d 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1065,6 +1065,90 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_SUCCESS;
 }
 
+static target_ulong h_join(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    CPUPPCState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+
+    if (env->msr & (1ULL << MSR_EE)) {
+        return H_BAD_MODE;
+    }
+
+    /*
+     * This should check for single-threaded mode. In practice, Linux
+     * does not try to H_JOIN all CPUs.
+     */
+
+    cs->halted = 1;
+    cs->exception_index = EXCP_HALTED;
+    cs->exit_request = 1;
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    target_long target = args[0];
+    CPUState *cs = CPU(cpu);
+
+    /*
+     * This does not do a targeted yield or confer, but check the parameter
+     * anyway. -1 means confer to all/any other CPUs.
+     */
+    if (target != -1 && !CPU(spapr_find_cpu(target))) {
+        return H_PARAMETER;
+    }
+
+    /*
+     * H_CONFER with target == this is not exactly the same as H_JOIN
+     * according to PAPR (e.g., MSR[EE] check and single threaded check
+     * is not done in this case), but unlikely to matter.
+     */
+    if (cpu == spapr_find_cpu(target)) {
+        return h_join(cpu, spapr, opcode, args);
+    }
+
+    /*
+     * This does not implement the dispatch sequence check that PAPR calls for,
+     * but PAPR also specifies a stronger implementation where the target must
+     * be run (or EE, or H_PROD) before H_CONFER returns. Without such a hard
+     * scheduling requirement implemented, there is no correctness reason to
+     * implement the dispatch sequence check.
+     */
+    cs->exception_index = EXCP_YIELD;
+    cpu_loop_exit(cs);
+
+    return H_SUCCESS;
+}
+
+/*
+ * H_PROD and H_CONFER are specified to only modify GPR r3, which is not
+ * achievable running under KVM, although KVM already implements H_CONFER
+ * this way.
+ */
+static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    target_long target = args[0];
+    CPUState *cs;
+
+    /*
+     * Should set the prod flag in the VPA.
+     */
+
+    cs = CPU(spapr_find_cpu(target));
+    if (!cs) {
+        return H_PARAMETER;
+    }
+
+    cs->halted = 0;
+    qemu_cpu_kick(cs);
+
+    return H_SUCCESS;
+}
+
 static target_ulong h_rtas(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
@@ -1860,6 +1944,10 @@ static void hypercall_register_types(void)
     /* hcall-splpar */
     spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
     spapr_register_hypercall(H_CEDE, h_cede);
+    spapr_register_hypercall(H_CONFER, h_confer);
+    spapr_register_hypercall(H_JOIN, h_join);
+    spapr_register_hypercall(H_PROD, h_prod);
+
     spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
 
     /* processor register resource access h-calls */
-- 
2.20.1


