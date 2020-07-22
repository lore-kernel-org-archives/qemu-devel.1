Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C10AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 316A42068F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Hqee3IIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316A42068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBJK-0004A7-BL
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAwv-0006Yf-7Z
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:22:05 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029]:34889)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAws-00068q-Pt
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:22:04 -0400
Received: by mail-pj1-x1029.google.com with SMTP id f16so879755pjt.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6dsPvMVzHsJABh7xGBvaDWgI0xunFGRz6/WHgzy8toI=;
 b=Hqee3IIbrbU7SgY2cti+lZCMReNAianILVcLsmKK6FWMrZgUKLdwWBuAwtWhZI92vp
 kDnA+tVBHQBkl3ymCqTCUfIXA7rQcWAWx0k8O2276W+7LaJuS4L39kIa1psjuwDKM8sQ
 DapVwlDH2dh/lxQZW0QenRPQWgtD/H/XLrghMKNGtwIbtcS+V/BsM+bujFg/5aka4ot/
 lYyPi9ayRK1co7FLEgpF68sWFRBCMEIBw+I1wkjlSiymwtRtNbADBo+1SimdRwKKXCxL
 JgGeAjMlFXcEuxoAkQgny4mhPukjPAX8FG8qy8kX9O+c6FtSj98j0bLnogbEguDlG3xR
 VHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6dsPvMVzHsJABh7xGBvaDWgI0xunFGRz6/WHgzy8toI=;
 b=FVcFHD/e8gP5I98k90ZahsBRHqtQXGD4DcbrzJsE0Ew8h8plQUy0/0CGkDIfUMtSuH
 m6Xhn3qSFvVcZFbnlXDrm1Ceyz3d6ZoWJcug5ElA3BUjzF4nnfVAEK78PeKAhIqM6Wxo
 aJCU+R9uoFOPOn/Gupd4NntXo0sTARuwn6BhXHyN2W7XIrAUsFFgsMXeqjrXA+M8C7hl
 SZ2stIyA5EhvLJocTwIK/Akg0RWcogr5enxnqZ5YcNY8PvOfArCtwgGWQCZOPEHb8JPI
 zdhSTnBILvQS3UZ0RUtbdHLTkENyhrRiu0STFQqyjm2DxIvdjbeIATMflnZD2jQAW4L6
 NKXA==
X-Gm-Message-State: AOAM533Oeo22tbV3oTX+2vrBXYafydJNJWk7C3eeO/5XjppvHL/hbK7O
 hX1aT51x/IvvZ9FpClUy0JD0P8BRk7E=
X-Google-Smtp-Source: ABdhPJziDrxIuaxE17ResbUr9xJDZfqQeXzqYbFacv47gZXkutpezyqyI3IkY05nww6ml8nkMLV5hQ==
X-Received: by 2002:a17:902:6842:: with SMTP id
 f2mr10817507pln.281.1595409720683; 
 Wed, 22 Jul 2020 02:22:00 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:22:00 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 63/76] target/riscv: rvv-0.9: widening floating-point
 reduction instructions
Date: Wed, 22 Jul 2020 17:16:26 +0800
Message-Id: <20200722091641.8834-64-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1029.google.com
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Frank Chang <frank.chang@sifive.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Separate the implementation of vfwredsum.vs and vfwredosum.vs.

