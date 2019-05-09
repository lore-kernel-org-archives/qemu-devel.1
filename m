Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCE7C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72C67216C4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ndcfxVaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C67216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48565 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOcAj-00076Q-LR
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 02:04:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc8q-0005v8-K1
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:02:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc8p-00070I-En
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:02:52 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOc8p-0006zu-5M
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:02:51 -0400
Received: by mail-pg1-x544.google.com with SMTP id z16so617152pgv.11
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 23:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=Beo6inO//WJ/P87zouheT0EPWAODR9kofCctnu88ZHk=;
	b=ndcfxVaTyswjTBmIPmeWAYCCgZQ3qml/I2wyFk6fNPP816QWeSIiT/yPE+ky/PIdea
	Nghm8PO3ZmGbOn7fGR8kGRzJP3eghNXokUJuAY4CbDYl0tmL9FJqcPOk/YGo0jicS/0D
	RcxxKENjw5mHASi/MDyvJ8Ss2sPaXQ8h4x4gasxevcTNpIARs231xDDFz7bqg1ionmUV
	CXGKSWgn/YNmv1KCVEBIbNFqVlWdmd6CwAy0NBSrTdr3yUmsnYLVbzHcxBKrxlKEzJYH
	9JugZhcj5s6RhSq8A+PLs6FUCACZHxihZzkO5YR7lO5IlRTGRbmJySpDYabCy+y5gakZ
	8Cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Beo6inO//WJ/P87zouheT0EPWAODR9kofCctnu88ZHk=;
	b=P7PgfeoRIQzVwR+fHorCAFtFgtSC6ue90QjnZSrBqUBfKBvl/2o80bi69iVZAvI7cY
	XaslC1kCGgD/Ol8/nV0uW+3a5WikehNMq0cuPfuDLeoUh1RDolz7WmmjG2NPulMONL1O
	MJKk3rOCRIXRA7/BBFHrdERtV66esYqsZ+eEWDUUHkfI9FrqyKuS8oHoqERK6YZF9U3e
	u9FbJ68f/8HJu64+t7a7zViedS8TI9QTUbmSVg69JF3gK0lpbi8lpycPK8cuBZJfQL5X
	DrpT/l1YUqFEniop3WdnVfTE9Tc8u8RrcbJyZ1HbGiWzf7bBmyyy6GPVjw6JaiN2gUdI
	3qjQ==
X-Gm-Message-State: APjAAAWzrP8G06TYfMtCD1kuFfWC/x9tvEpfEw4mKRMFob5gb+IVrF9N
	AXXmPswmMR2mHzxOEkweLOSa4rBvjF0=
X-Google-Smtp-Source: APXvYqzmmyDZRaP4fWiZDXmCebP6yfwNDAeLerJGqBA/Aa/5iAkpL8CGxB5O1k6un/TCqRSZOSq36Q==
X-Received: by 2002:a65:4c86:: with SMTP id m6mr3104123pgt.75.1557381769794;
	Wed, 08 May 2019 23:02:49 -0700 (PDT)
Received: from localhost.localdomain (97-113-27-95.tukw.qwest.net.
	[97.113.27.95])
	by smtp.gmail.com with ESMTPSA id n7sm1496109pff.45.2019.05.08.23.02.48
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 23:02:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  8 May 2019 23:02:20 -0700
Message-Id: <20190509060246.4031-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509060246.4031-1-richard.henderson@linaro.org>
References: <20190509060246.4031-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v2 01/27] tcg: Add CPUClass::tlb_fill
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


