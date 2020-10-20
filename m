Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FE4C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 360B4206DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kcptu55x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360B4206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuoo-0005MI-TO
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kUue5-0007tj-0y
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:37:57 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kUue1-0000zW-Rx
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:37:56 -0400
Received: by mail-wm1-x343.google.com with SMTP id d3so2686437wma.4
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 09:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uOhU29/NowXaLPExLCEbzYi18ydUnYSK+IxcDeBgxSI=;
 b=kcptu55xjjFF/p7RbLQ4mfuLVT79FXhRb9BsjwiMmnRbHNpNNiQGckX1dZY+hu0AjB
 Z29hQ7tyYeNVCMZeRcqxnorFdljLHqQdh1XbQrL4p1pQSxFOOoc32ZlQoFf2gipeU3p3
 KJ50vpd64IvyMtA9csJdQ2EguPJxNZQ2ai0ToNtTYIR04GV/QviMa03RbDn3Z9PFvA7J
 uw7zSuYa/waYdAql/Zq1vyHdY81URJd4hCksEORP3RxJiJLnrJAfChhol3AVeBLh5z8b
 E1W4bjINuMedweEGviUGM9NppwiFE95QWaC3pdCGmqvs1r7DLP2dW8lzcBszuPVkdr8b
 FDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uOhU29/NowXaLPExLCEbzYi18ydUnYSK+IxcDeBgxSI=;
 b=gTP5M1jrBB8SVrOlda9RdlvnFiS1bQZ39KDkwtFB6BPBJZG/8zr3V3SbGz1jjg6I3i
 chyM+cp4Jjmeemq5VCTV18WBOPHuVqTyBq3O0/1EuTAo0yZMeYJUJCLIyk2HggqgEvPf
 E/oy8oS8itVVTKyD9c6LCkFHHGRIdehgLYW6/22cM9a69RztFDVd9s+1q/FvhrDAkS5H
 4iyToOPR1CFi0WghumqMWsvYGiF9bvJdHly/jFqDG5ShfK2LrZbRsiPozry1ES3/gqkw
 cPCx116TzPLvDAYNU3babUmhefOMcenEzFy4FEJ6WzXAAG1o3M8qANAGRAinYXY7OIjh
 En2A==
X-Gm-Message-State: AOAM530WkC+CSf30irbzKHl3clxNikJUJ6RRqp0f/Bx/uas8FwwELhPi
 Lro5jPhD2I2bQ3YunANGCAQYJw==
X-Google-Smtp-Source: ABdhPJx/m7TpN5UQ4N8OQvB7B6biQybod5e/dx4k5irZDXDnH2+4gm5Lyvc64dvjyQ/q/bTyEa93oA==
X-Received: by 2002:a1c:e1d7:: with SMTP id y206mr3793231wmg.48.1603211870679; 
 Tue, 20 Oct 2020 09:37:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q10sm3639313wrp.83.2020.10.20.09.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 09:37:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2E5611FF93;
 Tue, 20 Oct 2020 17:37:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH  7/8] tests/fp: add quad support to the benchmark utility
Date: Tue, 20 Oct 2020 17:37:37 +0100
Message-Id: <20201020163738.27700-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020163738.27700-1-alex.bennee@linaro.org>
References: <20201020163738.27700-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently this only support softfloat calculations because working out
if the hardware supports 128 bit floats needs configure magic. The 3
op muladd operation is currently unimplemented so commented out for
now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/fp/fp-bench.c | 88 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 83 insertions(+), 5 deletions(-)

diff --git a/tests/fp/fp-bench.c b/tests/fp/fp-bench.c
index 4ba5e1d2d4..d319993280 100644
--- a/tests/fp/fp-bench.c
+++ b/tests/fp/fp-bench.c
@@ -14,6 +14,7 @@
 #include <math.h>
 #include <fenv.h>
 #include "qemu/timer.h"
+#include "qemu/int128.h"
 #include "fpu/softfloat.h"
 
 /* amortize the computation of random inputs */
