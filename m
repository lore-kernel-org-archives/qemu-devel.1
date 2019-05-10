Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7263CC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DB182070D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NDxtRjIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB182070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45174 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7Xn-0004RP-At
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:34:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7JU-0007Rq-6u
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:19:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7JS-0008Lg-Vv
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:19:56 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP7JS-0008JL-P1
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:19:54 -0400
Received: by mail-pg1-x542.google.com with SMTP id z3so3174853pgp.8
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 08:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=w7l/Pbs/dkuyE6y60mYyZzngNGSZYjs+O6jEPehbb2U=;
	b=NDxtRjIT9OwOwhQuz62GbKxNx3/1UWV99hQDQbrbUl+wF85WhiunFo3gRQe5HTaM2z
	yaEKk8KC6PV2P/UGYI2RSFDhDZq75/roQ6mZuJJNRZc/XosJQzWWuuB0Wug6gKqc2mV0
	8sJ8SM83s2wKVm1JrUy11/3lyp/0SdU+9XqUnoj+Hgn7EtwXAIexBd6m4pbyj/6TJ7tJ
	uovo/1e0mRAd3KOb8ZcG73XEE09pohPxEbE6HsRwnpPrGFRKOkf9cH9YIIXTRUQfdtyT
	ZR/q0DVxrRwMouujnEU7+bivGIx+lQfnYRq08TAKACRX9AWZ3JGqVxdQuparR3GUtozD
	ehzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=w7l/Pbs/dkuyE6y60mYyZzngNGSZYjs+O6jEPehbb2U=;
	b=q09N78clsZDPD0PRmY7m5RgtdUJ2f5Fkwihl9+2wHU3HH7YS5Or21CoJ+WsdD7a5eb
	Ljp9XIS4rEXWGJtBPrYlX8XDUKUo3/gY7LN7gXGk4yq0I3/TbEsDX57f7K2xuYi6eTg7
	6J8m/PzNsXFpBegQnYgB6drFVoivA/cVt9eA3NS2Ol94J6ZgDPdmj65lp8+q2NevxX4u
	cnjtU7ocqkOxQ1T2Bv6WExPzYrsao1L53s7XwrlNhX0cN9GF+dhxCxyqWhsxYKrwq+xl
	8mwzP0uOUaIrX4W8FJTiLpYYn2u2qjbSJ682UenWeiXHyI6xoic+qVB2iT+IsjphMGSo
	9JTA==
X-Gm-Message-State: APjAAAXmJqtjHqtOAKk63EaBXokM/N9v5doALf622BlIOANavrJUPNmq
	GemwRpr7mNUkb7IDQ6yVep1L3xTq8qM=
X-Google-Smtp-Source: APXvYqzWafCd/DDsaPUDKIDQn0EvgAPR3qNeP+mUCy5aDGehTHZ8ALdsIw9n+rKSszC7hnTCFlSL9Q==
X-Received: by 2002:a63:4852:: with SMTP id x18mr980020pgk.14.1557501593469;
	Fri, 10 May 2019 08:19:53 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id 19sm5920517pgz.24.2019.05.10.08.19.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 08:19:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 08:19:22 -0700
Message-Id: <20190510151944.22981-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510151944.22981-1-richard.henderson@linaro.org>
References: <20190510151944.22981-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PULL 05/27] target/hppa: Convert to CPUClass::tlb_fill
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        |  8 ++++----
 target/hppa/cpu.c        |  5 ++---
 target/hppa/mem_helper.c | 22 +++++++++++++++++-----
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 923346adb6..c1e0215e66 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -360,10 +360,10 @@ int hppa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void hppa_cpu_do_interrupt(CPUState *cpu);
 bool hppa_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void hppa_cpu_dump_state(CPUState *cs, FILE *f, int);
-#ifdef CONFIG_USER_ONLY
-int hppa_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
-                              int rw, int midx);
-#else
+bool hppa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr);
+#ifndef CONFIG_USER_ONLY
 int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
                               int type, hwaddr *pphys, int *pprot);
 extern const MemoryRegionOps hppa_io_eir_ops;
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index e64f48581e..9717ea1798 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -163,9 +163,8 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
     cc->synchronize_from_tb = hppa_cpu_synchronize_from_tb;
     cc->gdb_read_register = hppa_cpu_gdb_read_register;
     cc->gdb_write_register = hppa_cpu_gdb_write_register;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = hppa_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = hppa_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->get_phys_page_debug = hppa_cpu_get_phys_page_debug;
     dc->vmsd = &vmstate_hppa_cpu;
 #endif
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 77fb544838..5cee0c19b1 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -25,8 +25,9 @@
 #include "trace.h"
 
 #ifdef CONFIG_USER_ONLY
-int hppa_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
-                              int size, int rw, int mmu_idx)
+bool hppa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
 
@@ -34,7 +35,7 @@ int hppa_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
        which would affect si_code.  */
     cs->exception_index = EXCP_DMP;
     cpu->env.cr[CR_IOR] = address;
-    return 1;
+    cpu_loop_exit_restore(cs, retaddr);
 }
 #else
 static hppa_tlb_entry *hppa_find_tlb(CPUHPPAState *env, vaddr addr)
@@ -213,8 +214,9 @@ hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     return excp == EXCP_DTLB_MISS ? -1 : phys;
 }
 
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType type, int mmu_idx, uintptr_t retaddr)
+bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
+                       MMUAccessType type, int mmu_idx,
+                       bool probe, uintptr_t retaddr)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
@@ -236,6 +238,9 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
     excp = hppa_get_physical_address(env, addr, mmu_idx,
                                      a_prot, &phys, &prot);
     if (unlikely(excp >= 0)) {
+        if (probe) {
+            return false;
+        }
         trace_hppa_tlb_fill_excp(env, addr, size, type, mmu_idx);
         /* Failure.  Raise the indicated exception.  */
         cs->exception_index = excp;
@@ -252,6 +257,13 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
     /* Success!  Store the translation into the QEMU TLB.  */
     tlb_set_page(cs, addr & TARGET_PAGE_MASK, phys & TARGET_PAGE_MASK,
                  prot, mmu_idx, TARGET_PAGE_SIZE);
+    return true;
+}
+
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType type, int mmu_idx, uintptr_t retaddr)
+{
+    hppa_cpu_tlb_fill(cs, addr, size, type, mmu_idx, false, retaddr);
 }
 
 /* Insert (Insn/Data) TLB Address.  Note this is PA 1.1 only.  */
-- 
2.17.1


