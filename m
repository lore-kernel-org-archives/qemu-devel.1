Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EE1C2D0C3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0FE421835
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BtctEVPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FE421835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igycW-0006Wc-Lg
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 17:13:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igyb3-0004mC-S4
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igyb2-0006wW-Dq
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:09 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:40472)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igyb2-0006wL-5j
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:08 -0500
Received: by mail-pl1-x62c.google.com with SMTP id g6so5111448plp.7
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 14:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=RS/kUrwws8zXejELfRCwC8ziQ//v3quP81JyrfoDA60=;
 b=BtctEVPBfOrzanvikFEs/BY2dC9eQw7rbaheEolEp09XX20azf9Ut/VIMfEw+wF4zj
 4rdjfzd7uXoKUMcsZFEvmaLe1muItu6uQ2eRUpS3m4v3IDU3sp5mSb4nUNRrpTdbBbZm
 2Ob1bSldsD7xqmZL1V/dX09o8ZdjK6jxSuJQtjRHI95F4pfi6/utScoTx5NO3D0OuoRd
 TdMYTtyN2tkZCN41wWRlfimdcTR6PXWqGyMWF+Cf+Xy03UCROI/TDgP2JzAkKnXyS36c
 jm/jfEw2vP8BepnctywdRrQg6m7owMz3H5woln2md2Ihtm/cyn8Eod/6UnjrvBIl8n2l
 +JBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RS/kUrwws8zXejELfRCwC8ziQ//v3quP81JyrfoDA60=;
 b=V/FxHGlRACbN/DPU6OPp4Uu33Z7kOsLgILRar9v94/sLpF63+hxoKfrifTjZp0DW7/
 XpxDOhf2+pyG2enyOtv3+pYuAUyBTCsP3905cXjb7YvTb+lsk38W/V4pzRSmtaWwJSMa
 7d9wpI0+s9URSvU2qcNedW/5FUZKSWY3x/4z595db68tNJEoV7tsnK1EYqOWR7sB8ix8
 ffTnJM9H7uw+hrAKUBK4Rgdc/FGQ33jGfzhZXFjULVDfhSWZ/JB0OtptHFu9cpd1NP06
 Db30aSUNIEyduBmyEg/DJaAp6kcW/tubLi/xWunFpl2FTtlfqN67q9ugOP8HVPo6ZqNh
 mC8g==
X-Gm-Message-State: APjAAAXYYkHCG1CCXl6GkhrgPvQWdZb7tuQXSDruDsV3SlVReCRIDGE1
 3LRHjZ83WYbScxWjMYCqlZdzsPNYGQ0=
X-Google-Smtp-Source: APXvYqwDbKLBnvhhq3o/3Z/grsujlm8YqgRbNOLXptcMKl1hWSFnbzLjVCT3PdMfyLgniNOlPnbK/A==
X-Received: by 2002:a17:90a:fb87:: with SMTP id
 cp7mr1978705pjb.56.1576534326518; 
 Mon, 16 Dec 2019 14:12:06 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d6sm529767pjl.8.2019.12.16.14.12.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 14:12:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/28] trace: Remove trace_mem_build_info_no_se_[bl]e
Date: Mon, 16 Dec 2019 12:11:33 -1000
Message-Id: <20191216221158.29572-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216221158.29572-1-richard.henderson@linaro.org>
References: <20191216221158.29572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62c
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


