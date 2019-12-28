Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B07C2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D8DF20838
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oaf0kdqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8DF20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilLRs-0003f1-4S
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 18:24:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLFk-0004xX-2L
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLFh-0006NT-P0
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:11 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilLFh-0006Iu-GZ
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:09 -0500
Received: by mail-pl1-x643.google.com with SMTP id g6so10250982plp.6
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 15:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uB1yLwtWzwXzHBHtzMIQQis21sgQatB5l68T1HO/TXw=;
 b=Oaf0kdqG4XVtDaaAFhwY5L5HWLyy4FWjCsSpw5I0FVtXxt8cSr7XWd6qTg1nUKssAi
 /IRhTxO24/KQMLH44QAVeiDmhf/jH50vEfXiFNPpDUJxmhRVaVQ3fmR+mqczehZ7xBYN
 H7njpDtWVvjPOX57Y/t672jfLLAwimwanrTz1eEt1GTSiYk0SUKkVJ8X6tkF22UF23gA
 vESkn+ywIilYQokIB7hrHkGJQX2Y1CkZif1Gh8o7UClP7mEM8/0DO+nJXqjXqFlBcqik
 QW2WYXTmVgBD3AE+gzOVy7sgTpNwgZWiGqFW1Ga3UnXr+zE80n9LKJbdQ2BMhw/yp56V
 IJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uB1yLwtWzwXzHBHtzMIQQis21sgQatB5l68T1HO/TXw=;
 b=OYNt9/0838z/NjbxKrzJPsQ1IjFE+KHpD7iaTN1byL6HLPNVdhDwNiI7Cf7CxK9b7+
 LotmGhlL5eLdYp20e9NfpLgtUxjbknDckTLCO2HFpyTCcGl94b1x7FnduYaL4Km79iOB
 xcMaX2NNRHETeXYUMXNoXw2gItPCxi1qqV2CU52irg4RqqjS16dX1BcZzJoBm4SQSgE6
 UP6jPDt9pvcV0YUKGr/L/wrfYETjMAu1CvAqxI4Zukbch+KgbIjo99wUeiVyZL6xSqZs
 hYlTDRfmDfYmFPkyGYTgSwJ7bv2gBnGMMatMKL+BKO5RGhn+bmFQ66M9pmuv/fIM4nJD
 sEvg==
X-Gm-Message-State: APjAAAV2V8cuZa1/a+8vKG+PQZBuciR4hTdfzMGE2umR2xJMmhYgnvAU
 peUnnivQNEzE9tnshekwj4tTVp0YobY=
X-Google-Smtp-Source: APXvYqwW7OvoUH+N+q2jqPhkZlGJeOMgzcySfz2H5JihbreL92SEHVAJQuyygrCLqzaD8k5V0OUacA==
X-Received: by 2002:a17:902:be0e:: with SMTP id
 r14mr3425741pls.194.1577574728086; 
 Sat, 28 Dec 2019 15:12:08 -0800 (PST)
Received: from localhost.localdomain (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id c18sm21077186pfr.40.2019.12.28.15.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2019 15:12:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/29] cputlb: Rename helper_ret_ld*_cmmu to cpu_ld*_code
Date: Sun, 29 Dec 2019 10:11:07 +1100
Message-Id: <20191228231124.18307-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191228231124.18307-1-richard.henderson@linaro.org>
References: <20191228231124.18307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are no uses of the *_cmmu names other than the bare wrapping
within the *_code inlines.  Therefore rename the functions so we
can drop the inlines.

Use abi_ptr instead of target_ulong in preparation for user-only;
the two types are identical for softmmu.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h          | 29 ++++------
 include/exec/cpu_ldst_template.h | 21 -------
 tcg/tcg.h                        | 29 ----------
 accel/tcg/cputlb.c               | 94 ++++++++------------------------
 docs/devel/loads-stores.rst      |  4 +-
 5 files changed, 36 insertions(+), 141 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 399ff6c3da..ef59ed61e4 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -450,25 +450,20 @@ void cpu_stq_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
 #undef CPU_MMU_INDEX
 #undef MEMSUFFIX
 
-#define CPU_MMU_INDEX (cpu_mmu_index(env, true))
-#define MEMSUFFIX _code
-#define SOFTMMU_CODE_ACCESS
+uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr);
+uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr);
+uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr);
+uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr);
 
-#define DATA_SIZE 1
-#include "exec/cpu_ldst_template.h"
+static inline int cpu_ldsb_code(CPUArchState *env, abi_ptr addr)
+{
+    return (int8_t)cpu_ldub_code(env, addr);
+}
 
-#define DATA_SIZE 2
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 4
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 8
-#include "exec/cpu_ldst_template.h"
-
-#undef CPU_MMU_INDEX
-#undef MEMSUFFIX
-#undef SOFTMMU_CODE_ACCESS
+static inline int cpu_ldsw_code(CPUArchState *env, abi_ptr addr)
+{
+    return (int16_t)cpu_lduw_code(env, addr);
+}
 
 #endif /* defined(CONFIG_USER_ONLY) */
 
diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
index ea39e29c19..e400979f23 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -58,25 +58,6 @@
 
 /* generic load/store macros */
 
-#ifdef SOFTMMU_CODE_ACCESS
-
-static inline RES_TYPE
-glue(glue(cpu_ld, USUFFIX), _code)(CPUArchState *env, target_ulong ptr)
-{
-    TCGMemOpIdx oi = make_memop_idx(MO_TE | SHIFT, CPU_MMU_INDEX);
-    return glue(glue(helper_ret_ld, USUFFIX), _cmmu)(env, ptr, oi, 0);
-}
-
-#if DATA_SIZE <= 2
-static inline int
-glue(glue(cpu_lds, SUFFIX), _code)(CPUArchState *env, target_ulong ptr)
-{
-    return (DATA_STYPE)glue(glue(cpu_ld, USUFFIX), _code)(env, ptr);
-}
-#endif
-
-#else
-
 static inline RES_TYPE
 glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
                                                   target_ulong ptr,
@@ -127,8 +108,6 @@ glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr,
     glue(glue(cpu_st, SUFFIX), _mmuidx_ra)(env, ptr, v, CPU_MMU_INDEX, 0);
 }
 
-#endif /* !SOFTMMU_CODE_ACCESS */
-
 #undef RES_TYPE
 #undef DATA_TYPE
 #undef DATA_STYPE
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 92ca10dffc..3b4f79301c 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -1290,27 +1290,6 @@ void helper_be_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
 void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr);
 
-uint8_t helper_ret_ldub_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr);
-int8_t helper_ret_ldsb_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr);
-uint16_t helper_le_lduw_cmmu(CPUArchState *env, target_ulong addr,
-                             TCGMemOpIdx oi, uintptr_t retaddr);
-int16_t helper_le_ldsw_cmmu(CPUArchState *env, target_ulong addr,
-                             TCGMemOpIdx oi, uintptr_t retaddr);
-uint32_t helper_le_ldl_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr);
-uint64_t helper_le_ldq_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr);
-uint16_t helper_be_lduw_cmmu(CPUArchState *env, target_ulong addr,
-                             TCGMemOpIdx oi, uintptr_t retaddr);
-int16_t helper_be_ldsw_cmmu(CPUArchState *env, target_ulong addr,
-                             TCGMemOpIdx oi, uintptr_t retaddr);
-uint32_t helper_be_ldl_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr);
-uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr);
-
 /* Temporary aliases until backends are converted.  */
 #ifdef TARGET_WORDS_BIGENDIAN
 # define helper_ret_ldsw_mmu  helper_be_ldsw_mmu
@@ -1322,10 +1301,6 @@ uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
 # define helper_ret_stw_mmu   helper_be_stw_mmu
 # define helper_ret_stl_mmu   helper_be_stl_mmu
 # define helper_ret_stq_mmu   helper_be_stq_mmu
-# define helper_ret_lduw_cmmu  helper_be_lduw_cmmu
-# define helper_ret_ldsw_cmmu  helper_be_ldsw_cmmu
-# define helper_ret_ldl_cmmu  helper_be_ldl_cmmu
-# define helper_ret_ldq_cmmu  helper_be_ldq_cmmu
 #else
 # define helper_ret_ldsw_mmu  helper_le_ldsw_mmu
 # define helper_ret_lduw_mmu  helper_le_lduw_mmu
@@ -1336,10 +1311,6 @@ uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
 # define helper_ret_stw_mmu   helper_le_stw_mmu
 # define helper_ret_stl_mmu   helper_le_stl_mmu
 # define helper_ret_stq_mmu   helper_le_stq_mmu
