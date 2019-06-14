Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D025BC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 914A02177E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FtKApfm1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 914A02177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54064 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbqq1-0003RC-NB
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 14:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58661)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpqj-0005b2-2C
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpqe-000769-0M
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:47 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:32898)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbpqd-0006sD-Jq
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:43 -0400
Received: by mail-wr1-x444.google.com with SMTP id n9so3357124wru.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=il3aOSQFRSZJ2/99Y43bBqgnwxHoXzOMQ0saAfzkh+I=;
 b=FtKApfm1D/p6XGZGeDjMfRGy1o4ilmmub4IZ9hnbiP9zgmxz4dP2VZ5w5yo60JS7RZ
 uYGlXuBVAnlTwoiTV7cNdAOLjvGdoFn9rcnOChLHS6GI7+LWy+1pVLp8Z1ddGzeDxKEA
 BCkvz6LLIl3RosA0LDz225csT1b/tPlEuteqIYGlus6p3P1lMX7XPvAQz6WjGTFmOGsv
 YYTBHd+FQ+Df2QW5n/KaGqmWHJwTvSWdzvdmXPok3PcgL1acNWP4e2ZNRNnBnnqmQNhB
 ittPiVVyhn769RuDw8RkO2kbYezaQPNtYKJ3FG86Pnfci/a2fy7RynfrX3CWI2rCHbA9
 Ml+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=il3aOSQFRSZJ2/99Y43bBqgnwxHoXzOMQ0saAfzkh+I=;
 b=i+laC9Llr82HTJLV/1KQqkol+sOfhc9nGlUZsfvPLVRgwB1yQQKD99MijSlgP3mnIp
 J2NCdt3/Vncm0xxii3yxnDJc+2MT8R209YMNkq3AasFSEtAI8fOxRc/axl2N3TdosaB8
 +WNzKsgiPRHzR2Fwvrah29pHeDOpC9NfxpJoZndi5o+tSVdUdOru+P1btWl2/iqJb92f
 ZJx0GdYyutCV6qm5CTYr6vgJoxyHTwGScJzNeK8X+Z7MnwYtOJkScDfmmj93I8GpwcCa
 QlYOgoxPDUD42MzVhKB2VtaTgQVMDXCvCztgYbSFeMiSUFTvzg2+FGj1WszgqIuM8vrF
 EELw==
X-Gm-Message-State: APjAAAUUYqa1zGDchFhsW5Ybllwe3ijSHS0lAjibvDNEi788exqFhF6h
 RShUpr4fh6rALnxmK+aJk5FWAQ==
X-Google-Smtp-Source: APXvYqwTTWLBDQVCvgr7ufM5l5WLP+qVadJvzLop27KTPAFDvmpkG9btqgtyumm2aIzxjeSC0DD+cw==
X-Received: by 2002:a05:6000:110:: with SMTP id
 o16mr62393959wrx.200.1560532718511; 
 Fri, 14 Jun 2019 10:18:38 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id s10sm4486428wrt.49.2019.06.14.10.18.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:18:34 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0BFBC1FFA3;
 Fri, 14 Jun 2019 18:12:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:27 +0100
Message-Id: <20190614171200.21078-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v3 17/50] atomic_template: add inline
 trace/plugin helpers
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

In preparation for plugin support.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/atomic_template.h | 110 ++++++++++++++++++++++++------------
 1 file changed, 75 insertions(+), 35 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index df9c838817..04c4c7b0d2 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -59,25 +59,44 @@
 # define ABI_TYPE  uint32_t
 #endif
 
