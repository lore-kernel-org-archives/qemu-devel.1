Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F9BC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:50:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B1A2070A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tx17hTwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B1A2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2ML-0000Q0-8k
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 22:50:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2IB-0003Ux-7m
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2I9-0002px-N2
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:59 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:40963)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2I9-0002pa-Gj
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:57 -0500
Received: by mail-pg1-x52c.google.com with SMTP id x8so863023pgk.8
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q5vJOghVRdDlALEm4T0uJnn6jnvHJUhH0NdnFSF4Cms=;
 b=tx17hTwWYwvWeMVgoT3IqrD/6BB2/tDQy4cHBLJ2H9RwjPIlJ/gj+3GQI+qvwRYG4i
 s7qpMpgLouTOH3bqIIE6gK6FsoGgQNZsO9rxQvKEnYV0m4zCqcRMOe9yuWZYXcVdxDrX
 kQvkbf48v8A1IOjSYb5tW6Cn8EhXTJrmmqbgM8uQD3yv+ysA/C/6qNwn1w07WI8iBQR8
 71UXNut/VKmKby5H2tvBLKflnL6ZStDs4zy85et/sLNxMJRRco6tE8YfvYbpdt7bbjqV
 MVcgQcZdS9BPtuJ/JDqSp9TgxVfQtE+4F7a61pmELqEGFyxPEPaZfTnheks/+DlIr1k9
 TsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q5vJOghVRdDlALEm4T0uJnn6jnvHJUhH0NdnFSF4Cms=;
 b=Ro7SXeXuNpNxIQZ40ypSm2d2aahKd5ZxZm7P45Di2CqvPofrGJ0HIZIA9o5ip7h3EX
 HHMLKKrA7BLiFScp1/Vfwe4/yslQScwUTxMku6+KU3SSkj/2uJUAA8FflZ1+VaOPF6Jj
 uwwdYA+U0QPLS16IXOoEd4BLE6OqlZsw0kdTM7NoW4827Y6TmDsXFaqJPKSBhuE8CRXy
 ePoW2Q2KhSTzSJ4xr+wdotxjgzbmuM4eV1UZq2DF1TZk9SqaUp1WBPFA+gapYXlliRF8
 SlzrR76ex6SnqiZDU1cpKoW1I3cKau/IkkVNu0+ScFPfNQqHDGGGHLdNRV/5bkma67/A
 SQ7w==
X-Gm-Message-State: APjAAAU5hg+uR0XDKPIubXCr23cGO4jh4a1yepfDigPE5MeYrkTJAuwx
 QsIfWnHgwWyV17LXQSjpJOl/QDBec9swdw==
X-Google-Smtp-Source: APXvYqyQaXc6n1heufnWPu4yDSl+8EnfnhPPwXEM8YItuc26qa03ytltFdBroTdBc132isPfzq5BvA==
X-Received: by 2002:a62:5214:: with SMTP id g20mr2831546pfb.101.1578455156217; 
 Tue, 07 Jan 2020 19:45:56 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:45:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/41] cputlb: Use trace_mem_get_info instead of
 trace_mem_build_info
Date: Wed,  8 Jan 2020 14:44:51 +1100
Message-Id: <20200108034523.17349-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52c
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the cpu_ldst templates, we already require a MemOp, and it
is cleaner and clearer to pass that instead of 3 separate
arguments describing the memory operation.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst_template.h          | 22 +++++++++++-----------
 include/exec/cpu_ldst_useronly_template.h | 12 ++++++------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
index 54b5e858ce..0ad5de3ef9 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -86,9 +86,9 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     RES_TYPE res;
     target_ulong addr;
     int mmu_idx = CPU_MMU_INDEX;
-    TCGMemOpIdx oi;
+    MemOp op = MO_TE | SHIFT;
 #if !defined(SOFTMMU_CODE_ACCESS)
-    uint16_t meminfo = trace_mem_build_info(SHIFT, false, MO_TE, false, mmu_idx);
+    uint16_t meminfo = trace_mem_get_info(op, mmu_idx, false);
     trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
 #endif
 
