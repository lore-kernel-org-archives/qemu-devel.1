Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6C7C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C702173E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VX6mewHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C702173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifFjM-0005yC-Dz
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 23:05:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFes-0000rA-46
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFen-00040r-4h
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:00:57 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38060)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifFem-0003xX-PP
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:00:52 -0500
Received: by mail-pl1-x643.google.com with SMTP id a17so4323pls.5
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 20:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=LZjfj7f7LiMXr9N5B8njH/lhRDK1JnIrdikl5tdqwbU=;
 b=VX6mewHWiQ+T5WY3kNKKgSDBBd5rV7W9C+ZillY6GIArd8uCuYL7ELeu5O5n+gs8TS
 hrk6g4Ilb3VuT2mTBuuviIGJ0gImpz0qSg/8bdjrwaC7j/cWBqnrOwS60iQ0ddO5eKS5
 zFfHNsHn2Zpw5KGCZZgaV9cVHzVSXdqEXzRIN55q1JB2JaY1wz9ZdZ2gm0TklZbciFoC
 7kxKpB4YlWpCJJZW9OznNMwB4hK4S1uk64yyuQKUrT63ditxyuwjc6Si1b+VTwI88pjx
 jqRMzlxfke/hlbGv3xKSn7QGNKZipRvwuYsNANkFGwo+ghpa0uxOvt1mQu3rS5eRR3Hd
 e+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LZjfj7f7LiMXr9N5B8njH/lhRDK1JnIrdikl5tdqwbU=;
 b=Cz/oRXmYqoLRDOy5pFpTmhJyvFER9oghv75PtqA45iU52/yQzyhpg+wkOv29e7C3rQ
 eojIkb3qLSSNMrO2WJ8IJNyRBsmjPnPz7Rea9Wo/QZfYsf5iyIZ+y7v8dShXET5oS/90
 OfOLHmQkDikksFQ1jtG4LJLB179j+y1SDhEix3XOZAwgtVh50JyXQrQHrGWAibk0YOe0
 woZP2nlZ2+hu7582/GIm7FgP6afjBB4CBNa6mXSmN0ez4r7gqsQQifXN7F7F8GjWFZgv
 mxoZqj6yNQgDzql2kNGdeipo1OuNH9pXKp5k3dDsvU2uMP372VCEARf0uoPnNWq+OF5l
 OWMg==
X-Gm-Message-State: APjAAAWiXh3iTQDOOw6MKT2mlDpuHzwa5Bd8oBZ34l5D7wcaqcO+uN2H
 bpT4tbUR5/WKPsMkE4dqvFoQP2LiCUA=
X-Google-Smtp-Source: APXvYqxQQAW8nAhJclUZxfTHeWOuMmlcbBY3AImuj67wE1MsBVFd7pid7i22/AxT6ywIVlXduwCc9Q==
X-Received: by 2002:a17:902:9308:: with SMTP id
 bc8mr7441005plb.18.1576123247466; 
 Wed, 11 Dec 2019 20:00:47 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z130sm4666391pgz.6.2019.12.11.20.00.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 20:00:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/28] translator: Use cpu_ld*_code instead of open-coding
Date: Wed, 11 Dec 2019 20:00:16 -0800
Message-Id: <20191212040039.26546-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212040039.26546-1-richard.henderson@linaro.org>
References: <20191212040039.26546-1-richard.henderson@linaro.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The DO_LOAD macros replicate the distinction already performed
by the cpu_ldst.h functions.  Use them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h   | 11 ---------
 include/exec/translator.h | 48 +++++++++++----------------------------
 2 files changed, 13 insertions(+), 46 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index cf8af36dbc..399ff6c3da 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -129,11 +129,6 @@ static inline void clear_helper_retaddr(void)
 #include "exec/cpu_ldst_useronly_template.h"
 #undef MEMSUFFIX
 
-/*
- * Code access is deprecated in favour of translator_ld* functions
- * (see translator.h). However there are still users that need to
- * converted so for now these stay.
- */
 #define MEMSUFFIX _code
 #define CODE_ACCESS
 #define DATA_SIZE 1
