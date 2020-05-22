Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59DFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:39:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC052072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ugYrlGz6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC052072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxae-0004NM-M0
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWf-0002zI-H3
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:35:09 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:35002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWd-00058T-W8
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:35:09 -0400
Received: by mail-pj1-x1041.google.com with SMTP id 5so4348059pjd.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hhzEI0zY7uuhea/eDo3m8LR1KeJI+fOWQZOyopQnOJc=;
 b=ugYrlGz6ltuiNsbxkqPk9u7b4CZHviOZ4LKmlv//2Vh6NjQcHiyuCLGAlBH5DNp6Fi
 NF7QciY/bd21G/0PkCIeNnFKldeBJ62KxghAkKOMUjgQLHqPDM4I+PFFli7ap2+M+lHh
 1Jsvhv476z9mK8rqQ+frFuTusUi/6abGlEepqWHvZY1ew6fg26sCnfM2M/CMz0Lqi3ia
 zASSjCqb/gZzggqGfYaH5LGWoPo/EzirIqg62PpAnG9b3eJUDK0cC2Te3mS+jkCaNm8x
 8C5MoQmo2tgRDDfwQo2cRMiI1tDW3SNhlKuOfRTokojPZqLiWasdVnEUnBQrNzoCNGcq
 2BAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hhzEI0zY7uuhea/eDo3m8LR1KeJI+fOWQZOyopQnOJc=;
 b=Vs0xJcbxELfNol3dtmaYeHn9Va7p5YQp/szhw4+7AUl0i0on0MNaNDXDdgsqnnSJgI
 5FtW4ZsQXt5iq2riodxNaFxRtISTh3ofinEAnes7Ek1B2FHD5rV0g5qdPFQHM1BnHVM9
 oTdKj8fYdUuIdaUMeOQZx5FWxMnNipq/I8ufduSUNRnQGuxJxv0lYOZd9u4NuebxWCM4
 NOtux3sK3WQbAchhNrgBCKjsSa/0Tu+Ehs2HmI9r+Bq8B7q76tEQA8UlA9gQGp1QO1HS
 +sQfxP8IOmcaO6tJ1yMrJ/mBgJTKW21VKiUUcA8XBg/dv1cqXutpV3p+fbaJQ/5FJZ5D
 /WCw==
X-Gm-Message-State: AOAM530psQ3TUWQ04GIVVIZoJD9KWeo3+sQ0WJP+XP2y+txArdobkvHr
 TwshWXnOCV/aQVPfI1K+SxW+uiZ8kG4=
X-Google-Smtp-Source: ABdhPJzxvN5EpQAD9WlJuDgUhxQH0Mk6eRTTQlxWIj0p/0BiWvEp+tbadZxIQWn6fCImWe4LlFkYTw==
X-Received: by 2002:a17:902:dc86:: with SMTP id
 n6mr12400066pld.17.1590114906123; 
 Thu, 21 May 2020 19:35:06 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gt10sm5443755pjb.30.2020.05.21.19.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 19:35:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 19/25] aarch64: Reorg sve reginfo to save space
Date: Thu, 21 May 2020 19:34:34 -0700
Message-Id: <20200522023440.26261-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522023440.26261-1-richard.henderson@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mirror the signal frame by storing all of the registers
as a lump.  Use the signal macros to pull out the values.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu_reginfo_aarch64.h |  16 +----
 risu_reginfo_aarch64.c | 135 +++++++++++++++++++++--------------------
 2 files changed, 73 insertions(+), 78 deletions(-)

diff --git a/risu_reginfo_aarch64.h b/risu_reginfo_aarch64.h
index c33b86f..01076b4 100644
--- a/risu_reginfo_aarch64.h
+++ b/risu_reginfo_aarch64.h
@@ -17,20 +17,8 @@
 
 struct simd_reginfo {
     __uint128_t vregs[32];
-    char end[0];
 };
 
-#ifdef SVE_MAGIC
-struct sve_reginfo {
-    /* SVE */
-    uint16_t    vl; /* current VL */
-    __uint128_t zregs[SVE_NUM_ZREGS][SVE_VQ_MAX];
-    uint16_t    pregs[SVE_NUM_PREGS][SVE_VQ_MAX];
-    uint16_t    ffr[SVE_VQ_MAX];
-    char end[0];
-};
-#endif
-
 /* The kernel headers set this based on future arch extensions.
    The current arch maximum is 16.  Save space below.  */
 #undef SVE_VQ_MAX
@@ -47,11 +35,13 @@ struct reginfo {
     /* FP/SIMD */
     uint32_t fpsr;
     uint32_t fpcr;
+    uint32_t sve_vl;
 
     union {
         struct simd_reginfo simd;
 #ifdef SVE_MAGIC
-        struct sve_reginfo sve;
+        char sve[SVE_SIG_CONTEXT_SIZE(16) - SVE_SIG_REGS_OFFSET]
+            __attribute__((aligned(16)));
 #endif
     };
 };
diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index 7044648..a1020ac 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -71,15 +71,30 @@ void process_arch_opt(int opt, const char *arg)
 
 int reginfo_size(struct reginfo *ri)
 {
-    int size = offsetof(struct reginfo, simd.end);
 #ifdef SVE_MAGIC
-    if (test_sve) {
-        size = offsetof(struct reginfo, sve.end);
+    if (ri->sve_vl) {
+        int vq = sve_vq_from_vl(ri->sve_vl);
+        return (offsetof(struct reginfo, sve) +
+                SVE_SIG_CONTEXT_SIZE(vq) - SVE_SIG_REGS_OFFSET);
     }
 #endif
-    return size;
+    return offsetof(struct reginfo, simd) + sizeof(ri->simd);
 }
 
+#ifdef SVE_MAGIC
+static uint64_t *reginfo_zreg(struct reginfo *ri, int vq, int i)
+{
+    return (uint64_t *)(ri->sve + SVE_SIG_ZREG_OFFSET(vq, i) -
+                        SVE_SIG_REGS_OFFSET);
+}
+
+static uint16_t *reginfo_preg(struct reginfo *ri, int vq, int i)
+{
+    return (uint16_t *)(ri->sve + SVE_SIG_PREG_OFFSET(vq, i) -
+                        SVE_SIG_REGS_OFFSET);
+}
+#endif
+
 /* reginfo_init: initialize with a ucontext */
 void reginfo_init(struct reginfo *ri, ucontext_t *uc)
 {
@@ -152,8 +167,6 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
             return;
         }
 
-        ri->sve.vl = sve->vl;
-
         if (sve->head.size < SVE_SIG_CONTEXT_SIZE(vq)) {
             if (sve->head.size == sizeof(*sve)) {
                 /* SVE state is empty -- not an error.  */
@@ -164,24 +177,9 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
             return;
         }
 
-        /* Copy ZREG's one at a time */
-        for (i = 0; i < SVE_NUM_ZREGS; i++) {
-            memcpy(&ri->sve.zregs[i],
-                   (void *)sve + SVE_SIG_ZREG_OFFSET(vq, i),
-                   SVE_SIG_ZREG_SIZE(vq));
-        }
-
-        /* Copy PREG's one at a time */
-        for (i = 0; i < SVE_NUM_PREGS; i++) {
-            memcpy(&ri->sve.pregs[i],
-                   (void *)sve + SVE_SIG_PREG_OFFSET(vq, i),
-                   SVE_SIG_PREG_SIZE(vq));
-        }
-
-        /* Finally the FFR */
-        memcpy(&ri->sve.ffr, (void *)sve + SVE_SIG_FFR_OFFSET(vq),
-               SVE_SIG_FFR_SIZE(vq));
-
+        ri->sve_vl = sve->vl;
+        memcpy(ri->sve, (char *)sve + SVE_SIG_REGS_OFFSET,
+               SVE_SIG_CONTEXT_SIZE(vq) - SVE_SIG_REGS_OFFSET);
         return;
     }
 #endif /* SVE_MAGIC */
@@ -225,18 +223,20 @@ static void sve_dump_preg_diff(FILE *f, int vq, const uint16_t *p1,
     fprintf(f, "\n");
 }
 
-static void sve_dump_zreg_diff(FILE *f, int vq, const __uint128_t *z1,
-                               const __uint128_t *z2)
+static void sve_dump_zreg_diff(FILE *f, int vq, const uint64_t *za,
+                               const uint64_t *zb)
 {
     const char *pad = "";
     int q;
 
     for (q = 0; q < vq; ++q) {
-        if (z1[q] != z2[q]) {
+        uint64_t za0 = za[2 * q], za1 = za[2 * q + 1];
+        uint64_t zb0 = zb[2 * q], zb1 = zb[2 * q + 1];
+
+        if (za0 != zb0 || za1 != zb1) {
             fprintf(f, "%sq%-2d: %016" PRIx64 "%016" PRIx64
-                    " vs %016" PRIx64 "%016" PRIx64"\n", pad, q,
-                    (uint64_t)(z1[q] >> 64), (uint64_t)z1[q],
-                    (uint64_t)(z2[q] >> 64), (uint64_t)z2[q]);
+                    " vs %016" PRIx64 "%016" PRIx64"\n",
+                    pad, q, za1, za0, zb1, zb0);
             pad = "      ";
         }
     }
@@ -263,28 +263,30 @@ int reginfo_dump(struct reginfo *ri, FILE * f)
     if (test_sve) {
         int q, vq = test_sve;
 
-        fprintf(f, "  vl     : %d\n", ri->sve.vl);
+        fprintf(f, "  vl     : %d\n", ri->sve_vl);
 
-        for (i = 0; i < 32; i++) {
-            fprintf(f, "  Z%-2d q%-2d: %016" PRIx64 "%016" PRIx64 "\n", i, 0,
-                    (uint64_t)(ri->sve.zregs[i][0] >> 64),
-                    (uint64_t)ri->sve.zregs[i][0]);
+        for (i = 0; i < SVE_NUM_ZREGS; i++) {
+            uint64_t *z = reginfo_zreg(ri, vq, i);
+
+            fprintf(f, "  Z%-2d q%-2d: %016" PRIx64 "%016" PRIx64 "\n",
+                    i, 0, z[1], z[0]);
             for (q = 1; q < vq; ++q) {
-                fprintf(f, "      q%-2d: %016" PRIx64 "%016" PRIx64 "\n", q,
-                        (uint64_t)(ri->sve.zregs[i][q] >> 64),
-                        (uint64_t)ri->sve.zregs[i][q]);
+                fprintf(f, "      q%-2d: %016" PRIx64 "%016" PRIx64 "\n",
+                        q, z[q * 2 + 1], z[q * 2]);
             }
         }
 
-        for (i = 0; i < 16; i++) {
-            fprintf(f, "  P%-2d    : ", i);
-            sve_dump_preg(f, vq, &ri->sve.pregs[i][0]);
+        for (i = 0; i < SVE_NUM_PREGS + 1; i++) {
+            uint16_t *p = reginfo_preg(ri, vq, i);
+
+            if (i == SVE_NUM_PREGS) {
+                fprintf(f, "  FFR    : ");
+            } else {
+                fprintf(f, "  P%-2d    : ", i);
+            }
+            sve_dump_preg(f, vq, p);
             fprintf(f, "\n");
         }
-        fprintf(f, "  FFR    : ");
-        sve_dump_preg(f, vq, &ri->sve.ffr[0]);
-        fprintf(f, "\n");
-
         return !ferror(f);
     }
 #endif
@@ -338,31 +340,34 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
 
 #ifdef SVE_MAGIC
     if (test_sve) {
-        int vq = sve_vq_from_vl(m->sve.vl);
+        int vq = sve_vq_from_vl(m->sve_vl);
 
-        if (m->sve.vl != a->sve.vl) {
-            fprintf(f, "  vl    : %d vs %d\n", m->sve.vl, a->sve.vl);
+        if (m->sve_vl != a->sve_vl) {
+            fprintf(f, "  vl    : %d vs %d\n", m->sve_vl, a->sve_vl);
         }
 
         for (i = 0; i < SVE_NUM_ZREGS; i++) {
-            if (!sve_zreg_is_eq(vq, &m->sve.zregs[i], &a->sve.zregs[i])) {
-                fprintf(f, "  Z%-2d ", i);
-                sve_dump_zreg_diff(f, vq, &m->sve.zregs[i][0],
-                                   &a->sve.zregs[i][0]);
-            }
-        }
-        for (i = 0; i < SVE_NUM_PREGS; i++) {
-            if (!sve_preg_is_eq(vq, &m->sve.pregs[i], &a->sve.pregs[i])) {
-                fprintf(f, "  P%-2d    : ", i);
-                sve_dump_preg_diff(f, vq, &m->sve.pregs[i][0],
-                                   &a->sve.pregs[i][0]);
-            }
-        }
-        if (!sve_preg_is_eq(vq, &m->sve.ffr, &a->sve.ffr)) {
-            fprintf(f, "  FFR   : ");
-            sve_dump_preg_diff(f, vq, &m->sve.pregs[i][0], &a->sve.pregs[i][0]);
-        }
+            uint64_t *zm = reginfo_zreg(m, vq, i);
+            uint64_t *za = reginfo_zreg(a, vq, i);
 
+            if (!sve_zreg_is_eq(vq, zm, za)) {
+                fprintf(f, "  Z%-2d ", i);
+                sve_dump_zreg_diff(f, vq, zm, za);
+            }
+        }
+        for (i = 0; i < SVE_NUM_PREGS + 1; i++) {
+            uint16_t *pm = reginfo_preg(m, vq, i);
+            uint16_t *pa = reginfo_preg(a, vq, i);
+
+            if (!sve_preg_is_eq(vq, pm, pa)) {
+                if (i == SVE_NUM_PREGS) {
+                    fprintf(f, "  FFR   : ");
+                } else {
+                    fprintf(f, "  P%-2d    : ", i);
+                }
+                sve_dump_preg_diff(f, vq, pm, pa);
+            }
+        }
         return !ferror(f);
     }
 #endif
-- 
2.20.1


