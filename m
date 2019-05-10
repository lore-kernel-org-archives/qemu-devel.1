Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E08C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:44:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7181E2177B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gF0ARZK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7181E2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45332 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7hR-0005jb-Mx
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:44:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Jo-0007pq-SG
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Jn-0000GT-LK
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:16 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:33187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP7Jn-0000Fq-F3
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:15 -0400
Received: by mail-pg1-x535.google.com with SMTP id h17so3194448pgv.0
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 08:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=m8b1TfwrtSp/bIRpBWvKs+DLGDtPKUANT8NhwLlWDyg=;
	b=gF0ARZK4cj+gkEGp7aUCbIQDNiAp18oKWD7gfsU78opsuT47nUJZtOmJYr7nPxfJX9
	Ul0yMY5hebWanfg0/i0OF0L6vgDPi9ZnqHyH8NfovNd7SWUOVRt8tDxGTiQIi5EvCKKR
	K+ZFJOf9idlQlpApCVHa8HjlWXUtqsiLH9Xc7e88JLUSeSrbDT+4TamjhbUrTHsxqxSm
	2lNvLl2+ePXsSfwYUfIzR0XSva94DsBhKTt/MP8jf+Z1uQBB98T4bD1xsp9m/iuU6Cq0
	p1jNz44mcNCZqV6Ug12oVVaPKtj2zH+t25LQRGwsEqksyajqb4115OLHH66HiGT/hMAg
	Q4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=m8b1TfwrtSp/bIRpBWvKs+DLGDtPKUANT8NhwLlWDyg=;
	b=JLZOsbikiDdk0w/ZLgo+wGH6Qoy1H8x9bo0wqOVkvv+ygUHzZDd5c+zi+ydWwy45WQ
	OuMYKkx0Hv7l1ZSJUqcfgCMJ8y4BeQqd8sOHjyHdVOARIxftm/oHXQnQ1q4Xo/kCvZkQ
	RgKzSSRn7njouscLt0mw0S9x+pSKX4kyRxf4u5XzcTo1LKlQPrAb8Gc9+bRFoUnAprjR
	sN7YoFWbxcQI4Lf1nOpVj/faTKcNaCgeZcaM+jC3oEfp/C5d66NEhYlljocttROB5lNb
	9I4pBFjDpUyYAStovSmkHBjshP7vKe5BON1m4Saq7C4PREXl0C0+FL4bcHR++svLQnm/
	oL3g==
X-Gm-Message-State: APjAAAWB6Mthdq5G5JUuGYv5BmAv0HM3ki+ruJC1JSC1e3OcKNhtynBH
	x0UlHp2rqNwBEijhqmpE9n7W8WIFAfY=
X-Google-Smtp-Source: APXvYqzE1nlFj+QtNdjseMRqawBjCtuv0vRBXn+jh3p4vcqIGOB8FQu5z1k4cc9lcLyW+bAgebl+Sg==
X-Received: by 2002:aa7:9116:: with SMTP id 22mr14842707pfh.165.1557501614042; 
	Fri, 10 May 2019 08:20:14 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id 19sm5920517pgz.24.2019.05.10.08.20.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 08:20:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 08:19:39 -0700
Message-Id: <20190510151944.22981-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510151944.22981-1-richard.henderson@linaro.org>
References: <20190510151944.22981-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::535
Subject: [Qemu-devel] [PULL 22/27] target/tricore: Convert to
 CPUClass::tlb_fill
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

