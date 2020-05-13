Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB86DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57F1720659
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EXLhM5+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F1720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvxW-0000Q8-Pw
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 14:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYvpa-0003ru-DX
 for qemu-devel@nongnu.org; Wed, 13 May 2020 14:10:10 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:35664)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYvpW-0000Mm-V2
 for qemu-devel@nongnu.org; Wed, 13 May 2020 14:10:10 -0400
Received: by mail-pg1-x52f.google.com with SMTP id t11so107747pgg.2
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 11:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jBzLmvDxBp3zJZsO6hz95Oe3IMjRgxYk/8WAQc4mszU=;
 b=EXLhM5+FN0DVD7utH5kdiS/DzOjhprxOe0DBdpU4t0U+5gHbDoYHTITvehckOLmg4T
 fUkuwe2Gr9ofhCVGDL8J6DQAKNdgd7UId6BErNWv4lZY/bEg1KeBotPOcoVw2m75t+73
 kkyc7QrY2lUIJeugyECDsxuwX0Mx4y7m3cQ98M6snA2b0fppsOZbH4iP4uy8XGDAZbNG
 nZwiVJ3DvvIN6XX/An+mwYNCTqo6sllUs3a0qC5UmVnv7RYNm/418E1YPHfoK62TNXlu
 byifNPTmh/AR0grWWVLUMXhk+d3hRFh9vJWLiwM1QheDhWxpCXE9yrQIWhYY/A2qZPY0
 GWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jBzLmvDxBp3zJZsO6hz95Oe3IMjRgxYk/8WAQc4mszU=;
 b=UpxSQZF3EQmZzYoYHMy57R65WApBJ03QX09XJtD/cjC152sNRC2gSI0oZ3jMmeHXU9
 jATZZF2tFT0iGbzGxP/8XHnh/+bQKHgZ6ea/Xu2m39QJrrCxtkRfqiC54AhlcdpoyYnD
 ml2APnj82UloXIg+zv7NI8QF05ETnWKPFBRWqnTHq+SzA8lN4Wvl8vXrifaE9BttnDVQ
 /qLQmd9KrNBOp/LNVCRsNU+3q5FRdU0Y9zHeHbBtpNkNWZY0pm5QmlonfRKiYLSHCbAW
 RFWuu8BcM4bo83QosrR7rCc4v0wkLJd5W55BEygn0eed78mPrEyPuT/w6aQ1RYq2u7Cb
 63Qw==
X-Gm-Message-State: AOAM532oDoP2d7w9hmA5UvfphdU0EwJsbFaZzc1Dlcbc1bf4PqKvmUxk
 zVwS8kuzhfHBZTPnCzenN4bSBADHH70=
X-Google-Smtp-Source: ABdhPJw1LG3t7HpO7Q+OBSRjH17grKticq+XR9a7ssIJwNpzOWV4Z7E2zB0HkgAomRO7Dr675HJ6Hw==
X-Received: by 2002:a63:4911:: with SMTP id w17mr498675pga.13.1589393405167;
 Wed, 13 May 2020 11:10:05 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i185sm197361pfg.14.2020.05.13.11.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 11:10:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RISU 7/9] Compute reginfo_size based on the reginfo
Date: Wed, 13 May 2020 11:09:51 -0700
Message-Id: <20200513180953.20376-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513180953.20376-1-richard.henderson@linaro.org>
References: <20200513180953.20376-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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
 reginfo.c              | 7 ++++---
 risu_reginfo_aarch64.c | 4 ++--
 risu_reginfo_arm.c     | 2 +-
 risu_reginfo_i386.c    | 2 +-
 risu_reginfo_m68k.c    | 2 +-
 risu_reginfo_ppc64.c   | 2 +-
 7 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/risu.h b/risu.h
index 3fc198f..0ae7fa9 100644
--- a/risu.h
+++ b/risu.h
@@ -139,6 +139,6 @@ int reginfo_dump(struct reginfo *ri, FILE * f);
 int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f);
 
 /* return size of reginfo */
-const int reginfo_size(void);
+int reginfo_size(struct reginfo *ri);
 
 #endif /* RISU_H */
diff --git a/reginfo.c b/reginfo.c
index a4f7da6..1727867 100644
--- a/reginfo.c
+++ b/reginfo.c
@@ -40,7 +40,7 @@ int send_register_info(write_fn write_fn, void *uc)
     case OP_TESTEND:
     case OP_COMPARE:
     default:
-        header.size = reginfo_size();
+        header.size = reginfo_size(&ri);
         extra = &ri;
         break;
 
@@ -121,8 +121,9 @@ int recv_and_compare_register_info(read_fn read_fn,
         /* Do a simple register compare on (a) explicit request
          * (b) end of test (c) a non-risuop UNDEF
          */
-        if (header.size != reginfo_size() ||
-            read_fn(&apprentice_ri, header.size)) {
+        if (header.size > sizeof(struct reginfo) ||
+            read_fn(&apprentice_ri, header.size) ||
+            header.size != reginfo_size(&apprentice_ri)) {
             packet_mismatch = 1;
             resp = 2;
         } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
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


