Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4700DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:03:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 052F120720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VzO9zq8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052F120720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsgz-0005i6-2z
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqdM-0005Kt-3g
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:52:00 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqdJ-0006de-B4
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:51:59 -0400
Received: by mail-pg1-x544.google.com with SMTP id d4so2376021pgk.4
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vo3RZ3hCoyDKCtjdh1YpQa4b9rA0/P6MU16G39wxVVI=;
 b=VzO9zq8R5ScS/94cD14vtcq2xxFYwMpPTyxlrmM+cYPpEz/5Udw20PfxA/jR48V3zU
 8YJLGa5tbIzp+IQiVUzuTq1vpM2ooGUrDAJeC+rSiQrWUIDfyRGvOG6k7CE5dXdMYgCa
 ZoRlLc6DoxCQamZtGzZc0i0may+hOyOhJPcg+xcZDp4Dw3Lz8DWZ66VsGU7qqmtsxl6m
 LMPZkVjFR8F7vzAlkzMZQLowrPn4pNK6qL6kjfErruxs+plVHJqUqx0A4njkeRj/SMKp
 +WzpzViwJiJXY7JTZdStnzTSBRJ70Hoc4tZlKD6sdC8TuYKSnezhRrXSrBFwzb+Ij4r/
 +LqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vo3RZ3hCoyDKCtjdh1YpQa4b9rA0/P6MU16G39wxVVI=;
 b=NsPX9Yv/0nqLgAUR9aN68XteS1uTKegJUMxFss2v2gVWZdcYQw0fl9x3FmclQgAoJl
 e86TT3KMxQh4ECTQbNU2pnsK1PVpx2oO05CuJjbvt/wxENTwlHDJSPy2GSNss2AhEKus
 ZUga0DlJfrzNbYEW2SbnGvNRN/Q1jEKkZRYeihYO/JYL43JAsdYziNEJvHAMxurORbWT
 BJl6ZAKOUtjqPG3whGBqoPTjKwyKAKpQUaN9ghn1MvxyyIXvMUY3hxN0mzwRpuWQzq4Q
 5uqxu7GPq7oFvPCgdun1zQ72pNwgQ5cRAxXwVFJgMOMh0NNQ2kNNeHXBLibXSviMjy67
 NBTw==
X-Gm-Message-State: AOAM533H8JEsADTv3PxZhDeprnT7+lZMImy/aVZvEp5kmZO24iPcoX2e
 z1YzOyke+kh5RDvV8LfxzTATTQCRF2YrgA==
X-Google-Smtp-Source: ABdhPJy+YMkStw4QrJFLs05mlmclkqip8IahHTA8KGqf6H17r1yvIE9rPZ3sTgPcNMuCIQvliUwYFg==
X-Received: by 2002:a63:7a56:: with SMTP id j22mr58083960pgn.293.1594378315701; 
 Fri, 10 Jul 2020 03:51:55 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:51:55 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 20/65] target/riscv: rvv-0.9: update vext_max_elems() for
 load/store insns
Date: Fri, 10 Jul 2020 18:48:34 +0800
Message-Id: <20200710104920.13550-21-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2020 08:57:17 -0400
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/vector_helper.c | 118 ++++++++++++++++++++---------------
 1 file changed, 68 insertions(+), 50 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 39b9a462ab..2a006f956c 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -129,14 +129,32 @@ static inline uint32_t vext_vma(uint32_t desc)
 }
 
 /*
- * Get vector group length in bytes. Its range is [64, 2048].
- *
- * As simd_desc support at most 256, the max vlen is 512 bits.
- * So vlen in bytes is encoded as maxsz.
+ * Get the maximum number of elements can be operated.
  */
