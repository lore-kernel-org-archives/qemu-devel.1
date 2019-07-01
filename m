Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83EAC06513
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 981BF21479
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E1d+/6sS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981BF21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi4BW-0005VJ-Rg
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 17:50:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46823)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3HL-00044k-G9
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3HH-00034y-Ic
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:51:57 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:34376)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3HF-000321-Sb
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:51:55 -0400
Received: by mail-wr1-f44.google.com with SMTP id u18so7121749wru.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 13:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=hbpFTS+wT4M13YQ/zISzNiEibHqtCKZT/nQxMRw1Pcg=;
 b=E1d+/6sSdVBAYdDzUpYiMSy4yFSMjeioFYXnlXj2QIRHJhhbw/Qo0o3g63tBGSnA0h
 vh+xpd4t0RUXpfD+63fEPEgEqgeSTeI/spqeYbBdSdx+DrgDlQnhbYiEscFpkWsOeDUn
 xp6h5HII2rvNIZdy9vFvndd4RkjGQHPNpRoWU8FZOt1DlZ+4UL2gC8b2xyv9enTs+oNv
 4Dln8R3/wIeiSolYgYhDUlbNcyMUyZ+9+yTDne0tUeE96wpoxQw7G9NHZpcT8qiraqI9
 Y4p6VmQ/VPba6mUDGjUoBT3nK5XyH5HyvDjj38BosLKwdZNIYSbYW8rI+Fqt8J0E5GSV
 2UiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hbpFTS+wT4M13YQ/zISzNiEibHqtCKZT/nQxMRw1Pcg=;
 b=QZZ6nTIeqxRL3EJV7FXmkxdWzH8eE1YTbFu7tPcqIBXdpV1t/MbwcOKKqtMDxOFgl/
 oJvZkgs+jODqvbUMOGZwywxb71r5oj1uVRwJxTmsVLTQM3PMGxAxD7A9CJ/Pp7fZqxUl
 VHr4glrh5SkXos92wewAzufeu9eLW7J8+IodWcFpr7vboE8kXKWQt3fVjzCLVrh7rS96
 pLQaJj9FzUszRozMmBu30y9sDiSFSuOewRp0YIKfA+zn3mCY0vmAklBnIY4PROD7t5Lu
 O3tXKrtEBI/sycyvh5rBlFk5EmPBazVvIsqSzXKyqRJOv99iZEYI6zr0VBf9jknYPN2y
 SoVg==
X-Gm-Message-State: APjAAAX8EwpDxrDhxvOMnGyfsjcDlsGm/b7MOC2UCM3KekdxuoWmVaYF
 HJCJgCZF4Bu7AjOUynuc5pIEWQHzh0UxTA==
X-Google-Smtp-Source: APXvYqyjUQQAnp4H1fJsYyRMoCFKChwcphDr9xBcvLmRk9pamCIOzHeAbAaa08UTqylS+mS3y93qCg==
X-Received: by 2002:adf:e947:: with SMTP id m7mr8962187wrn.123.1561999235176; 
 Mon, 01 Jul 2019 09:40:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.40.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:40:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:42 +0100
Message-Id: <20190701163943.22313-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.44
Subject: [Qemu-devel] [PULL 45/46] target/arm: Declare arm_log_exception()
 function publicly
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

In few commits we will split the M-profile functions from this
file, and this function will also be called in the new file.
Declare it in the "internals.h" header.
Since it is in the middle of a block of M profile functions,
move it previous to this block to ease the later refactor.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190701132516.26392-21-philmd@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h |  2 ++
 target/arm/helper.c    | 76 +++++++++++++++++++++---------------------
 2 files changed, 40 insertions(+), 38 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 57e0253ef48..11bfdba5129 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1000,6 +1000,8 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
                    target_ulong *page_size,
                    ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs);
 
+void arm_log_exception(int idx);
+
 #endif /* !CONFIG_USER_ONLY */
 
 #endif
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4ef908c611e..dc880b4dabc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7695,6 +7695,44 @@ uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
     return target_el;
 }
 