@@ -96,9 +96,9 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     entry = tlb_entry(env, mmu_idx, addr);
     if (unlikely(entry->ADDR_READ !=
                  (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
-        oi = make_memop_idx(SHIFT, mmu_idx);
+        TCGMemOpIdx oi = make_memop_idx(op, mmu_idx);
         res = glue(glue(helper_ret_ld, URETSUFFIX), MMUSUFFIX)(env, addr,
-                                                            oi, retaddr);
+                                                               oi, retaddr);
     } else {
         uintptr_t hostaddr = addr + entry->addend;
         res = glue(glue(ld, USUFFIX), _p)((uint8_t *)hostaddr);
@@ -125,9 +125,9 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     int res;
     target_ulong addr;
     int mmu_idx = CPU_MMU_INDEX;
-    TCGMemOpIdx oi;
-#if !defined(SOFTMMU_CODE_ACCESS)
-    uint16_t meminfo = trace_mem_build_info(SHIFT, true, MO_TE, false, mmu_idx);
+    MemOp op = MO_TE | MO_SIGN | SHIFT;
+#ifndef SOFTMMU_CODE_ACCESS
+    uint16_t meminfo = trace_mem_get_info(op, mmu_idx, false);
     trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
 #endif
 
@@ -135,7 +135,7 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     entry = tlb_entry(env, mmu_idx, addr);
     if (unlikely(entry->ADDR_READ !=
                  (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
-        oi = make_memop_idx(SHIFT, mmu_idx);
+        TCGMemOpIdx oi = make_memop_idx(op & ~MO_SIGN, mmu_idx);
         res = (DATA_STYPE)glue(glue(helper_ret_ld, SRETSUFFIX),
                                MMUSUFFIX)(env, addr, oi, retaddr);
     } else {
@@ -167,9 +167,9 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     CPUTLBEntry *entry;
     target_ulong addr;
     int mmu_idx = CPU_MMU_INDEX;
-    TCGMemOpIdx oi;
+    MemOp op = MO_TE | SHIFT;
 #if !defined(SOFTMMU_CODE_ACCESS)
-    uint16_t meminfo = trace_mem_build_info(SHIFT, false, MO_TE, true, mmu_idx);
+    uint16_t meminfo = trace_mem_get_info(op, mmu_idx, true);
     trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
 #endif
 
@@ -177,7 +177,7 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     entry = tlb_entry(env, mmu_idx, addr);
     if (unlikely(tlb_addr_write(entry) !=
                  (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
-        oi = make_memop_idx(SHIFT, mmu_idx);
+        TCGMemOpIdx oi = make_memop_idx(op, mmu_idx);
         glue(glue(helper_ret_st, SUFFIX), MMUSUFFIX)(env, addr, v, oi,
                                                      retaddr);
     } else {
diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index dbdc7a845d..e5a3d1983a 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -70,8 +70,8 @@ glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
     ret = glue(glue(ld, USUFFIX), _p)(g2h(ptr));
     clear_helper_retaddr();
 #else
-    uint16_t meminfo = trace_mem_build_info(SHIFT, false, MO_TE, false,
-                                            MMU_USER_IDX);
+    MemOp op = MO_TE | SHIFT;
+    uint16_t meminfo = trace_mem_get_info(op, MMU_USER_IDX, false);
     trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
     ret = glue(glue(ld, USUFFIX), _p)(g2h(ptr));
 #endif
@@ -102,8 +102,8 @@ glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
     ret = glue(glue(lds, SUFFIX), _p)(g2h(ptr));
     clear_helper_retaddr();
 #else
-    uint16_t meminfo = trace_mem_build_info(SHIFT, true, MO_TE, false,
-                                            MMU_USER_IDX);
+    MemOp op = MO_TE | MO_SIGN | SHIFT;
+    uint16_t meminfo = trace_mem_get_info(op, MMU_USER_IDX, false);
     trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
     ret = glue(glue(lds, SUFFIX), _p)(g2h(ptr));
     qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
@@ -131,8 +131,8 @@ static inline void
 glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr,
                                       RES_TYPE v)
 {
-    uint16_t meminfo = trace_mem_build_info(SHIFT, false, MO_TE, true,
-                                            MMU_USER_IDX);
+    MemOp op = MO_TE | SHIFT;
+    uint16_t meminfo = trace_mem_get_info(op, MMU_USER_IDX, true);
     trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
     glue(glue(st, SUFFIX), _p)(g2h(ptr), v);
     qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
-- 
2.20.1


