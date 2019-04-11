Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEEAC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 06:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF5092133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 06:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5092133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42590 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hETJ2-0001FH-V7
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 02:35:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hETI5-0000mL-Qz
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 02:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hETI4-0003iG-MM
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 02:34:29 -0400
Received: from 4.mo1.mail-out.ovh.net ([46.105.76.26]:46678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hETI4-0003Xj-FE
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 02:34:28 -0400
Received: from player746.ha.ovh.net (unknown [10.109.159.35])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id CBB6E167D15
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 08:34:18 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-40-22.w86-201.abo.wanadoo.fr
	[86.201.133.22]) (Authenticated sender: clg@kaod.org)
	by player746.ha.ovh.net (Postfix) with ESMTPSA id 773AE4BDCF46;
	Thu, 11 Apr 2019 06:34:12 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 11 Apr 2019 08:34:08 +0200
Message-Id: <20190411063408.3998-1-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Ovh-Tracer-Id: 16134708617910062054
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudekgddutdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.76.26
Subject: [Qemu-devel] [PATCH] ppc/spapr: Add H_PROD and H_CONFER
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
Message-ID: <20190411063408.wbLPHy8M4EbwrczXSLkNhARclwc80AHpjguSWqJk6lo@z>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

H_PROD should be fully functional, H_CEDE is modified to
ignore a proded CPU. H_CONFER is a stub to avoid returning
an error.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/cpu.h     |  3 +++
 hw/ppc/spapr_hcall.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 42eadc4b7997..07cea7268c0c 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1141,6 +1141,9 @@ struct CPUPPCState {
      * sreset), so flag this here.
      */
     bool resume_as_sreset;
+
+    /* Used by SPAPR for H_CEDE/H_PROD */
+    bool prodded;
 #endif
=20
     /* Those resources are used only during code translation */
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8a736797b9bf..be8044a92f2f 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1057,6 +1057,11 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprM=
achineState *spapr,
=20
     env->msr |=3D (1ULL << MSR_EE);
     hreg_compute_hflags(env);
+    if (env->prodded) {
+        env->prodded =3D false;
+        return H_SUCCESS;
+    }
+
     if (!cpu_has_work(cs)) {
         cs->halted =3D 1;
         cs->exception_index =3D EXCP_HLT;
@@ -1065,6 +1070,36 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprM=
achineState *spapr,
     return H_SUCCESS;
 }
=20
+static void spapr_do_wakeup_on_cpu(CPUState *cs, run_on_cpu_data data)
+{
+    cs->halted =3D 0;
+    cs->exception_index =3D -1;
+}
+
+static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    target_ulong target =3D args[0];
+    CPUPPCState *env;
+
+    cpu =3D spapr_find_cpu(target);
+    if (cpu) {
+        env =3D &cpu->env;
+        env->prodded =3D true;
+        run_on_cpu(CPU(cpu), spapr_do_wakeup_on_cpu, RUN_ON_CPU_NULL);
+    } else {
+        return H_PARAMETER;
+    }
+    return H_SUCCESS;
+}
+
+static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                             target_ulong opcode, target_ulong *args)
+{
+    /* Do nothing (supposed to confer timeslice). */
+    return H_SUCCESS;
+}
+
 static target_ulong h_rtas(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
@@ -1860,6 +1895,8 @@ static void hypercall_register_types(void)
     /* hcall-splpar */
     spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
     spapr_register_hypercall(H_CEDE, h_cede);
+    spapr_register_hypercall(H_PROD, h_prod);
+    spapr_register_hypercall(H_CONFER, h_confer);
     spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
=20
     /* processor register resource access h-calls */
--=20
2.20.1


