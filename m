Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DC5C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:03:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD292173E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F9iDsB7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD292173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifFgq-0002fr-7v
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 23:03:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFem-0000oF-Is
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:00:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFeh-0003uq-1c
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:00:52 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:45132)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifFeg-0003tY-Mr
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:00:46 -0500
Received: by mail-pg1-x534.google.com with SMTP id b9so417577pgk.12
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 20:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=RS/kUrwws8zXejELfRCwC8ziQ//v3quP81JyrfoDA60=;
 b=F9iDsB7Mn0c/k4ZKeJ3Ysn6AGExwr3Rv4/aPajVYuHHak88C66WMJPG0+ms66DvvhF
 64znF4Pc+S+ptNTyvXV+wIA6uhawyO+ON9URMfqmTkLSLS/PbSUA5G/GPfbgGFTKDny+
 2fg4SKtgjxFsxLBI+wzNvXLh8rmAqD6Yrp+MT4Z4xFW5FYvPLJD1JOduJO+E2YNfN23E
 KfKlWxnRF57NIS4gXNd3SsVl992PQzXX8pkKmj16GtEPwc1X0w4HHmwWBwsUPyqItGQ6
 U23MWejZIYAcIvEIhbMpe89+WikncNjvmThgjAWIWyAj8dsjiz2IP5mDj93Cj+XRHmoX
 cALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RS/kUrwws8zXejELfRCwC8ziQ//v3quP81JyrfoDA60=;
 b=MjueqqpiiSKmvyN5yHHHl84yoqcWERd0u3/7+93O7tpHjel3zOrB1p49Ar5DlCRsLe
 msFishFa9b9g2SZx68OZpKoGFfhQDUT0EYHGRPjYIqT1JXCxVXlwEWz1GSVDbVHASSh7
 FZWTCHclBLbbCq9A93N8lAuPQT3MQNAoUIcGtaLgZvqA4M8ot1z3wIBDrIxVd0fr9tkq
 g7UtZSvWaGWqGs58SKfCgYkHDzqJ+uTrPxU2CgCZqo3Q7AZ4sMazBrqlMRax+B+I3h3E
 rzoY6+CZl9azYL2uKA9muJ3R0639vRe/RvBBdeo/mlWyDhrTDjrpGmMPuxKSjqkimAJy
 RMnw==
X-Gm-Message-State: APjAAAXx2yGC6VUxzZ/nDemMN1ovCW+SFYEP3fp7p6D/IKz/10UeD+sT
 lSP8veP1gNu8/tXpdm4d6b9Bd9IFLu4=
X-Google-Smtp-Source: APXvYqxwsgK+iu5Ds2jgFfiO4Y7nnDtFL377qwQmMGVHxr7VNAb4VbPLRDpBhGa1o2WDJPAAdYtYcw==
X-Received: by 2002:aa7:9351:: with SMTP id 17mr7501075pfn.16.1576123245142;
 Wed, 11 Dec 2019 20:00:45 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z130sm4666391pgz.6.2019.12.11.20.00.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 20:00:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/28] trace: Remove trace_mem_build_info_no_se_[bl]e
Date: Wed, 11 Dec 2019 20:00:14 -0800
Message-Id: <20191212040039.26546-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212040039.26546-1-richard.henderson@linaro.org>
References: <20191212040039.26546-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::534
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

It is easy for the atomic helpers to use trace_mem_build_info
directly, without resorting to symbol pasting.  For this usage,
we cannot use trace_mem_get_info, because the MemOp does not
support 16-byte accesses.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/atomic_template.h | 67 +++++++++++++------------------------
 trace/mem-internal.h        | 17 ----------
 2 files changed, 24 insertions(+), 60 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 837676231f..26969487d6 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -64,13 +64,10 @@
    the ATOMIC_NAME macro, and redefined below.  */
 #if DATA_SIZE == 1
 # define END
