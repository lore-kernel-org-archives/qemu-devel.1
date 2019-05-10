Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC929C04AB3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A2F20578
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WzX5/Kg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A2F20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45085 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7RX-0006rM-PD
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:28:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7JO-0007Oi-MZ
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7JN-0008By-CD
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:19:50 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:46643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP7JN-00088E-4S
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:19:49 -0400
Received: by mail-pf1-x42b.google.com with SMTP id y11so3385952pfm.13
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 08:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=7ZAIu4sKS6YB4WebUUhTxA56tE0hF5se6ULN034aZNQ=;
	b=WzX5/Kg3wXGGAAVo4Q5/PLRYl3vm580BE/g9KL3k/ouTDQOpiKB6T9XBcmZeFCy/1X
	WcLldaII9Gyjk1PcYLTKMKKSKZTe8+1xo0gaxyobfTrF2fLDI7xalsVOLeJEP2ewcaYA
	n/CYwb2ltPliqWgFePK4/Cr5u4CHXaMe2B79eRMfkBIz5ZBsOdgmfKxCmQ5ofrB8QG9t
	n+C3LYTzZLwv9Ku96lJ13FT0VGp2IR+CYTudPQxrJ2YFw5pEP0IBzLgzzk/iwRzDY2+h
	LX581NsUX1zvQUyL5S1EXb0LD1kFBwEGFk+eyXZWH7M4pFPcYdaXurt4y+1Ti0iK2NG3
	O0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=7ZAIu4sKS6YB4WebUUhTxA56tE0hF5se6ULN034aZNQ=;
	b=fHfQxcNYUdyNdu5we/GtcVYoMuQpa8BMO4xSj16TAWpUV1anqBq3kMwLDBo6cSjTbI
	UWxa4OU5fMiOqNmjjbSrK9mndiaECojWn2hzzolKLYSVQQCKrJd6371BN8tGI0rYAWOM
	7hPWgBOMin6JVB1Zv5U/JYhky3js09OP9M9Tj3obulnmFBGUSTJj75CplSQuDlanlyJK
	8xBDpWAjFNc4RDNIIpwt1G49pC5OO66PfjBiw5T3kGwq1c2MXPcfMoGWPi7+LRXh1Qua
	0xen6+cSbZShSycUPG57KygE4QyzzAaKctOHuhFQzs6W1G9UfFu3ubYEChlGHHEMMMmq
	WtSQ==
X-Gm-Message-State: APjAAAVd0jWLzi5Alx3kdccVj+oyz2fw2YXKD0iF/6QPzspORuUi93Wk
	XlhMzHsDWgvQvHyGh1phxc/Oic+YHnY=
X-Google-Smtp-Source: APXvYqzlyhy5QN67Ew0xUp9Kk/YdZKdPyyvDDLWOAwaCuTSUuq3kJY/rCilVhfCjfz8eHcMT/LHNrA==
X-Received: by 2002:a62:2703:: with SMTP id n3mr14915651pfn.199.1557501587657; 
	Fri, 10 May 2019 08:19:47 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id 19sm5920517pgz.24.2019.05.10.08.19.46
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 08:19:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 08:19:18 -0700
Message-Id: <20190510151944.22981-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510151944.22981-1-richard.henderson@linaro.org>
References: <20190510151944.22981-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42b
Subject: [Qemu-devel] [PULL 01/27] tcg: Add CPUClass::tlb_fill
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

This hook will replace the (user-only mode specific) handle_mmu_fault
hook, and the (system mode specific) tlb_fill function.

The handle_mmu_fault hook was written as if there was a valid
way to recover from an mmu fault, and had 3 possible return states.
In reality, the only valid action is to raise an exception,
return to the main loop, and deliver the SIGSEGV to the guest.

Note that all of the current implementations of handle_mmu_fault
for guests which support linux-user do in fact only ever return 1,
which is the signal to return to the main loop.

