Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D340DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:20:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEC8222D2C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="K4crNQEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC8222D2C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dtM-0004x1-Ch
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dST-0003Qb-3z
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:13 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:35937)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSR-0007xx-0C
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:12 -0400
Received: by mail-pl1-x629.google.com with SMTP id y6so131809plt.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=uyZlOwf5sY29/KWwIlC8fQBvaqUFIeMUTjg0JvPcbYY=;
 b=K4crNQEYBR3w5OazAjtg9WbfMCDR0B1OPdWLukg+tQB2u4e5uD7iNH5nYSAkL5VjIl
 txyKvDxVGXQsDt/6VqnxVYmvi4z1uAnO7hji7hWSm8V4jCQzDYiu3/BAv70MVysVRgcG
 x+RrAvIxPFUZjymW1bEnsBcAQQ3ujazNk2mq+YiJgKjwNI6+uAGxGc2o8jADjZMhoVR2
 DNngHrp7hdAVavlW3Zgtbkp423Jten3PjkG1dqzKeH/ny4U/WUP5YQTuSN/mRCGqJADj
 ps28TFloEjbFLCH7nMAgayH67lhkzhZ5QO8Zba0uix4hGLgSmGan9UKKICWn7iep+dog
 JBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=uyZlOwf5sY29/KWwIlC8fQBvaqUFIeMUTjg0JvPcbYY=;
 b=tCo5UtfdEwVHzFxRMnn8cfkK9aXDOq5IYrRPpPMjIeqT7otLpB1CiG3LcCyzf+FUr4
 hWVWLUdMRR7M/tJEGz27iF6PnRs4cn5VLxxumtspqIx4YRSEMuXIjeGt9m2F8lu1ri0N
 E6bKBy3lllp6r7KjNuLxBh3q6xglOLCkmTcZ4EzXHQTeBKVc6iNeM5+2tk/wdHOE/fLW
 u0S2ube8d89r1YYLKqNfBq/opiEUNbswOHJdEsvgGexDvMW9fnXhE6CxXJDamdlJRRwv
 pvj3QWt4LRbSMAvGTBTx8uiKULJhr0CewuUabwYaaj86ZhOIO19flalVjyLDUWi436PA
 s45Q==
X-Gm-Message-State: AOAM532rF+G6VHZTkGcnV9se+9ogcYSuuRh5vBwz1SZ7eUrX9n7bjPpp
 9G+Wu7+9OCWn3zM2F0XbCUhEzgDoZzg=
X-Google-Smtp-Source: ABdhPJzM2q2QhUWt4zRZ8ARFdj/IN6ga81qx6+QxbvIGcmmjsGjG2GEoTbs90lGc2fZj653N+Rakew==
X-Received: by 2002:a17:90b:1093:: with SMTP id
 gj19mr7802680pjb.149.1596710949532; 
 Thu, 06 Aug 2020 03:49:09 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:49:09 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 44/71] target/riscv: rvv-1.0: integer
 add-with-carry/subtract-with-borrow
Date: Thu,  6 Aug 2020 18:46:41 +0800
Message-Id: <20200806104709.13235-45-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x629.google.com
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

Clear tail elements only if VTA is agnostic.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn32.decode              | 20 ++++++-------
 target/riscv/insn_trans/trans_rvv.inc.c |  2 +-
 target/riscv/vector_helper.c            | 40 +++++++++++--------------
 3 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index fd00ee6fdca..e62bad906a3 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -342,16 +342,16 @@ vwsubu_wv       110110 . ..... ..... 010 ..... 1010111 @r_vm
 vwsubu_wx       110110 . ..... ..... 110 ..... 1010111 @r_vm
 vwsub_wv        110111 . ..... ..... 010 ..... 1010111 @r_vm
 vwsub_wx        110111 . ..... ..... 110 ..... 1010111 @r_vm
