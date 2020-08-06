Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57113C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2631122D06
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BM8HU9qB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2631122D06
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3drR-0001Gt-Ge
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSk-0003wb-O4
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:30 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:34412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSe-000813-Ry
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:30 -0400
Received: by mail-pl1-x634.google.com with SMTP id o1so27327913plk.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gATifW08Q1iWD9fEU6clkKUOIggBsmvVgd7EsV7dSlM=;
 b=BM8HU9qBqUJ1fH32y55/z5WQ+sVr+2wTzycMADfz234/ht3U+dFULL1amcIb8UBwUp
 MiJHvX9wxCcKrYxI3U/WWTzo8oVYo8fO1tF+U05G/wSRY+D2RsEUNEQ0Y/sudE+Y9CKU
 jpVSfRNFoD4Z8PjuToIKTnqn4oRax3nEfLta1mcsEVnCIRBpp1FZLwQ3GWKjXEaZgIBg
 FBO9nS8tRCcFdrokTT0AKouwXUop+7Vs15QvIhdbt/9+inkErIXulRMC55X45HtB54qD
 03W6pZvR1PPnOElhTYnCcbva6xHSk6qt7QKfabs8HKe9QkxjqFiKrCTvq5LFKBqZil3N
 GP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gATifW08Q1iWD9fEU6clkKUOIggBsmvVgd7EsV7dSlM=;
 b=iw3PSVkd2Otui66HHl7zoiPr5q/W3ReWNcS7qWjBDZRQKJmFaXd64vTKPMCNQ/L5yN
 hSX0OhILRusMmRBriE/W8mQNTddfwWvyS35fLyIxcOp2REmriXLev87qa/0WJ9e2AMuJ
 TCB82u13UPwiAJuCSZRp+Alb9svQ/14OOzq2nf8c77bHUDPiVYQzBeZ6lzz4YEKC1WFV
 m4YdM4z7gaXvQdhs1jJwXVsGLUUCmfuXj3KM5BR6uMwPHOFfo3vPpdijwaOXCxBv/x4x
 QHl4Q4rBKVUUM/5hXE8p2xus0gpzjZpOzVOLkQeZ5+uFZVSpAqdqzsPKZ3rXtr4g4mHz
 IESw==
X-Gm-Message-State: AOAM533NPHGQHr8zvJu03V+0VTwU4XT9yYt0ocHkUoKXp5Lk82ChusAm
 QdJj0Nos0Bnb50UJhuvfbQ5mzRDbIQY=
X-Google-Smtp-Source: ABdhPJxObvVv1qd2bS5NyyLkxJsdIAPBcs3Tj2kivW6dABiWlldL28WW+4jjrl+r7skOaWibgr3r5A==
X-Received: by 2002:a17:90a:d904:: with SMTP id
 c4mr7553318pjv.145.1596710963105; 
 Thu, 06 Aug 2020 03:49:23 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:49:22 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 50/71] target/riscv: rvv-1.0: integer comparison instructions
Date: Thu,  6 Aug 2020 18:46:47 +0800
Message-Id: <20200806104709.13235-51-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x634.google.com
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

* Sign-extend vmselu.vi and vmsgtu.vi immediate values.
* Remove "set tail elements to zeros" as tail elements can be unchanged
  for either VTA to have undisturbed or agnostic setting.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 4 ++--
 target/riscv/vector_helper.c            | 8 --------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index c2eda17c0ce..0a86d41b0a4 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2075,9 +2075,9 @@ GEN_OPIVX_TRANS(vmsgt_vx, opivx_cmp_check)
 
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
index 5add464933c..32bcee0f380 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -1421,7 +1421,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
 {                                                             \
     uint32_t vm = vext_vm(desc);                              \
     uint32_t vl = env->vl;                                    \
-    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);        \
     uint32_t i;                                               \
                                                               \
     for (i = 0; i < vl; i++) {                                \
@@ -1432,9 +1431,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
         }                                                     \
         vext_set_elem_mask(vd, i, DO_OP(s2, s1));             \
     }                                                         \
-    for (; i < vlmax; i++) {                                  \
-        vext_set_elem_mask(vd, i, 0);                         \
-    }                                                         \
 }
 
 GEN_VEXT_CMP_VV(vmseq_vv_b, uint8_t,  H1, DO_MSEQ)
@@ -1473,7 +1469,6 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,   \
 {                                                                   \
     uint32_t vm = vext_vm(desc);                                    \
     uint32_t vl = env->vl;                                          \
-    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);              \
     uint32_t i;                                                     \
                                                                     \
     for (i = 0; i < vl; i++) {                                      \
@@ -1484,9 +1479,6 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,   \
         vext_set_elem_mask(vd, i,                                   \
                 DO_OP(s2, (ETYPE)(target_long)s1));                 \
     }                                                               \
-    for (; i < vlmax; i++) {                                        \
-        vext_set_elem_mask(vd, i, 0);                               \
-    }                                                               \
 }
 
 GEN_VEXT_CMP_VX(vmseq_vx_b, uint8_t,  H1, DO_MSEQ)
-- 
2.17.1