+void arm_log_exception(int idx)
+{
+    if (qemu_loglevel_mask(CPU_LOG_INT)) {
+        const char *exc = NULL;
+        static const char * const excnames[] = {
+            [EXCP_UDEF] = "Undefined Instruction",
+            [EXCP_SWI] = "SVC",
+            [EXCP_PREFETCH_ABORT] = "Prefetch Abort",
+            [EXCP_DATA_ABORT] = "Data Abort",
+            [EXCP_IRQ] = "IRQ",
+            [EXCP_FIQ] = "FIQ",
+            [EXCP_BKPT] = "Breakpoint",
+            [EXCP_EXCEPTION_EXIT] = "QEMU v7M exception exit",
+            [EXCP_KERNEL_TRAP] = "QEMU intercept of kernel commpage",
+            [EXCP_HVC] = "Hypervisor Call",
+            [EXCP_HYP_TRAP] = "Hypervisor Trap",
+            [EXCP_SMC] = "Secure Monitor Call",
+            [EXCP_VIRQ] = "Virtual IRQ",
+            [EXCP_VFIQ] = "Virtual FIQ",
+            [EXCP_SEMIHOST] = "Semihosting call",
+            [EXCP_NOCP] = "v7M NOCP UsageFault",
+            [EXCP_INVSTATE] = "v7M INVSTATE UsageFault",
+            [EXCP_STKOF] = "v8M STKOF UsageFault",
+            [EXCP_LAZYFP] = "v7M exception during lazy FP stacking",
+            [EXCP_LSERR] = "v8M LSERR UsageFault",
+            [EXCP_UNALIGNED] = "v7M UNALIGNED UsageFault",
+        };
+
+        if (idx >= 0 && idx < ARRAY_SIZE(excnames)) {
+            exc = excnames[idx];
+        }
+        if (!exc) {
+            exc = "unknown";
+        }
+        qemu_log_mask(CPU_LOG_INT, "Taking exception %d [%s]\n", idx, exc);
+    }
+}
+
 /*
  * Return true if the v7M CPACR permits access to the FPU for the specified
  * security state and privilege level.
@@ -9434,44 +9472,6 @@ static bool do_v7m_function_return(ARMCPU *cpu)
     return true;
 }
 
-static void arm_log_exception(int idx)
-{
-    if (qemu_loglevel_mask(CPU_LOG_INT)) {
-        const char *exc = NULL;
-        static const char * const excnames[] = {
-            [EXCP_UDEF] = "Undefined Instruction",
-            [EXCP_SWI] = "SVC",
-            [EXCP_PREFETCH_ABORT] = "Prefetch Abort",
-            [EXCP_DATA_ABORT] = "Data Abort",
-            [EXCP_IRQ] = "IRQ",
-            [EXCP_FIQ] = "FIQ",
-            [EXCP_BKPT] = "Breakpoint",
-            [EXCP_EXCEPTION_EXIT] = "QEMU v7M exception exit",
-            [EXCP_KERNEL_TRAP] = "QEMU intercept of kernel commpage",
-            [EXCP_HVC] = "Hypervisor Call",
-            [EXCP_HYP_TRAP] = "Hypervisor Trap",
-            [EXCP_SMC] = "Secure Monitor Call",
-            [EXCP_VIRQ] = "Virtual IRQ",
-            [EXCP_VFIQ] = "Virtual FIQ",
-            [EXCP_SEMIHOST] = "Semihosting call",
-            [EXCP_NOCP] = "v7M NOCP UsageFault",
-            [EXCP_INVSTATE] = "v7M INVSTATE UsageFault",
-            [EXCP_STKOF] = "v8M STKOF UsageFault",
-            [EXCP_LAZYFP] = "v7M exception during lazy FP stacking",
-            [EXCP_LSERR] = "v8M LSERR UsageFault",
-            [EXCP_UNALIGNED] = "v7M UNALIGNED UsageFault",
-        };
-
-        if (idx >= 0 && idx < ARRAY_SIZE(excnames)) {
-            exc = excnames[idx];
-        }
-        if (!exc) {
-            exc = "unknown";
-        }
-        qemu_log_mask(CPU_LOG_INT, "Taking exception %d [%s]\n", idx, exc);
-    }
-}
-
 static bool v7m_read_half_insn(ARMCPU *cpu, ARMMMUIdx mmu_idx,
                                uint32_t addr, uint16_t *insn)
 {
-- 
2.20.1


