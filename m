Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31A7C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:38:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BECA2077D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fBSVIFt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BECA2077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBCv-0006fH-R7
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAwO-0005ax-8V
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:21:32 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35261)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAwM-00064S-Fl
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:21:31 -0400
Received: by mail-pf1-x442.google.com with SMTP id a14so878277pfi.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Y2KhL2jx26SA0fTdqwK4kIep/hAoNdtUzmiGc3hCqv0=;
 b=fBSVIFt8M+1vCfA5AkeAlSY7H3yfNI3CYuRBLR19toJ85X7JXkeMQLBqV3TLYBmaJa
 8PJohVgPvNGppJQ+PRrY6WEQfrgQmGpKjta0QRL5C7KcFVljxUta+lD+IsDDU9CMeveV
 5Nh6d4x8O933PY3JwQecSMhNntwdviXcaDGBZWRc0UmW0bdx3Lv3tru2M1/ocTzlHpk3
 YXw42Q3zT2tg/ZyzUSTw2V8rKlErXaakMWGZTRyzGsPNoGnpwS5xdsXbZMdD3JIn2mGE
 hd9yJkacr41bheLJnx3me1ploDXjz8/qqx9+rEG/UAzpFjs/KgHHYGhHf+s1s0WC1kjj
 hU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Y2KhL2jx26SA0fTdqwK4kIep/hAoNdtUzmiGc3hCqv0=;
 b=XPh86c84g0B8VNDPrEy82d8fPnGG/l2aCuokVm614XbpJRvpS7+Js9EZ+OaHxGoMHv
 RkMi0XC0jiV8X4idHh5Iax9Q2wA6ENZ+BlM2E2hOJV8eKINZhBXTS7FikdzO9qTXIxp/
 6r5amp3M1W2YncgR8NRc7v59ZGlgW58eGQD84wcrOTO3Q8IV8ul510PS0bSVa0YU1zrd
 wyLkp91dQw2b42zDyHL3WrRLj8/reHrLezPuU2HAThO1GBbnYNo/bhOt54BJcT1C5Nw0
 6kXmonfWYSIwVvizJOCtuwbYEeh6uAekN6fCy7t0s1ee1C+2a6VszFOI36ChtEWFIH4h
 kRnA==
X-Gm-Message-State: AOAM530vSiMWo+ga5jfCp7Jf+s5B7dsYCYzLtGwGT1NatJKr7cof5JTP
 mrssFppXYEH0qJY9y/bO66OrHOQ5MTo=
X-Google-Smtp-Source: ABdhPJx3KaHP5GqEREd1cWksd+w4MxzRbEVM1BS1JpjUOJ46Be6xvW3A5+SPDEzAB5ZUANE7tbHNyA==
X-Received: by 2002:a62:52cd:: with SMTP id
 g196mr27987915pfb.178.1595409689032; 
 Wed, 22 Jul 2020 02:21:29 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:21:28 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 55/76] target/riscv: rvv-0.9: single-width integer reduction
 instructions
Date: Wed, 22 Jul 2020 17:16:18 +0800
Message-Id: <20200722091641.8834-56-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x442.google.com
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

Remove clear function from helper function as the tail elements
are unchanged in RVV 0.9.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/vector_helper.c | 69 +++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 36 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 8dccec4e04..39245b5ac8 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4565,15 +4565,13 @@ GEN_VEXT_V_ENV(vfncvt_f_f_v_w, 4, 4, clearl)
  *** Vector Reduction Operations
  */
 /* Vector Single-Width Integer Reduction Instructions */
-#define GEN_VEXT_RED(NAME, TD, TS2, HD, HS2, OP, CLEAR_FN)\
+#define GEN_VEXT_RED(NAME, TD, TS2, HD, HS2, OP)          \
 void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
         void *vs2, CPURISCVState *env, uint32_t desc)     \
 {                                                         \
     uint32_t vm = vext_vm(desc);                          \
-    uint32_t vta = vext_vm(desc);                         \
     uint32_t vl = env->vl;                                \
     uint32_t i;                                           \
-    uint32_t tot = env_archcpu(env)->cfg.vlen / 8;        \
     TD s1 =  *((TD *)vs1 + HD(0));                        \
                                                           \
     for (i = 0; i < vl; i++) {                            \
@@ -4584,56 +4582,55 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
         s1 = OP(s1, (TD)s2);                              \
     }                                                     \
     *((TD *)vd + HD(0)) = s1;                             \
-    CLEAR_FN(vd, vta, 1, sizeof(TD), tot);                \
 }
 
 /* vd[0] = sum(vs1[0], vs2[*]) */
