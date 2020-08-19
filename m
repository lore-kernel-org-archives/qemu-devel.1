Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6833C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 18:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C6020658
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 18:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F/Vy6ig4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C6020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8SuA-0008R6-OU
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 14:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k8Sqx-00030h-2f
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 14:30:27 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:33816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k8Squ-0001xc-H2
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 14:30:26 -0400
Received: by mail-pj1-x1042.google.com with SMTP id c10so1486807pjn.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 11:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lfY7bHrFHXynSVDo8ptewPOGV7rWpBju4iD77BNem5c=;
 b=F/Vy6ig4OwGRe58M2fAQ8YX9gUsZhSBu0NEwHt69H9UuLfbw7Ux4SXGlj6vdzDl7Y5
 xSmtlQxOzwstF81U+g8HsliT76DBYMFC63AKV5Bl77z+v63ZKlkZYiQCXt2+7ihiraMo
 FgfJzSypEA/Ib0T/IONW7vEg8er25At/5z5r7t2NmvWrMexzGV9ca8zB1SgnEsvwxq0g
 b2pCQ6ZOv9jN6QGaSpvO2NlYA7dDY5qtL6yTcAvcUCi2U27WAxEfJcTGXfc1wo6wSIGr
 Lmiaiq3WiCHMwX8YYJj6JBSIWLcfrPfauKKZxo3wZClTcE1+J/3dBV8AAsBVQN+Yceon
 ZgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lfY7bHrFHXynSVDo8ptewPOGV7rWpBju4iD77BNem5c=;
 b=DBAum7Ba/3OcrkytrnontDlvZFFsstVuIhWarrZiLp243ndGY29y6uRp/YIfWGfyZA
 C8RkSOjkwxSFHy1Ixono3m6Pzehw82SSmJL1BEpa5QCduF2pHcBaVDyD1dbrNFk82DC5
 GCCoFlVq1W8F2yuyGm7XgmrP+YZGpxtAxPaqhDaP07j+plEBACGbsoBAtk9TgrWuSAtH
 zMXl4LrnvnYXtSD8qOb1C/ww/yCbdbMb28lz14Q5ye4zEHdS2xe8wHsgervbrLl64OLZ
 V+52LtmAsqWtFsHk6/zOKmKa0kxGQi7HLId1hZzs1P4s4cqeucTuSJcCXHWBbeUQqbqQ
 CXfw==
X-Gm-Message-State: AOAM533e1LAOhzmIk9/g4gUtTqrp/nCmEf66Je0zZzbcdYgeMONbD82R
 a5UELtEoxoSFuInHdgf4Ru9TO8QsgjeSpv1+
X-Google-Smtp-Source: ABdhPJwm/0hpsAPwXmdNFh/R0sR6jnousSmxARNTXMdpGukqoef4BSeiYBXpfCV59QVH7k7pJPURbw==
X-Received: by 2002:a17:90a:8a87:: with SMTP id
 x7mr4618737pjn.81.1597861822894; 
 Wed, 19 Aug 2020 11:30:22 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 (c-73-47-162-176.hsd1.ma.comcast.net. [73.47.162.176])
 by smtp.gmail.com with ESMTPSA id p20sm220766pjg.44.2020.08.19.11.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 11:30:22 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/7] target/cris: add CRISCPUClass->do_interrupt_locked
Date: Wed, 19 Aug 2020 14:28:52 -0400
Message-Id: <20200819182856.4893-4-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819182856.4893-1-robert.foley@linaro.org>
References: <20200819182856.4893-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=robert.foley@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, pbonzini@redhat.com,
 alex.bennee@linaro.org, robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adding ->do_interrupt_locked to CRISCPUClass is preparation for
pushing the BQL down into the per-arch implementation of ->do_interrupt.

This is needed since Cris's *_cpu_exec_interrupt calls to *_do_interrupt.
With the push down of the BQL into *_cpu_exec_interrupt and
*_do_interrupt, *_cpu_exec_interrupt will call to ->do_interrupt
with lock held.  Since ->do_interrupt also has the lock, we need a way
to allow cpu_exec_interrupt to call do_interrupt with lock held.
This patch solves the issue of *_cpu_exec_interrupt needing
to call do_interrupt with lock held.

This patch is part of a series of transitions to move the
BQL down into the do_interrupt per arch functions.  This set of
transitions is needed to maintain bisectability.

This approach was suggested by Paolo Bonzini.
For reference, here are two key posts in the discussion, explaining
the reasoning/benefits of this approach.
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00784.html
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg01517.html
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg08731.html
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00044.html

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/cris/cpu-qom.h | 3 +++
 target/cris/cpu.c     | 6 ++++++
 target/cris/helper.c  | 6 +++---
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/cris/cpu-qom.h b/target/cris/cpu-qom.h
index f1de6041dc..dc94a17ffe 100644
--- a/target/cris/cpu-qom.h
+++ b/target/cris/cpu-qom.h
@@ -36,6 +36,7 @@
  * @parent_realize: The parent class' realize handler.
  * @parent_reset: The parent class' reset handler.
  * @vr: Version Register value.
