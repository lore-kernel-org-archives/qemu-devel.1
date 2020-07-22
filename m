Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D555AC433E6
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:53:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D67020714
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Go68i/sg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D67020714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBR7-0001rx-U9
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAw8-0004yU-NB
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:21:16 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:43113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAw6-00061F-JZ
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:21:16 -0400
Received: by mail-pg1-x535.google.com with SMTP id w2so865498pgg.10
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=uszXZkWPs2BCvFrrB1JthqoxvCbuVc0XI1W65Psr/2M=;
 b=Go68i/sgzrI1dJzZTOuVdxpGojBZSafl5Jw3ZsN68oc3zsZUI1f6+z0o+X8sm1faY6
 c1qGKm+2vfI1YKkNxQNh9vhmwxUohSTYnXYLkL1lcGQGaZI4SMLm/GewXLbVEcOpi8cv
 EkZU02fqTJI1zQqKhol7cyje6/buanzxjKzTJfkZO7Buc6T1qlJfIfKmqA3ts8lsNfWf
 V+HEulkBJNvWcBuHKs/rPSh3WZWBjFSHpfsnM1viEShJ0D1Ytrf+XKuUByhGjWCKCdrk
 DVyzFDT76hpR69avvoven8llEzXQtUgDgWce67NCsa8qz1sGrAfu2jnyteU283vGQCvq
 qoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=uszXZkWPs2BCvFrrB1JthqoxvCbuVc0XI1W65Psr/2M=;
 b=UU/KKikxz+PMl3o+z0Rybd6Yp8/NlKMq0bcn6Wv9vDM7iUPrnHqj0N3RoIzGuSlq4K
 14JVfNJ4awLPo/mIZteLLMAaAKLimu8uKSqCT+XjVnM2uhWaaJA6WNZ3S9m4EUyPu2MH
 tVr4N9Puy9giNtPM5/aO+eU/jctPGwT3wgZu7G0JOLXNNtPtsSrupSwFw9hCwYIDk8IC
 2786Lnt/Gkeppq/VgtKY3xi/61gZw4qJFgiZOdLsQdMfJgpf0Iuuj1eN0zRIL3JncdTO
 anmtYzCh1o1jzf2RMngJdkxgTqxPaQWerbKHlZBKpekV4xqrWjFIgwgnE88kuOwCqfk2
 LEnQ==
X-Gm-Message-State: AOAM533dfc1P7ewHH/uoN+d++xK8YVkrQnbuChujx6IN089hS+aNlwwo
 2nBz8Wkp0CpG9sLzMvlE3gMugbaunm0=
X-Google-Smtp-Source: ABdhPJxiznK1NDdNeR+/zl98A036l8wSlCyFgqQ8ipZJT4LNu6HlQzH33u8GA5iLRPsQxDT7kZZoAQ==
X-Received: by 2002:a63:1f04:: with SMTP id f4mr25541942pgf.34.1595409673099; 
 Wed, 22 Jul 2020 02:21:13 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:21:12 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 51/76] target/riscv: rvv-0.9: integer comparison instructions
Date: Wed, 22 Jul 2020 17:16:14 +0800
Message-Id: <20200722091641.8834-52-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x535.google.com
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

Sign-extend vmselu.vi and vmsgtu.vi immediate values.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c |  4 +-
 target/riscv/vector_helper.c            | 86 +++++++++++++------------
 2 files changed, 48 insertions(+), 42 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 3018489536..378af8344d 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2118,9 +2118,9 @@ GEN_OPIVX_TRANS(vmsgt_vx, opivx_cmp_check)
 
 GEN_OPIVI_TRANS(vmseq_vi, IMM_SX, vmseq_vx, opivx_cmp_check)
 GEN_OPIVI_TRANS(vmsne_vi, IMM_SX, vmsne_vx, opivx_cmp_check)
-GEN_OPIVI_TRANS(vmsleu_vi, IMM_ZX, vmsleu_vx, opivx_cmp_check)
+GEN_OPIVI_TRANS(vmsleu_vi, IMM_SX, vmsleu_vx, opivx_cmp_check)
 GEN_OPIVI_TRANS(vmsle_vi, IMM_SX, vmsle_vx, opivx_cmp_check)
-GEN_OPIVI_TRANS(vmsgtu_vi, IMM_ZX, vmsgtu_vx, opivx_cmp_check)
+GEN_OPIVI_TRANS(vmsgtu_vi, IMM_SX, vmsgtu_vx, opivx_cmp_check)
 GEN_OPIVI_TRANS(vmsgt_vi, IMM_SX, vmsgt_vx, opivx_cmp_check)
 
 /* Vector Integer Min/Max Instructions */
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 420c5f675d..dc883e0352 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -1535,26 +1535,29 @@ GEN_VEXT_SHIFT_VX(vnsra_wx_w, int32_t, int64_t, H4, H8, DO_SRL, 0x3f, clearl)
 #define DO_MSLE(N, M) (N <= M)
 #define DO_MSGT(N, M) (N > M)
 