-GEN_VEXT_RED(vredsum_vs_b, int8_t, int8_t, H1, H1, DO_ADD, clearb)
-GEN_VEXT_RED(vredsum_vs_h, int16_t, int16_t, H2, H2, DO_ADD, clearh)
-GEN_VEXT_RED(vredsum_vs_w, int32_t, int32_t, H4, H4, DO_ADD, clearl)
-GEN_VEXT_RED(vredsum_vs_d, int64_t, int64_t, H8, H8, DO_ADD, clearq)
+GEN_VEXT_RED(vredsum_vs_b, int8_t,  int8_t,  H1, H1, DO_ADD)
+GEN_VEXT_RED(vredsum_vs_h, int16_t, int16_t, H2, H2, DO_ADD)
+GEN_VEXT_RED(vredsum_vs_w, int32_t, int32_t, H4, H4, DO_ADD)
+GEN_VEXT_RED(vredsum_vs_d, int64_t, int64_t, H8, H8, DO_ADD)
 
 /* vd[0] = maxu(vs1[0], vs2[*]) */
-GEN_VEXT_RED(vredmaxu_vs_b, uint8_t, uint8_t, H1, H1, DO_MAX, clearb)
-GEN_VEXT_RED(vredmaxu_vs_h, uint16_t, uint16_t, H2, H2, DO_MAX, clearh)
-GEN_VEXT_RED(vredmaxu_vs_w, uint32_t, uint32_t, H4, H4, DO_MAX, clearl)
-GEN_VEXT_RED(vredmaxu_vs_d, uint64_t, uint64_t, H8, H8, DO_MAX, clearq)
+GEN_VEXT_RED(vredmaxu_vs_b, uint8_t,  uint8_t,  H1, H1, DO_MAX)
+GEN_VEXT_RED(vredmaxu_vs_h, uint16_t, uint16_t, H2, H2, DO_MAX)
+GEN_VEXT_RED(vredmaxu_vs_w, uint32_t, uint32_t, H4, H4, DO_MAX)
+GEN_VEXT_RED(vredmaxu_vs_d, uint64_t, uint64_t, H8, H8, DO_MAX)
 
 /* vd[0] = max(vs1[0], vs2[*]) */
-GEN_VEXT_RED(vredmax_vs_b, int8_t, int8_t, H1, H1, DO_MAX, clearb)
-GEN_VEXT_RED(vredmax_vs_h, int16_t, int16_t, H2, H2, DO_MAX, clearh)
-GEN_VEXT_RED(vredmax_vs_w, int32_t, int32_t, H4, H4, DO_MAX, clearl)
-GEN_VEXT_RED(vredmax_vs_d, int64_t, int64_t, H8, H8, DO_MAX, clearq)
+GEN_VEXT_RED(vredmax_vs_b, int8_t,  int8_t,  H1, H1, DO_MAX)
+GEN_VEXT_RED(vredmax_vs_h, int16_t, int16_t, H2, H2, DO_MAX)
+GEN_VEXT_RED(vredmax_vs_w, int32_t, int32_t, H4, H4, DO_MAX)
+GEN_VEXT_RED(vredmax_vs_d, int64_t, int64_t, H8, H8, DO_MAX)
 
 /* vd[0] = minu(vs1[0], vs2[*]) */
-GEN_VEXT_RED(vredminu_vs_b, uint8_t, uint8_t, H1, H1, DO_MIN, clearb)
-GEN_VEXT_RED(vredminu_vs_h, uint16_t, uint16_t, H2, H2, DO_MIN, clearh)
-GEN_VEXT_RED(vredminu_vs_w, uint32_t, uint32_t, H4, H4, DO_MIN, clearl)
-GEN_VEXT_RED(vredminu_vs_d, uint64_t, uint64_t, H8, H8, DO_MIN, clearq)
+GEN_VEXT_RED(vredminu_vs_b, uint8_t,  uint8_t,  H1, H1, DO_MIN)
+GEN_VEXT_RED(vredminu_vs_h, uint16_t, uint16_t, H2, H2, DO_MIN)
+GEN_VEXT_RED(vredminu_vs_w, uint32_t, uint32_t, H4, H4, DO_MIN)
+GEN_VEXT_RED(vredminu_vs_d, uint64_t, uint64_t, H8, H8, DO_MIN)
 
 /* vd[0] = min(vs1[0], vs2[*]) */