Introduce propagate NaN feature for vfwredsum.vs as implementations are
permitted to canonicalize the NaN and, if the NaN is signaling, set the
invalid exception flag.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/helper.h                   |  2 +
 target/riscv/insn32.decode              |  3 +-
 target/riscv/insn_trans/trans_rvv.inc.c |  3 +-
 target/riscv/vector_helper.c            | 71 +++++++++++++++++++++++--
 4 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 6957a98237..cfe9baa253 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1078,6 +1078,8 @@ DEF_HELPER_6(vfredmin_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_6(vfwredsum_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwredsum_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwredosum_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwredosum_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_6(vmand_mm, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vmnand_mm, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 0fe46c10c2..e32946b1f5 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -580,7 +580,8 @@ vfredosum_vs    000011 . ..... ..... 001 ..... 1010111 @r_vm
 vfredmin_vs     000101 . ..... ..... 001 ..... 1010111 @r_vm
 vfredmax_vs     000111 . ..... ..... 001 ..... 1010111 @r_vm
 # Vector widening ordered and unordered float reduction sum
-vfwredsum_vs    1100-1 . ..... ..... 001 ..... 1010111 @r_vm
+vfwredsum_vs    110001 . ..... ..... 001 ..... 1010111 @r_vm
+vfwredosum_vs   110011 . ..... ..... 001 ..... 1010111 @r_vm
 vmand_mm        011001 - ..... ..... 010 ..... 1010111 @r
 vmnand_mm       011101 - ..... ..... 010 ..... 1010111 @r
 vmandnot_mm     011000 - ..... ..... 010 ..... 1010111 @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 37eee6cf97..10d8b8b00d 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -3016,7 +3016,8 @@ GEN_OPFVV_TRANS(vfredmax_vs, reduction_check)
 GEN_OPFVV_TRANS(vfredmin_vs, reduction_check)
 
 /* Vector Widening Floating-Point Reduction Instructions */
-GEN_OPFVV_WIDEN_TRANS(vfwredsum_vs, reduction_check)
+GEN_OPFVV_WIDEN_TRANS(vfwredsum_vs, reduction_widen_check)
+GEN_OPFVV_WIDEN_TRANS(vfwredosum_vs, reduction_widen_check)
 
 /*
  *** Vector Mask Operations
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 8465aec94e..2b2b1f521f 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4805,6 +4805,51 @@ GEN_VEXT_FRED(vfredmin_vs_d, uint64_t, uint64_t, H8, H8, false,
               float64_minnum_noprop, clearq)
 
 /* Vector Widening Floating-Point Reduction Instructions */
+/* Ordered reduce 2*SEW = 2*SEW + sum(promote(SEW)) */
+void HELPER(vfwredosum_vs_h)(void *vd, void *v0, void *vs1,
+                             void *vs2, CPURISCVState *env, uint32_t desc)
+{
+    uint32_t vm = vext_vm(desc);
+    uint32_t vta = vext_vta(desc);
+    uint32_t vl = env->vl;
+    uint32_t i;
+    uint32_t tot = env_archcpu(env)->cfg.vlen >> 3;
+    uint32_t s1 =  *((uint32_t *)vs1 + H4(0));
+
+    for (i = 0; i < vl; i++) {
+        uint16_t s2 = *((uint16_t *)vs2 + H2(i));
+        if (!vm && !vext_elem_mask(v0, i)) {
+            continue;
+        }
+        s1 = float32_add(s1, float16_to_float32(s2, true, &env->fp_status),
+                         &env->fp_status);
+    }
+    *((uint32_t *)vd + H4(0)) = s1;
+    clearl(vd, vta, 1, sizeof(uint32_t), tot);
+}
+
+void HELPER(vfwredosum_vs_w)(void *vd, void *v0, void *vs1,
+                             void *vs2, CPURISCVState *env, uint32_t desc)
+{
+    uint32_t vm = vext_vm(desc);
+    uint32_t vta = vext_vta(desc);
+    uint32_t vl = env->vl;
+    uint32_t i;
+    uint32_t tot = env_archcpu(env)->cfg.vlen >> 3;
+    uint64_t s1 =  *((uint64_t *)vs1);
+
+    for (i = 0; i < vl; i++) {
+        uint32_t s2 = *((uint32_t *)vs2 + H4(i));
+        if (!vm && !vext_elem_mask(v0, i)) {
+            continue;
+        }
+        s1 = float64_add(s1, float32_to_float64(s2, &env->fp_status),
+                         &env->fp_status);
+    }
+    *((uint64_t *)vd) = s1;
+    clearq(vd, vta, 1, sizeof(uint64_t), tot);
+}
+
 /* Unordered reduce 2*SEW = 2*SEW + sum(promote(SEW)) */
 void HELPER(vfwredsum_vs_h)(void *vd, void *v0, void *vs1,
                             void *vs2, CPURISCVState *env, uint32_t desc)
@@ -4813,18 +4858,27 @@ void HELPER(vfwredsum_vs_h)(void *vd, void *v0, void *vs1,
     uint32_t vta = vext_vta(desc);
     uint32_t vl = env->vl;
     uint32_t i;
-    uint32_t tot = env_archcpu(env)->cfg.vlen / 8;
+    uint32_t tot = env_archcpu(env)->cfg.vlen >> 3;
     uint32_t s1 =  *((uint32_t *)vs1 + H4(0));
+    bool active = false;
 
     for (i = 0; i < vl; i++) {
         uint16_t s2 = *((uint16_t *)vs2 + H2(i));
         if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
+        active = true;
         s1 = float32_add(s1, float16_to_float32(s2, true, &env->fp_status),
                          &env->fp_status);
     }
-    *((uint32_t *)vd + H4(0)) = s1;
+
+    if (vl > 0) {
+        if (!active) {
+            *((uint32_t *)vd + H4(0)) = propagate_nan(s1, 32, &env->fp_status);
+        } else {
+            *((uint32_t *)vd + H4(0)) = s1;
+        }
+    }
     clearl(vd, vta, 1, sizeof(uint32_t), tot);
 }
 
@@ -4835,18 +4889,27 @@ void HELPER(vfwredsum_vs_w)(void *vd, void *v0, void *vs1,
     uint32_t vta = vext_vta(desc);
     uint32_t vl = env->vl;
     uint32_t i;
-    uint32_t tot = env_archcpu(env)->cfg.vlen / 8;
+    uint32_t tot = env_archcpu(env)->cfg.vlen >> 3;
     uint64_t s1 =  *((uint64_t *)vs1);
+    bool active = false;                                                   \
 
     for (i = 0; i < vl; i++) {
         uint32_t s2 = *((uint32_t *)vs2 + H4(i));
         if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
+        active = true;
         s1 = float64_add(s1, float32_to_float64(s2, &env->fp_status),
                          &env->fp_status);
     }
-    *((uint64_t *)vd) = s1;
+
+    if (vl > 0) {
+        if (!active) {
+            *((uint64_t *)vd) = propagate_nan(s1, 64, &env->fp_status);
+        } else {
+            *((uint64_t *)vd) = s1;
+        }
+    }
     clearq(vd, vta, 1, sizeof(uint64_t), tot);
 }
 
-- 
2.17.1


