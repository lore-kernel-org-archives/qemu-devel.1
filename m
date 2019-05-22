Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A65AC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:33:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB902089E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYPob7b0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB902089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52555 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTZnl-0006qe-9U
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 18:33:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZip-0002wO-Uo
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZio-0007K6-1y
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:31 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:33082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTZin-0007JT-Sm
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:29 -0400
Received: by mail-yw1-xc44.google.com with SMTP id v81so1494347ywe.0
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 15:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=dIrUBx1AozwSRTf1CstcHoUDbRuw3JV0rC9AxpXdw/A=;
	b=IYPob7b0zzs+KlftGHpeu4nEX3FpGsNqAjDLjjae9PvIhmoVaM0r7mloEGNqdk9086
	xdvZyYgbaspSq4kpH2+vuQIuicGIxfJS3tuZZCyGVTXk8Pn6ykXsm9RjJyY+ohxAJsgg
	rz646o2U1lzUekg0d0IyBZBBwJf6BXJ0o8qyiaxMX6EBRTFdzNhGHSAFcb+10XQ0zU1D
	ZXSdXZ1VQXyKJ/C39J13Ueq6XhPIqgreQA0sWpEbAM8Wg5tDEcW27BwKsGfPQrHHo/nU
	AfGi2Hu6nUywlV1W0oKqQtV2ex7P2dKh7KCBNJG4oZNaUMQ4dsQWR5t08tyZNUGsR+1E
	q6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=dIrUBx1AozwSRTf1CstcHoUDbRuw3JV0rC9AxpXdw/A=;
	b=X8MNNn/4vLy8jU7bWkC0R15b8p+gYaccgfvVaYpjVYlrq2soYBMxuwbrEpP4DwshzZ
	6P+5TBWk8siqe67Xjv3UAh2fguKr1lqFjavjZsFTTKjsOswX3jPlcyQWOb0nLac0fcaq
	3mrmdv41vCIkS7qby55PG2AFgrcd5Quc52H9PVQ95pgZIF4vnY1S6RhnJmSN1d4EHXfk
	CGd7sw7vDLlVraN/srj78BmCrn9nWfAm1UFG+vvAizFvSDJkXbm0/JWovwowyR3mfdSO
	28p5zpYpm/L9Fch3W9ROaaJp3Gx7AO0EFU5qmwtamTwdKpNuQGf4e4O4bZfM4riNyvO5
	aV5g==
X-Gm-Message-State: APjAAAVfOuCrSSJrwVikjvwET9iZnJFxDaZrAGV2C4ZjsYAfev66ppAU
	Y3xhIPzn+SOuXn8qB8wcRrMc8qHv/i0=
X-Google-Smtp-Source: APXvYqy59uJYg3FtG2fyvPMUX5QOHYubXFyW6vDKBI+jBjP/LcR4hpcMquhGTCbImlRlwUYdl5JtPA==
X-Received: by 2002:a81:72d5:: with SMTP id n204mr43050821ywc.72.1558564108440;
	Wed, 22 May 2019 15:28:28 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id q11sm2276453ywg.7.2019.05.22.15.28.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 15:28:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 18:28:09 -0400
Message-Id: <20190522222821.23850-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522222821.23850-1-richard.henderson@linaro.org>
References: <20190522222821.23850-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [PULL 04/16] tcg: Add support for vector compare select
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Perform a per-element conditional move.  This combination operation is
easier to implement on some host vector units than plain cmp+bitsel.
Omit the usual gvec interface, as this is intended to be used by
target-specific gvec expansion call-backs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h |  1 +
 tcg/i386/tcg-target.h    |  1 +
 tcg/tcg-op.h             |  2 ++
 tcg/tcg-opc.h            |  1 +
 tcg/tcg.h                |  1 +
 tcg/tcg-op-vec.c         | 59 ++++++++++++++++++++++++++++++++++++++++
 tcg/tcg.c                |  3 ++
 tcg/README               |  7 +++++
 8 files changed, 75 insertions(+)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 52ee66424f..b4a9d36bbc 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -141,6 +141,7 @@ typedef enum {
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       0
+#define TCG_TARGET_HAS_cmpsel_vec       0
 
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_HAS_MEMORY_BSWAP     1
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 08a0386433..16a83a7f7b 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -191,6 +191,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       0
+#define TCG_TARGET_HAS_cmpsel_vec       0
 
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
     (((ofs) == 0 && (len) == 8) || ((ofs) == 8 && (len) == 8) || \
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 268860ed2f..2d4dd5cd7d 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -1002,6 +1002,8 @@ void tcg_gen_cmp_vec(TCGCond cond, unsigned vece, TCGv_vec r,
 
 void tcg_gen_bitsel_vec(unsigned vece, TCGv_vec r, TCGv_vec a,
                         TCGv_vec b, TCGv_vec c);
+void tcg_gen_cmpsel_vec(TCGCond cond, unsigned vece, TCGv_vec r,
+                        TCGv_vec a, TCGv_vec b, TCGv_vec c, TCGv_vec d);
 
 void tcg_gen_ld_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
 void tcg_gen_st_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index c05b71427c..c7d971fa3d 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -257,6 +257,7 @@ DEF(sarv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shv_vec))
 DEF(cmp_vec, 1, 2, 1, IMPLVEC)
 
 DEF(bitsel_vec, 1, 3, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_bitsel_vec))
+DEF(cmpsel_vec, 1, 4, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_cmpsel_vec))
 
 DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 72f9f6c70b..21cd6f1249 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -188,6 +188,7 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_sat_vec          0
 #define TCG_TARGET_HAS_minmax_vec       0
 #define TCG_TARGET_HAS_bitsel_vec       0