-# define MEND _be /* either le or be would be fine */
 #elif defined(HOST_WORDS_BIGENDIAN)
 # define END  _be
-# define MEND _be
 #else
 # define END  _le
-# define MEND _le
 #endif
 
 ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
@@ -79,8 +76,8 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     DATA_TYPE ret;
-    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false,
-                                                           ATOMIC_MMU_IDX);
+    uint16_t info = trace_mem_build_info(SHIFT, false, 0, false,
+                                         ATOMIC_MMU_IDX);
 
     atomic_trace_rmw_pre(env, addr, info);
 #if DATA_SIZE == 16
@@ -99,8 +96,8 @@ ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE val, *haddr = ATOMIC_MMU_LOOKUP;
-    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false,
-                                                           ATOMIC_MMU_IDX);
+    uint16_t info = trace_mem_build_info(SHIFT, false, 0, false,
+                                         ATOMIC_MMU_IDX);
 
     atomic_trace_ld_pre(env, addr, info);
     val = atomic16_read(haddr);
@@ -114,8 +111,8 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
-    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, true,
-                                                          ATOMIC_MMU_IDX);
+    uint16_t info = trace_mem_build_info(SHIFT, false, 0, true,
+                                         ATOMIC_MMU_IDX);
 
     atomic_trace_st_pre(env, addr, info);
     atomic16_set(haddr, val);
@@ -130,8 +127,8 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     DATA_TYPE ret;
-    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false,
-                                                          ATOMIC_MMU_IDX);
+    uint16_t info = trace_mem_build_info(SHIFT, false, 0, false,
+                                         ATOMIC_MMU_IDX);
 
     atomic_trace_rmw_pre(env, addr, info);
     ret = atomic_xchg__nocheck(haddr, val);
@@ -147,10 +144,8 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
     ATOMIC_MMU_DECLS;                                               \
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                           \
     DATA_TYPE ret;                                                  \
-    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT,   \
-                                                           false,   \
-                                                           ATOMIC_MMU_IDX); \
-                                                                    \
+    uint16_t info = trace_mem_build_info(SHIFT, false, 0, false,    \
+                                         ATOMIC_MMU_IDX);           \
     atomic_trace_rmw_pre(env, addr, info);                          \
     ret = atomic_##X(haddr, val);                                   \
     ATOMIC_MMU_CLEANUP;                                             \
@@ -183,10 +178,8 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
     ATOMIC_MMU_DECLS;                                               \
     XDATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                          \
     XDATA_TYPE cmp, old, new, val = xval;                           \
-    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT,   \
-                                                           false,   \
-                                                           ATOMIC_MMU_IDX); \
-                                                                    \
+    uint16_t info = trace_mem_build_info(SHIFT, false, 0, false,    \
+                                         ATOMIC_MMU_IDX);           \
     atomic_trace_rmw_pre(env, addr, info);                          \
     smp_mb();                                                       \
     cmp = atomic_read__nocheck(haddr);                              \
@@ -213,7 +206,6 @@ GEN_ATOMIC_HELPER_FN(umax_fetch, MAX,  DATA_TYPE, new)
 #endif /* DATA SIZE >= 16 */
 
 #undef END
-#undef MEND
 
 #if DATA_SIZE > 1
 
@@ -221,10 +213,8 @@ GEN_ATOMIC_HELPER_FN(umax_fetch, MAX,  DATA_TYPE, new)
    within the ATOMIC_NAME macro.  */
 #ifdef HOST_WORDS_BIGENDIAN
 # define END  _le
-# define MEND _le
 #else
 # define END  _be
-# define MEND _be
 #endif
 
 ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
@@ -233,9 +223,8 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     DATA_TYPE ret;
-    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT,
-                                                           false,
-                                                           ATOMIC_MMU_IDX);
+    uint16_t info = trace_mem_build_info(SHIFT, false, MO_BSWAP, false,
+                                         ATOMIC_MMU_IDX);
 
     atomic_trace_rmw_pre(env, addr, info);
 #if DATA_SIZE == 16