Acked-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/tricore/cpu.h       |  6 +++---
 target/tricore/cpu.c       |  1 +
 target/tricore/helper.c    | 27 +++++++++++++++++++--------
 target/tricore/op_helper.c | 26 --------------------------
 4 files changed, 23 insertions(+), 37 deletions(-)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 64d1a9c75e..287f4328a3 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -417,8 +417,8 @@ static inline void cpu_get_tb_cpu_state(CPUTriCoreState *env, target_ulong *pc,
 #define CPU_RESOLVING_TYPE TYPE_TRICORE_CPU
 
 /* helpers.c */
-int cpu_tricore_handle_mmu_fault(CPUState *cpu, target_ulong address,
-                                 int rw, int mmu_idx);
-#define cpu_handle_mmu_fault cpu_tricore_handle_mmu_fault
+bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                          MMUAccessType access_type, int mmu_idx,
+                          bool probe, uintptr_t retaddr);
 
 #endif /* TRICORE_CPU_H */
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index e8d37e4040..ea1199d27e 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -166,6 +166,7 @@ static void tricore_cpu_class_init(ObjectClass *c, void *data)
     cc->synchronize_from_tb = tricore_cpu_synchronize_from_tb;
     cc->get_phys_page_attrs_debug = tricore_cpu_get_phys_page_attrs_debug;
     cc->tcg_initialize = tricore_tcg_init;
+    cc->tlb_fill = tricore_cpu_tlb_fill;
 }
 
 #define DEFINE_TRICORE_CPU_TYPE(cpu_model, initfn) \
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 78ee87c9ea..ed184fee3a 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -50,8 +50,9 @@ static void raise_mmu_exception(CPUTriCoreState *env, target_ulong address,
 {
 }
 
-int cpu_tricore_handle_mmu_fault(CPUState *cs, target_ulong address,
-                                 int rw, int mmu_idx)
+bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                          MMUAccessType rw, int mmu_idx,
+                          bool probe, uintptr_t retaddr)
 {
     TriCoreCPU *cpu = TRICORE_CPU(cs);
     CPUTriCoreState *env = &cpu->env;
@@ -64,20 +65,30 @@ int cpu_tricore_handle_mmu_fault(CPUState *cs, target_ulong address,
     access_type = ACCESS_INT;
     ret = get_physical_address(env, &physical, &prot,
                                address, rw, access_type);
-    qemu_log_mask(CPU_LOG_MMU, "%s address=" TARGET_FMT_lx " ret %d physical " TARGET_FMT_plx
-                  " prot %d\n", __func__, address, ret, physical, prot);
+
+    qemu_log_mask(CPU_LOG_MMU, "%s address=" TARGET_FMT_lx " ret %d physical "
+                  TARGET_FMT_plx " prot %d\n",
+                  __func__, (target_ulong)address, ret, physical, prot);
 
     if (ret == TLBRET_MATCH) {
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
                      physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
                      mmu_idx, TARGET_PAGE_SIZE);
-        ret = 0;
-    } else if (ret < 0) {
+        return true;
+    } else {
+        assert(ret < 0);
+        if (probe) {
+            return false;
+        }
         raise_mmu_exception(env, address, rw, ret);
-        ret = 1;
+        cpu_loop_exit_restore(cs, retaddr);
     }
+}
 
-    return ret;
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    tricore_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
 }
 
 static void tricore_cpu_list_entry(gpointer data, gpointer user_data)
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index ed9dc0c83e..601e92f92a 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -2793,29 +2793,3 @@ uint32_t helper_psw_read(CPUTriCoreState *env)
 {
     return psw_read(env);
 }
-
-
-static inline void QEMU_NORETURN do_raise_exception_err(CPUTriCoreState *env,
-                                                        uint32_t exception,
-                                                        int error_code,
-                                                        uintptr_t pc)
-{
-    CPUState *cs = CPU(tricore_env_get_cpu(env));
-    cs->exception_index = exception;
-    env->error_code = error_code;
-    /* now we have a real cpu fault */
-    cpu_loop_exit_restore(cs, pc);
-}
-
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    int ret;
-    ret = cpu_tricore_handle_mmu_fault(cs, addr, access_type, mmu_idx);
-    if (ret) {
-        TriCoreCPU *cpu = TRICORE_CPU(cs);
-        CPUTriCoreState *env = &cpu->env;
-        do_raise_exception_err(env, cs->exception_index,
-                               env->error_code, retaddr);
-    }
-}
-- 
2.17.1


