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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A0BC76191
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 02:48:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8203720880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 02:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKX56AuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8203720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnDVv-0003qV-0M
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 22:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44256)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hnDVP-000264-Mu
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 22:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hnDVO-0004TR-Km
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 22:47:51 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33398)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hnDVM-0004Qj-Ek; Mon, 15 Jul 2019 22:47:48 -0400
Received: by mail-pl1-x644.google.com with SMTP id c14so9278874plo.0;
 Mon, 15 Jul 2019 19:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aspJFmRkiuGl98ZZpfTk4UAxRVGqt3PVQT6yVoIbn6Q=;
 b=BKX56AuBGgyx61xd76VALGoghvtPYsdpPunNIhrOhrZO6PT7+F0A/FcT4zr8Ji/Dn+
 uMcGUj1L11CVPEgTxBnraY/X8N8BhXzh0m9zzA/2RqmdJhxzHb3JfYkScFB7rZHnLaFL
 4zG7oWBHEclgwysCSRIJfqA9WwPmSUp3hA0jC2V8Cnl4cwOptrInvGpy/aEXgtSjQ9Y5
 dorpi5MnxTxrjJTYT067NLPkHkMwhKwGqBMXCnFyack+41KTBLkR5K81PJ+y3qG0BR7q
 Omp4Y3pnLzBmE4g8WSTgytbbpZCH4hVXQ0+b93cGnK+BkZC/yWi1AbZqxiNVFCs/u8d3
 d3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aspJFmRkiuGl98ZZpfTk4UAxRVGqt3PVQT6yVoIbn6Q=;
 b=tgkUo0JFpio1Dyhh6e1SDaw/qkj8Rg9Yf9X81WkzR5ayR8x6pcX1+OO0kbbhNkHgq7
 5kH5t3a15dZzDmjYZQqsNr1Tm97+wiDG0Y1YbqXY6lGcp1JTNKtRBJV+qOiKqXNoB3zi
 4IKvUqh362JVwZlgp4wdRe+hNUrijYCvhxq2RNKQolej9Bh3pBG7+nio9b+h/Xk7SVex
 IV5+/SwcQqzy3xi7h2xAviVn/SMN9Q4Q4X8RpFHJ/bjgNdw9BimJrtpa+WLRRklj+hM/
 zs/d0BJCElFETkz3wI2IY+DoR1zzwL3ka+iN780p2nCl8EWLXmdxjQUjvICINFgpkbhE
 xAlA==
X-Gm-Message-State: APjAAAWfHUBpkS2kqmWeCeyuqq/RE49kL8wnXaJSbOt/gOfJ2Yx2V8NK
 8wNiFIz2zNZQ2ulhkPHE2WQ=
X-Google-Smtp-Source: APXvYqz7u4Sfb++ZR0r6HA7JvgJecqVTPvQO0vDgY6Esj/PAY1mWowkMO5+ojotTEOYGJHm/bAflSA==
X-Received: by 2002:a17:902:f082:: with SMTP id
 go2mr33697942plb.25.1563245267578; 
 Mon, 15 Jul 2019 19:47:47 -0700 (PDT)
Received: from bobo.local0.net ([203.220.8.141])
 by smtp.gmail.com with ESMTPSA id x8sm16557837pfa.46.2019.07.15.19.47.44
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 19:47:47 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 16 Jul 2019 12:47:23 +1000
Message-Id: <20190716024726.17864-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190716024726.17864-1-npiggin@gmail.com>
References: <20190716024726.17864-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v4 2/5] spapr: Implement H_PROD
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