-vadc_vvm        010000 1 ..... ..... 000 ..... 1010111 @r_vm_1
-vadc_vxm        010000 1 ..... ..... 100 ..... 1010111 @r_vm_1
-vadc_vim        010000 1 ..... ..... 011 ..... 1010111 @r_vm_1
-vmadc_vvm       010001 1 ..... ..... 000 ..... 1010111 @r_vm_1
-vmadc_vxm       010001 1 ..... ..... 100 ..... 1010111 @r_vm_1
-vmadc_vim       010001 1 ..... ..... 011 ..... 1010111 @r_vm_1
-vsbc_vvm        010010 1 ..... ..... 000 ..... 1010111 @r_vm_1
-vsbc_vxm        010010 1 ..... ..... 100 ..... 1010111 @r_vm_1
-vmsbc_vvm       010011 1 ..... ..... 000 ..... 1010111 @r_vm_1
-vmsbc_vxm       010011 1 ..... ..... 100 ..... 1010111 @r_vm_1
+vadc_vvm        010000 0 ..... ..... 000 ..... 1010111 @r_vm_1
+vadc_vxm        010000 0 ..... ..... 100 ..... 1010111 @r_vm_1
+vadc_vim        010000 0 ..... ..... 011 ..... 1010111 @r_vm_1
+vmadc_vvm       010001 . ..... ..... 000 ..... 1010111 @r_vm
+vmadc_vxm       010001 . ..... ..... 100 ..... 1010111 @r_vm
+vmadc_vim       010001 . ..... ..... 011 ..... 1010111 @r_vm
+vsbc_vvm        010010 0 ..... ..... 000 ..... 1010111 @r_vm_1
+vsbc_vxm        010010 0 ..... ..... 100 ..... 1010111 @r_vm_1
+vmsbc_vvm       010011 . ..... ..... 000 ..... 1010111 @r_vm
+vmsbc_vxm       010011 . ..... ..... 100 ..... 1010111 @r_vm
 vand_vv         001001 . ..... ..... 000 ..... 1010111 @r_vm
 vand_vx         001001 . ..... ..... 100 ..... 1010111 @r_vm
 vand_vi         001001 . ..... ..... 011 ..... 1010111 @r_vm
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index a22db5f2f13..2f5846fe4f0 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1760,7 +1760,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
 
 /*
  * For vadc and vsbc, an illegal instruction exception is raised if the
- * destination vector register is v0 and LMUL > 1. (Section 12.3)
+ * destination vector register is v0 and LMUL > 1. (Section 12.4)
  */
 static bool opivv_vadc_check(DisasContext *s, arg_rmrr *a)
 {
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index efc29affb06..cc501a7cb44 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -1218,24 +1218,21 @@ GEN_VEXT_VADC_VXM(vsbc_vxm_d, uint64_t, H8, DO_VSBC)
                           (__typeof(N))(N + M) < N)
 #define DO_MSBC(N, M, C) (C ? N <= M : N < M)
 
-#define GEN_VEXT_VMADC_VVM(NAME, ETYPE, H, DO_OP)             \
-void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
-                  CPURISCVState *env, uint32_t desc)          \
-{                                                             \
-    uint32_t vl = env->vl;                                    \
-    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);        \
-    uint32_t i;                                               \
-                                                              \
-    for (i = 0; i < vl; i++) {                                \
-        ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
-        ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
-        uint8_t carry = vext_elem_mask(v0, i);                \
-                                                              \
-        vext_set_elem_mask(vd, i, DO_OP(s2, s1, carry));      \
-    }                                                         \
-    for (; i < vlmax; i++) {                                  \
-        vext_set_elem_mask(vd, i, 0);                         \
-    }                                                         \
+#define GEN_VEXT_VMADC_VVM(NAME, ETYPE, H, DO_OP)               \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,     \
+                  CPURISCVState *env, uint32_t desc)            \
+{                                                               \
+    uint32_t vl = env->vl;                                      \
+    uint32_t vm = vext_vm(desc);                                \
+    uint32_t i;                                                 \
+                                                                \
+    for (i = 0; i < vl; i++) {                                  \
+        ETYPE s1 = *((ETYPE *)vs1 + H(i));                      \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                      \
+        uint8_t carry = !vm ? vext_elem_mask(v0, i) : 0;        \
+                                                                \
+        vext_set_elem_mask(vd, i, DO_OP(s2, s1, carry));        \
+    }                                                           \
 }
 
 GEN_VEXT_VMADC_VVM(vmadc_vvm_b, uint8_t,  H1, DO_MADC)
@@ -1253,19 +1250,16 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,          \
                   void *vs2, CPURISCVState *env, uint32_t desc) \
 {                                                               \
     uint32_t vl = env->vl;                                      \
-    uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);\
+    uint32_t vm = vext_vm(desc);                                \
     uint32_t i;                                                 \
                                                                 \
     for (i = 0; i < vl; i++) {                                  \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                      \
-        uint8_t carry = vext_elem_mask(v0, i);                  \
+        uint8_t carry = !vm ? vext_elem_mask(v0, i) : 0;         \
                                                                 \
         vext_set_elem_mask(vd, i,                               \
                 DO_OP(s2, (ETYPE)(target_long)s1, carry));      \
     }                                                           \
-    for (; i < vlmax; i++) {                                    \
-        vext_set_elem_mask(vd, i, 0);                           \
-    }                                                           \
 }
 
 GEN_VEXT_VMADC_VXM(vmadc_vxm_b, uint8_t,  H1, DO_MADC)
-- 
2.17.1


