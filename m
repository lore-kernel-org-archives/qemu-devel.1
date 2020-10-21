Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4206C5517A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 05:02:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D2120936
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 05:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iJDvrXl9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D2120936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV6GI-0002c7-Iy
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 01:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66g-0000ut-Ak
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:52:14 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46886)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66e-0005mt-Fe
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:52:13 -0400
Received: by mail-pf1-x442.google.com with SMTP id y14so727954pfp.13
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 21:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L/Y6IwJodXEJY+Oy5VNijd3IS8AKx3LhqtUy8JRkWdQ=;
 b=iJDvrXl9zWkq2jwrDeahTjDp8NnichL4yv/1Pv0bCUmrKQi2O523YzH1E0t7pHPCLg
 hsppbRX46wG4J3JgmuXJ8ewmuVieAI7f8TWRA3ZtweMOOnjwBnBmm3TAo2sfjunuj5fb
 ovh/sJUmPG62JVQceH+rLUXPVw4nu4k5y776ud2xbL6mviGunhtBAXtfhl3YwwLuyY5h
 GsJfjHsPNcZyZsRI/Fr0QiZpMHh2KQQIthWKJ0ceX4SmSgCj2GoM468ieWA7MghES3Hm
 u/enTPsM+XETk9YYoolnRNO05pDGSVzKHhLC7I/0T4qE8L4hWhUlezuim07moKFn5OLe
 Nddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L/Y6IwJodXEJY+Oy5VNijd3IS8AKx3LhqtUy8JRkWdQ=;
 b=HqKVikiv17IYlObV/iMTamYQ1ospvPZki1m9Jx02LZbXDv68NhIHIhndO5HQcnC2Yi
 Xk1L3nztLDoBLJbDX8nkWCKcphIkQZKsR6JH2WsguqXyOXlJJ/HO3myt+NZNkwHD+Of0
 h0QIKjSA5L27O0MWy+VP4uBX+9WPmjm2CHb2bIEws8mTXlXfJxqP4TDAYLBSM90V1cN/
 hOCwrS29ORn18kvqRo5AJ8IrZPxfwIgweYVBMzD6hfg27MMD+2O897h+FeaVKVqsIZu6
 RJM+25e1gUc6cTe6sAZbCNkU6Mmv/MkkBYbPrpI4c8I+xzminighCuVnzWMwEArFMbJY
 MKIQ==
X-Gm-Message-State: AOAM533RJbXV9K2W09tU/KTMBajrNrdfxUgLaOwNPB2cm0wEZ4H8rA0s
 VmLSnn4FN1+7PT1MLvIwE059xVo5i+XxRA==
X-Google-Smtp-Source: ABdhPJzA6HrJBf3u2liKs+EtMWIFq2FglvQh+R/4W48SNa8MOfGMZPXfhfVZVHo9GhEtoxO4HhgbFw==
X-Received: by 2002:aa7:9f0f:0:b029:155:ef07:6ae0 with SMTP id
 g15-20020aa79f0f0000b0290155ef076ae0mr1576797pfr.70.1603255930700; 
 Tue, 20 Oct 2020 21:52:10 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j11sm620070pfh.143.2020.10.20.21.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 21:52:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 15/15] softfloat: Improve subtraction of equal exponent
Date: Tue, 20 Oct 2020 21:51:49 -0700
Message-Id: <20201021045149.1582203-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021045149.1582203-1-richard.henderson@linaro.org>
References: <20201021045149.1582203-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rather than compare the fractions before subtracting, do the
subtract and examine the result, possibly negating it.

Looking toward re-using addsub_floats(N**2) for the addition
stage of muladd_floats(N), this will important because of the
longer fraction sizes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           |  4 ++++
 fpu/softfloat-parts.c.inc | 32 ++++++++++++++++++++------------
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 294c573fb9..bf808a1b74 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -732,6 +732,7 @@ static FloatParts pick_nan_muladd(FloatParts a, FloatParts b, FloatParts c,
 #define EQ0(P)            ((P) == 0)
 #define EQ(P1, P2)        ((P1) == (P2))
 #define GEU(P1, P2)       ((P1) >= (P2))
+#define NEG(P)            (-(P))
 #define OR(P1, P2)        ((P1) | (P2))
 #define SHL(P, C)         ((P) << (C))
 #define SHR(P, C)         ((P) >> (C))
@@ -755,6 +756,7 @@ static FloatParts pick_nan_muladd(FloatParts a, FloatParts b, FloatParts c,
 #undef EQ0
 #undef EQ
 #undef GEU
+#undef NEG
 #undef OR
 #undef SHL
 #undef SHR
@@ -777,6 +779,7 @@ static FloatParts pick_nan_muladd(FloatParts a, FloatParts b, FloatParts c,
 #define EQ0(P)            (!int128_nz(P))
 #define EQ(P1, P2)        int128_eq(P1, P2)
 #define GEU(P1, P2)       int128_geu(P1, P2)
+#define NEG(P)            int128_neg(P)
 #define OR(P1, P2)        int128_or(P1, P2)
 #define SHL(P, C)         int128_shl(P, C)
 #define SHR(P, C)         int128_shr(P, C)
@@ -801,6 +804,7 @@ static FloatParts pick_nan_muladd(FloatParts a, FloatParts b, FloatParts c,
 #undef EQ0
 #undef EQ
 #undef GEU
+#undef NEG
 #undef SHL
 #undef SHR
 #undef SHR_JAM
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index d2b6454903..9762cf8b66 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -254,29 +254,37 @@ FUNC(addsub_floats)(PARTS_TYPE a, PARTS_TYPE b,
         /* Subtraction */
 
         if (likely(ab_mask == float_cmask_normal)) {
-            if (a.exp > b.exp || (a.exp == b.exp && GEU(a.frac, b.frac))) {
-                b.frac = SHR_JAM(b.frac, a.exp - b.exp);
+            int shift, diff_exp = a.exp - b.exp;
+
+            if (diff_exp > 0) {
+                b.frac = SHR_JAM(b.frac, diff_exp);
                 a.frac = SUB(a.frac, b.frac);
-            } else {
-                a.frac = SHR_JAM(a.frac, b.exp - a.exp);
+            } else if (diff_exp < 0) {
+                a.frac = SHR_JAM(a.frac, -diff_exp);
                 a.frac = SUB(b.frac, a.frac);
                 a.exp = b.exp;
                 a.sign ^= 1;
+            } else {
+                a.frac = SUB(b.frac, a.frac);
+                /* a.frac < b.frac results in carry into the overflow bit. */
+                if (HI(a.frac) & DECOMPOSED_OVERFLOW_BIT) {
+                    a.frac = NEG(a.frac);
+                    a.sign ^= 1;
+                } else if (EQ0(a.frac)) {
+                    a.cls = float_class_zero;
+                    goto sub_zero;
+                }
             }
 
-            if (EQ0(a.frac)) {
-                a.cls = float_class_zero;
-                a.sign = s->float_rounding_mode == float_round_down;
-            } else {
-                int shift = CLZ(a.frac) - 1;
-                a.frac = SHL(a.frac, shift);
-                a.exp -= shift;
-            }
+            shift = CLZ(a.frac) - 1;
+            a.frac = SHL(a.frac, shift);
+            a.exp -= shift;
             return a;
         }
 
         /* 0 - 0 */
         if (ab_mask == float_cmask_zero) {
+ sub_zero:
             a.sign = s->float_rounding_mode == float_round_down;
             return a;
         }
-- 
2.25.1


