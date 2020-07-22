Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E62C433FC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9031620792
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Rt0vzosm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9031620792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBKc-00065g-QU
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAwa-00066r-GT
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:21:44 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031]:39294)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAwX-00065m-Bj
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:21:44 -0400
Received: by mail-pj1-x1031.google.com with SMTP id b92so867478pjc.4
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gpep5/nDCBjR2xblMkuotvD31Bl23GAVCnm9qzFyGGI=;
 b=Rt0vzosm8vkfV3oPflNIgTAijlsLlsvLhfVmff/nMW/pxnHPtEWsJ72CVC13WwsiIe
 IdhggjQdAyGF+iXclJJVhGq/r1bbHhyWnpdhh76FQ+UOY+rM8yWzQPBUaU37are0yQXo
 WYQGJkT2GA8ikhAybdC9J18V8H5EZh0U655gOWVDZu6OcEPCivjRwQJ4a1It+Ab3xPeC
 WdTtTBaz4u9pDrwt4L+LbWd2Vjs1wYw5+QSjsGls+D7kugxejNZPkF5TQ3KUcIXIf+Ef
 GoxrQiKRZUCgUOc8dLU/O14AqIJ+frMYUt+FWZJd4TtzjyUs8oGBJLvG7Gy4MMSM/K9Q
 mQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gpep5/nDCBjR2xblMkuotvD31Bl23GAVCnm9qzFyGGI=;
 b=Gzjk629d3KJrDU7CDq4eALKImL7LVMi4mPb1fyH2eSmf9dpv6ImhXLWF+sawlKwg5a
 0noGiNb2y7pp1BwVJn88qvSgFe73X6HN6vsJX5BJDvkLEYx39AOsrZ3KDkUXaPAyCHIY
 A+aAzmHbgAEaUL5caMIDn8/2KFQxsz+Dh51gFVWFtUtNcTq4Iff6kXdaHp//D7Gf9Npp
 wZGyBU5yHJf1DbwrNIpT53vOogFWoaDstiPz/epShiHlFtdJh4bt1qtJjCwTliEsVaDb
 PF1bDaqN7zirSw3Q0sduXpoCc8Znb0SxCcjF6tsVC2oIfIlVY6bYsOIYDUwcUHbSPm4X
 psPg==
X-Gm-Message-State: AOAM5312GkZltJJvptTLJnZBRt+3sQWyPSq9hlfEHmDG+cZfP/p85HDB
 w5xykk8X2k4uUQJKekpGNjhJnP4b750=
X-Google-Smtp-Source: ABdhPJzgoRHUlMmWqvJocJLqB70jrpIXO54WxHhzp/7IR6/ZXCqtN13Ex305G+b++w96NFNk5ENJNw==
X-Received: by 2002:a17:90a:cc03:: with SMTP id
 b3mr8297944pju.80.1595409699796; 
 Wed, 22 Jul 2020 02:21:39 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:21:39 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 58/76] target/riscv: rvv-0.9: slide instructions
Date: Wed, 22 Jul 2020 17:16:21 +0800
Message-Id: <20200722091641.8834-59-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1031.google.com
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

* Fix offset overflow issue.
* Remove clear function from helper functions as the tail elements
  are unchanged in RVV 0.9.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/vector_helper.c | 83 ++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 46 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index bb426e224c..b47ca6c406 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4923,64 +4923,59 @@ GEN_VEXT_VID_V(vid_v_d, uint64_t, H8, clearq)
  */
 
 /* Vector Slide Instructions */
-#define GEN_VEXT_VSLIDEUP_VX(NAME, ETYPE, H, CLEAR_FN)                    \
-void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
-                  CPURISCVState *env, uint32_t desc)                      \
-{                                                                         \
-    uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);          \
-    uint32_t vm = vext_vm(desc);                                          \
-    uint32_t vta = vext_vta(desc);                                        \
-    uint32_t vl = env->vl;                                                \
-    target_ulong offset = s1, i;                                          \
-                                                                          \
-    for (i = offset; i < vl; i++) {                                       \
-        if (!vm && !vext_elem_mask(v0, i)) {                              \
-            continue;                                                     \
-        }                                                                 \
-        *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
-    }                                                                     \
-    CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
+#define GEN_VEXT_VSLIDEUP_VX(NAME, ETYPE, H)                      \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2, \
+                  CPURISCVState *env, uint32_t desc)              \
+{                                                                 \
+    uint32_t vm = vext_vm(desc);                                  \
+    uint32_t vl = env->vl;                                        \
+    target_ulong offset = s1, i;                                  \
+                                                                  \
+    for (i = offset; i < vl; i++) {                               \
+        if (!vm && !vext_elem_mask(v0, i)) {                      \
+            continue;                                             \
+        }                                                         \
+        *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));  \
+    }                                                             \
 }
 
 /* vslideup.vx vd, vs2, rs1, vm # vd[i+rs1] = vs2[i] */
