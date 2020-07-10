Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35414C433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:14:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0463E206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GshIuWF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0463E206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsr3-00088W-7o
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqec-0005lx-DD
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:53:18 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:34644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqea-0006qO-RV
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:53:18 -0400
Received: by mail-pf1-x42f.google.com with SMTP id u185so2396013pfu.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+TRVZdJ7hWy9J9A4YaHWnZmcv1QrrHR5mQMCCk6IF8g=;
 b=GshIuWF/dd78PrKYp8D7gTSV9dHZZ7B06fDPx8fd62mF0Vtl99p9IHUbpcs4JDrPHn
 ANuyyODQkfCp7/vTM8WABU+glM2DIsrgEhfI4UyEjxAHQVOp3H/3T7htxluXce1V0Y1h
 xphJPKhwHOS29f2g4YV79J8IoOia8sdFtRlm5b4N8rLp9Rw05MqhdCqEF3VUm/FW6ZVm
 xB6vOUujFIhkHTkYlInZNlw9SscyNVAHrlY3lXQCd/5It2Tu5caCjGCBbjl/P1SaAAts
 vLOUhIj8382b4uwJid1VtKGpx6wAgBWjp1c2mIoazTMIc7LF7RlN1gaFa7EdMmBycnoy
 9fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+TRVZdJ7hWy9J9A4YaHWnZmcv1QrrHR5mQMCCk6IF8g=;
 b=IgyBznN+AZGd5Fg9F/rLQ3eiavE9i+1RtDu0HiB1RQ8ISgTsXps9T3LL6sAqFUInJK
 sap8OkjmYCuENndNCOsWfatLPjorgwQOw3V+vqY8kTRm+kk0D9Tn0jh8ES7/zzUTjdvx
 KmfCrF0mQ0MvK/zvQffkcX4xdt7SEXMEGfbh3CLsVEwVJwvIpQvtMbLdPrx+rw/3Re4x
 KtHo8ELT3usLsTci8+k50BXOt3RqHgdUBP+A3cmQsPY9TbNHAgXCsEIL4K998/SKxAfg
 ViDPtf/0tyFc5GGmyEg4emC2J3nbLQeSy6FYjdZUxT8sw8onV5C1YMSU1dGotdkYivXU
 D8wQ==
X-Gm-Message-State: AOAM5338wqMKj79iVrDK7yZwMWr5Cma+Cu67SsKEvHW/tVIazormJU9k
 CGRKqXhzMtTODOS7q4UwFfgvTKHZblEMKA==
X-Google-Smtp-Source: ABdhPJyQQGTeWjc+KJgPAAeWls855nPZWWc2BB0m2axvkQgHIfEw1poPzJ43MvVVa2l8VeOIcbdmSw==
X-Received: by 2002:a65:620f:: with SMTP id d15mr56401331pgv.270.1594378395376; 
 Fri, 10 Jul 2020 03:53:15 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:53:15 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 40/65] target/riscv: rvv-0.9: integer comparison instructions
Date: Fri, 10 Jul 2020 18:48:54 +0800
Message-Id: <20200710104920.13550-41-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42f.google.com
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
X-Mailman-Approved-At: Fri, 10 Jul 2020 08:57:18 -0400
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
index 152da0bd30..b2552f920e 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1889,9 +1889,9 @@ GEN_OPIVX_TRANS(vmsgt_vx, opivx_cmp_check)
 
 GEN_OPIVI_TRANS(vmseq_vi, 0, vmseq_vx, opivx_cmp_check)
 GEN_OPIVI_TRANS(vmsne_vi, 0, vmsne_vx, opivx_cmp_check)
-GEN_OPIVI_TRANS(vmsleu_vi, 1, vmsleu_vx, opivx_cmp_check)
+GEN_OPIVI_TRANS(vmsleu_vi, 0, vmsleu_vx, opivx_cmp_check)
 GEN_OPIVI_TRANS(vmsle_vi, 0, vmsle_vx, opivx_cmp_check)
-GEN_OPIVI_TRANS(vmsgtu_vi, 1, vmsgtu_vx, opivx_cmp_check)
+GEN_OPIVI_TRANS(vmsgtu_vi, 0, vmsgtu_vx, opivx_cmp_check)
 GEN_OPIVI_TRANS(vmsgt_vi, 0, vmsgt_vx, opivx_cmp_check)
 
 /* Vector Integer Min/Max Instructions */
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 17a98bebe1..8d251dee58 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -1541,26 +1541,29 @@ GEN_VEXT_SHIFT_VX(vnsra_wx_w, int32_t, int64_t, H4, H8, DO_SRL, 0x3f, clearl)
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
+            vext_set_elem_mask(vd, i, 0);                        \
+        }                                                        \
+    }                                                            \
 }
 
 GEN_VEXT_CMP_VV(vmseq_vv_b, uint8_t,  H1, DO_MSEQ)
@@ -1593,26 +1596,29 @@ GEN_VEXT_CMP_VV(vmsle_vv_h, int16_t, H2, DO_MSLE)
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
+            vext_set_elem_mask(vd, i, 0);                         \
+        }                                                         \
+    }                                                             \
 }
 
 GEN_VEXT_CMP_VX(vmseq_vx_b, uint8_t,  H1, DO_MSEQ)
-- 
2.17.1


