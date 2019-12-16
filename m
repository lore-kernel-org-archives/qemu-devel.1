Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2286C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:13:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBB121835
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eifVvz6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBB121835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igycV-0006Tc-7p
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 17:13:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igyb2-0004lE-Ea
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igyb1-0006ve-3I
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:08 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:36998)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igyb0-0006vF-Te
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:07 -0500
Received: by mail-pl1-x62f.google.com with SMTP id c23so5121793plz.4
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 14:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=L1jHeOFQAeKhXPKxXaTdBBGGRizQ9egD6BUcKiL091Y=;
 b=eifVvz6eHqww7voesCY7JTeZsXZHcK2Zo15G/oQBKE7qX2LkmRwuVv0yNpv1gdVwd9
 XDFNP2jdfl/WrZ/0C+64+vbbe7pX2IR8KcY5OUMny3XJxbx4891BomgIaNQ4T30EcVHp
 s3gOQkol14QT1UL8kC+V5fTZR0i6JooCi8Np1A/D4yF6wtKnL8bRg0rrj3R7kOVZcX64
 Xzvxdk9x3M0w+s87kwN3hbYbGIgwgC4+eJk7v6TG1/dfkcP0wK7GsqTxAM+Or1LNz+W1
 7ZOrlDfCrhDn31I2HfxvKnLIS8iQbni0rnhXEfu+6l8D1XVUJ3KMb7zpqZbIN4xqSMkl
 2URQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L1jHeOFQAeKhXPKxXaTdBBGGRizQ9egD6BUcKiL091Y=;
 b=njLxPFo2j5TsTvpTxaWQvgVEpC+BdOsKy0gSylTCngRza55JiagaXEPuL+3i9ZAbxf
 0gQ9GDytK0slPvJgTcBZUoURMUWe5uJuiDIZMUAGctJnTcHnDY3+9HSm9nCdzze6qQmL
 a9DYuEKaphzyGWP8FyjAzpqXxDJNRZM4sf6tBGziR+5xTUhzwHKUWDqW0YBffl2laOnI
 bEvKvZLNFhmB/PePbyR2wvR+oyqFVOD5FzI4lxpYmP1xvxJw/iIHixtV/0uh5yZxtVmy
 BkfK1VOEMnC2GmyxePPtIezib/5d1qj13PJ9rd8UGWZPxheKpKTMyIqpkjC6WRURKv3Q
 +HQQ==
X-Gm-Message-State: APjAAAU/nLqyr6NeT7tangyvt8u1qb+buxTTIwTNsyEb9H0aWfMztxLs
 jyvfsi4nQu+N0LyVOeF6PpuC9nDh79w=
X-Google-Smtp-Source: APXvYqy/nYD+ZeGgth9tx0UPbmWeZO0avXuqC3syiPE0n4r9tFyPwg0r6U1rXWXIhQknwMspd0RDvw==
X-Received: by 2002:a17:90a:c697:: with SMTP id
 n23mr1873320pjt.37.1576534325190; 
 Mon, 16 Dec 2019 14:12:05 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d6sm529767pjl.8.2019.12.16.14.12.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 14:12:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/28] cputlb: Use trace_mem_get_info instead of
 trace_mem_build_info
Date: Mon, 16 Dec 2019 12:11:32 -1000
Message-Id: <20191216221158.29572-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216221158.29572-1-richard.henderson@linaro.org>
References: <20191216221158.29572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62f
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

In the cpu_ldst templates, we already require a MemOp, and it
is cleaner and clearer to pass that instead of 3 separate
arguments describing the memory operation.

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


