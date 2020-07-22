Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DA7C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:33:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F84E206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RSLfqkWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F84E206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyB87-0004GY-Qt
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAuf-0001oi-U9
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:19:45 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46540)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAua-0005bk-Co
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:19:45 -0400
Received: by mail-pg1-x541.google.com with SMTP id s189so858230pgc.13
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5Wcnm8IqhkmajVRLy3EPsUykg3HluDMA8Ajti6zvwSg=;
 b=RSLfqkWMuS0H0eLGdhX+zJ5A/B5kzIXun1zQejjwJJJ1LidffekShJlYcwEJSD6gCa
 diYBjvEY4NX+HiD92KOyslUqzbNZf5dnuDK/BSuyI6ubyRUlgAl5A64LHKYvBiCEEFeB
 vEOJ8sHidI1q39mLlwjuNtJQkR7V2cqg0diRhFoKXbuBgUbDXmbJIjz7jagzx4PO9vMS
 ZGiu1Gl/xtAvkE2BybJ6sX3n4LUkzuS47msswcm2gPWUmx4yiDJsD5kj66evwp701e16
 rEEBTD3TPYBZlb4yKdD87g54L0z9A6VEgrJVsdghDsmxv9dMrFLDZvUg7tuhH70J71sd
 voQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5Wcnm8IqhkmajVRLy3EPsUykg3HluDMA8Ajti6zvwSg=;
 b=Lr1dcNMcyn/+AGbvsa+dLvoi6QobVOCg1JEKDx8qHaq59NvoiPItUF8bFvlMF0rPzv
 5cjJEeFI0uHGffctRQT4baNMK42zcX9esrmeCbdbi6w++ug0fJIcE2bckU8a2aVtQT3s
 DJjySVZ7gqVwiJCEBGHbFdaX1p7vaTJ97tEzJZxxoala1aZb3+yF0DTSJ7Mre4PvwTNF
 l/l89RY7PgqsX2jd3PpDrRcT2YwlgLIWM/Q1OATYqRnLaaMxMpqEnmO3mC4HdyZLKEke
 W2RpKzmql/hn2NLQWkQGT67Mp8+3/LpYAORIWZDKjqpRTIJcJq/eytSbsOM4ZqkAtKiH
 rHNA==
X-Gm-Message-State: AOAM531XeyXWkyeOb50h//+VccP0IdsTow0+YtWWRFB7mMQ+gniihEkV
 d1SYG+RSw8DNyy2DZbCoquDCyltmowo=
X-Google-Smtp-Source: ABdhPJxxDeAmdZc1+eOf9eo+RPH+qR1EnhQEhFETFGpRRSpyOw+lsbxmLIiGy1vBHrvnbnGMdpAYTQ==
X-Received: by 2002:aa7:955a:: with SMTP id w26mr28585277pfq.137.1595409575329; 
 Wed, 22 Jul 2020 02:19:35 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:19:34 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 28/76] target/riscv: rvv-0.9: update vext_max_elems() for
 load/store insns
Date: Wed, 22 Jul 2020 17:15:51 +0800
Message-Id: <20200722091641.8834-29-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x541.google.com
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

