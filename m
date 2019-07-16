Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C980EC76191
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 02:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BB6320880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 02:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kkg+t5l/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB6320880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnDWW-0006pe-GU
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 22:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44321)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hnDVU-0002TK-Hh
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 22:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hnDVT-0004Wi-B3
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 22:47:56 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44995)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hnDVR-0004UY-3W; Mon, 15 Jul 2019 22:47:53 -0400
Received: by mail-pl1-x642.google.com with SMTP id t14so9271263plr.11;
 Mon, 15 Jul 2019 19:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MdtW8CuvYdkhDUoUgf1LxOsNkRLOuv7x20g9x/4mLVg=;
 b=Kkg+t5l/JSXrrd4G1WmWSklPmahpG1n7pTy+67V3HxNO4JdsLoO3JTicKcReljIakV
 Lqn8sXxaMV/eZieMNc8bTaUKNwEvfeKEOhPprKpAsl+YmikKWLA6mb9V89kCRfihl7oq
 KhVnQqhNnGiSSA0wZYJsFZt/fh4Cf+GJD8vye8ewU9gjlUl8ZZ/+QTzqPGQZO8v7cX/V
 fJ8MXZQWPthRg9jq3R8OIwazaR7ttYearCcjeVbxr5KoRFey2SadWPP9O4P+eyCh9yxy
 pFr8c8PyT4EIDb0eqd5jQlH8O6q4l3kYjfxmgD8wtdML8pGvFxeXLio+PHv2l3soAlod
 xIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MdtW8CuvYdkhDUoUgf1LxOsNkRLOuv7x20g9x/4mLVg=;
 b=YXcf6ndYMiciuc679tmqe11VuuZJPzx51A8NP9e1NyVLVRN10iQCQ6s16RJXSl0/JW
 VZ3jXU0J0spgWC5zLSEfMNLEvRayWMOBae0ygtL7xwf/tspTgT9UfdRBRvLcme83D0Op
 CO5jX32zG4PHwL7n9RoTeW2MTbrRaD/OLIhW8DkueBxEAZ1nHPWtyuK7/zyCoA4AmoT8
 pY+fD4L7kBCWS76ygopEU6NqlaT7ivnhXqGp0e/1XuEZ+tWSWEXuNqwnNarboNiMDGH3
 i8EFi2vTFIISny2I5MBIrBk4hrRSNXAKS7bWSUveTEtP4h3698fePlvG2L0VjK3+ec6K
 PQEw==
X-Gm-Message-State: APjAAAVc4axexW5vhgVZY853xnJcfA+zcjp+5ZuhpkfxbRGWQK92Cj/S
 kvNGJLQcZu2ve4SHoiysNq8=
X-Google-Smtp-Source: APXvYqyDkuMUoZflY9Z/M2w/Bx0ALzYnQwOJ0Uv8KYdzrJXchaqWjKZnQEb2FnXtMvBcLv/s9FeslQ==
X-Received: by 2002:a17:902:7c05:: with SMTP id
 x5mr32390317pll.321.1563245271705; 
 Mon, 15 Jul 2019 19:47:51 -0700 (PDT)
Received: from bobo.local0.net ([203.220.8.141])
 by smtp.gmail.com with ESMTPSA id x8sm16557837pfa.46.2019.07.15.19.47.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 19:47:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 16 Jul 2019 12:47:24 +1000
Message-Id: <20190716024726.17864-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190716024726.17864-1-npiggin@gmail.com>
References: <20190716024726.17864-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v4 3/5] spapr: Implement H_CONFER
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

This does not do directed yielding and is not quite as strict as PAPR
specifies in terms of precise dispatch behaviour. This generally will
mean suboptimal performance, rather than guest misbehaviour. Linux
does not rely on exact dispatch behaviour.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_hcall.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8b208ab259..28d58113be 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1069,6 +1069,53 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_SUCCESS;
 }
 
+static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    target_long target = args[0];
+    uint32_t dispatch = args[1];
+    PowerPCCPU *target_cpu = spapr_find_cpu(target);
+    CPUState *target_cs = CPU(target_cpu);
+    CPUState *cs = CPU(cpu);
+    SpaprCpuState *spapr_cpu;
+
+    /*
+     * This does not do a targeted yield or confer, but check the parameter
+     * anyway. -1 means confer to all/any other CPUs.
+     */
+    if (target != -1 && !target_cs) {
+        return H_PARAMETER;
+    }
+
+    spapr_cpu = spapr_cpu_state(target_cpu);
+
+    /*
+     * PAPR specifies waiting until proded in this case, without dispatch
+     * counter check.
+     */
+    if (cpu == target_cpu) {
+        if (spapr_cpu->prod) {
+            spapr_cpu->prod = false;
+            return H_SUCCESS;
+        }
+
+        cs->halted = 1;
+        cs->exception_index = EXCP_HALTED;
+        cs->exit_request = 1;
+
+        return H_SUCCESS;
+    }
+
+    if (spapr_cpu->dispatch_counter != dispatch || (dispatch & 1) == 0) {
+        return H_SUCCESS;
+    }
+
+    cs->exception_index = EXCP_YIELD;
+    cpu_loop_exit(cs);
+
+    return H_SUCCESS;
+}
+
 static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
@@ -1909,6 +1956,7 @@ static void hypercall_register_types(void)
     /* hcall-splpar */
     spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
     spapr_register_hypercall(H_CEDE, h_cede);
+    spapr_register_hypercall(H_CONFER, h_confer);
     spapr_register_hypercall(H_PROD, h_prod);
 
     spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
-- 
2.20.1


