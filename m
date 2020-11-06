Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8437CC388F2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0DE320735
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nuK8DZ3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DE320735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasdO-0006gD-QH
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:41:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSP-0005wp-In
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:33 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33489)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSG-0007It-TC
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:33 -0500
Received: by mail-pf1-x444.google.com with SMTP id q10so67877pfn.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+d27eU2L8HgDgwohO42SmmVaHgpu663rk7fnfFSZMqQ=;
 b=nuK8DZ3VsZkS0PXRlY00qP+A4+AW9DM19HWN59gGRHfOlSWQQeOB4GNaS6uSRvtLy7
 xFkRMCb+3XVco8hrgTysZug0EZ6xqzjxOKAPT41InJDzZGM4qS4n5NOkR3/3/UpCQ5+s
 WztJFohkpmK6lfiiHxDpfR2+C+lNUx5o6tazPmgs5YlbBhog05wxRtns8H43Uj2HbJ7K
 7GENmD9HX/EJ20lBJSm+Tv5KI49ZcErodnFarjzuGck7nmI1CtFSUaUNvb2+XCc1W21l
 njueLOEoTQqL5tPc01VizryJnSHtD16rq7q44J4BoHjbpS5e0olGPXDNM+U0PuIpdQ+m
 BiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+d27eU2L8HgDgwohO42SmmVaHgpu663rk7fnfFSZMqQ=;
 b=YCPudEhi1+me9J/YeQRUAKN9kS2bC/HBd9WstkIVk6IFcpBi8Ykm7oV+Q/M8PCNFMZ
 eFeORtikrjUHdu/jnnbWXJ180wvVvC5fQgJpN6skU2+P/yCBN0OzZbHfYQA34z9b3rgO
 Q1zQiClBYqH9XcrPoUTcmUKcq9q94kZdRwrozayIbbmjU/7ML8bdiNBB6XYAQOANp6Rt
 c+rmWH0kZjkGNunTL1+8lkex18/XxyGORRtezPpH/WSMyNIfj2TKqtSDGjn6vsAiDxrg
 my6FLRdqPf/odMXYtYT/nRX+vPkfbEITVOgiSvehvi//qlaP1Fkb3ISI/la4qlnMnQbf
 x6yw==
X-Gm-Message-State: AOAM533A19piMlhCgDdS174Q8KhqrQPbeCFryR2yIS3WYV8UqXIGiPJ9
 ZfIqDFjOIYZb9G1z8L1mVf/ISiz+uoFPhg==
X-Google-Smtp-Source: ABdhPJyCtHHsmrqsZLiOp2CADViNcAnqIeivcpYUGQdpGf2sJ++cDB3MUDFNEzdpvC1OM2GygBnMuQ==
X-Received: by 2002:aa7:9f06:0:b029:18a:e1a6:cec9 with SMTP id
 g6-20020aa79f060000b029018ae1a6cec9mr5465343pfr.20.1604633421689; 
 Thu, 05 Nov 2020 19:30:21 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:30:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 39/41] tcg: Remove TCG_TARGET_SUPPORT_MIRROR
Date: Thu,  5 Nov 2020 19:29:19 -0800
Message-Id: <20201106032921.600200-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that all native tcg hosts support splitwx,
remove the define.  Replace the one use with a
test for CONFIG_TCG_INTERPRETER.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h  |  1 -
 tcg/arm/tcg-target.h      |  1 -
 tcg/i386/tcg-target.h     |  1 -
 tcg/mips/tcg-target.h     |  1 -
 tcg/ppc/tcg-target.h      |  1 -
 tcg/riscv/tcg-target.h    |  1 -
 tcg/s390/tcg-target.h     |  1 -
 tcg/sparc/tcg-target.h    |  1 -
 tcg/tci/tcg-target.h      |  1 -
 accel/tcg/translate-all.c | 14 +++++++-------
 10 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index abb94f9458..fedd88f6fb 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -155,6 +155,5 @@ void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
 #define TCG_TARGET_NEED_LDST_LABELS
 #endif
 #define TCG_TARGET_NEED_POOL_LABELS
