Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5775C76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 05:41:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B28202173E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 05:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdXjsO5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28202173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hncgh-0005h9-0m
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 01:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50113)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hncfq-00021B-2p
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 01:40:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hncfp-0005GQ-05
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 01:40:17 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38936)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hncfl-0005Bf-Rg; Wed, 17 Jul 2019 01:40:13 -0400
Received: by mail-pf1-x444.google.com with SMTP id f17so6266297pfn.6;
 Tue, 16 Jul 2019 22:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aspJFmRkiuGl98ZZpfTk4UAxRVGqt3PVQT6yVoIbn6Q=;
 b=FdXjsO5mRmokaFRmbwR/DaaQqePC8CSAjMzr9fCK1JTZS5QUBEbVgTP1qCEHlVoQhb
 en/nb6cw3bYR2G6ixAkmHLyNZdhhq5MIHpyHfcebIM8CbNM8PyMrusztOfpxhH7ZfFJd
 EkG+Iia1TuaxC4F0R3E5p+QfubJSOz/fgvL36/svz4hAIFxyXL1L8/sjJWdKTp3acari
 uwFVo1X2ZyoMxWsThoJEvVciVP94/bK/2GZD9ktrgeN1ggFKMFffv+7+v+h/ebZSkjwb
 7c9BX4Ji0euILO37F+EA+9IZYdBr82la4XcHMy4ndexh0LfFKbxm23WLXRahrB4IKSd8
 X4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aspJFmRkiuGl98ZZpfTk4UAxRVGqt3PVQT6yVoIbn6Q=;
 b=PmaQuFQsw3NyHcE5ircPM1OipIQOu70DkdciNRRiuVOvsIB/DJABAD8FnyGDfSMRW4
 wVtiPq2ugD9vEonb8dg6zKIirCrNrTb4pKELYdReCVaNl6YnbY0+6nhWJiAqIgK+fi3d
 Bhv+AbR3+wbLDJ1Mz3UOsJSdujKUDQizLPvVEM9eJmgkcshM68AySF+biNC49+1fmHBC
 dkbDzJHirSYjX9+1Fz7712NFO0EzFDK9GMjfcQs7zfWD6a3yFJ4zXmp4IIp0lotkr3ZO
 PTIQdmnQ6Oox2atJ8zbGD4FCEtGDIzzg6Fnbzd1UtojNaQETKIe10AFJUsPHuVPFS7AK
 gIqg==
X-Gm-Message-State: APjAAAUlUN+Zs+IilIVMBrmNV+ctMvrqF7JUPXos3dmUuxnULpHlYkT+
 lNXHBvzDGPj2ufRhX+o9cks=
X-Google-Smtp-Source: APXvYqyRqAdRjQuTCq0nXyBslfjQ3C2ahv49npfxSv4hCG6uRpz6iBO9AICbO2M4gc+jJ+7lNGIN4w==
X-Received: by 2002:a63:9e43:: with SMTP id r3mr13698802pgo.148.1563342013018; 
 Tue, 16 Jul 2019 22:40:13 -0700 (PDT)
Received: from bobo.local0.net ([203.220.8.141])
 by smtp.gmail.com with ESMTPSA id g18sm39322656pgm.9.2019.07.16.22.40.09
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 16 Jul 2019 22:40:12 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 17 Jul 2019 15:39:50 +1000
Message-Id: <20190717053952.13729-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717053952.13729-1-npiggin@gmail.com>
References: <20190717053952.13729-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v5 2/4] spapr: Implement H_PROD
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

H_PROD is added, and H_CEDE is modified to test the prod bit
according to PAPR.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_hcall.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index e615881ac4..8b208ab259 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1050,14 +1050,41 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
 {
     CPUPPCState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
+    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
 
     env->msr |= (1ULL << MSR_EE);
     hreg_compute_hflags(env);
+
+    if (spapr_cpu->prod) {
+        spapr_cpu->prod = false;
+        return H_SUCCESS;
+    }
+
     if (!cpu_has_work(cs)) {
         cs->halted = 1;
         cs->exception_index = EXCP_HLT;
         cs->exit_request = 1;
     }
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    target_long target = args[0];
+    CPUState *cs;
+    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
+
+    cs = CPU(spapr_find_cpu(target));
+    if (!cs) {
+        return H_PARAMETER;
+    }
+
+    spapr_cpu->prod = true;
+    cs->halted = 0;
+    qemu_cpu_kick(cs);
+
     return H_SUCCESS;
 }
 
@@ -1882,6 +1909,8 @@ static void hypercall_register_types(void)
     /* hcall-splpar */
     spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
     spapr_register_hypercall(H_CEDE, h_cede);
+    spapr_register_hypercall(H_PROD, h_prod);
+
     spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
 
     /* processor register resource access h-calls */
-- 
2.20.1