@@ -50,8 +51,10 @@ static const char * const op_names[] = {
 enum precision {
     PREC_SINGLE,
     PREC_DOUBLE,
+    PREC_QUAD,
     PREC_FLOAT32,
     PREC_FLOAT64,
+    PREC_FLOAT128,
     PREC_MAX_NR,
 };
 
@@ -89,6 +92,7 @@ union fp {
     double d;
     float32 f32;
     float64 f64;
+    float128 f128;
     uint64_t u64;
 };
 
@@ -113,6 +117,10 @@ struct op_desc {
 static uint64_t random_ops[MAX_OPERANDS] = {
     SEED_A, SEED_B, SEED_C,
 };
+
+static float128 random_quad_ops[MAX_OPERANDS] = {
+    {SEED_A, SEED_B}, {SEED_B, SEED_C}, {SEED_C, SEED_A},
+};
 static float_status soft_status;
 static enum precision precision;
 static enum op operation;
@@ -141,25 +149,45 @@ static void update_random_ops(int n_ops, enum precision prec)
     int i;
 
     for (i = 0; i < n_ops; i++) {
-        uint64_t r = random_ops[i];
 
         switch (prec) {
         case PREC_SINGLE:
         case PREC_FLOAT32:
+        {
+            uint64_t r = random_ops[i];
             do {
                 r = xorshift64star(r);
             } while (!float32_is_normal(r));
+            random_ops[i] = r;
             break;
+        }
         case PREC_DOUBLE:
         case PREC_FLOAT64:
+        {
+            uint64_t r = random_ops[i];
             do {
                 r = xorshift64star(r);
             } while (!float64_is_normal(r));
+            random_ops[i] = r;
+            break;
+        }
+        case PREC_QUAD:
+        case PREC_FLOAT128:
+        {
+            float128 r = random_quad_ops[i];
+            uint64_t hi = r.high;
+            uint64_t lo = r.low;
+            do {
+                hi = xorshift64star(hi);
+                lo = xorshift64star(lo);
+                r = make_float128(hi, lo);
+            } while (!float128_is_normal(r));
+            random_quad_ops[i] = r;
             break;
+        }
         default:
             g_assert_not_reached();
         }
-        random_ops[i] = r;
     }
 }
 
@@ -184,6 +212,13 @@ static void fill_random(union fp *ops, int n_ops, enum precision prec,
                 ops[i].f64 = float64_chs(ops[i].f64);
             }
             break;
+        case PREC_QUAD:
+        case PREC_FLOAT128:
+            ops[i].f128 = random_quad_ops[i];
+            if (no_neg && float128_is_neg(ops[i].f128)) {
+                ops[i].f128 = float128_chs(ops[i].f128);
+            }
+            break;
         default:
             g_assert_not_reached();
         }
@@ -345,6 +380,41 @@ static void bench(enum precision prec, enum op op, int n_ops, bool no_neg)
                 }
             }
             break;
+        case PREC_FLOAT128:
+            fill_random(ops, n_ops, prec, no_neg);
+            t0 = get_clock();
+            for (i = 0; i < OPS_PER_ITER; i++) {
+                float128 a = ops[0].f128;
+                float128 b = ops[1].f128;
+                /* float128 c = ops[2].f128; */
+
+                switch (op) {
+                case OP_ADD:
+                    res.f128 = float128_add(a, b, &soft_status);
+                    break;
+                case OP_SUB:
+                    res.f128 = float128_sub(a, b, &soft_status);
+                    break;
+                case OP_MUL:
+                    res.f128 = float128_mul(a, b, &soft_status);
+                    break;
+                case OP_DIV:
+                    res.f128 = float128_div(a, b, &soft_status);
+                    break;
+                /* case OP_FMA: */
+                /*     res.f128 = float128_muladd(a, b, c, 0, &soft_status); */
+                /*     break; */
+                case OP_SQRT:
+                    res.f128 = float128_sqrt(a, &soft_status);
+                    break;
+                case OP_CMP:
+                    res.u64 = float128_compare_quiet(a, b, &soft_status);
+                    break;
+                default:
+                    g_assert_not_reached();
+                }
+            }
+            break;
         default:
             g_assert_not_reached();
         }
