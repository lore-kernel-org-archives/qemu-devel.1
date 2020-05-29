Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC07C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64FFA20721
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q1hyMGOh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64FFA20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jef0P-0005xq-IL
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 09:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jeezA-0004Ln-Ng
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:23:44 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:52839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jeez9-0003aE-Po
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:23:44 -0400
Received: by mail-pj1-x1041.google.com with SMTP id k2so1336548pjs.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 06:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=aGYJ5nJt/JAH6FWXmjwSAlg0Omv/+y0t2oEMaylOlqc=;
 b=Q1hyMGOhYqTQVuJ+eJ7rnzgRQjCTe2sbRcVbbB0u0iPqw943v5zjYVpInmgrG/XPne
 CCyum2Ee7JCWynyPEbNdxUcAzGK4sm9WvjiM4sZqCmLkx6ruFgT0Gt+Z0zS+ksEIJKWP
 3xAHoPyj5VJC2da/ouxL1N/tNHZsC0hkAODuqBZilASz66z9T/+O8bmpt8GX84vvQiZT
 HfuZmhRYu43Br9BUnBTShGeC6bJ8FaZqOl8DuoOt+1EYKrk4RMDRFXH0X4/JEqgT1OQy
 ca0eoseUmdQTbCKVgiv6nmNoEB9Pmq3DjGpzEdtpfgEq31xKZsSnFtlngxdUB2q8kjw2
 3cZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=aGYJ5nJt/JAH6FWXmjwSAlg0Omv/+y0t2oEMaylOlqc=;
 b=didnWF0vF98NNKcNPyNGqCJe0V/BAbwyHIaQwEJARo6BWlprnyz5U9UQB4av91fREK
 Jas8chaGqQEE1Qk8ZgVzcxVsRLGwCrs+CrMVf2xvhZXx/clhPaDFd0ZqJitLYKxaxhil
 ZB9hyfDzmbZq1Xsui7SD3g9uxN/cjiGCeRu7cPqsOc9Sxf8TxDlwadIGxFBTLvN/TXAA
 9wBj8UagJGrV8NURMHfDH1Zpyupn2NgpSEqeh1Ay2r00SWsUwiJxhOqWcjWSmpp9I0cw
 k+7fjXV32cxGHOjf6fOuwNfmkJLgsyBV5iohGy4ryFy9A6IruMxvDs0KbQNYU2MpWQWn
 BAOA==
X-Gm-Message-State: AOAM532qPSRPtHRGBsoZHdUwkaBAk5nNX377x9KWh91QvkvCPmrmHGJ/
 nPGONy3aBQe6cDP4DgPVeIrStMFWbwkkww==
X-Google-Smtp-Source: ABdhPJzMmFxNOyNIS0zK5sxLhaHm1mMavV6paPAnTh6gdbniECjcAbaZ4vSf3gy/ya5Tb7G8Cr4OZA==
X-Received: by 2002:a17:90a:f283:: with SMTP id
 fs3mr9206135pjb.1.1590758621974; 
 Fri, 29 May 2020 06:23:41 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:75ac:d268:da04:dde4])
 by smtp.gmail.com with ESMTPSA id e13sm1998686pfd.10.2020.05.29.06.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 06:23:41 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 04/12] cputlb: destroy CPUTLB with tlb_destroy
Date: Fri, 29 May 2020 09:23:34 -0400
Message-Id: <20200529132341.755-4-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529132341.755-1-robert.foley@linaro.org>
References: <20200529132341.755-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=robert.foley@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: robert.foley@linaro.org, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

I was after adding qemu_spin_destroy calls, but while at
it I noticed that we are leaking some memory.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 accel/tcg/cputlb.c      | 15 +++++++++++++++
 exec.c                  |  1 +
 include/exec/exec-all.h |  8 ++++++++
 3 files changed, 24 insertions(+)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index eb2cf9de5e..1e815357c7 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -270,6 +270,21 @@ void tlb_init(CPUState *cpu)
     }
 }
 
+void tlb_destroy(CPUState *cpu)
+{
+    CPUArchState *env = cpu->env_ptr;
+    int i;
+
+    qemu_spin_destroy(&env_tlb(env)->c.lock);
+    for (i = 0; i < NB_MMU_MODES; i++) {
+        CPUTLBDesc *desc = &env_tlb(env)->d[i];
+        CPUTLBDescFast *fast = &env_tlb(env)->f[i];
+
+        g_free(fast->table);
+        g_free(desc->iotlb);
+    }
+}
+
 /* flush_all_helper: run fn across all cpus
  *
  * If the wait flag is set then the src cpu's helper will be queued as
diff --git a/exec.c b/exec.c
index 5162f0d12f..da3d60b034 100644
--- a/exec.c
+++ b/exec.c
@@ -892,6 +892,7 @@ void cpu_exec_unrealizefn(CPUState *cpu)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
 
+    tlb_destroy(cpu);
     cpu_list_remove(cpu);
 
     if (cc->vmsd != NULL) {
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 8792bea07a..3cf88272df 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -124,6 +124,11 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
  * @cpu: CPU whose TLB should be initialized
  */
 void tlb_init(CPUState *cpu);
+/**
+ * tlb_destroy - destroy a CPU's TLB
+ * @cpu: CPU whose TLB should be destroyed
+ */
+void tlb_destroy(CPUState *cpu);
 /**
  * tlb_flush_page:
  * @cpu: CPU whose TLB should be flushed
@@ -284,6 +289,9 @@ void tlb_set_page(CPUState *cpu, target_ulong vaddr,
 static inline void tlb_init(CPUState *cpu)
 {
 }
+static inline void tlb_destroy(CPUState *cpu)
+{
+}
 static inline void tlb_flush_page(CPUState *cpu, target_ulong addr)
 {
 }
-- 
2.17.1