-GEN_VEXT_RED(vredmin_vs_b, int8_t, int8_t, H1, H1, DO_MIN, clearb)
-GEN_VEXT_RED(vredmin_vs_h, int16_t, int16_t, H2, H2, DO_MIN, clearh)
-GEN_VEXT_RED(vredmin_vs_w, int32_t, int32_t, H4, H4, DO_MIN, clearl)
-GEN_VEXT_RED(vredmin_vs_d, int64_t, int64_t, H8, H8, DO_MIN, clearq)
+GEN_VEXT_RED(vredmin_vs_b, int8_t,  int8_t,  H1, H1, DO_MIN)
+GEN_VEXT_RED(vredmin_vs_h, int16_t, int16_t, H2, H2, DO_MIN)
+GEN_VEXT_RED(vredmin_vs_w, int32_t, int32_t, H4, H4, DO_MIN)
+GEN_VEXT_RED(vredmin_vs_d, int64_t, int64_t, H8, H8, DO_MIN)
 
 /* vd[0] = and(vs1[0], vs2[*]) */
-GEN_VEXT_RED(vredand_vs_b, int8_t, int8_t, H1, H1, DO_AND, clearb)
-GEN_VEXT_RED(vredand_vs_h, int16_t, int16_t, H2, H2, DO_AND, clearh)
-GEN_VEXT_RED(vredand_vs_w, int32_t, int32_t, H4, H4, DO_AND, clearl)
-GEN_VEXT_RED(vredand_vs_d, int64_t, int64_t, H8, H8, DO_AND, clearq)
+GEN_VEXT_RED(vredand_vs_b, int8_t,  int8_t,  H1, H1, DO_AND)
+GEN_VEXT_RED(vredand_vs_h, int16_t, int16_t, H2, H2, DO_AND)
+GEN_VEXT_RED(vredand_vs_w, int32_t, int32_t, H4, H4, DO_AND)
+GEN_VEXT_RED(vredand_vs_d, int64_t, int64_t, H8, H8, DO_AND)
 
 /* vd[0] = or(vs1[0], vs2[*]) */
-GEN_VEXT_RED(vredor_vs_b, int8_t, int8_t, H1, H1, DO_OR, clearb)
-GEN_VEXT_RED(vredor_vs_h, int16_t, int16_t, H2, H2, DO_OR, clearh)
-GEN_VEXT_RED(vredor_vs_w, int32_t, int32_t, H4, H4, DO_OR, clearl)
-GEN_VEXT_RED(vredor_vs_d, int64_t, int64_t, H8, H8, DO_OR, clearq)
+GEN_VEXT_RED(vredor_vs_b, int8_t,  int8_t,  H1, H1, DO_OR)
+GEN_VEXT_RED(vredor_vs_h, int16_t, int16_t, H2, H2, DO_OR)
+GEN_VEXT_RED(vredor_vs_w, int32_t, int32_t, H4, H4, DO_OR)
+GEN_VEXT_RED(vredor_vs_d, int64_t, int64_t, H8, H8, DO_OR)
 
 /* vd[0] = xor(vs1[0], vs2[*]) */
-GEN_VEXT_RED(vredxor_vs_b, int8_t, int8_t, H1, H1, DO_XOR, clearb)
-GEN_VEXT_RED(vredxor_vs_h, int16_t, int16_t, H2, H2, DO_XOR, clearh)
-GEN_VEXT_RED(vredxor_vs_w, int32_t, int32_t, H4, H4, DO_XOR, clearl)
-GEN_VEXT_RED(vredxor_vs_d, int64_t, int64_t, H8, H8, DO_XOR, clearq)
+GEN_VEXT_RED(vredxor_vs_b, int8_t,  int8_t,  H1, H1, DO_XOR)
+GEN_VEXT_RED(vredxor_vs_h, int16_t, int16_t, H2, H2, DO_XOR)
+GEN_VEXT_RED(vredxor_vs_w, int32_t, int32_t, H4, H4, DO_XOR)
+GEN_VEXT_RED(vredxor_vs_d, int64_t, int64_t, H8, H8, DO_XOR)
 
 /* Vector Widening Integer Reduction Instructions */
 /* signed sum reduction into double-width accumulator */
-- 
2.17.1