-#define ATOMIC_TRACE_RMW do {                                           \
-        uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false); \
-                                                                        \
-        trace_guest_mem_before_exec(env_cpu(env), addr, info);      \
-        trace_guest_mem_before_exec(env_cpu(env), addr,             \
-                                    info | TRACE_MEM_ST);               \
-    } while (0)
-
-#define ATOMIC_TRACE_LD do {                                            \
-        uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false); \
-                                                                        \
-        trace_guest_mem_before_exec(env_cpu(env), addr, info);      \
-    } while (0)
-
-# define ATOMIC_TRACE_ST do {                                           \
-        uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, true); \
-                                                                        \
-        trace_guest_mem_before_exec(env_cpu(env), addr, info);      \
-    } while (0)
+#ifndef ATOMIC_TEMPLATE_COMMON
+#define ATOMIC_TEMPLATE_COMMON
+static inline
+void atomic_trace_rmw_pre(CPUArchState *env, target_ulong addr, uint8_t info)
+{
+    CPUState *cpu = env_cpu(env);
+
+    trace_guest_mem_before_exec(cpu, addr, info);
+    trace_guest_mem_before_exec(cpu, addr, info | TRACE_MEM_ST);
+}
+
+static inline void atomic_trace_rmw_post(CPUArchState *env, target_ulong addr,
+                                         void *haddr, uint8_t info)
+{
+}
+
+static inline
+void atomic_trace_ld_pre(CPUArchState *env, target_ulong addr, uint8_t info)
+{
+    trace_guest_mem_before_exec(env_cpu(env), addr, info);
+}
+
+static inline void atomic_trace_ld_post(CPUArchState *env, target_ulong addr,
+                                        void *haddr, uint8_t info)
+{
+}
+
+static inline
+void atomic_trace_st_pre(CPUArchState *env, target_ulong addr, uint8_t info)
+{
+    trace_guest_mem_before_exec(env_cpu(env), addr, info);
+}
+
+static inline void atomic_trace_st_post(CPUArchState *env, target_ulong addr,
+                                        void *haddr, uint8_t info)
+{
+}
+#endif /* ATOMIC_TEMPLATE_COMMON */
 
 /* Define host-endian atomic operations.  Note that END is used within
    the ATOMIC_NAME macro, and redefined below.  */
@@ -98,14 +117,16 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     DATA_TYPE ret;
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false);
 
-    ATOMIC_TRACE_RMW;
+    atomic_trace_rmw_pre(env, addr, info);
 #if DATA_SIZE == 16
     ret = atomic16_cmpxchg(haddr, cmpv, newv);
 #else
     ret = atomic_cmpxchg__nocheck(haddr, cmpv, newv);
 #endif
     ATOMIC_MMU_CLEANUP;
+    atomic_trace_rmw_post(env, addr, haddr, info);
     return ret;
 }
 
@@ -115,10 +136,12 @@ ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE val, *haddr = ATOMIC_MMU_LOOKUP;
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false);
 
-    ATOMIC_TRACE_LD;
+    atomic_trace_ld_pre(env, addr, info);
     val = atomic16_read(haddr);
     ATOMIC_MMU_CLEANUP;
+    atomic_trace_ld_post(env, addr, haddr, info);
     return val;
 }
 
@@ -127,10 +150,12 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, true);
 
-    ATOMIC_TRACE_ST;
+    atomic_trace_st_pre(env, addr, info);
     atomic16_set(haddr, val);
     ATOMIC_MMU_CLEANUP;
+    atomic_trace_st_post(env, addr, haddr, info);
 }
 #endif
 #else
@@ -140,10 +165,12 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     DATA_TYPE ret;
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false);
 
-    ATOMIC_TRACE_RMW;
+    atomic_trace_rmw_pre(env, addr, info);
     ret = atomic_xchg__nocheck(haddr, val);
     ATOMIC_MMU_CLEANUP;
+    atomic_trace_rmw_post(env, addr, haddr, info);
     return ret;
 }
 
@@ -154,10 +181,12 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
     ATOMIC_MMU_DECLS;                                               \
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                           \
     DATA_TYPE ret;                                                  \
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false); \
                                                                     \
-    ATOMIC_TRACE_RMW;                                               \
+    atomic_trace_rmw_pre(env, addr, info);                          \
     ret = atomic_##X(haddr, val);                                   \
     ATOMIC_MMU_CLEANUP;                                             \
+    atomic_trace_rmw_post(env, addr, haddr, info);                  \
     return ret;                                                     \
 }
 
@@ -186,8 +215,9 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
     ATOMIC_MMU_DECLS;                                               \
     XDATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                          \
     XDATA_TYPE cmp, old, new, val = xval;                           \
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false); \
                                                                     \
