Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4EFC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:05:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9947020748
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CaAea5ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9947020748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsic-0000g6-Pk
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqdl-0005Tr-2d
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:52:25 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:35222)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqdj-0006gp-De
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:52:24 -0400
Received: by mail-pj1-x1032.google.com with SMTP id f16so2454615pjt.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=g/n/shcRANt+Py1I0cI3sy7fFEukQpkbO1lT8zVmbBo=;
 b=CaAea5qlN4iZPKQSrur0UwqT+jO+TLP75GdCROEsX7YU9vYC1ZdY8iRRtRv9cRnv1G
 I+dgMg+j6YrqY64cyaBSadn8tbAU/a/RjLviVzuwlYMNeHpKV1Cye3KKq1fLeUIavJd+
 OwlqKEYEHCTseLunsw4OO+wfkAdMGYct0029vwtIQyPFoeCqp7xDfwgLB61INV51ICGb
 nWREnQ1sl9njPfIk8kCWaYCI3nqa+ZTb3Zy4QxwVgWWBdhVG54nkyFVQveVzLDPz8Ik1
 +n0ky7TqGRHNrVHoA3Of5uiJFhzIusq/BT7Uyq1fjlFNOwGMiqXlpqCXw6J3OBkWaHzm
 4++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=g/n/shcRANt+Py1I0cI3sy7fFEukQpkbO1lT8zVmbBo=;
 b=Qlc7RggOzcfufh7s6zNPHXr2NiQ53JkzJO9yQgDF39M8fhjxLqmbEPrv6cV7jIPe2S
 UTKQfyYJmbIkmH9qYoNTGhZ/jvXGl6VyZl0ahdUmFbk+IoHeLGK5Hkkr/tOZJFz1pbyt
 6JtCI80MHzZ5JSydUS1Y+ove5nnjMW6cETGuwl4tUYjmOABadwBKEaGN6CmLWBKK8gUe
 lqMhON9++fGpxdjErU/+l41b5rdzcIVvTdVXwLGccfcFh4gKZ2OeoXwRmDG9l4AaB6+U
 H4XhUZ4O7AHoBHqiA9jGfjh6rMHbdUdTSPIvm9diFOtf1PZI09n2vId2Ro4KH7Nw7TpA
 njzw==
X-Gm-Message-State: AOAM533UsmE8QUvord94LzNjgdaxJ7hSp9SvIhoAEQBlX2LCTnxQdCo/
 SNJCuZEwy5CNwVpXalpXD7vNGYKX8uZ4fg==
X-Google-Smtp-Source: ABdhPJyhrkEF4D8Bzz+uw5RCletqdpmNwNH6eDst71YKDB6ORObdXCOVxrxmj7ZKPXdRq5z0Zc2W4g==
X-Received: by 2002:a17:90a:3624:: with SMTP id
 s33mr5038586pjb.148.1594378342130; 
 Fri, 10 Jul 2020 03:52:22 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:52:21 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 27/65] target/riscv: rvv-0.9: iota instruction
Date: Fri, 10 Jul 2020 18:48:41 +0800
Message-Id: <20200710104920.13550-28-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1032.google.com
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

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn32.decode              |  2 +-
 target/riscv/insn_trans/trans_rvv.inc.c | 44 ++++++++++++-------------
 target/riscv/vector_helper.c            |  2 +-
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 37b2582981..4560bc4379 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -578,7 +578,7 @@ vfirst_m        010000 . ..... 10001 010 ..... 1010111 @r2_vm
 vmsbf_m         010100 . ..... 00001 010 ..... 1010111 @r2_vm
 vmsif_m         010100 . ..... 00011 010 ..... 1010111 @r2_vm
 vmsof_m         010100 . ..... 00010 010 ..... 1010111 @r2_vm
-viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
+viota_m         010100 . ..... 10000 010 ..... 1010111 @r2_vm
 vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
 vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
 vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index c1efb87e8d..0e552c3660 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2785,29 +2785,29 @@ GEN_M_TRANS(vmsof_m)
 /* Vector Iota Instruction */
 static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
 {
-    if (vext_check_isa_ill(s) &&
-        vext_check_reg(s, a->rd, false) &&
-        vext_check_overlap_group(a->rd, 1 << s->lmul, a->rs2, 1) &&
-        (a->vm != 0 || a->rd != 0)) {
-        uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    require_noover(a->rd, s->flmul, a->rs2, 1);
+    require_vm(a->vm, a->rd);
+    require_align(a->rd, s->flmul);
 
-        data = FIELD_DP32(data, VDATA, VM, a->vm);
-        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
-        data = FIELD_DP32(data, VDATA, VTA, s->vta);
-        data = FIELD_DP32(data, VDATA, VMA, s->vma);
-        static gen_helper_gvec_3_ptr * const fns[4] = {
-            gen_helper_viota_m_b, gen_helper_viota_m_h,
-            gen_helper_viota_m_w, gen_helper_viota_m_d,
-        };
-        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
-                           vreg_ofs(s, a->rs2), cpu_env, 0,
-                           s->vlen / 8, data, fns[s->sew]);
-        gen_set_label(over);
-        return true;
-    }
-    return false;
+    uint32_t data = 0;
+    TCGLabel *over = gen_new_label();
+    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+
+    data = FIELD_DP32(data, VDATA, VM, a->vm);
+    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);
+    static gen_helper_gvec_3_ptr * const fns[4] = {
+        gen_helper_viota_m_b, gen_helper_viota_m_h,
+        gen_helper_viota_m_w, gen_helper_viota_m_d,
+    };
+    tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
+                       vreg_ofs(s, a->rs2), cpu_env, 0,
+                       s->vlen / 8, data, fns[s->sew]);
+    gen_set_label(over);
+    return true;
 }
 
 /* Vector Element Index Instruction */
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index bc1363fb7d..71a12c6c9b 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4748,7 +4748,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2, CPURISCVState *env,      \
     CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
 }
 
-GEN_VEXT_VIOTA_M(viota_m_b, uint8_t, H1, clearb)
+GEN_VEXT_VIOTA_M(viota_m_b, uint8_t,  H1, clearb)
 GEN_VEXT_VIOTA_M(viota_m_h, uint16_t, H2, clearh)
 GEN_VEXT_VIOTA_M(viota_m_w, uint32_t, H4, clearl)
 GEN_VEXT_VIOTA_M(viota_m_d, uint64_t, H8, clearq)
-- 
2.17.1


