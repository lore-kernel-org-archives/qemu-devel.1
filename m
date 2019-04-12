Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EABEC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 05:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E0D20818
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 05:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxlKKcDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E0D20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59311 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEoy8-0001g8-8E
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 01:43:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hEoxJ-0001Jb-7b
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 01:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hEoxI-0008S1-47
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 01:42:29 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:34534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <npiggin@gmail.com>)
	id 1hEoxF-00083X-AS; Fri, 12 Apr 2019 01:42:25 -0400
Received: by mail-pg1-x533.google.com with SMTP id v12so4649332pgq.1;
	Thu, 11 Apr 2019 22:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=vJm4r0hEPk2pdOBu4EwWQ8tV2fCXs9DtfzB9HdAk1oY=;
	b=SxlKKcDDnaoRDXpeXMrw755eD1jOlW7wzSyL6CBxd9JpUnmJcuxCaotnU4XB+sDcLh
	WwrwbK4FCGjHoGwiKcVo/bOmAQQ6HPDyliKKQMXLYd7Z13rTpU67IA/FISFSBktNML59
	Xg+ZTgZ4lkfFQrHxBjAV0ak9mJ4sB94x8IECbMuRuRKcWkopLGZ1URmKs6ndZb3R2Uq6
	KuB+KJdm5BBc7F+UcuPrB9spSyI72p57dxkDuNQlcdaGlNAdqAqjL256gmEKiqPVM4Vk
	UvbvdyHDxUYGk7eqyOJKcLjEGRI3bvipGHTuEoehUgvluYxCZ5pNW3bG8VD4DFHLdycY
	wC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=vJm4r0hEPk2pdOBu4EwWQ8tV2fCXs9DtfzB9HdAk1oY=;
	b=sqZtK9JYzVc56uWKL4W0Nrum4ES9TQZgBqtVVUHHqCU2iyXe699a0iMTwwb2rnABDu
	OtjLlLazJ1ZMBLvcRHpd7Ovs0AZV2qNVlvQcKcUUebyn64lAdqKsKhrFBo5133EJkB6L
	b/A1qMC5LbIRZJUqNQUTy1ALm13UGYrH7lTfw79h4lTM/Ucftl7x1S84LCZxaOC4hSgq
	ArKhhpReXLrBW25NCjXJ7w+uqJLKO1kx75dY48b+4Xa5UcRKa15Zw2rYV4fnuyRQiiI3
	uKrtoXi7fWksSct6ovHZCkwuJEHvqEIW4mYZodHfdhivoT0RZBii8Lcu+i0ptJu02XS9
	vHVg==
X-Gm-Message-State: APjAAAXf6S4o3vrw7ulA9FcWrZRQqeKj7iA0PAjb/d0gNmx68VJIOksh
	cmk5fLrujoWymxdd/SBwOcw=
X-Google-Smtp-Source: APXvYqyrEZg0YH1En+sjmejnNgFpBondU4SyyTue2dT+Up8Dp3lyJpvwvlTsUbJE+jzPRIF0kjVK+Q==
X-Received: by 2002:aa7:8719:: with SMTP id b25mr54387685pfo.90.1555047743944; 
	Thu, 11 Apr 2019 22:42:23 -0700 (PDT)
Received: from bobo.local0.net (115-64-237-195.tpgi.com.au. [115.64.237.195])
	by smtp.gmail.com with ESMTPSA id
	n21sm64237682pfb.42.2019.04.11.22.42.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 22:42:23 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 12 Apr 2019 15:42:13 +1000
Message-Id: <20190412054214.707-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::533
Subject: [Qemu-devel] [PATCH] spapr: add splpar hcalls H_JOIN, H_PROD,
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
Message-ID: <20190412054213.HNjRdHxcekRENvnfiyX1AcHTTKPKrfQllTUOzfEEQhU@z>

These implementations have a few deficiencies that are noted, but are
good enough for Linux to use.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

---
This has been tested with TCG with some Linux hacks to use H_JOIN/H_PROD
for suspend and CPU unplug (plus an implementation of ibm,suspend-me to
do the suspend). Not sure if KVM might need some more work to support
H_JOIN properly, but right now Linux only uses it on PowerVM.


 hw/ppc/spapr_hcall.c | 84 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8a736797b9..6829cadcd3 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1065,6 +1065,86 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_SUCCESS;
 }
 
+static target_ulong h_join(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    CPUPPCState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+
+    if (env->msr & (1ULL << MSR_EE))
+        return H_BAD_MODE;
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
+    if (target != -1 && !CPU(spapr_find_cpu(target)))
+        return H_PARAMETER;
+
+    /*
+     * H_CONFER with target == this is not exactly the same as H_JOIN
+     * according to PAPR (e.g., MSR[EE] check and single threaded check
+     * is not done in this case), but unlikely to matter.
+     */
+    if (cpu == spapr_find_cpu(target))
+        return h_join(cpu, spapr, opcode, args);
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
+     * This does not maintain a prod flag for the vCPU that PAPR asks for.
+     */
+
+    cs = CPU(spapr_find_cpu(target));
+    if (!cs)
+        return H_PARAMETER;
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
@@ -1860,6 +1940,10 @@ static void hypercall_register_types(void)
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