-    ATOMIC_TRACE_RMW;                                               \
+    atomic_trace_rmw_pre(env, addr, info);                          \
     smp_mb();                                                       \
     cmp = atomic_read__nocheck(haddr);                              \
     do {                                                            \
@@ -195,6 +225,7 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
         cmp = atomic_cmpxchg__nocheck(haddr, old, new);             \
     } while (cmp != old);                                           \
     ATOMIC_MMU_CLEANUP;                                             \
+    atomic_trace_rmw_post(env, addr, haddr, info);                  \
     return RET;                                                     \
 }
 
@@ -232,14 +263,16 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     DATA_TYPE ret;
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false);
 
-    ATOMIC_TRACE_RMW;
+    atomic_trace_rmw_pre(env, addr, info);
 #if DATA_SIZE == 16
     ret = atomic16_cmpxchg(haddr, BSWAP(cmpv), BSWAP(newv));
 #else
     ret = atomic_cmpxchg__nocheck(haddr, BSWAP(cmpv), BSWAP(newv));
 #endif
     ATOMIC_MMU_CLEANUP;
+    atomic_trace_rmw_post(env, addr, haddr, info);
     return BSWAP(ret);
 }
 
@@ -249,10 +282,12 @@ ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE val, *haddr = ATOMIC_MMU_LOOKUP;
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false);
 
-    ATOMIC_TRACE_LD;
+    atomic_trace_ld_pre(env, addr, info);
     val = atomic16_read(haddr);
     ATOMIC_MMU_CLEANUP;
+    atomic_trace_ld_post(env, addr, haddr, info);
     return BSWAP(val);
 }
 
@@ -261,11 +296,14 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
 {
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, true);
 
-    ATOMIC_TRACE_ST;
+    val = BSWAP(val);
+    atomic_trace_st_pre(env, addr, info);
     val = BSWAP(val);
     atomic16_set(haddr, val);
     ATOMIC_MMU_CLEANUP;
+    atomic_trace_st_post(env, addr, haddr, info);
 }
 #endif
 #else
@@ -275,10 +313,12 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
     ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     ABI_TYPE ret;
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false);
 
-    ATOMIC_TRACE_RMW;
+    atomic_trace_rmw_pre(env, addr, info);
     ret = atomic_xchg__nocheck(haddr, BSWAP(val));
     ATOMIC_MMU_CLEANUP;
+    atomic_trace_rmw_post(env, addr, haddr, info);
     return BSWAP(ret);
 }
 
@@ -289,10 +329,12 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
     ATOMIC_MMU_DECLS;                                               \
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                           \
     DATA_TYPE ret;                                                  \
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false); \
                                                                     \
-    ATOMIC_TRACE_RMW;                                               \
+    atomic_trace_rmw_pre(env, addr, info);                          \
     ret = atomic_##X(haddr, BSWAP(val));                            \
     ATOMIC_MMU_CLEANUP;                                             \
+    atomic_trace_rmw_post(env, addr, haddr, info);                  \
     return BSWAP(ret);                                              \
 }
 
@@ -319,8 +361,9 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
     ATOMIC_MMU_DECLS;                                               \
     XDATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                          \
     XDATA_TYPE ldo, ldn, old, new, val = xval;                      \
+    uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false); \
                                                                     \
-    ATOMIC_TRACE_RMW;                                               \
+    atomic_trace_rmw_pre(env, addr, info);                          \
     smp_mb();                                                       \
     ldn = atomic_read__nocheck(haddr);                              \
     do {                                                            \
@@ -328,6 +371,7 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
         ldn = atomic_cmpxchg__nocheck(haddr, ldo, BSWAP(new));      \
     } while (ldo != ldn);                                           \
     ATOMIC_MMU_CLEANUP;                                             \
+    atomic_trace_rmw_post(env, addr, haddr, info);                  \
     return RET;                                                     \
 }
 
@@ -355,10 +399,6 @@ GEN_ATOMIC_HELPER_FN(add_fetch, ADD, DATA_TYPE, new)
 #undef MEND
 #endif /* DATA_SIZE > 1 */
 
-#undef ATOMIC_TRACE_ST
-#undef ATOMIC_TRACE_LD
-#undef ATOMIC_TRACE_RMW
-
 #undef BSWAP
 #undef ABI_TYPE
 #undef DATA_TYPE
-- 
2.20.1