@@ -254,9 +243,8 @@ ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE val, *haddr = ATOMIC_MMU_LOOKUP;
-    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT,
-                                                           false,
-                                                           ATOMIC_MMU_IDX);
+    uint16_t info = trace_mem_build_info(SHIFT, false, MO_BSWAP, false,
+                                         ATOMIC_MMU_IDX);
 
     atomic_trace_ld_pre(env, addr, info);
     val = atomic16_read(haddr);
@@ -270,9 +258,8 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
-    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT,
-                                                           true,
-                                                           ATOMIC_MMU_IDX);
+    uint16_t info = trace_mem_build_info(SHIFT, false, MO_BSWAP, true,
+                                         ATOMIC_MMU_IDX);
 
     val = BSWAP(val);
     atomic_trace_st_pre(env, addr, info);
@@ -289,9 +276,8 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     ABI_TYPE ret;
-    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT,
-                                                           false,
-                                                           ATOMIC_MMU_IDX);
+    uint16_t info = trace_mem_build_info(SHIFT, false, MO_BSWAP, false,
+                                         ATOMIC_MMU_IDX);
 
     atomic_trace_rmw_pre(env, addr, info);
     ret = atomic_xchg__nocheck(haddr, BSWAP(val));
@@ -307,10 +293,8 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
     ATOMIC_MMU_DECLS;                                               \
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                           \
     DATA_TYPE ret;                                                  \
-    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT,   \
-                                                           false,   \
-                                                           ATOMIC_MMU_IDX); \
-                                                                    \
+    uint16_t info = trace_mem_build_info(SHIFT, false, MO_BSWAP,    \
+                                         false, ATOMIC_MMU_IDX);    \
     atomic_trace_rmw_pre(env, addr, info);                          \
     ret = atomic_##X(haddr, BSWAP(val));                            \
     ATOMIC_MMU_CLEANUP;                                             \
@@ -341,10 +325,8 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
     ATOMIC_MMU_DECLS;                                               \
     XDATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                          \
     XDATA_TYPE ldo, ldn, old, new, val = xval;                      \
-    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT,   \
-                                                           false,   \
-                                                           ATOMIC_MMU_IDX); \
-                                                                    \
+    uint16_t info = trace_mem_build_info(SHIFT, false, MO_BSWAP,    \
+                                         false, ATOMIC_MMU_IDX);    \
     atomic_trace_rmw_pre(env, addr, info);                          \
     smp_mb();                                                       \
     ldn = atomic_read__nocheck(haddr);                              \
@@ -378,7 +360,6 @@ GEN_ATOMIC_HELPER_FN(add_fetch, ADD, DATA_TYPE, new)
 #endif /* DATA_SIZE >= 16 */
 
 #undef END
-#undef MEND
 #endif /* DATA_SIZE > 1 */
 
 #undef BSWAP
diff --git a/trace/mem-internal.h b/trace/mem-internal.h
index 0a32aa22ca..8b72b678fa 100644
--- a/trace/mem-internal.h
+++ b/trace/mem-internal.h
@@ -47,21 +47,4 @@ static inline uint16_t trace_mem_get_info(MemOp op,
                                 mmu_idx);
 }
 
-/* Used by the atomic helpers */
-static inline
-uint16_t trace_mem_build_info_no_se_be(int size_shift, bool store,
-                                       TCGMemOpIdx oi)
-{
-    return trace_mem_build_info(size_shift, false, MO_BE, store,
-                                get_mmuidx(oi));
-}
-
-static inline
-uint16_t trace_mem_build_info_no_se_le(int size_shift, bool store,
-                                       TCGMemOpIdx oi)
-{
-    return trace_mem_build_info(size_shift, false, MO_LE, store,
-                                get_mmuidx(oi));
-}
-
 #endif /* TRACE__MEM_INTERNAL_H */
-- 
2.20.1


