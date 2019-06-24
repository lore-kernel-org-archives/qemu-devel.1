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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1E2C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 06:01:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A2A2083D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 06:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u8xQ3Eqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A2A2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48140 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfI2a-0005Pq-A4
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 02:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35894)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sjitindarsingh@gmail.com>) id 1hfHzp-0003aD-Sq
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 01:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sjitindarsingh@gmail.com>) id 1hfHzo-00061D-Py
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 01:58:29 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41234)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
 id 1hfHzl-0005yO-OE; Mon, 24 Jun 2019 01:58:25 -0400
Received: by mail-pf1-x444.google.com with SMTP id m30so6850796pff.8;
 Sun, 23 Jun 2019 22:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BNTveCJapGdj0Gv7DBpJLbE+44u541pQ9RFkUPFhZ0E=;
 b=u8xQ3EqrsdT2p3zJbJBjyGfdY0D8UsMm3Kaa5w31AhgYRzM4BWu3uIjsH4791dTWVa
 fibzMzPR6I4KgbbnQEq5KFd3YdKnCauNZLglleXNizLYm5NclxM9UvDhaA+dSNiSArvS
 TKUM19OBmxV022079tzd9vYJ9glwZRgvFlzDJSAOEQ4h2viZ5mPPdL92v4UM9RLGgG9Y
 5Gxkaqi1tf4lLylkx1OF8aLf1AhYVM87Ggvu6L2TW/F/2CI+zki47UJNw9iFVr+qg859
 Yerznd1rNA34VzundVQuO8dFbqMsRClN2BMC4SaN3msCFFGoMwDhYsAbf4HBP16KNgnq
 LzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BNTveCJapGdj0Gv7DBpJLbE+44u541pQ9RFkUPFhZ0E=;
 b=N/0SuQ0bRn8piJsBnWc5a39JVongVQ39DEXwu5t2v9L93J6nNrHIziPUVjglTMtiO2
 yrCJMEVZV6zX80C5sIE2xhmFRGjU9n02G21ZO9zRAQbKcmGoPooVuBtAFQFwUKvfmRWC
 SPNo7Ox9jYw9ulHpp5C8iRxjMAFQObrLzaVoyru2Y09dHdB5XTeMbO0hB4ZFeZIePdV7
 +wmoRQixUIAHGx5mfxRct+fIZEDCRrXfNhb5bRRs8Zl0i15VtXq6hY5NTjkwPzDjJu6Q
 JynJ7hJuJ33ttxRSTuKoQ1KDGw6tOI8YyHkZ/wm0zx3xI0DG7crziciaaeZgOypDhgIF
 QKpA==
X-Gm-Message-State: APjAAAVo9alMj+g4qT4btmjPFDuBAuBa27KVHD19ReXCfYxH2cLEaY8j
 hb8+QwKAyMtedJf6YpmVePrwmfww
X-Google-Smtp-Source: APXvYqwNfB/ZqmihU93asYXQ2m2bbIbyNkRFEPUowGXSZj7JBCzS+25dxAS4jRX0ygK4ng7NzA5xCA==
X-Received: by 2002:a63:e43:: with SMTP id 3mr7899574pgo.402.1561355904637;
 Sun, 23 Jun 2019 22:58:24 -0700 (PDT)
Received: from surajjs2.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id s15sm12579335pfd.183.2019.06.23.22.58.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 23 Jun 2019 22:58:24 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: qemu-ppc@nongnu.org
Date: Mon, 24 Jun 2019 15:58:12 +1000
Message-Id: <20190624055812.3906-2-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190624055812.3906-1-sjitindarsingh@gmail.com>
References: <20190624055812.3906-1-sjitindarsingh@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 2/2] ppc/spapr: Enable H_PURR
 in-kernel handling
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

Enable in-kernel handling of the hcall H_PURR. This means that if the
kernel implements an hcall handler for H_PURR, it will be used.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr.c       | 3 +++
 target/ppc/kvm.c     | 5 +++++
 target/ppc/kvm_ppc.h | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 39e698e9b0..b62dce8876 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2851,6 +2851,9 @@ static void spapr_machine_init(MachineState *machine)
 
         /* Enable H_PAGE_INIT */
         kvmppc_enable_h_page_init();
+
+        /* Enable H_PURR */
+        kvmppc_enable_h_purr();
     }
 
     /* allocate RAM */
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 3bf0a46c33..0fd3ef4d48 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2075,6 +2075,11 @@ void kvmppc_enable_h_page_init(void)
     kvmppc_enable_hcall(kvm_state, H_PAGE_INIT);
 }
 
+void kvmppc_enable_h_purr(void)
+{
+    kvmppc_enable_hcall(kvm_state, H_PURR);
+}
+
 void kvmppc_set_papr(PowerPCCPU *cpu)
 {
     CPUState *cs = CPU(cpu);
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 45776cad79..b5d2feab22 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -24,6 +24,7 @@ void kvmppc_enable_logical_ci_hcalls(void);
 void kvmppc_enable_set_mode_hcall(void);
 void kvmppc_enable_clear_ref_mod_hcalls(void);
 void kvmppc_enable_h_page_init(void);
+void kvmppc_enable_h_purr(void);
 void kvmppc_set_papr(PowerPCCPU *cpu);
 int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
 void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
@@ -145,6 +146,10 @@ static inline void kvmppc_enable_h_page_init(void)
 {
 }
 
+static inline void kvmppc_enable_h_purr(void)
+{
+}
+
 static inline void kvmppc_set_papr(PowerPCCPU *cpu)
 {
 }
-- 
2.13.6


