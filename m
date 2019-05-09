Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD54C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:04:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE51216C4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gbrikn+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE51216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48569 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOcAp-00079E-5O
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 02:04:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc8r-0005vA-HD
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:02:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc8q-00070o-BM
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:02:53 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOc8q-00070S-5I
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:02:52 -0400
Received: by mail-pf1-x441.google.com with SMTP id t87so730724pfa.2
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 23:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=nXQKQmWv/YKHXQBl4iXWce1fvy4Q62aar83khsKjymg=;
	b=Gbrikn+Vp37AnJo3jBEL6aMO5QmhCkB1IUb5phruLggUL4W557VUZq7rAwGZnHCUA6
	za4LFYWuAdWIJWih/9HMtU6L89xJJwNnQSv5xobp8BuhQ+0x7YXV2j3euZ7zNR0YbRDG
	gxBCkcXD/iqYQd8E+nwOD1/DVnwOWs2E6vGo1ZtQjVldh7K81FDzRTA0LlDcOWRHc7up
	YRgqovz97WZkosVrG2udkZ2PZf+ynfW/Z6lAOXSfU4dn+RuLx/WflMxl0hk2mXgOuwyp
	Vl00iT79kHSF2WiI3hky4twd3pYEDIO/gfvXDrGLNmTUtE1+NMa6OePRiAF2ZLMhOBGv
	42xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=nXQKQmWv/YKHXQBl4iXWce1fvy4Q62aar83khsKjymg=;
	b=ByLnalDKrOz0rWJ3hx199VCEgfM77S2SDgTF9GOIWG/Z9HAeC0fY8QIiJQ0NIHDQjq
	L1UaGczpTRoB2TlBI5KtKQA0ZptP97ekIxpL98tmSvLNvRYROEiu7FDsKBzWeILcgxyX
	eAzMLfBZdhTUDhDUNf/JZONs6WDI/9r2VqqQBJ4q82miZLHXdEwjYBs2laHX8n5ppC1O
	veNRIJ46yVjbPCI3gyQf34Jj/hwTxX6LPoteB2I0UuKqOgkM6OcfWRg0Mqtv2n1GO4t+
	eCte7ZrJJWBFJseRygg3jBPKYQmZlyNKTVrSty8QfwF9qy5ftrBdaTHA2m8dp4KovvAW
	6B1w==
X-Gm-Message-State: APjAAAUFBCxJOFrp9cre+wzlJdVwf+IiMio5xXUd51rSEt57xS+WsrZt
	jgvYxgdw8pQzSn0y9cOI5A+WQw6GG8M=
X-Google-Smtp-Source: APXvYqwxLyJcf3VjyVYHetPoRV8uQDqElVxts6+m+CYJszVNb9LEAq24bxhpA/0VVoF/Pk9dZuy9ug==
X-Received: by 2002:a65:4489:: with SMTP id l9mr3084713pgq.1.1557381770916;
	Wed, 08 May 2019 23:02:50 -0700 (PDT)
Received: from localhost.localdomain (97-113-27-95.tukw.qwest.net.
	[97.113.27.95])
	by smtp.gmail.com with ESMTPSA id n7sm1496109pff.45.2019.05.08.23.02.49
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 23:02:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  8 May 2019 23:02:21 -0700
Message-Id: <20190509060246.4031-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509060246.4031-1-richard.henderson@linaro.org>
References: <20190509060246.4031-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v2 02/27] target/alpha: Convert to
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Keep user-only and system tlb_fill separate.
---
 target/alpha/cpu.h        |  5 +++--
 target/alpha/cpu.c        |  5 ++---
 target/alpha/helper.c     | 30 +++++++++++++++++++++---------
 target/alpha/mem_helper.c | 16 ----------------
 4 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 63bf3618ff..cf09112b6a 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -475,8 +475,9 @@ void alpha_cpu_list(void);
    is returned if the signal was handled by the virtual CPU.  */
 int cpu_alpha_signal_handler(int host_signum, void *pinfo,
                              void *puc);