+#define TCG_TARGET_HAS_cmpsel_vec       0
 #else
 #define TCG_TARGET_MAYBE_vec            1
 #endif
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 99cbf29e0b..a888c02df8 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -119,6 +119,11 @@ bool tcg_can_emit_vecop_list(const TCGOpcode *list,
                 continue;
             }
             break;
+        case INDEX_op_cmpsel_vec:
+            if (tcg_can_emit_vec_op(INDEX_op_cmp_vec, type, vece)) {
+                continue;
+            }
+            break;
         default:
             break;
         }
@@ -159,6 +164,20 @@ void vec_gen_4(TCGOpcode opc, TCGType type, unsigned vece,
     op->args[3] = c;
 }
 
+static void vec_gen_6(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r,
+                      TCGArg a, TCGArg b, TCGArg c, TCGArg d, TCGArg e)
+{
+    TCGOp *op = tcg_emit_op(opc);
+    TCGOP_VECL(op) = type - TCG_TYPE_V64;
+    TCGOP_VECE(op) = vece;
+    op->args[0] = r;
+    op->args[1] = a;
+    op->args[2] = b;
+    op->args[3] = c;
+    op->args[4] = d;
+    op->args[5] = e;
+}
+
 static void vec_gen_op2(TCGOpcode opc, unsigned vece, TCGv_vec r, TCGv_vec a)
 {
     TCGTemp *rt = tcgv_vec_temp(r);
@@ -717,3 +736,43 @@ void tcg_gen_bitsel_vec(unsigned vece, TCGv_vec r, TCGv_vec a,
         tcg_temp_free_vec(t);
     }
 }
+
+void tcg_gen_cmpsel_vec(TCGCond cond, unsigned vece, TCGv_vec r,
+                        TCGv_vec a, TCGv_vec b, TCGv_vec c, TCGv_vec d)
+{
+    TCGTemp *rt = tcgv_vec_temp(r);
+    TCGTemp *at = tcgv_vec_temp(a);
+    TCGTemp *bt = tcgv_vec_temp(b);
+    TCGTemp *ct = tcgv_vec_temp(c);
+    TCGTemp *dt = tcgv_vec_temp(d);
+    TCGArg ri = temp_arg(rt);
+    TCGArg ai = temp_arg(at);
+    TCGArg bi = temp_arg(bt);
+    TCGArg ci = temp_arg(ct);
+    TCGArg di = temp_arg(dt);
+    TCGType type = rt->base_type;
+    const TCGOpcode *hold_list;
+    int can;
+
+    tcg_debug_assert(at->base_type >= type);
+    tcg_debug_assert(bt->base_type >= type);
+    tcg_debug_assert(ct->base_type >= type);
+    tcg_debug_assert(dt->base_type >= type);
+
+    tcg_assert_listed_vecop(INDEX_op_cmpsel_vec);
+    hold_list = tcg_swap_vecop_list(NULL);
+    can = tcg_can_emit_vec_op(INDEX_op_cmpsel_vec, type, vece);
+
+    if (can > 0) {
+        vec_gen_6(INDEX_op_cmpsel_vec, type, vece, ri, ai, bi, ci, di, cond);
+    } else if (can < 0) {
+        tcg_expand_vec_op(INDEX_op_cmpsel_vec, type, vece,
+                          ri, ai, bi, ci, di, cond);
+    } else {
+        TCGv_vec t = tcg_temp_new_vec(type);
+        tcg_gen_cmp_vec(cond, vece, t, a, b);
+        tcg_gen_bitsel_vec(vece, r, t, c, d);
+        tcg_temp_free_vec(t);
+    }
+    tcg_swap_vecop_list(hold_list);
+}
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 5d947dbcb0..02a2680169 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1648,6 +1648,8 @@ bool tcg_op_supported(TCGOpcode op)
         return have_vec && TCG_TARGET_HAS_minmax_vec;
     case INDEX_op_bitsel_vec:
         return have_vec && TCG_TARGET_HAS_bitsel_vec;
+    case INDEX_op_cmpsel_vec:
+        return have_vec && TCG_TARGET_HAS_cmpsel_vec;
 
     default:
         tcg_debug_assert(op > INDEX_op_last_generic && op < NB_OPS);
@@ -2028,6 +2030,7 @@ static void tcg_dump_ops(TCGContext *s, bool have_prefs)
             case INDEX_op_setcond_i64:
             case INDEX_op_movcond_i64:
             case INDEX_op_cmp_vec:
+            case INDEX_op_cmpsel_vec:
                 if (op->args[k] < ARRAY_SIZE(cond_name)
                     && cond_name[op->args[k]]) {
                     col += qemu_log(",%s", cond_name[op->args[k++]]);
diff --git a/tcg/README b/tcg/README
index 76057ab59f..21fcdf737f 100644
--- a/tcg/README
+++ b/tcg/README
@@ -631,6 +631,13 @@ E.g. VECL=1 -> 64 << 1 -> v128, and VECE=2 -> 1 << 2 -> i32.
 
   Bitwise select, v0 = (v2 & v1) | (v3 & ~v1), across the entire vector.
 
+* cmpsel_vec v0, c1, c2, v3, v4, cond
+
+  Select elements based on comparison results:
+  for (i = 0; i < n; ++i) {
+    v0[i] = (c1[i] cond c2[i]) ? v3[i] : v4[i].
+  }
+
 *********
 
 Note 1: Some shortcuts are defined when the last operand is known to be
-- 
2.17.1