Unlike other vector instructions, load/store vector instructions return
the maximum vector size calculated with EMUL.
For other vector instructions, return VLMAX as the maximum vector size.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/vector_helper.c | 118 ++++++++++++++++++++---------------
 1 file changed, 68 insertions(+), 50 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 995e873549..53867a6a2d 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -121,14 +121,32 @@ static inline uint32_t vext_vma(uint32_t desc)
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
@@ -289,7 +307,7 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
 {
     uint32_t i, k;
     uint32_t nf = vext_nf(desc);
-    uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t max_elems = vext_max_elems(desc, esz, true);
     uint32_t vta = vext_vta(desc);
 
     /* probe every access*/
@@ -307,15 +325,15 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
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
@@ -364,7 +382,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
 {
     uint32_t i, k;
     uint32_t nf = vext_nf(desc);
-    uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t max_elems = vext_max_elems(desc, esz, true);
     uint32_t vta = vext_vta(desc);
 
     /* probe every access */
@@ -374,15 +392,15 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
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
@@ -465,7 +483,7 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
     uint32_t i, k;
     uint32_t nf = vext_nf(desc);
     uint32_t vm = vext_vm(desc);
-    uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t max_elems = vext_max_elems(desc, esz, true);
     uint32_t vta = vext_vta(desc);
 
     /* probe every access*/
@@ -484,15 +502,15 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
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
@@ -563,7 +581,7 @@ vext_ldff(void *vd, void *v0, target_ulong base,
     uint32_t i, k, vl = 0;
     uint32_t nf = vext_nf(desc);
     uint32_t vm = vext_vm(desc);
-    uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t max_elems = vext_max_elems(desc, esz, true);
     uint32_t vta = vext_vta(desc);
     target_ulong addr, offset, remain;
 
@@ -615,7 +633,7 @@ ProbeSuccess:
         }
         while (k < nf) {
             target_ulong addr = base + (i * nf + k) * esz;
-            ldst_elem(env, addr, i + k * vlmax, vd, ra);
+            ldst_elem(env, addr, i + k * max_elems, vd, ra);
             k++;
         }
     }
@@ -624,8 +642,8 @@ ProbeSuccess:
         return;
     }
     for (k = 0; k < nf; k++) {
-        clear_elem(vd, vta, env->vl + k * vlmax,
-                   env->vl * esz, vlmax * esz);
+        clear_elem(vd, vta, env->vl + k * max_elems,
+                   env->vl * esz, max_elems * esz);
     }
 }
 
@@ -652,7 +670,7 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
 {
     uint32_t i, k;
     uint32_t nf = vext_nf(desc);
-    uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t max_elems = vext_max_elems(desc, esz, true);
     uint32_t vlenb = env_archcpu(env)->cfg.vlen >> 3;
 
     /* probe every access */
@@ -663,7 +681,7 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
         k = 0;
         while (k < nf) {
             target_ulong addr = base + (i * nf + k) * esz;
-            ldst_elem(env, addr, i + k * vlmax, vd, ra);
+            ldst_elem(env, addr, i + k * max_elems, vd, ra);
             k++;
         }
     }
@@ -806,7 +824,7 @@ vext_amo_noatomic(void *vs3, void *v0, target_ulong base,
     target_long addr;
     uint32_t wd = vext_wd(desc);
     uint32_t vm = vext_vm(desc);
-    uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t vlmax = vext_max_elems(desc, esz, false);
     uint32_t vta = vext_vta(desc);
 
     for (i = 0; i < env->vl; i++) {
@@ -977,7 +995,7 @@ static void do_vext_vv(void *vd, void *v0, void *vs1, void *vs2,
                        uint32_t esz, uint32_t dsz,
                        opivv2_fn *fn, clear_fn *clearfn)
 {
-    uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t vlmax = vext_max_elems(desc, esz, false);
     uint32_t vm = vext_vm(desc);
     uint32_t vta = vext_vta(desc);
     uint32_t vl = env->vl;
@@ -989,7 +1007,7 @@ static void do_vext_vv(void *vd, void *v0, void *vs1, void *vs2,
         }
         fn(vd, vs1, vs2, i);
     }
-    clearfn(vd, vta, vl, vl * dsz,  vlmax * dsz);
+    clearfn(vd, vta, vl, vl * dsz, vlmax * dsz);
 }
 
 /* generate the helpers for OPIVV */
@@ -1042,7 +1060,7 @@ static void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
                        uint32_t esz, uint32_t dsz,
                        opivx2_fn fn, clear_fn *clearfn)
 {
-    uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t vlmax = vext_max_elems(desc, esz, false);
     uint32_t vm = vext_vm(desc);
     uint32_t vta = vext_vta(desc);
     uint32_t vl = env->vl;
@@ -1054,7 +1072,7 @@ static void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
         }
         fn(vd, s1, vs2, i);
     }
-    clearfn(vd, vta, vl, vl * dsz,  vlmax * dsz);
+    clearfn(vd, vta, vl, vl * dsz, vlmax * dsz);
 }
 
 /* generate the helpers for OPIVX */