@@ -455,12 +450,6 @@ void cpu_stq_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
 #undef CPU_MMU_INDEX
 #undef MEMSUFFIX
 
-/*
- * Code access is deprecated in favour of translator_ld* functions
- * (see translator.h). However there are still users that need to
- * converted so for now these stay.
- */
-
 #define CPU_MMU_INDEX (cpu_mmu_index(env, true))
 #define MEMSUFFIX _code
 #define SOFTMMU_CODE_ACCESS
diff --git a/include/exec/translator.h b/include/exec/translator.h
index 459dd72aab..638e1529c5 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -148,41 +148,19 @@ void translator_loop_temp_check(DisasContextBase *db);
 /*
  * Translator Load Functions
  *
- * These are intended to replace the old cpu_ld*_code functions and
- * are mandatory for front-ends that have been migrated to the common
- * translator_loop. These functions are only intended to be called
- * from the translation stage and should not be called from helper
- * functions. Those functions should be converted to encode the
- * relevant information at translation time.
+ * These are intended to replace the direct usage of the cpu_ld*_code
+ * functions and are mandatory for front-ends that have been migrated
+ * to the common translator_loop. These functions are only intended
+ * to be called from the translation stage and should not be called
+ * from helper functions. Those functions should be converted to encode
+ * the relevant information at translation time.
  */
 
-#ifdef CONFIG_USER_ONLY
-
-#define DO_LOAD(type, name, shift)               \
-    do {                                         \
-        set_helper_retaddr(1);                   \
-        ret = name ## _p(g2h(pc));               \
-        clear_helper_retaddr();                  \
-    } while (0)
-
-#else
-
-#define DO_LOAD(type, name, shift)                          \
-    do {                                                    \
-        int mmu_idx = cpu_mmu_index(env, true);             \
-        TCGMemOpIdx oi = make_memop_idx(shift, mmu_idx);    \
-        ret = helper_ret_ ## name ## _cmmu(env, pc, oi, 0); \
-    } while (0)
-
-#endif
-
-#define GEN_TRANSLATOR_LD(fullname, name, type, shift, swap_fn)         \
+#define GEN_TRANSLATOR_LD(fullname, type, load_fn, swap_fn)             \
     static inline type                                                  \
     fullname ## _swap(CPUArchState *env, abi_ptr pc, bool do_swap)      \
     {                                                                   \
-        type ret;                                                       \
-        DO_LOAD(type, name, shift);                                     \
-                                                                        \
+        type ret = load_fn(env, pc);                                    \
         if (do_swap) {                                                  \
             ret = swap_fn(ret);                                         \
         }                                                               \
@@ -195,11 +173,11 @@ void translator_loop_temp_check(DisasContextBase *db);
         return fullname ## _swap(env, pc, false);                       \
     }
 
-GEN_TRANSLATOR_LD(translator_ldub, ldub, uint8_t, 0, /* no swap */ )
-GEN_TRANSLATOR_LD(translator_ldsw, ldsw, int16_t, 1, bswap16)
-GEN_TRANSLATOR_LD(translator_lduw, lduw, uint16_t, 1, bswap16)
-GEN_TRANSLATOR_LD(translator_ldl, ldl, uint32_t, 2, bswap32)
-GEN_TRANSLATOR_LD(translator_ldq, ldq, uint64_t, 3, bswap64)
+GEN_TRANSLATOR_LD(translator_ldub, uint8_t, cpu_ldub_code, /* no swap */)
+GEN_TRANSLATOR_LD(translator_ldsw, int16_t, cpu_ldsw_code, bswap16)
+GEN_TRANSLATOR_LD(translator_lduw, uint16_t, cpu_lduw_code, bswap16)
+GEN_TRANSLATOR_LD(translator_ldl, uint32_t, cpu_ldl_code, bswap32)
+GEN_TRANSLATOR_LD(translator_ldq, uint64_t, cpu_ldq_code, bswap64)
 #undef GEN_TRANSLATOR_LD
 
 #endif  /* EXEC__TRANSLATOR_H */
-- 
2.20.1


