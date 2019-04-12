Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E974C10F14
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 03:29:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37DF20675
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 03:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lr9ZsGlc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37DF20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58226 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEmsQ-0003ef-Vv
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 23:29:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hEmrZ-0003HF-S1
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 23:28:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hEmrY-0007Lh-QY
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 23:28:25 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:46882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <npiggin@gmail.com>)
	id 1hEmrY-0007Jj-Gz; Thu, 11 Apr 2019 23:28:24 -0400
Received: by mail-pg1-x536.google.com with SMTP id q1so4469393pgv.13;
	Thu, 11 Apr 2019 20:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:subject:to:cc:references:in-reply-to:mime-version
	:user-agent:message-id:content-transfer-encoding;
	bh=YLajjg+6GUjuRMR1keV/z9YJDqGaMpmPfFUuvkiNM2Q=;
	b=lr9ZsGlcBDyeLx0dJNxj4A7rzlmKWSRGn7ty0aBoO+KdA2nqeVVqcSaFIPa0NBaczP
	vKcBbTpNcA+L0XCc5pfXxqEF244QCcZsqhDy6OAUY6rapyMKACLTQnvvTqKQlgA04eQc
	9SwaJ4h1r0eKYi4mwxGjH9g7FpRAOIXGRU+TqxR6VPmg2Mw9NdKGWu90CdZkg/DLfstD
	fkIwgApzIYXmXnBB0cJ1ahiRwzgdTLN42gTE6fDIr6QVmLtFWIE7xC2Z4TtMxIwhGHF9
	3Cv7VzIl1xOiQdizHflTJGFLjERMM3KiZ0oijCoHuJi1GGDoVpNy61trXVDNRZXpzK8p
	1VeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
	:mime-version:user-agent:message-id:content-transfer-encoding;
	bh=YLajjg+6GUjuRMR1keV/z9YJDqGaMpmPfFUuvkiNM2Q=;
	b=Zl5pNO8qB+OcimDckVys8PQ4W78FOXVIsLYFFR25uxVithW+M49pBJORGBDlsUn6vB
	qXeWLnFqZ+SpGK06XMg9Kt/gSwrTG6hx3XPyUKCUmhofqjvy6ElMSus014sMIcyo5e2V
	6o7N7lh1YRA+Js0KzxSZ4ZvKDPNnHJW7zRyfdQFqiJMsHkBxCDx+6BstNCHHMGFpKXoK
	71QJ0SKsuw0krMeXYGcSP3foZPH8JRQnnh4x+2yi5ar9LCxy4lR6WfZvECpAl2uy1oT7
	/RMHatKJx6Kv3N7Cxb36rb+49bEnk7HncUYnBOqLpDtJLKeFMrL3LAv/Pql3i9Vuh8mY
	bi/g==
X-Gm-Message-State: APjAAAWMpYF3UeP3JgkpKE4JSSVohLE33jcnwrldeyd4QLBMW/ojiumA
	qWksQUxdb63zp9dc3hLT6ds=
X-Google-Smtp-Source: APXvYqyVHuPO8oUl/QNuPvX8tTf32xGtrAceY30cISAC/ohwAkaaTOx3BEqmU4O9/93IkWc+5Ad1pw==
X-Received: by 2002:a62:1197:: with SMTP id 23mr54827011pfr.210.1555039702602; 
	Thu, 11 Apr 2019 20:28:22 -0700 (PDT)
Received: from localhost (115-64-237-195.tpgi.com.au. [115.64.237.195])
	by smtp.gmail.com with ESMTPSA id
	a129sm87743389pfa.152.2019.04.11.20.28.21
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 11 Apr 2019 20:28:21 -0700 (PDT)
Date: Fri, 12 Apr 2019 13:28:16 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson
	<david@gibson.dropbear.id.au>
References: <20190411063408.3998-1-clg@kaod.org>
In-Reply-To: <20190411063408.3998-1-clg@kaod.org>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1555039552.i5y8oxfv9m.astroid@bobo.none>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::536
Subject: Re: [Qemu-devel] [PATCH] ppc/spapr: Add H_PROD and H_CONFER
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412032816.SgCs_LEu3AtFwBfyNr1hemNjcKTT5uL7wRDb0JTCvJY@z>

C=C3=A9dric Le Goater's on April 11, 2019 4:34 pm:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> H_PROD should be fully functional, H_CEDE is modified to
> ignore a proded CPU. H_CONFER is a stub to avoid returning
> an error.

Huh, I just implemented these a couple of days ago to test pseries
suspend, also H_JOIN.

---
 hw/ppc/spapr_hcall.c | 79 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8a736797b9..47ee933333 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1065,6 +1065,81 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMac=
hineState *spapr,
     return H_SUCCESS;
 }
=20
+static target_ulong h_join(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    CPUPPCState *env =3D &cpu->env;
+    CPUState *cs =3D CPU(cpu);
+
+    if (env->msr & (1ULL << MSR_EE))
+        return H_BAD_MODE;
+
+    /*
+     * This should check for single-threaded mode. In practice, Linux
+     * does not try to H_JOIN all CPUs.
+     */
+
+    cs->halted =3D 1;
+    cs->exception_index =3D EXCP_HALTED;
+    cs->exit_request =3D 1;
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    target_long target =3D args[0];
+    CPUState *cs =3D CPU(cpu);
+
+    /*
+     * This does not do a targeted yield, but check the parameter anyway.
+     */
+    if (target !=3D -1 && !CPU(spapr_find_cpu(target)))
+        return H_PARAMETER;
+
+    /*
+     * H_CONFER with target =3D=3D this is not exactly the same as H_JOIN
+     * according to PAPR (e.g., MSR[EE] check and single threaded check
+     * is not done in this case), but unlikely to matter.
+     */
+    if (cpu =3D=3D spapr_find_cpu(target))
+        return h_join(cpu, spapr, opcode, args);
+
+    /*
+     * This does not implement the dispatch sequence check.
+     */
+    cs->exception_index =3D EXCP_YIELD;
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
+    target_long target =3D args[0];
+    CPUState *cs;
+
+    /*
+     * Should set the prod flag in the VPA.
+     */
+
+    cs =3D CPU(spapr_find_cpu(target));
+    if (!cs)
+        return H_PARAMETER;
+
+    cs->halted =3D 0;
+    qemu_cpu_kick(cs);
+
+    return H_SUCCESS;
+}
+
 static target_ulong h_rtas(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
@@ -1860,6 +1935,10 @@ static void hypercall_register_types(void)
     /* hcall-splpar */
     spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
     spapr_register_hypercall(H_CEDE, h_cede);
+    spapr_register_hypercall(H_CONFER, h_confer);
+    spapr_register_hypercall(H_JOIN, h_join);
+    spapr_register_hypercall(H_PROD, h_prod);
+
     spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
=20
     /* processor register resource access h-calls */
--=20
2.20.1

=