-#define GEN_VEXT_CMP_VV(NAME, ETYPE, H, DO_OP)                \
-void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
-                  CPURISCVState *env, uint32_t desc)          \
-{                                                             \
-    uint32_t vm = vext_vm(desc);                              \
-    uint32_t vl = env->vl;                                    \
-    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);        \
-    uint32_t i;                                               \
-                                                              \
-    for (i = 0; i < vl; i++) {                                \
-        ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
-        ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
-        if (!vm && !vext_elem_mask(v0, i)) {                  \
-            continue;                                         \
-        }                                                     \
-        vext_set_elem_mask(vd, i, DO_OP(s2, s1));             \
-    }                                                         \
-    for (; i < vlmax; i++) {                                  \
-        vext_set_elem_mask(vd, i, 0);                         \
-    }                                                         \
+#define GEN_VEXT_CMP_VV(NAME, ETYPE, H, DO_OP)                   \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,      \
+                  CPURISCVState *env, uint32_t desc)             \
+{                                                                \
+    uint32_t vm = vext_vm(desc);                                 \
+    uint32_t vl = env->vl;                                       \
+    uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false); \
+    uint32_t vta = vext_vta(desc);                               \
+    uint32_t i;                                                  \
+                                                                 \
+    for (i = 0; i < vl; i++) {                                   \
+        ETYPE s1 = *((ETYPE *)vs1 + H(i));                       \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                       \
+        if (!vm && !vext_elem_mask(v0, i)) {                     \
+            continue;                                            \
+        }                                                        \
+        vext_set_elem_mask(vd, i, DO_OP(s2, s1));                \
+    }                                                            \
+    if (vta == 1) {                                              \
+        for (; i < vlmax; i++) {                                 \
+            vext_set_elem_mask(vd, i, 1);                        \
+        }                                                        \
+    }                                                            \
 }
 
 GEN_VEXT_CMP_VV(vmseq_vv_b, uint8_t,  H1, DO_MSEQ)
@@ -1587,26 +1590,29 @@ GEN_VEXT_CMP_VV(vmsle_vv_h, int16_t, H2, DO_MSLE)
 GEN_VEXT_CMP_VV(vmsle_vv_w, int32_t, H4, DO_MSLE)
 GEN_VEXT_CMP_VV(vmsle_vv_d, int64_t, H8, DO_MSLE)
 
-#define GEN_VEXT_CMP_VX(NAME, ETYPE, H, DO_OP)                      \
-void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,   \
-                  CPURISCVState *env, uint32_t desc)                \
-{                                                                   \
-    uint32_t vm = vext_vm(desc);                                    \
-    uint32_t vl = env->vl;                                          \
-    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);              \
-    uint32_t i;                                                     \
-                                                                    \
-    for (i = 0; i < vl; i++) {                                      \
-        ETYPE s2 = *((ETYPE *)vs2 + H(i));                          \
-        if (!vm && !vext_elem_mask(v0, i)) {                        \
-            continue;                                               \
-        }                                                           \
-        vext_set_elem_mask(vd, i,                                   \
-                DO_OP(s2, (ETYPE)(target_long)s1));                 \
-    }                                                               \
-    for (; i < vlmax; i++) {                                        \
-        vext_set_elem_mask(vd, i, 0);                               \
-    }                                                               \
+#define GEN_VEXT_CMP_VX(NAME, ETYPE, H, DO_OP)                    \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2, \
+                  CPURISCVState *env, uint32_t desc)              \
+{                                                                 \
+    uint32_t vm = vext_vm(desc);                                  \
+    uint32_t vl = env->vl;                                        \
+    uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);  \
+    uint32_t vta = vext_vta(desc);                                \
+    uint32_t i;                                                   \
+                                                                  \
+    for (i = 0; i < vl; i++) {                                    \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                        \
+        if (!vm && !vext_elem_mask(v0, i)) {                      \
+            continue;                                             \
+        }                                                         \
+        vext_set_elem_mask(vd, i,                                 \
+            DO_OP(s2, (ETYPE)(target_long)s1));                   \
+    }                                                             \
+    if (vta == 1) {                                               \
+        for (; i < vlmax; i++) {                                  \
+            vext_set_elem_mask(vd, i, 1);                         \
+        }                                                         \
+    }                                                             \
 }
 
 GEN_VEXT_CMP_VX(vmseq_vx_b, uint8_t,  H1, DO_MSEQ)
-- 
2.17.1


