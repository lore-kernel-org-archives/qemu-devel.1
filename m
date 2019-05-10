Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCEDC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAEDF2177B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mJxTkwtn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEDF2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44999 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7LR-0000NG-2D
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:21:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7JP-0007Ok-I7
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7JO-0008Dc-DJ
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:19:51 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP7JO-0008Cz-6t
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:19:50 -0400
Received: by mail-pf1-x442.google.com with SMTP id z26so3404116pfg.6
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 08:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=FfWuCh2mm65OwVmLvUKciMMvVsrbj00IXvSAZ0jgt/k=;
	b=mJxTkwtnFtTM8f1S3KTzL1i+xwO9CxFOhV+gQYZsGyu5pneF2S8rat/EXgfRkIRjmx
	S89IClaCSzCpTKnXlfRiQZkA/1GNnNjnXvps7cFbWyKRmHMFdT36k/y7IVrxcwBD5wto
	zWlPMkX01Ph+D6LkZgl6k6B6VizLggnub7HilUZu2sm7amDQ7Ux8VYzWiS8sIG94B1bS
	+QJ0DwG/yQG/s+D0p6MINqek7KGk8VGOrjj74ish+aWACLsWqTW9Gt7triFC3sSHEB3w
	6137ZfTJ1YeluBcoqJB3bMZzUo4RKY/nJhfxnK5/nL5SMJ3mjr/tEwBAMh8x7BYlgKLE
	piuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=FfWuCh2mm65OwVmLvUKciMMvVsrbj00IXvSAZ0jgt/k=;
	b=UFghDdVr71WY2cm7F9Gb0W57nKVf1O+CR0HZhhLhDFHv1BK08+BkiZyuO1EGFj8o68
	S6OsPz572evzgorcq9um0RhD3zfw4ct+DvQaH+DQm5613BF8aKpQOwFYktsX0F4HKf1d
	OQw/dlpsCIcol99iuQ4xt+m5/GDZ+YAR1erleAPJnSpq83+OAlRFIglB3nkO6parNcoJ
	ezuBEyW1oU2DakJMwZlFpy50NUmhAVK3o3viWFyzsyKFU/EmzK6rdiOkxwlE6JsOizDn
	FGgcsf11wHfPSuLF29VMUcUIQ0iGrQhLTWvg97/InoOIe/S5zIofvTDd5NzuJGG0/2TJ
	fh2Q==
X-Gm-Message-State: APjAAAU+0S5sofKNFxlLU9xzQsoa+mIbieXDgPcGKhn+mTfP1fPH+xcc
	+MeOX9BiOBBrKlDvCcBm6ewP43EDn6k=
X-Google-Smtp-Source: APXvYqyCN7fniTFLhkQ7SJSXIk/FQ6odBkYzRYI1Bq5rUImuaIyNe5mIlLBcYJ9XNbaOR78vF86ZnA==
X-Received: by 2002:aa7:9a99:: with SMTP id w25mr14683056pfi.249.1557501588824;
	Fri, 10 May 2019 08:19:48 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id 19sm5920517pgz.24.2019.05.10.08.19.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 08:19:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 08:19:19 -0700
Message-Id: <20190510151944.22981-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510151944.22981-1-richard.henderson@linaro.org>
References: <20190510151944.22981-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PULL 02/27] target/alpha: Convert to
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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