@@ -369,7 +439,8 @@ static void bench(enum precision prec, enum op op, int n_ops, bool no_neg)
     GEN_BENCH(bench_ ## opname ## _float, float, PREC_SINGLE, op, n_ops) \
     GEN_BENCH(bench_ ## opname ## _double, double, PREC_DOUBLE, op, n_ops) \
     GEN_BENCH(bench_ ## opname ## _float32, float32, PREC_FLOAT32, op, n_ops) \
-    GEN_BENCH(bench_ ## opname ## _float64, float64, PREC_FLOAT64, op, n_ops)
+    GEN_BENCH(bench_ ## opname ## _float64, float64, PREC_FLOAT64, op, n_ops) \
+    GEN_BENCH(bench_ ## opname ## _float128, float128, PREC_FLOAT128, op, n_ops)
 
 GEN_BENCH_ALL_TYPES(add, OP_ADD, 2)
 GEN_BENCH_ALL_TYPES(sub, OP_SUB, 2)
@@ -383,7 +454,8 @@ GEN_BENCH_ALL_TYPES(cmp, OP_CMP, 2)
     GEN_BENCH_NO_NEG(bench_ ## name ## _float, float, PREC_SINGLE, op, n) \
     GEN_BENCH_NO_NEG(bench_ ## name ## _double, double, PREC_DOUBLE, op, n) \
     GEN_BENCH_NO_NEG(bench_ ## name ## _float32, float32, PREC_FLOAT32, op, n) \
-    GEN_BENCH_NO_NEG(bench_ ## name ## _float64, float64, PREC_FLOAT64, op, n)
+    GEN_BENCH_NO_NEG(bench_ ## name ## _float64, float64, PREC_FLOAT64, op, n) \
+    GEN_BENCH_NO_NEG(bench_ ## name ## _float128, float128, PREC_FLOAT128, op, n)
 
 GEN_BENCH_ALL_TYPES_NO_NEG(sqrt, OP_SQRT, 1)
 #undef GEN_BENCH_ALL_TYPES_NO_NEG
@@ -397,6 +469,7 @@ GEN_BENCH_ALL_TYPES_NO_NEG(sqrt, OP_SQRT, 1)
         [PREC_DOUBLE]    = bench_ ## opname ## _double,         \
         [PREC_FLOAT32]   = bench_ ## opname ## _float32,        \
         [PREC_FLOAT64]   = bench_ ## opname ## _float64,        \
+        [PREC_FLOAT128]   = bench_ ## opname ## _float128,      \
     }
 
 static const bench_func_t bench_funcs[OP_MAX_NR][PREC_MAX_NR] = {
@@ -445,7 +518,7 @@ static void usage_complete(int argc, char *argv[])
     fprintf(stderr, " -h = show this help message.\n");
     fprintf(stderr, " -o = floating point operation (%s). Default: %s\n",
             op_list, op_names[0]);
-    fprintf(stderr, " -p = floating point precision (single, double). "
+    fprintf(stderr, " -p = floating point precision (single, double, quad[soft only]). "
             "Default: single\n");
     fprintf(stderr, " -r = rounding mode (even, zero, down, up, tieaway). "
             "Default: even\n");
@@ -565,6 +638,8 @@ static void parse_args(int argc, char *argv[])
                 precision = PREC_SINGLE;
             } else if (!strcmp(optarg, "double")) {
                 precision = PREC_DOUBLE;
+            } else if (!strcmp(optarg, "quad")) {
+                precision = PREC_QUAD;
             } else {
                 fprintf(stderr, "Unsupported precision '%s'\n", optarg);
                 exit(EXIT_FAILURE);
@@ -608,6 +683,9 @@ static void parse_args(int argc, char *argv[])
         case PREC_DOUBLE:
             precision = PREC_FLOAT64;
             break;
+        case PREC_QUAD:
+            precision = PREC_FLOAT128;
+            break;
         default:
             g_assert_not_reached();
         }
-- 
2.20.1


