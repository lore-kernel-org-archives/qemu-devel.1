Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93621C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55CD422CED
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AXdCSoED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CD422CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5C22-0008Ev-HS
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BND-0001fd-MJ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BNC-00040x-Cg
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:39 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:38881)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BNC-000405-6n
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:38 -0400
Received: by mail-pf1-x42c.google.com with SMTP id h195so4519430pfe.5
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7AiiEg4xJiOqmmYYjoxw79QoYQMGZfk7FrNe3RqLABM=;
 b=AXdCSoED4045SCexaDvftDHizMTfRMOzM2xBMi29VKAzpIIA7iRVER8jpoIjNcZJBe
 hk4Jsi4/ob7oICO/dWc6NlMQu42qqXX7RzVlFqpsrGKClWrEYlrK6BLAIlDY64kXwNst
 sSTtji3LUfDFluySHvLRZhK2Up0sRfMoMM4K2Ps5EMpU5aCkclGYqNv7jyvcAKiMnQsT
 np9LFcm97chTCIB04tIkckLTtE9OnbBhwQk2urslYvhmOtO8P4ghuPFYPRmULmO+j7Tu
 cL8+EhmSkCfNWQFj3m431jR9fITOYnkVdYeMHJbU4P0mMT7CfC7CCRk3djnHSF6u5507
 HVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7AiiEg4xJiOqmmYYjoxw79QoYQMGZfk7FrNe3RqLABM=;
 b=AS8p14hudP/pEt8nHU7sPe0c5BRCcpe/uy5DbygDV7xw/o+GEejLdx3osqMNZ1FqFx
 GzjuUAUs2GbKNIR58ItFx7ih6LN2rPhH36PRDcJmFdCG6RPs9Egyqjar1owxoSgawnWZ
 7G38slujCfBcL0LCDQMhTle8enhb64NW7EAleifWU5ddgxwrFRaHHi3QqRtyetcfgMsc
 VxEIXeIXXWgsW4AzEpyT6czrrnkj3E1eHdg85MOGpqxx2pfrnhPOk4xpq0P/7ad+Hb5l
 5nJ1Ojilk6WYR8LTw1/lvldkUWlJUWzL6/hUH6R0q5ID3o1lmFhzWBAdywougdTwmoOH
 AvzQ==
X-Gm-Message-State: APjAAAUxUI5iGm8uOSk1hcjpCChLrAZkVTL59Dbe6bzNlPV4PUM3ssB/
 d4ZC4Ng2so9Q+Wo8nOQ1/oBvj6skJec=
X-Google-Smtp-Source: APXvYqwk+STxX87GZZBa0ONUSTcIxO0BCnF6D1jPi89kUaMUJxpXXMaAEol9j4eRnkEkY35XP0OTRg==
X-Received: by 2002:a62:60c7:: with SMTP id u190mr41656514pfb.54.1567526976905; 
 Tue, 03 Sep 2019 09:09:36 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:52 -0700
Message-Id: <20190903160858.5296-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42c
Subject: [Qemu-devel] [PATCH 30/36] tcg: Factor out CONFIG_USER_ONLY
 probe_write() from s390x code
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
Cc: peter.maydell@linaro.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Factor it out into common code. Similar to the !CONFIG_USER_ONLY variant,
let's not allow to cross page boundaries.

Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190826075112.25637-4-david@redhat.com>
[rth: Move cpu & cc variables inside if block.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h   |  4 ++--
 accel/tcg/user-exec.c     | 14 ++++++++++++++
 target/s390x/mem_helper.c |  7 -------
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 135aeaab0d..cbcc85add3 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -260,8 +260,6 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
 void tlb_set_page(CPUState *cpu, target_ulong vaddr,
                   hwaddr paddr, int prot,
                   int mmu_idx, target_ulong size);
-void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
-                 uintptr_t retaddr);
 #else
 static inline void tlb_init(CPUState *cpu)
 {
@@ -312,6 +310,8 @@ static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
 {
 }
 #endif
+void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
+                 uintptr_t retaddr);
 
 #define CODE_GEN_ALIGN           16 /* must be >= of the size of a icache line */
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 897d1571c4..86e6827201 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -188,6 +188,20 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
     g_assert_not_reached();
 }
 
+void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
+                 uintptr_t retaddr)
+{
+    if (!guest_addr_valid(addr) ||
+        page_check_range(addr, size, PAGE_WRITE) < 0) {
+        CPUState *cpu = env_cpu(env);
+        CPUClass *cc = CPU_GET_CLASS(cpu);
+
+        cc->tlb_fill(cpu, addr, size, MMU_DATA_STORE, MMU_USER_IDX, false,
+                     retaddr);
+        g_assert_not_reached();
+    }
+}
+
 #if defined(__i386__)
 
 #if defined(__NetBSD__)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 4b43440e89..fdff60ce5d 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -2615,12 +2615,6 @@ uint32_t HELPER(cu42)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t m3)
 void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
                         uintptr_t ra)
 {
-#ifdef CONFIG_USER_ONLY
-    if (!guest_addr_valid(addr) || !guest_addr_valid(addr + len - 1) ||
-        page_check_range(addr, len, PAGE_WRITE) < 0) {
-        s390_program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO, ra);
-    }
-#else
     /* test the actual access, not just any access to the page due to LAP */
     while (len) {
         const uint64_t pagelen = -(addr | TARGET_PAGE_MASK);
@@ -2630,7 +2624,6 @@ void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
         addr = wrap_address(env, addr + curlen);
         len -= curlen;
     }
-#endif
 }
 
 void HELPER(probe_write_access)(CPUS390XState *env, uint64_t addr, uint64_t len)
-- 
2.17.1