-static inline uint32_t vext_maxsz(uint32_t desc)
+static inline uint32_t vext_max_elems(uint32_t desc, uint32_t esz, bool is_ldst)
 {
-    return simd_maxsz(desc) << vext_lmul(desc);
+    /*
+     * As simd_desc support at most 256, the max vlen is 512 bits,
+     * so vlen in bytes (vlenb) is encoded as maxsz.
+     */
+    uint32_t vlenb = simd_maxsz(desc);
+
+    if (is_ldst) {
+        /*
+         * Vector load/store instructions have the EEW encoded
+         * directly in the instructions. The maximum vector size is
+         * calculated with EMUL rather than LMUL.
+         */
+        uint32_t eew = esz << 3;
+        uint32_t sew = vext_sew(desc);
+        float flmul = vext_vflmul(desc);
+        float emul = (float)eew / sew * flmul;
+        uint32_t emul_r = emul < 1 ? 1 : emul;
+        return vlenb * emul_r / esz;
+    } else {
+        /* Return VLMAX */
+        return vlenb * vext_vflmul(desc) / esz;
+    }
 }
 
 /*
@@ -296,7 +314,7 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
 {
     uint32_t i, k;
     uint32_t nf = vext_nf(desc);
-    uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t max_elems = vext_max_elems(desc, esz, true);
     uint32_t vta = vext_vta(desc);
 
     /* probe every access*/
@@ -314,15 +332,15 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
         }
         while (k < nf) {
             target_ulong addr = base + stride * i + k * esz;
-            ldst_elem(env, addr, i + k * vlmax, vd, ra);
+            ldst_elem(env, addr, i + k * max_elems, vd, ra);
             k++;
         }
     }
     /* clear tail elements */
     if (clear_elem) {
         for (k = 0; k < nf; k++) {
-            clear_elem(vd, vta, env->vl + k * vlmax,
-                       env->vl * esz, vlmax * esz);
+            clear_elem(vd, vta, env->vl + k * max_elems,
+                       env->vl * esz, max_elems * esz);
         }
     }
 }
@@ -371,7 +389,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
 {
     uint32_t i, k;
     uint32_t nf = vext_nf(desc);
-    uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t max_elems = vext_max_elems(desc, esz, true);
     uint32_t vta = vext_vta(desc);
 
     /* probe every access */
@@ -381,15 +399,15 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
         k = 0;
         while (k < nf) {
             target_ulong addr = base + (i * nf + k) * esz;
-            ldst_elem(env, addr, i + k * vlmax, vd, ra);
+            ldst_elem(env, addr, i + k * max_elems, vd, ra);
             k++;
         }
     }
     /* clear tail elements */
     if (clear_elem) {
         for (k = 0; k < nf; k++) {
-            clear_elem(vd, vta, env->vl + k * vlmax,
-                       env->vl * esz, vlmax * esz);
+            clear_elem(vd, vta, env->vl + k * max_elems,
+                       env->vl * esz, max_elems * esz);
         }
     }
 }
@@ -472,7 +490,7 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
     uint32_t i, k;
     uint32_t nf = vext_nf(desc);
     uint32_t vm = vext_vm(desc);
-    uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t max_elems = vext_max_elems(desc, esz, true);
     uint32_t vta = vext_vta(desc);
 
     /* probe every access*/
@@ -491,15 +509,15 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
         }
         while (k < nf) {
             abi_ptr addr = get_index_addr(base, i, vs2) + k * esz;
-            ldst_elem(env, addr, i + k * vlmax, vd, ra);
+            ldst_elem(env, addr, i + k * max_elems, vd, ra);
             k++;
         }
     }
     /* clear tail elements */
     if (clear_elem) {
         for (k = 0; k < nf; k++) {
-            clear_elem(vd, vta, env->vl + k * vlmax,
-                       env->vl * esz, vlmax * esz);
+            clear_elem(vd, vta, env->vl + k * max_elems,
+                       env->vl * esz, max_elems * esz);
         }
     }
 }