+ * @do_interrupt_locked: Handler for interrupts (lock already held).
  *
  * A CRIS CPU model.
  */
@@ -48,6 +49,8 @@ typedef struct CRISCPUClass {
     DeviceReset parent_reset;
 
     uint32_t vr;
+
+    void (*do_interrupt_locked)(CPUState *cpu);
 } CRISCPUClass;
 
 typedef struct CRISCPU CRISCPU;
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 40b110f161..948eeb6260 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -200,6 +200,7 @@ static void crisv8_cpu_class_init(ObjectClass *oc, void *data)
 
     ccc->vr = 8;
     cc->do_interrupt = crisv10_cpu_do_interrupt_locked;
+    ccc->do_interrupt_locked = crisv10_cpu_do_interrupt_locked;
     cc->gdb_read_register = crisv10_cpu_gdb_read_register;
     cc->tcg_initialize = cris_initialize_crisv10_tcg;
 }
@@ -211,6 +212,7 @@ static void crisv9_cpu_class_init(ObjectClass *oc, void *data)
 
     ccc->vr = 9;
     cc->do_interrupt = crisv10_cpu_do_interrupt_locked;
+    ccc->do_interrupt_locked = crisv10_cpu_do_interrupt_locked;
     cc->gdb_read_register = crisv10_cpu_gdb_read_register;
     cc->tcg_initialize = cris_initialize_crisv10_tcg;
 }
@@ -222,6 +224,7 @@ static void crisv10_cpu_class_init(ObjectClass *oc, void *data)
 
     ccc->vr = 10;
     cc->do_interrupt = crisv10_cpu_do_interrupt_locked;
+    ccc->do_interrupt_locked = crisv10_cpu_do_interrupt_locked;
     cc->gdb_read_register = crisv10_cpu_gdb_read_register;
     cc->tcg_initialize = cris_initialize_crisv10_tcg;
 }
@@ -233,6 +236,7 @@ static void crisv11_cpu_class_init(ObjectClass *oc, void *data)
 
     ccc->vr = 11;
     cc->do_interrupt = crisv10_cpu_do_interrupt_locked;
+    ccc->do_interrupt_locked = crisv10_cpu_do_interrupt_locked;
     cc->gdb_read_register = crisv10_cpu_gdb_read_register;
     cc->tcg_initialize = cris_initialize_crisv10_tcg;
 }
@@ -244,6 +248,7 @@ static void crisv17_cpu_class_init(ObjectClass *oc, void *data)
 
     ccc->vr = 17;
     cc->do_interrupt = crisv10_cpu_do_interrupt_locked;
+    ccc->do_interrupt_locked = crisv10_cpu_do_interrupt_locked;
     cc->gdb_read_register = crisv10_cpu_gdb_read_register;
     cc->tcg_initialize = cris_initialize_crisv10_tcg;
 }
@@ -269,6 +274,7 @@ static void cris_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = cris_cpu_class_by_name;
     cc->has_work = cris_cpu_has_work;
     cc->do_interrupt = cris_cpu_do_interrupt_locked;
+    ccc->do_interrupt_locked = cris_cpu_do_interrupt_locked;
     cc->cpu_exec_interrupt = cris_cpu_exec_interrupt;
     cc->dump_state = cris_cpu_dump_state;
     cc->set_pc = cris_cpu_set_pc;
diff --git a/target/cris/helper.c b/target/cris/helper.c
index e0ee6b4e05..3b7ee74813 100644
--- a/target/cris/helper.c
+++ b/target/cris/helper.c
@@ -290,7 +290,7 @@ hwaddr cris_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 
 bool cris_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    CPUClass *cc = CPU_GET_CLASS(cs);
+    CRISCPUClass *ccc = CRIS_CPU_CLASS(cs);
     CRISCPU *cpu = CRIS_CPU(cs);
     CPUCRISState *env = &cpu->env;
     bool ret = false;
@@ -299,7 +299,7 @@ bool cris_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
         && (env->pregs[PR_CCS] & I_FLAG)
         && !env->locked_irq) {
         cs->exception_index = EXCP_IRQ;
-        cc->do_interrupt(cs);
+        ccc->do_interrupt_locked(cs);
         ret = true;
     }
     if (interrupt_request & CPU_INTERRUPT_NMI) {
@@ -311,7 +311,7 @@ bool cris_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
         }
         if ((env->pregs[PR_CCS] & m_flag_archval)) {
             cs->exception_index = EXCP_NMI;
-            cc->do_interrupt(cs);
+            ccc->do_interrupt_locked(cs);
             ret = true;
         }
     }
-- 
2.17.1