-GEN_VEXT_VSLIDEUP_VX(vslideup_vx_b, uint8_t, H1, clearb)
-GEN_VEXT_VSLIDEUP_VX(vslideup_vx_h, uint16_t, H2, clearh)
-GEN_VEXT_VSLIDEUP_VX(vslideup_vx_w, uint32_t, H4, clearl)
-GEN_VEXT_VSLIDEUP_VX(vslideup_vx_d, uint64_t, H8, clearq)
+GEN_VEXT_VSLIDEUP_VX(vslideup_vx_b, uint8_t,  H1)
+GEN_VEXT_VSLIDEUP_VX(vslideup_vx_h, uint16_t, H2)
+GEN_VEXT_VSLIDEUP_VX(vslideup_vx_w, uint32_t, H4)
+GEN_VEXT_VSLIDEUP_VX(vslideup_vx_d, uint64_t, H8)
 
-#define GEN_VEXT_VSLIDEDOWN_VX(NAME, ETYPE, H, CLEAR_FN)                  \
+#define GEN_VEXT_VSLIDEDOWN_VX(NAME, ETYPE, H)                            \
 void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
+    uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);          \
     uint32_t vm = vext_vm(desc);                                          \
-    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
     target_ulong offset = s1, i;                                          \
                                                                           \
     for (i = 0; i < vl; ++i) {                                            \
+        /* offset may be a large value, which j may overflow */           \
         target_ulong j = i + offset;                                      \
+        bool is_valid = (offset >= vlmax || j >= vlmax) ? false : true;   \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
             continue;                                                     \
         }                                                                 \
-        *((ETYPE *)vd + H(i)) = j >= vlmax ? 0 : *((ETYPE *)vs2 + H(j));  \
+        *((ETYPE *)vd + H(i)) = is_valid ? *((ETYPE *)vs2 + H(j)) : 0;  \
     }                                                                     \
-    CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
 }
 
 /* vslidedown.vx vd, vs2, rs1, vm # vd[i] = vs2[i+rs1] */
-GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_b, uint8_t, H1, clearb)
-GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_h, uint16_t, H2, clearh)
-GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_w, uint32_t, H4, clearl)
-GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_d, uint64_t, H8, clearq)
+GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_b, uint8_t,  H1)
+GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_h, uint16_t, H2)
+GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_w, uint32_t, H4)
+GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_d, uint64_t, H8)
 
-#define GEN_VEXT_VSLIDE1UP_VX(NAME, ETYPE, H, CLEAR_FN)                   \
+#define GEN_VEXT_VSLIDE1UP_VX(NAME, ETYPE, H)                             \
 void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
-    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
     uint32_t i;                                                           \
                                                                           \
@@ -4994,22 +4989,19 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
             *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - 1));           \
         }                                                                 \
     }                                                                     \
-    CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
 }
 
 /* vslide1up.vx vd, vs2, rs1, vm # vd[0]=x[rs1], vd[i+1] = vs2[i] */
-GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_b, uint8_t, H1, clearb)
-GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_h, uint16_t, H2, clearh)
-GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_w, uint32_t, H4, clearl)
-GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_d, uint64_t, H8, clearq)
+GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_b, uint8_t,  H1)
+GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_h, uint16_t, H2)
+GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_w, uint32_t, H4)
+GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_d, uint64_t, H8)
 
-#define GEN_VEXT_VSLIDE1DOWN_VX(NAME, ETYPE, H, CLEAR_FN)                 \
+#define GEN_VEXT_VSLIDE1DOWN_VX(NAME, ETYPE, H)                           \
 void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
-    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
     uint32_t i;                                                           \
                                                                           \
@@ -5023,14 +5015,13 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
             *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i + 1));           \
         }                                                                 \
     }                                                                     \
-    CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
 }
 
 /* vslide1down.vx vd, vs2, rs1, vm # vd[i] = vs2[i+1], vd[vl-1]=x[rs1] */
-GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_b, uint8_t, H1, clearb)
-GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_h, uint16_t, H2, clearh)
-GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_w, uint32_t, H4, clearl)
-GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_d, uint64_t, H8, clearq)
+GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_b, uint8_t,  H1)
+GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_h, uint16_t, H2)
+GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_w, uint32_t, H4)
+GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_d, uint64_t, H8)
 
 /* Vector Register Gather Instruction */
 #define GEN_VEXT_VRGATHER_VV(NAME, ETYPE, H, CLEAR_FN)                    \
-- 
2.17.1