-#define TCG_TARGET_SUPPORT_MIRROR       1
 
 #endif /* AARCH64_TCG_TARGET_H */
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 17f6be9cfc..b21a2fb6a1 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -150,6 +150,5 @@ void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
 #define TCG_TARGET_NEED_LDST_LABELS
 #endif
 #define TCG_TARGET_NEED_POOL_LABELS
-#define TCG_TARGET_SUPPORT_MIRROR       1
 
 #endif
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index bbbd1c2d4a..f52ba0ffec 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -236,6 +236,5 @@ static inline void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_rx,
 #define TCG_TARGET_NEED_LDST_LABELS
 #endif
 #define TCG_TARGET_NEED_POOL_LABELS
-#define TCG_TARGET_SUPPORT_MIRROR       1
 
 #endif
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index d7d8e6ea1c..cd548dacec 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -206,7 +206,6 @@ extern bool use_mips32r2_instructions;
 
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_HAS_MEMORY_BSWAP     1
-#define TCG_TARGET_SUPPORT_MIRROR       1
 
 /* Flush the dcache at RW, and the icache at RX, as necessary. */
 static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index a8628b6cad..8f3e4c924a 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -185,6 +185,5 @@ void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
 #define TCG_TARGET_NEED_LDST_LABELS
 #endif
 #define TCG_TARGET_NEED_POOL_LABELS
-#define TCG_TARGET_SUPPORT_MIRROR       1
 
 #endif
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 0eb19f2b11..e03fd17427 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -179,6 +179,5 @@ void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
 #define TCG_TARGET_NEED_POOL_LABELS
 
 #define TCG_TARGET_HAS_MEMORY_BSWAP 0
-#define TCG_TARGET_SUPPORT_MIRROR   1
 
 #endif
diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 1fd8b3858e..c5a749e425 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -163,6 +163,5 @@ static inline void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_rx,
 #define TCG_TARGET_NEED_LDST_LABELS
 #endif
 #define TCG_TARGET_NEED_POOL_LABELS
-#define TCG_TARGET_SUPPORT_MIRROR       1
 
 #endif
diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
index bb2505bfc7..87e2be61e6 100644
--- a/tcg/sparc/tcg-target.h
+++ b/tcg/sparc/tcg-target.h
@@ -181,6 +181,5 @@ static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
 
 #define TCG_TARGET_NEED_POOL_LABELS
-#define TCG_TARGET_SUPPORT_MIRROR       1
 
 #endif
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 3653fef947..a19a6b06e5 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -200,7 +200,6 @@ static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 #define TCG_TARGET_DEFAULT_MO  (0)
 
 #define TCG_TARGET_HAS_MEMORY_BSWAP     1
-#define TCG_TARGET_SUPPORT_MIRROR       0
 
 static inline void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_rx,
                                             uintptr_t jmp_rw, uintptr_t addr)
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index b49aaf1026..06102871e7 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1257,14 +1257,14 @@ static bool alloc_code_gen_buffer_splitwx_vmremap(size_t size, Error **errp)
 
 static bool alloc_code_gen_buffer_splitwx(size_t size, Error **errp)
 {
-    if (TCG_TARGET_SUPPORT_MIRROR) {
-#ifdef CONFIG_DARWIN
-        return alloc_code_gen_buffer_splitwx_vmremap(size, errp);
+#ifndef CONFIG_TCG_INTERPRETER
+# ifdef CONFIG_DARWIN
+    return alloc_code_gen_buffer_splitwx_vmremap(size, errp);
+# endif
+# ifdef CONFIG_POSIX
+    return alloc_code_gen_buffer_splitwx_memfd(size, errp);
+# endif
 #endif
-#ifdef CONFIG_POSIX
-        return alloc_code_gen_buffer_splitwx_memfd(size, errp);
-#endif
-    }
     error_setg(errp, "jit split-wx not supported");
     return false;
 }
-- 
2.25.1


