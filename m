Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2FDC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21FCE2068F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KnWT1lix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FCE2068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBHf-0000M7-Cc
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAwK-0005SP-Ud
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:21:28 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:41165)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAwJ-00062y-Bl
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:21:28 -0400
Received: by mail-pf1-x42b.google.com with SMTP id w126so701282pfw.8
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lSGavHjP8DkZgSzTSXFcl5cCaE8i//N9BsXmCdZs8Ww=;
 b=KnWT1lixgFk93ruSwizppy66iVSTs4uQDmPJVDG6azKUhMF/vrkNPXwIqe4J1B1ntZ
 OPTmxCdZ0u2Shkdu9MEQ5vfTqJMfzb4t12BbYXG4Faksy0KZ+oYNRpApi2m0wa03vL/G
 BY57bbbGelfBJKSbQNTakkkNWRjShXExUazmLr4XgN6OMTwV4LG3BJ0xshL9mnUPkWNW
 IeISZaLH4URxadfcpMJa271M+VM7TMdxE74z+laNI2Kp+mQ2s7o5pnu1spYmxrOV7Mly
 wRwjKRhIQ1CN2lHl/YayZj+ta/mQI2C7gnfmFpWJgfzqHvKJA4DfTWuu3IBIaYpW5hc2
 Xifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lSGavHjP8DkZgSzTSXFcl5cCaE8i//N9BsXmCdZs8Ww=;
 b=INZ2Fe86uS6LhKcmkG5M8GgFYQdVefa/4sXbB0+SxVFXNhRpcredf0vsKK1FIWMwWp
 +wL/ilvPdtyfFRLI8e2Qh/PA8hRD+fn52A8xgUSpP0OAt2pBObBZ5r8pi4QXWFeC4t7D
 e2i9K9P0n995UmZcFd8zzeZOoaq6hxhHu6OeLPHfjLHx1nzRtBdnnT8kriedw/g6+1oG
 ilEziHPxDGvcDEfkWrBz0V+V4RDzGAaD+n6YsHhTYsx0iMPGmejorva+j7dcxj14Nl9z
 w6zLEYgzYIu8cqi7nG+qCpG7Ubb7WtRsY5hn2lX2s1AZP0meOWGJLm6IP2stLP7XPJ4T
 5JPQ==
X-Gm-Message-State: AOAM531tMLWCguYmkGbI3BRB6Pgg3JJrmJzKc5DUtiVgrvLjoiGZz5NF
 QbbHj2Q8hZQXuIYnma2J3qYKMiVz0w4=
X-Google-Smtp-Source: ABdhPJw4B0xCrzhHOPZfBkQkihjMR9DtE3963cnKY79n15QckVEZ8ytX+dJHhJvZeDQh9TTxrc2o3Q==
X-Received: by 2002:a62:a20d:: with SMTP id m13mr6294215pff.201.1595409685603; 
 Wed, 22 Jul 2020 02:21:25 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:21:25 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 54/76] target/riscv: rvv-0.9: floating-point compare
 instructions
Date: Wed, 22 Jul 2020 17:16:17 +0800
Message-Id: <20200722091641.8834-55-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42b.google.com
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
 target/riscv/vector_helper.c | 52 ++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 95cce063d0..8dccec4e04 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4174,27 +4174,30 @@ GEN_VEXT_VF(vfsgnjx_vf_w, 4, 4, clearl)
 GEN_VEXT_VF(vfsgnjx_vf_d, 8, 8, clearq)
 
 /* Vector Floating-Point Compare Instructions */
-#define GEN_VEXT_CMP_VV_ENV(NAME, ETYPE, H, DO_OP)            \
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
-        vext_set_elem_mask(vd, i,                             \
-                           DO_OP(s2, s1, &env->fp_status));   \
-    }                                                         \
-    for (; i < vlmax; i++) {                                  \
-        vext_set_elem_mask(vd, i, 0);                         \
-    }                                                         \
+#define GEN_VEXT_CMP_VV_ENV(NAME, ETYPE, H, DO_OP)               \
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
+        vext_set_elem_mask(vd, i,                                \
+                           DO_OP(s2, s1, &env->fp_status));      \
+    }                                                            \
+    if (vta == 1) {                                              \
+        for (; i < vlmax; i++) {                                 \
+            vext_set_elem_mask(vd, i, 1);                        \
+        }                                                        \
+    }                                                            \
 }
 
 GEN_VEXT_CMP_VV_ENV(vmfeq_vv_h, uint16_t, H2, float16_eq_quiet)
@@ -4208,6 +4211,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
     uint32_t vm = vext_vm(desc);                                    \
     uint32_t vl = env->vl;                                          \
     uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);    \
+    uint32_t vta = vext_vta(desc);                                  \
     uint32_t i;                                                     \
                                                                     \
     for (i = 0; i < vl; i++) {                                      \
@@ -4218,8 +4222,10 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
         vext_set_elem_mask(vd, i,                                   \
                            DO_OP(s2, (ETYPE)s1, &env->fp_status));  \
     }                                                               \
-    for (; i < vlmax; i++) {                                        \
-        vext_set_elem_mask(vd, i, 0);                               \
+    if (vta == 1) {                                                 \
+        for (; i < vlmax; i++) {                                    \
+            vext_set_elem_mask(vd, i, 1);                           \
+        }                                                           \
     }                                                               \
 }
 
-- 
2.17.1