-# define helper_ret_lduw_cmmu  helper_le_lduw_cmmu
-# define helper_ret_ldsw_cmmu  helper_le_ldsw_cmmu
-# define helper_ret_ldl_cmmu  helper_le_ldl_cmmu
-# define helper_ret_ldq_cmmu  helper_le_ldq_cmmu
 #endif
 
 uint32_t helper_atomic_cmpxchgb_mmu(CPUArchState *env, target_ulong addr,
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ddd19718bf..f0e4b0aee4 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2028,98 +2028,50 @@ void cpu_stq_mmuidx_ra(CPUArchState *env, target_ulong addr, uint64_t val,
 
 /* Code access functions.  */
 
-static uint64_t full_ldub_cmmu(CPUArchState *env, target_ulong addr,
+static uint64_t full_ldub_code(CPUArchState *env, target_ulong addr,
                                TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, MO_8, true, full_ldub_cmmu);
+    return load_helper(env, addr, oi, retaddr, MO_8, true, full_ldub_code);
 }
 
-uint8_t helper_ret_ldub_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
+uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr)
 {
-    return full_ldub_cmmu(env, addr, oi, retaddr);
+    TCGMemOpIdx oi = make_memop_idx(MO_UB, cpu_mmu_index(env, true));
+    return full_ldub_code(env, addr, oi, 0);
 }
 
-int8_t helper_ret_ldsb_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
+static uint64_t full_lduw_code(CPUArchState *env, target_ulong addr,
+                               TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return (int8_t) full_ldub_cmmu(env, addr, oi, retaddr);
+    return load_helper(env, addr, oi, retaddr, MO_TEUW, true, full_lduw_code);
 }
 
-static uint64_t full_le_lduw_cmmu(CPUArchState *env, target_ulong addr,
-                                  TCGMemOpIdx oi, uintptr_t retaddr)
+uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr)
 {
-    return load_helper(env, addr, oi, retaddr, MO_LEUW, true,
-                       full_le_lduw_cmmu);
+    TCGMemOpIdx oi = make_memop_idx(MO_TEUW, cpu_mmu_index(env, true));
+    return full_lduw_code(env, addr, oi, 0);
 }
 
-uint16_t helper_le_lduw_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
+static uint64_t full_ldl_code(CPUArchState *env, target_ulong addr,
+                              TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return full_le_lduw_cmmu(env, addr, oi, retaddr);
+    return load_helper(env, addr, oi, retaddr, MO_TEUL, true, full_ldl_code);
 }
 
-int16_t helper_le_ldsw_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
+uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr)
 {
-    return (int16_t) full_le_lduw_cmmu(env, addr, oi, retaddr);
+    TCGMemOpIdx oi = make_memop_idx(MO_TEUL, cpu_mmu_index(env, true));
+    return full_ldl_code(env, addr, oi, 0);
 }
 
-static uint64_t full_be_lduw_cmmu(CPUArchState *env, target_ulong addr,
-                                  TCGMemOpIdx oi, uintptr_t retaddr)
+static uint64_t full_ldq_code(CPUArchState *env, target_ulong addr,
+                              TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, MO_BEUW, true,
-                       full_be_lduw_cmmu);
+    return load_helper(env, addr, oi, retaddr, MO_TEQ, true, full_ldq_code);
 }
 
-uint16_t helper_be_lduw_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
+uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
 {
-    return full_be_lduw_cmmu(env, addr, oi, retaddr);
-}
-
-int16_t helper_be_ldsw_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    return (int16_t) full_be_lduw_cmmu(env, addr, oi, retaddr);
-}
-
-static uint64_t full_le_ldul_cmmu(CPUArchState *env, target_ulong addr,
-                                  TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    return load_helper(env, addr, oi, retaddr, MO_LEUL, true,
-                       full_le_ldul_cmmu);
-}
-
-uint32_t helper_le_ldl_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    return full_le_ldul_cmmu(env, addr, oi, retaddr);
-}
-
-static uint64_t full_be_ldul_cmmu(CPUArchState *env, target_ulong addr,
-                                  TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    return load_helper(env, addr, oi, retaddr, MO_BEUL, true,
-                       full_be_ldul_cmmu);
-}
-
-uint32_t helper_be_ldl_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    return full_be_ldul_cmmu(env, addr, oi, retaddr);
-}
-
-uint64_t helper_le_ldq_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    return load_helper(env, addr, oi, retaddr, MO_LEQ, true,
-                       helper_le_ldq_cmmu);
-}
-
-uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    return load_helper(env, addr, oi, retaddr, MO_BEQ, true,
-                       helper_be_ldq_cmmu);
+    TCGMemOpIdx oi = make_memop_idx(MO_TEQ, cpu_mmu_index(env, true));
+    return full_ldq_code(env, addr, oi, 0);
 }
diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index c74cd090e6..8a5bc912a5 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -171,8 +171,6 @@ more in line with the other memory access functions.
 
 load: ``helper_{endian}_ld{sign}{size}_mmu(env, addr, opindex, retaddr)``
 
-load (code): ``helper_{endian}_ld{sign}{size}_cmmu(env, addr, opindex, retaddr)``
-
 store: ``helper_{endian}_st{size}_mmu(env, addr, val, opindex, retaddr)``
 
 ``sign``
@@ -192,7 +190,7 @@ store: ``helper_{endian}_st{size}_mmu(env, addr, val, opindex, retaddr)``
  - ``ret`` : target endianness
 
 Regexes for git grep
- - ``\<helper_\(le\|be\|ret\)_ld[us]\?[bwlq]_c\?mmu\>``
+ - ``\<helper_\(le\|be\|ret\)_ld[us]\?[bwlq]_mmu\>``
  - ``\<helper_\(le\|be\|ret\)_st[bwlq]_mmu\>``
 
 ``address_space_*``
-- 
2.20.1