@@ -570,7 +588,7 @@ vext_ldff(void *vd, void *v0, target_ulong base,
     uint32_t i, k, vl = 0;
     uint32_t nf = vext_nf(desc);
     uint32_t vm = vext_vm(desc);
-    uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t max_elems = vext_max_elems(desc, esz, true);
     uint32_t vta = vext_vta(desc);
     target_ulong addr, offset, remain;
 
@@ -622,7 +640,7 @@ ProbeSuccess:
         }
         while (k < nf) {
             target_ulong addr = base + (i * nf + k) * esz;
-            ldst_elem(env, addr, i + k * vlmax, vd, ra);
+            ldst_elem(env, addr, i + k * max_elems, vd, ra);
             k++;
         }
     }
@@ -631,8 +649,8 @@ ProbeSuccess:
         return;
     }
     for (k = 0; k < nf; k++) {
-        clear_elem(vd, vta, env->vl + k * vlmax,
-                   env->vl * esz, vlmax * esz);
+        clear_elem(vd, vta, env->vl + k * max_elems,
+                   env->vl * esz, max_elems * esz);
     }
 }
 
@@ -659,7 +677,7 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
 {
     uint32_t i, k;
     uint32_t nf = vext_nf(desc);
-    uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t max_elems = vext_max_elems(desc, esz, true);
 
     /* probe every access */
     probe_pages(env, base, env->vlenb * nf * esz, ra, access_type);
@@ -669,7 +687,7 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
         k = 0;
         while (k < nf) {
             target_ulong addr = base + (i * nf + k) * esz;
-            ldst_elem(env, addr, i + k * vlmax, vd, ra);
+            ldst_elem(env, addr, i + k * max_elems, vd, ra);
             k++;
         }
     }
@@ -812,7 +830,7 @@ vext_amo_noatomic(void *vs3, void *v0, target_ulong base,
     target_long addr;
     uint32_t wd = vext_wd(desc);
     uint32_t vm = vext_vm(desc);
-    uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t vlmax = vext_max_elems(desc, esz, false);
     uint32_t vta = vext_vta(desc);
 
     for (i = 0; i < env->vl; i++) {
@@ -983,7 +1001,7 @@ static void do_vext_vv(void *vd, void *v0, void *vs1, void *vs2,
                        uint32_t esz, uint32_t dsz,
                        opivv2_fn *fn, clear_fn *clearfn)
 {
-    uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t vlmax = vext_max_elems(desc, esz, false);
     uint32_t vm = vext_vm(desc);
     uint32_t vta = vext_vta(desc);
     uint32_t vl = env->vl;
@@ -995,7 +1013,7 @@ static void do_vext_vv(void *vd, void *v0, void *vs1, void *vs2,
         }
         fn(vd, vs1, vs2, i);
     }
-    clearfn(vd, vta, vl, vl * dsz,  vlmax * dsz);
+    clearfn(vd, vta, vl, vl * dsz, vlmax * dsz);
 }
 
 /* generate the helpers for OPIVV */
@@ -1048,7 +1066,7 @@ static void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
                        uint32_t esz, uint32_t dsz,
                        opivx2_fn fn, clear_fn *clearfn)
 {
-    uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t vlmax = vext_max_elems(desc, esz, false);
     uint32_t vm = vext_vm(desc);
     uint32_t vta = vext_vta(desc);
     uint32_t vl = env->vl;
@@ -1060,7 +1078,7 @@ static void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
         }
         fn(vd, s1, vs2, i);
     }
-    clearfn(vd, vta, vl, vl * dsz,  vlmax * dsz);
+    clearfn(vd, vta, vl, vl * dsz, vlmax * dsz);
 }
 
 /* generate the helpers for OPIVX */
