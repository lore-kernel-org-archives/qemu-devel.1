Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC8FC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 04:57:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D99E020684
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 04:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sI00WmPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99E020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59362 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGG9S-0003e8-Rv
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 00:56:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hGG8d-0003HX-HN
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 00:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hGG8c-0006IO-F4
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 00:56:07 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <npiggin@gmail.com>)
	id 1hGG8a-0006HG-29; Tue, 16 Apr 2019 00:56:04 -0400
Received: by mail-pl1-x642.google.com with SMTP id w23so9696839ply.4;
	Mon, 15 Apr 2019 21:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=LMMn1/3yoW4kcpAOUmvJsGSodCeWg/DkFUqZPl9PJHI=;
	b=sI00WmPAY+bgQFfE5Kr+QVwcuMjlgCg1LwntdHMjHUJRUmKWY8Ds5UFoU2lpsRgc40
	GMGZer+URf01N+jmJN2J1jbVEwT1hLyNZc6J9cKWaJIgiDFsP8iL6WbGpBzvRPJjQTrC
	gQ8NTj9/C2PFNXYvpe5tyKL05IXBj0sSx8VGEqwSsChDjZq921V2IZ529aK+ESBWwOtw
	bcOtUXfZTwo73u6FH/i9hRId5suEvfPhxt00tIQ296+InFb9CrXPY3Q7C+VDlxcoxmyI
	vkj8dguvpr7XQSlyg7EqkR0aSW1H3DRAYWzfSfd0QM0QVYt+TECtCdUR4XiLzLwx6Idj
	Qoww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=LMMn1/3yoW4kcpAOUmvJsGSodCeWg/DkFUqZPl9PJHI=;
	b=jzbvToCGFMH+6nHoOhmxMwoLXxOnvHC45EEbPa7QcTirP5+Q9kuk9dS/+V4YTwMOR4
	GZnD0EzCoSWU+y96Ml7Uif/n/ozfeQXwPdbUlytMSYaK8BdxmklPa40VtzILek1afFxy
	iFEVR8Zq7a4Hxxz1EhZnjylB39hVq4uRY7iAY40Y3u5ouV8vm0kPZdoe7i+XCv0e+AwN
	1/k8bLhVbUh6CS/VJRjj48Gxmby1hbl6GQbXAsHSEt0CZfqAYMolN/7YvRexyHq5XNMp
	us5Aojj/DXP1CE9rW3h3udi9wr8qy++p+/iYQbauKZ79wkxSHnZ1vwA5vSlsVHetUcaz
	cweA==
X-Gm-Message-State: APjAAAWlMbbjYbXMIL3VwMlMCfrihlib6jZ566Msf5N3stx1/LTsQckX
	jP7EAV1x5MRNx+TIw2KIX5c=
X-Google-Smtp-Source: APXvYqyEMx6WqHoRWNdUf/raCkPPTn2rw9w4m/QCn8dZNWOxs1tgvoZJqTuTOMCNTMwWCfkzhKrsiw==
X-Received: by 2002:a17:902:e704:: with SMTP id
	co4mr39271996plb.30.1555390563111; 
	Mon, 15 Apr 2019 21:56:03 -0700 (PDT)
Received: from bobo.local0.net (61-68-62-84.tpgi.com.au. [61.68.62.84])
	by smtp.gmail.com with ESMTPSA id
	v82sm114487487pfa.170.2019.04.15.21.55.59
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 15 Apr 2019 21:56:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 16 Apr 2019 14:55:52 +1000
Message-Id: <20190416045552.24573-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v3] spapr: add splpar hcalls H_PROD, H_CONFER
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
Message-ID: <20190416045552.6Iwclxcswh0U88_YEKfKSx5sowzp9unY85pQn4sTN1o@z>

These implementations have a few deficiencies that are noted, but are
good enough for Linux to use.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

v3: Removed wrong comment about GPR3, drop H_JOIN for now (at least until
it is tested some more in Linux/KVM), and expand the comment about not
prod bit.

 hw/ppc/spapr_hcall.c | 71 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8a736797b9..8892ad008b 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1065,6 +1065,74 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_SUCCESS;
 }
 
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
+     * PAPR calls for waiting until proded in this case (or presumably
+     * an external interrupt if MSR[EE]=1, without dispatch sequence count
+     * check.
+     */
+    if (cpu == spapr_find_cpu(target)) {
+        cs->halted = 1;
+        cs->exception_index = EXCP_HALTED;
+        cs->exit_request = 1;
+
+        return H_SUCCESS;
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
+static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    target_long target = args[0];
+    CPUState *cs;
+
+    /*
+     * PAPR specifies there should be a prod flag should be associated with
+     * a vCPU, which gets set here, tested by H_CEDE, and cleared any time
+     * the vCPU is dispatched, including via preemption.
+     *
+     * We don't implement this because it is not used by Linux. The bit would
+     * be difficult or impossible to use properly because preemption can not
+     * be prevented so dispatch sequence count would have to somehow be used
+     * to detect it.
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
@@ -1860,6 +1928,9 @@ static void hypercall_register_types(void)
     /* hcall-splpar */
     spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
     spapr_register_hypercall(H_CEDE, h_cede);
+    spapr_register_hypercall(H_CONFER, h_confer);
+    spapr_register_hypercall(H_PROD, h_prod);
+
     spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
 
     /* processor register resource access h-calls */
-- 
2.20.1