Using the hook for system mode requires that all targets be converted,
so for now the hook is (optionally) used only from user-only mode.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qom/cpu.h     |  9 +++++++++
 accel/tcg/user-exec.c | 39 ++++++++++++++-------------------------
 2 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 08abcbd3fe..c1f267b4e0 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -118,6 +118,12 @@ struct TranslationBlock;
  *       will need to do more. If this hook is not implemented then the
  *       default is to call @set_pc(tb->pc).
  * @handle_mmu_fault: Callback for handling an MMU fault.
+ * @tlb_fill: Callback for handling a softmmu tlb miss or user-only
+ *       address fault.  For system mode, if the access is valid, call
+ *       tlb_set_page and return true; if the access is invalid, and
+ *       probe is true, return false; otherwise raise an exception and
+ *       do not return.  For user-only mode, always raise an exception
+ *       and do not return.
  * @get_phys_page_debug: Callback for obtaining a physical address.
  * @get_phys_page_attrs_debug: Callback for obtaining a physical address and the
  *       associated memory transaction attributes to use for the access.
@@ -191,6 +197,9 @@ typedef struct CPUClass {
     void (*synchronize_from_tb)(CPUState *cpu, struct TranslationBlock *tb);
     int (*handle_mmu_fault)(CPUState *cpu, vaddr address, int size, int rw,
                             int mmu_index);
+    bool (*tlb_fill)(CPUState *cpu, vaddr address, int size,
+                     MMUAccessType access_type, int mmu_idx,
+                     bool probe, uintptr_t retaddr);
     hwaddr (*get_phys_page_debug)(CPUState *cpu, vaddr addr);
     hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu, vaddr addr,
                                         MemTxAttrs *attrs);
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 0789984fe6..199f88c826 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -65,6 +65,7 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
     CPUClass *cc;
     int ret;
     unsigned long address = (unsigned long)info->si_addr;
+    MMUAccessType access_type;
 
     /* We must handle PC addresses from two different sources:
      * a call return address and a signal frame address.
@@ -147,35 +148,23 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
        are still valid segv ones */
     address = h2g_nocheck(address);
 
-    cc = CPU_GET_CLASS(cpu);
-    /* see if it is an MMU fault */
-    g_assert(cc->handle_mmu_fault);
-    ret = cc->handle_mmu_fault(cpu, address, 0, is_write, MMU_USER_IDX);
-
-    if (ret == 0) {
-        /* The MMU fault was handled without causing real CPU fault.
-         *  Retain helper_retaddr for a possible second fault.
-         */
-        return 1;
-    }
-
-    /* All other paths lead to cpu_exit; clear helper_retaddr
-     * for next execution.
+    /*
+     * There is no way the target can handle this other than raising
+     * an exception.  Undo signal and retaddr state prior to longjmp.
      */
+    sigprocmask(SIG_SETMASK, old_set, NULL);
     helper_retaddr = 0;
 
-    if (ret < 0) {
-        return 0; /* not an MMU fault */
+    cc = CPU_GET_CLASS(cpu);
+    if (cc->tlb_fill) {
+        access_type = is_write ? MMU_DATA_STORE : MMU_DATA_LOAD;
+        cc->tlb_fill(cpu, address, 0, access_type, MMU_USER_IDX, false, pc);
+        g_assert_not_reached();
+    } else {
+        ret = cc->handle_mmu_fault(cpu, address, 0, is_write, MMU_USER_IDX);
+        g_assert(ret > 0);
+        cpu_loop_exit_restore(cpu, pc);
     }
-
-    /* Now we have a real cpu fault.  */
-    cpu_restore_state(cpu, pc, true);
-
-    sigprocmask(SIG_SETMASK, old_set, NULL);
-    cpu_loop_exit(cpu);
-
-    /* never comes here */
-    return 1;
 }
 
 #if defined(__i386__)
-- 
2.17.1


