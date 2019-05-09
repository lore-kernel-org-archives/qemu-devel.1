Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48496C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0248A2173C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x7C7VdUR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0248A2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33529 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOrcj-0006AA-59
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 18:34:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrUr-0007Vi-Ns
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrUq-0005Mr-KN
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:37 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOrUq-0005Ma-E8
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:36 -0400
Received: by mail-pg1-x542.google.com with SMTP id 145so1916389pgg.9
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 15:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=7ZAIu4sKS6YB4WebUUhTxA56tE0hF5se6ULN034aZNQ=;
	b=x7C7VdUR/J75eALT7laVxfbag0DNejwYdKa1FQi1YfsU5rw7mEhcs/G2Tn52tQR0Jk
	8wfpxpSfT1KfGA02VsKNsDh6sR2sgb8WpmqI3I++ZqKX6jACMmh6x38yuvn0E4qel5mO
	vtI7kZBBGmUTq7O32LKgnuwJQwVH1uROLPn+zIdBTIi3/qR/pxRerZXK4zmD6ZunYXwB
	1dVQ4j46dwKAvMjRFY6G4QMngs+WkU7zMTx+K18Ba/AvctbusToTIur84dC3VISrnL43
	bSqMddxCXyTwJGYbS17qbfRN2lyyZKp3XYyDV6T+qWL2Ow3rUS/r02Q3c8+2aR11WyDK
	ka3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=7ZAIu4sKS6YB4WebUUhTxA56tE0hF5se6ULN034aZNQ=;
	b=fAcBkdrTwW72Qs/D/xzsDNyVVXrG3gLY4v5BOh8s2U3flVakhSPJn3gnOQMb2kEAeY
	ae0ZOnKs17BmeJVBZCqce2RjmYtk7Uj2kmZ2hW0Wm7jHxPXRbcb5l3JfB5f6AiT2dM8d
	8PwUbSQFSLkg0e3Hke8s3XdcvUuzRp+tAa/1e1Mi3Wwu+0Au/2a9SGezLM1mEgvgrIXS
	XNDtB0oiLhvTjWQvamoIWv10u4k7Pu0hZmnQpznXBf+Tm2cNruse3BKCify297LTWPwL
	Um4iM2uQx6mXyVstZDz7EmUVjMDqG8vrq3i2I3uMRxK/Oe/+2Z7ld1PkG1AigzacoReD
	xWXw==
X-Gm-Message-State: APjAAAVlNfOczWncHBZ6hPxkjZZitICPq7tkbVLuBXoPc08QyXLdKyA4
	xfhvCPbRHC+uUE+d2BkcaZcqL8InhuU=
X-Google-Smtp-Source: APXvYqyyEjm37f/QnYr/uejeCMMjlx3vp1L3LnYaL+w+gWz/GJ1FVLYiSkMbYk8BUivF+AMimJXraA==
X-Received: by 2002:a63:1d05:: with SMTP id d5mr8881169pgd.157.1557440795175; 
	Thu, 09 May 2019 15:26:35 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m2sm4490521pfi.24.2019.05.09.15.26.34
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 15:26:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 15:26:05 -0700
Message-Id: <20190509222631.14271-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509222631.14271-1-richard.henderson@linaro.org>
References: <20190509222631.14271-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v3 01/27] tcg: Add CPUClass::tlb_fill
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


