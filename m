Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727CDC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 02:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7FD82075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 02:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XNRpgroy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7FD82075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jasTi-00087f-54
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 22:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasOa-0005eY-JB
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:20 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:36789)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasOZ-0002W4-J0
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:20 -0400
Received: by mail-pg1-x52e.google.com with SMTP id c75so4728850pga.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 19:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ilYiYwfPbx2qQQFy7b/Ot3fVz/Ep7kBx5xS7fCDZud0=;
 b=XNRpgroyCQAQtseX2XqU1SxiCNiUdWkvLOClEGW2w2byClMHpPILQjbm3tAkZ6YQ0g
 SfGgG8p3EXxa0Wd3tk2nxhJ4crqtL0NEH9KxFD9R9noOnsPwWK0OpNijQjWN90xq5TAx
 0dXwoyx83BTY3sTmExGR8HoefpZCyhTvWg/sV1Et2PfoZXVDtmVNfuDE6f2UY0xD51uz
 aGL/FSFwobTo6zP/aNGzBQ8Yen/pt++uzgG4zLrascyU7XGbQ4fKiJyR6UnGwNRWELKM
 znAmUibRLqCoV66szH5xxZ3I9pLEvAdhsWyw5aEVjSmDj9vpu0OKVwsPR5Vo1IWcRu6y
 cWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ilYiYwfPbx2qQQFy7b/Ot3fVz/Ep7kBx5xS7fCDZud0=;
 b=cdnJd0ctj3DJdDE+8raOL21BxgHt1xzebRgbqppXwRShlJ7kOV6f6WLFddaGCKzmS1
 OT4VbFHGIVTdb1mM/2qpiN5B11p78MawE7JMfculAJsAItgMo5DLOAUUIe8oUV1wtVwL
 lmSh5qRztiiQ4qAhjAJ+ODr3K4xHmpNaeAyS8U+4zs1HAcsqW+GgDDdGhEfMcHMAEd7L
 f0OMmQBC2QXQeMGRVwrY9fWcHUfTXelgmD4gygPVKQdl4j9vtuNx8RowKzXY3U2D1bY0
 KvF7r/sdaTxaAFNEWmuzLCn17QL0TKQdfxvvk9SrL/8Ng+M45EO/17JVCf6tCaqF4BHE
 ioyw==
X-Gm-Message-State: AOAM531UJz2FIeXD+6Xbb6k2uALvWq3BWl2+zXrxN5IiUrHijVmhki6I
 i8jKsfXDo2gQdaBhNOREbRVrIkUAdMY=
X-Google-Smtp-Source: ABdhPJwDvoSsgcqNKhWFXh7Xm+vClUZSG0Tq9Quixoqi4Po26YebrMHPvjCN0/f0+t6cDR8pqCKDWg==
X-Received: by 2002:a63:5114:: with SMTP id f20mr11932150pgb.148.1589856857419; 
 Mon, 18 May 2020 19:54:17 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id a2sm8772418pgh.57.2020.05.18.19.54.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 19:54:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RISU v2 15/17] Compute reginfo_size based on the reginfo
Date: Mon, 18 May 2020 19:53:53 -0700
Message-Id: <20200519025355.4420-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519025355.4420-1-richard.henderson@linaro.org>
References: <20200519025355.4420-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will allow dumping of SVE frames without having
to know the SVE vector length beforehand.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.h                 | 2 +-
 reginfo.c              | 6 +++---
 risu_reginfo_aarch64.c | 4 ++--
 risu_reginfo_arm.c     | 2 +-
 risu_reginfo_i386.c    | 2 +-
 risu_reginfo_m68k.c    | 2 +-
 risu_reginfo_ppc64.c   | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/risu.h b/risu.h
index eeb6775..054cef7 100644
--- a/risu.h
+++ b/risu.h
@@ -155,6 +155,6 @@ int reginfo_dump(struct reginfo *ri, FILE * f);
 int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f);
 
 /* return size of reginfo */
-const int reginfo_size(void);
+int reginfo_size(struct reginfo *ri);
 
 #endif /* RISU_H */
diff --git a/reginfo.c b/reginfo.c
index f187d9c..411c2a6 100644
--- a/reginfo.c
+++ b/reginfo.c
@@ -38,7 +38,7 @@ RisuResult send_register_info(void *uc)
     case OP_TESTEND:
     case OP_COMPARE:
     case OP_SIGILL:
-        header.size = reginfo_size();
+        header.size = reginfo_size(&ri);
         extra = &ri;
         break;
 
@@ -109,7 +109,7 @@ RisuResult recv_and_compare_register_info(void *uc)
     case OP_TESTEND:
     case OP_COMPARE:
     case OP_SIGILL:
-        extra_size = reginfo_size();
+        extra_size = reginfo_size(&master_ri);
         break;
     case OP_SETMEMBLOCK:
     case OP_GETMEMBLOCK:
@@ -217,7 +217,7 @@ void report_mismatch_header(void)
         case OP_COMPARE:
         case OP_SIGILL:
             kind = "reginfo";
-            a_sz = reginfo_size();
+            a_sz = reginfo_size(&apprentice_ri);
             break;
         case OP_SETMEMBLOCK:
         case OP_GETMEMBLOCK:
diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index 028c690..7044648 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -69,7 +69,7 @@ void process_arch_opt(int opt, const char *arg)
 #endif
 }
 
-const int reginfo_size(void)
+int reginfo_size(struct reginfo *ri)
 {
     int size = offsetof(struct reginfo, simd.end);
 #ifdef SVE_MAGIC
@@ -194,7 +194,7 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
 /* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
 int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2)
 {
-    return memcmp(r1, r2, reginfo_size()) == 0;
+    return memcmp(r1, r2, reginfo_size(r1)) == 0;
 }
 
 #ifdef SVE_MAGIC
diff --git a/risu_reginfo_arm.c b/risu_reginfo_arm.c
index 3662f12..3832e27 100644
--- a/risu_reginfo_arm.c
+++ b/risu_reginfo_arm.c
@@ -36,7 +36,7 @@ void process_arch_opt(int opt, const char *arg)
     abort();
 }
 
-const int reginfo_size(void)
+int reginfo_size(struct reginfo *ri)
 {
     return sizeof(struct reginfo);
 }
diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
index 60fc239..902d33e 100644
--- a/risu_reginfo_i386.c
+++ b/risu_reginfo_i386.c
@@ -74,7 +74,7 @@ void process_arch_opt(int opt, const char *arg)
     }
 }
 
-const int reginfo_size(void)
+int reginfo_size(struct reginfo *ri)
 {
     return sizeof(struct reginfo);
 }
diff --git a/risu_reginfo_m68k.c b/risu_reginfo_m68k.c
index 32b28c8..361f172 100644
--- a/risu_reginfo_m68k.c
+++ b/risu_reginfo_m68k.c
@@ -23,7 +23,7 @@ void process_arch_opt(int opt, const char *arg)
     abort();
 }
 
-const int reginfo_size(void)
+int reginfo_size(struct reginfo *ri)
 {
     return sizeof(struct reginfo);
 }
diff --git a/risu_reginfo_ppc64.c b/risu_reginfo_ppc64.c
index 071c951..c86313c 100644
--- a/risu_reginfo_ppc64.c
+++ b/risu_reginfo_ppc64.c
@@ -32,7 +32,7 @@ void process_arch_opt(int opt, const char *arg)
     abort();
 }
 
-const int reginfo_size(void)
+int reginfo_size(struct reginfo *ri)
 {
     return sizeof(struct reginfo);
 }
-- 
2.20.1