@@ -1247,7 +1265,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
 {                                                             \
     uint32_t vl = env->vl;                                    \
     uint32_t esz = sizeof(ETYPE);                             \
-    uint32_t vlmax = vext_maxsz(desc) / esz;                  \
+    uint32_t vlmax = vext_max_elems(desc, esz, false);        \
     uint32_t vta = vext_vta(desc);                            \
     uint32_t i;                                               \
                                                               \
@@ -1277,7 +1295,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
 {                                                                        \
     uint32_t vl = env->vl;                                               \
     uint32_t esz = sizeof(ETYPE);                                        \
-    uint32_t vlmax = vext_maxsz(desc) / esz;                             \
+    uint32_t vlmax = vext_max_elems(desc, esz, false);                   \
     uint32_t vta = vext_vta(desc);                                       \
     uint32_t i;                                                          \
                                                                          \
@@ -1339,7 +1357,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,          \
                   void *vs2, CPURISCVState *env, uint32_t desc) \
 {                                                               \
     uint32_t vl = env->vl;                                      \
-    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);          \
+    uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);\
     uint32_t i;                                                 \
                                                                 \
     for (i = 0; i < vl; i++) {                                  \
@@ -1427,7 +1445,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,                          \
     uint32_t vm = vext_vm(desc);                                          \
     uint32_t vl = env->vl;                                                \
     uint32_t esz = sizeof(TS1);                                           \
-    uint32_t vlmax = vext_maxsz(desc) / esz;                              \
+    uint32_t vlmax = vext_max_elems(desc, esz, false);                    \
     uint32_t vta = vext_vta(desc);                                        \
     uint32_t i;                                                           \
                                                                           \
@@ -1465,7 +1483,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,                \
     uint32_t vm = vext_vm(desc);                                      \
     uint32_t vl = env->vl;                                            \
     uint32_t esz = sizeof(TD);                                        \
-    uint32_t vlmax = vext_maxsz(desc) / esz;                          \
+    uint32_t vlmax = vext_max_elems(desc, esz, false);                \
     uint32_t vta = vext_vta(desc);                                    \
     uint32_t i;                                                       \
                                                                       \
@@ -2108,7 +2126,7 @@ void HELPER(NAME)(void *vd, void *vs1, CPURISCVState *env,           \
 {                                                                    \
     uint32_t vl = env->vl;                                           \
     uint32_t esz = sizeof(ETYPE);                                    \
-    uint32_t vlmax = vext_maxsz(desc) / esz;                         \
+    uint32_t vlmax = vext_max_elems(desc, esz, false);               \
     uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
@@ -2130,7 +2148,7 @@ void HELPER(NAME)(void *vd, uint64_t s1, CPURISCVState *env,         \
 {                                                                    \
     uint32_t vl = env->vl;                                           \
     uint32_t esz = sizeof(ETYPE);                                    \
-    uint32_t vlmax = vext_maxsz(desc) / esz;                         \
+    uint32_t vlmax = vext_max_elems(desc, esz, false);               \
     uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
@@ -2151,7 +2169,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,          \
 {                                                                    \
     uint32_t vl = env->vl;                                           \
     uint32_t esz = sizeof(ETYPE);                                    \
-    uint32_t vlmax = vext_maxsz(desc) / esz;                         \
+    uint32_t vlmax = vext_max_elems(desc, esz, false);               \
     uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
@@ -2173,7 +2191,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
 {                                                                    \
     uint32_t vl = env->vl;                                           \
     uint32_t esz = sizeof(ETYPE);                                    \
-    uint32_t vlmax = vext_maxsz(desc) / esz;                         \
+    uint32_t vlmax = vext_max_elems(desc, esz, false);               \
     uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
@@ -2234,7 +2252,7 @@ vext_vv_rm_2(void *vd, void *v0, void *vs1, void *vs2,
              uint32_t desc, uint32_t esz, uint32_t dsz,
              opivv2_rm_fn *fn, clear_fn *clearfn)
 {
-    uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t vlmax = vext_max_elems(desc, esz, false);
     uint32_t vm = vext_vm(desc);
     uint32_t vta = vext_vta(desc);
     uint32_t vl = env->vl;
@@ -2354,7 +2372,7 @@ vext_vx_rm_2(void *vd, void *v0, target_long s1, void *vs2,
              uint32_t desc, uint32_t esz, uint32_t dsz,
              opivx2_rm_fn *fn, clear_fn *clearfn)
 {
-    uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t vlmax = vext_max_elems(desc, esz, false);
     uint32_t vm = vext_vm(desc);
     uint32_t vta = vext_vta(desc);
     uint32_t vl = env->vl;
@@ -3258,7 +3276,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
                   void *vs2, CPURISCVState *env,          \
                   uint32_t desc)                          \
 {                                                         \
-    uint32_t vlmax = vext_maxsz(desc) / ESZ;              \
+    uint32_t vlmax = vext_max_elems(desc, ESZ, false);    \
     uint32_t vm = vext_vm(desc);                          \
     uint32_t vta = vext_vta(desc);                        \
     uint32_t vl = env->vl;                                \
@@ -3293,7 +3311,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
                   void *vs2, CPURISCVState *env,          \
                   uint32_t desc)                          \
 {                                                         \
-    uint32_t vlmax = vext_maxsz(desc) / ESZ;              \
+    uint32_t vlmax = vext_max_elems(desc, ESZ, false);    \
     uint32_t vm = vext_vm(desc);                          \
     uint32_t vta = vext_vta(desc);                        \
     uint32_t vl = env->vl;                                \
@@ -3864,7 +3882,7 @@ static void do_##NAME(void *vd, void *vs2, int i,      \
 void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
         CPURISCVState *env, uint32_t desc)             \
 {                                                      \
-    uint32_t vlmax = vext_maxsz(desc) / ESZ;           \
+    uint32_t vlmax = vext_max_elems(desc, ESZ, false); \
     uint32_t vm = vext_vm(desc);                       \
     uint32_t vta = vext_vta(desc);                     \
     uint32_t vl = env->vl;                             \
@@ -4041,7 +4059,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
 {                                                                   \
     uint32_t vm = vext_vm(desc);                                    \
     uint32_t vl = env->vl;                                          \
-    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);              \
+    uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);    \
     uint32_t i;                                                     \
                                                                     \
     for (i = 0; i < vl; i++) {                                      \
@@ -4185,7 +4203,7 @@ static void do_##NAME(void *vd, void *vs2, int i)      \
 void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
                   CPURISCVState *env, uint32_t desc)   \
 {                                                      \
-    uint32_t vlmax = vext_maxsz(desc) / ESZ;           \
+    uint32_t vlmax = vext_max_elems(desc, ESZ, false); \
     uint32_t vm = vext_vm(desc);                       \
     uint32_t vta = vext_vta(desc);                     \
     uint32_t vl = env->vl;                             \
@@ -4272,7 +4290,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
     uint32_t vm = vext_vm(desc);                              \
     uint32_t vl = env->vl;                                    \
     uint32_t esz = sizeof(ETYPE);                             \
-    uint32_t vlmax = vext_maxsz(desc) / esz;                  \
+    uint32_t vlmax = vext_max_elems(desc, esz, false);        \
     uint32_t vta = vext_vta(desc);                            \
     uint32_t i;                                               \
                                                               \
@@ -4772,7 +4790,7 @@ GEN_VEXT_VID_V(vid_v_d, uint64_t, H8, clearq)
 void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
+    uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);          \
     uint32_t vm = vext_vm(desc);                                          \
     uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
@@ -4882,7 +4900,7 @@ GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_d, uint64_t, H8, clearq)
 void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
+    uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);          \
     uint32_t vm = vext_vm(desc);                                          \
     uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
@@ -4912,7 +4930,7 @@ GEN_VEXT_VRGATHER_VV(vrgather_vv_d, uint64_t, H8, clearq)
 void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
+    uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);          \
     uint32_t vm = vext_vm(desc);                                          \
     uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
@@ -4942,7 +4960,7 @@ GEN_VEXT_VRGATHER_VX(vrgather_vx_d, uint64_t, H8, clearq)
 void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
+    uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);          \
     uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
     uint32_t num = 0, i;                                                  \
-- 
2.17.1