-int alpha_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
-                               int mmu_idx);
+bool alpha_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr);
 void QEMU_NORETURN dynamic_excp(CPUAlphaState *, uintptr_t, int, int);
 void QEMU_NORETURN arith_excp(CPUAlphaState *, uintptr_t, int, uint64_t);
 
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index ad3588a44a..7c81be4111 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -225,9 +225,8 @@ static void alpha_cpu_class_init(ObjectClass *oc, void *data)
     cc->set_pc = alpha_cpu_set_pc;
     cc->gdb_read_register = alpha_cpu_gdb_read_register;
     cc->gdb_write_register = alpha_cpu_gdb_write_register;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = alpha_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = alpha_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->do_transaction_failed = alpha_cpu_do_transaction_failed;
     cc->do_unaligned_access = alpha_cpu_do_unaligned_access;
     cc->get_phys_page_debug = alpha_cpu_get_phys_page_debug;
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 7201576aae..929a217455 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -104,14 +104,15 @@ void cpu_alpha_store_gr(CPUAlphaState *env, unsigned reg, uint64_t val)
 }
 
 #if defined(CONFIG_USER_ONLY)
-int alpha_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
-                               int rw, int mmu_idx)
+bool alpha_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr)
 {
     AlphaCPU *cpu = ALPHA_CPU(cs);
 
     cs->exception_index = EXCP_MMFAULT;
     cpu->env.trap_arg0 = address;
-    return 1;
+    cpu_loop_exit_restore(cs, retaddr);
 }
 #else
 /* Returns the OSF/1 entMM failure indication, or -1 on success.  */
@@ -248,26 +249,37 @@ hwaddr alpha_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     return (fail >= 0 ? -1 : phys);
 }
 
-int alpha_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size, int rw,
-                               int mmu_idx)
+bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr)
 {
     AlphaCPU *cpu = ALPHA_CPU(cs);
     CPUAlphaState *env = &cpu->env;
     target_ulong phys;
     int prot, fail;
 
-    fail = get_physical_address(env, addr, 1 << rw, mmu_idx, &phys, &prot);
+    fail = get_physical_address(env, addr, 1 << access_type,
+                                mmu_idx, &phys, &prot);
     if (unlikely(fail >= 0)) {
+        if (probe) {
+            return false;
+        }
         cs->exception_index = EXCP_MMFAULT;
         env->trap_arg0 = addr;
         env->trap_arg1 = fail;
-        env->trap_arg2 = (rw == 2 ? -1 : rw);
-        return 1;
+        env->trap_arg2 = (access_type == MMU_INST_FETCH ? -1 : access_type);
+        cpu_loop_exit_restore(cs, retaddr);
     }
 
     tlb_set_page(cs, addr & TARGET_PAGE_MASK, phys & TARGET_PAGE_MASK,
                  prot, mmu_idx, TARGET_PAGE_SIZE);
-    return 0;
+    return true;
+}
+
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    alpha_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
 }
 #endif /* USER_ONLY */
 
diff --git a/target/alpha/mem_helper.c b/target/alpha/mem_helper.c
index 011bc73dca..934faa1d6f 100644
--- a/target/alpha/mem_helper.c
+++ b/target/alpha/mem_helper.c
@@ -62,20 +62,4 @@ void alpha_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
     env->error_code = 0;
     cpu_loop_exit_restore(cs, retaddr);
 }
-
-/* try to fill the TLB and return an exception if error. If retaddr is
-   NULL, it means that the function was called in C code (i.e. not
-   from generated code or from helper.c) */
-/* XXX: fix it to restore all registers */
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    int ret;
-
-    ret = alpha_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (unlikely(ret != 0)) {
-        /* Exception index and error code are already set */
-        cpu_loop_exit_restore(cs, retaddr);
-    }
-}
 #endif /* CONFIG_USER_ONLY */
-- 
2.17.1


