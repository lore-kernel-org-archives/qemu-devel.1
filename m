Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B83DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 03:03:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4118C20674
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 03:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DOUm4Kug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4118C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jasX6-0004mP-EQ
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 23:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasOc-0005ie-1C
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:22 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:35247)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasOa-0002X7-T3
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:21 -0400
Received: by mail-pf1-x42c.google.com with SMTP id n18so5869244pfa.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 19:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hhzEI0zY7uuhea/eDo3m8LR1KeJI+fOWQZOyopQnOJc=;
 b=DOUm4KugWp/kOGDAKBupoFDC4SqvBW90J9aXblWXvgZeGWiKVjvmUmslh5vjIBVCXz
 GxzF4JkYikUtnNbzTDVN9Lzr1LpibCDVdwSBJkxfPMDgkUEgnOp4Rt8A7Rj+MskHS43G
 G8HWgtdCaDplTZK8yJYTfOifAsYt+yWc83g4bC6s8y4ZLpO6O1HEnOasE1GZdwZGrPa+
 BpnO5t86Tuq6Nhj6AFC6sQIxt0/XS5Jzy/Kb52oVWcz+s3G3bBI5ArRsrvwOsEYdHphO
 YqSwIG6RjWbhJLatGe3qKdEArwBHpRzyJwtifjJR/iZe5mi1nanE6UxCsDK6jSVOh5rf
 yZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hhzEI0zY7uuhea/eDo3m8LR1KeJI+fOWQZOyopQnOJc=;
 b=k37VGu/Z+lg/4cJT/T3ETM/fS8wwi0S7dfopHYf4LQV4cHosJjSCNWpqOXlW0z5ZBo
 GzkWt4P+iR+S0pMU7xkNo1QuigTlIL2gkWT7Al4mK9yPYhUJTAAhWP8NayY08V+oftD6
 Kf4Sm+OqjdvP0IfRk+Rjxr8Vi+owVH1kvj+k73nOcZs4Vt2cZnKKSm3Kv7Wgx6mHLve1
 JfjtYlSoeOzPglvapQlokiSk0oM0eqs1JjjW4dlvPibuuHdAaTIwCCxZuF0SfljJi7cq
 Gr72jX1Y/8v6J/+MvAMAN32jJsWAUqA1AQ+csJuqnPbmVy6x37RJ1kDjfkI+wiueGlGL
 nzzg==
X-Gm-Message-State: AOAM530x5bTsyhCk7m8ojia70PiIFIGd/QFSi5F2q8rdGAW95oFKLtus
 VkfFgLHV/RrEk19PlDeK3ASZM2ZQ23g=
X-Google-Smtp-Source: ABdhPJzJkT9Eh0XkzjMGkyco7yQZYC6fhHdpSb3ztbdWLHiLiSgqcZxydJOl3cAIjrQVHqyoJjCMRA==
X-Received: by 2002:a63:fb14:: with SMTP id o20mr17903000pgh.144.1589856858940; 
 Mon, 18 May 2020 19:54:18 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id a2sm8772418pgh.57.2020.05.18.19.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 19:54:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RISU v2 16/17] aarch64: Reorg sve reginfo to save space
Date: Mon, 18 May 2020 19:53:54 -0700
Message-Id: <20200519025355.4420-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519025355.4420-1-richard.henderson@linaro.org>
References: <20200519025355.4420-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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


