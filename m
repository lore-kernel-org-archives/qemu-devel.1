Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC40C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:16:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B3FD206EC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uMBhtMfd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3FD206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igyfW-0001jB-PH
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 17:16:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igyb8-0004t9-Q1
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igyb6-00070N-Vc
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:14 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:41848)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igyb6-0006zy-Ne
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:12 -0500
Received: by mail-pg1-x541.google.com with SMTP id x8so4494282pgk.8
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 14:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uB1yLwtWzwXzHBHtzMIQQis21sgQatB5l68T1HO/TXw=;
 b=uMBhtMfd8rigRwDaQd0LZZZ1zMBdx6bCQ3JDEPqM5IbmHb3xCnPQZMFmKPWIPWdJ7m
 5m/qsKmAVXC6pPSglsD/dg0aDpr8wX/cSXvL3knCoiXzXA1rHhwoR6IT3Tab+emR1bhi
 1UXicdCE+YV97aw8V1iN+ro9LZvgrqhaI8geqiCLMUW3kAHtpCpzdHF6ldNBnjBAx+Xq
 MAnQekIKmM9D23+X3lY3CEHB6x+Wp44kWDLDZ/t3re5yBIzdYLLfWdas3WKfo+12rVin
 lqP1JIqPmbcLRhI5WmtpIBXbevGk6+LxlTKchQMugssmNM45b6xpiBKhh19cTxA5kCBT
 f9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uB1yLwtWzwXzHBHtzMIQQis21sgQatB5l68T1HO/TXw=;
 b=hFn/O5HjlsIcpO9eeBxnxH+jBGn9kNvLvOIsU6Pu2esorH8fgo9Nhi75z9F6sEOVzA
 9a+5xRQ+J6axBvG2xmSBahXMCfnr0kz0RhB9NsbZ8hODVxApO6OW/QyBQFDBSvVE9bnh
 Nsm2xD9bpAcRxf14XmzFBIgg3nOb3gnihOoAsf1NNX/htaG0fvbIv6aekmYurSXK0nsX
 FeKjySGKELf3D1kB8SDhpdf4BMHY2lq6l9EZy4KcN2gUOCaUAEqnxln3G4Qm6WNPoF66
 ZkUc5ReVlawKLgEVjQA1ro8bwrgbVVolWLBh5WhdPTMrbrhZdNoqlwV1UKOVMwYHE9kP
 WE7g==
X-Gm-Message-State: APjAAAW5pguKvXogTdd0xQjRgsXjh1lcomVdv6Cw7AfnvkYUKN6yr29q
 lgIKvaSDkUKGgtX3sduJ+gtGmWahOs8=
X-Google-Smtp-Source: APXvYqzqdPlRuYtlGYn+z5YARWx/58ImJ58xOa3UgNLyDz1rO13ATViJjM9kFzDu10GDomsSLC4TvQ==
X-Received: by 2002:a63:f844:: with SMTP id v4mr20627254pgj.71.1576534331237; 
 Mon, 16 Dec 2019 14:12:11 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d6sm529767pjl.8.2019.12.16.14.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 14:12:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/28] cputlb: Rename helper_ret_ld*_cmmu to cpu_ld*_code
Date: Mon, 16 Dec 2019 12:11:36 -1000
Message-Id: <20191216221158.29572-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216221158.29572-1-richard.henderson@linaro.org>
References: <20191216221158.29572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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