@@ -1241,7 +1259,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
 {                                                             \
     uint32_t vl = env->vl;                                    \
     uint32_t esz = sizeof(ETYPE);                             \
-    uint32_t vlmax = vext_maxsz(desc) / esz;                  \
+    uint32_t vlmax = vext_max_elems(desc, esz, false);        \
     uint32_t vta = vext_vta(desc);                            \
     uint32_t i;                                               \
                                                               \
@@ -1271,7 +1289,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
 {                                                                        \
     uint32_t vl = env->vl;                                               \
     uint32_t esz = sizeof(ETYPE);                                        \
-    uint32_t vlmax = vext_maxsz(desc) / esz;                             \
+    uint32_t vlmax = vext_max_elems(desc, esz, false);                   \
     uint32_t vta = vext_vta(desc);                                       \
     uint32_t i;                                                          \
                                                                          \
@@ -1333,7 +1351,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,          \
                   void *vs2, CPURISCVState *env, uint32_t desc) \
 {                                                               \
     uint32_t vl = env->vl;                                      \
-    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);          \
+    uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);\
     uint32_t i;                                                 \
                                                                 \
     for (i = 0; i < vl; i++) {                                  \
@@ -1421,7 +1439,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,                          \
     uint32_t vm = vext_vm(desc);                                          \
     uint32_t vl = env->vl;                                                \
     uint32_t esz = sizeof(TS1);                                           \
-    uint32_t vlmax = vext_maxsz(desc) / esz;                              \
+    uint32_t vlmax = vext_max_elems(desc, esz, false);                    \
     uint32_t vta = vext_vta(desc);                                        \
     uint32_t i;                                                           \
                                                                           \
@@ -1459,7 +1477,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,                \
     uint32_t vm = vext_vm(desc);                                      \
     uint32_t vl = env->vl;                                            \
     uint32_t esz = sizeof(TD);                                        \
-    uint32_t vlmax = vext_maxsz(desc) / esz;                          \
+    uint32_t vlmax = vext_max_elems(desc, esz, false);                \
     uint32_t vta = vext_vta(desc);                                    \
     uint32_t i;                                                       \
                                                                       \
@@ -2102,7 +2120,7 @@ void HELPER(NAME)(void *vd, void *vs1, CPURISCVState *env,           \
 {                                                                    \
     uint32_t vl = env->vl;                                           \
     uint32_t esz = sizeof(ETYPE);                                    \
-    uint32_t vlmax = vext_maxsz(desc) / esz;                         \
+    uint32_t vlmax = vext_max_elems(desc, esz, false);               \
     uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
@@ -2124,7 +2142,7 @@ void HELPER(NAME)(void *vd, uint64_t s1, CPURISCVState *env,         \
 {                                                                    \
     uint32_t vl = env->vl;                                           \
     uint32_t esz = sizeof(ETYPE);                                    \
-    uint32_t vlmax = vext_maxsz(desc) / esz;                         \
+    uint32_t vlmax = vext_max_elems(desc, esz, false);               \
     uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
@@ -2145,7 +2163,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,          \
 {                                                                    \
     uint32_t vl = env->vl;                                           \
     uint32_t esz = sizeof(ETYPE);                                    \
-    uint32_t vlmax = vext_maxsz(desc) / esz;                         \
+    uint32_t vlmax = vext_max_elems(desc, esz, false);               \
     uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
@@ -2167,7 +2185,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
 {                                                                    \
     uint32_t vl = env->vl;                                           \
     uint32_t esz = sizeof(ETYPE);                                    \
-    uint32_t vlmax = vext_maxsz(desc) / esz;                         \
+    uint32_t vlmax = vext_max_elems(desc, esz, false);               \
     uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
@@ -2228,7 +2246,7 @@ vext_vv_rm_2(void *vd, void *v0, void *vs1, void *vs2,
              uint32_t desc, uint32_t esz, uint32_t dsz,
              opivv2_rm_fn *fn, clear_fn *clearfn)
 {
-    uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t vlmax = vext_max_elems(desc, esz, false);
     uint32_t vm = vext_vm(desc);
     uint32_t vta = vext_vta(desc);
     uint32_t vl = env->vl;
@@ -2348,7 +2366,7 @@ vext_vx_rm_2(void *vd, void *v0, target_long s1, void *vs2,
              uint32_t desc, uint32_t esz, uint32_t dsz,
              opivx2_rm_fn *fn, clear_fn *clearfn)
 {
-    uint32_t vlmax = vext_maxsz(desc) / esz;
+    uint32_t vlmax = vext_max_elems(desc, esz, false);
     uint32_t vm = vext_vm(desc);
     uint32_t vta = vext_vta(desc);
     uint32_t vl = env->vl;
@@ -3284,7 +3302,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
                   void *vs2, CPURISCVState *env,          \
                   uint32_t desc)                          \
 {                                                         \
-    uint32_t vlmax = vext_maxsz(desc) / ESZ;              \
+    uint32_t vlmax = vext_max_elems(desc, ESZ, false);    \
     uint32_t vm = vext_vm(desc);                          \
     uint32_t vta = vext_vta(desc);                        \
     uint32_t vl = env->vl;                                \
@@ -3319,7 +3337,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
                   void *vs2, CPURISCVState *env,          \
                   uint32_t desc)                          \
 {                                                         \
-    uint32_t vlmax = vext_maxsz(desc) / ESZ;              \
+    uint32_t vlmax = vext_max_elems(desc, ESZ, false);    \
     uint32_t vm = vext_vm(desc);                          \
     uint32_t vta = vext_vta(desc);                        \
     uint32_t vl = env->vl;                                \
@@ -3890,7 +3908,7 @@ static void do_##NAME(void *vd, void *vs2, int i,      \
 void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
         CPURISCVState *env, uint32_t desc)             \
 {                                                      \
-    uint32_t vlmax = vext_maxsz(desc) / ESZ;           \
+    uint32_t vlmax = vext_max_elems(desc, ESZ, false); \
     uint32_t vm = vext_vm(desc);                       \
     uint32_t vta = vext_vta(desc);                     \
     uint32_t vl = env->vl;                             \
@@ -4067,7 +4085,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
 {                                                                   \
     uint32_t vm = vext_vm(desc);                                    \
     uint32_t vl = env->vl;                                          \
-    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);              \
+    uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);    \
     uint32_t i;                                                     \
                                                                     \
     for (i = 0; i < vl; i++) {                                      \
@@ -4211,7 +4229,7 @@ static void do_##NAME(void *vd, void *vs2, int i)      \
 void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
                   CPURISCVState *env, uint32_t desc)   \
 {                                                      \
-    uint32_t vlmax = vext_maxsz(desc) / ESZ;           \
+    uint32_t vlmax = vext_max_elems(desc, ESZ, false); \
     uint32_t vm = vext_vm(desc);                       \
     uint32_t vta = vext_vta(desc);                     \
     uint32_t vl = env->vl;                             \
@@ -4298,7 +4316,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
     uint32_t vm = vext_vm(desc);                              \
     uint32_t vl = env->vl;                                    \
     uint32_t esz = sizeof(ETYPE);                             \
-    uint32_t vlmax = vext_maxsz(desc) / esz;                  \
+    uint32_t vlmax = vext_max_elems(desc, esz, false);        \
     uint32_t vta = vext_vta(desc);                            \
     uint32_t i;                                               \
                                                               \
@@ -4798,7 +4816,7 @@ GEN_VEXT_VID_V(vid_v_d, uint64_t, H8, clearq)
 void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
+    uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);          \
     uint32_t vm = vext_vm(desc);                                          \
     uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
@@ -4908,7 +4926,7 @@ GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_d, uint64_t, H8, clearq)
 void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
+    uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);          \
     uint32_t vm = vext_vm(desc);                                          \
     uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
@@ -4938,7 +4956,7 @@ GEN_VEXT_VRGATHER_VV(vrgather_vv_d, uint64_t, H8, clearq)
 void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
+    uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);          \
     uint32_t vm = vext_vm(desc);                                          \
     uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
@@ -4968,7 +4986,7 @@ GEN_VEXT_VRGATHER_VX(vrgather_vx_d, uint64_t, H8, clearq)
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


