Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF049C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:30:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75A9F206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Z/EKns/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A9F206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyB4h-0005g5-Ms
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAuK-00012J-Lv
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:19:24 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:36037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAuI-0005Yk-2m
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:19:24 -0400
Received: by mail-pg1-x52d.google.com with SMTP id p3so880504pgh.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Zaz1YKMLbjDLooDJEehaxTfgg40pu4GNpEuVJmdgSH4=;
 b=Z/EKns/fYuSEqf/wb6ZMbtTsfvJZug+Uu7/hXDG800d1f3QFV52Kq5gnKnZ3O8n0hW
 NBVEDnC2JXbBuVt/VucE/aZz/aIH31HM11anls3BcVqwVCx73OqCRsQ7MqLao44qBkK2
 i7Ih3v1BaxaaWcxfb65m5cXy43kx8tD7jBtklXIQs7PHFDgX6vyX6najFwjGQKkUtMII
 //DuZxDABG+IXiEnXTEsejgdrSDEiWP8qXkOT4Q7PdD8WSIRBK+K4lSx+7qBtofaMAoj
 FEWWUVovJ7QwIl3lTTDQBeSoFQYGIszjOtBUeVjXpmE78jQW++j4JpogEpeYt3a+wH2r
 +dVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Zaz1YKMLbjDLooDJEehaxTfgg40pu4GNpEuVJmdgSH4=;
 b=Utpsca0r5RqPcDRe1AEQdGWs7OMsxtIc+BhU3vekjTAOgbvJ8lEe+/C+QKU37h0MAX
 SBBRV89hOIh9l+AoYDM7T2IOrytnwJqC0YtZiVD36Z+61eTlSmTHMsXtEHJM8arn73ls
 k+VsimIZRyRD7zf24FQbZmAFvW92oMyotQkqqJuEGPLsxO5eptdp+4nS5J6eB0ktHEPf
 cl3UhUMGOH3cUCn64bElOENIWHqDsXzjyNGpwLSJQ5ZJLqZbBbiWSffE/gyXgjts4NZ+
 l7VBwEjl1jDeySVt0GaCkj8cye8XSvNDLZqA5gxdRv2JXPSfu7NVwu6ETu4XYDqjNU6a
 8IZQ==
X-Gm-Message-State: AOAM531IY1SSJ0aNUjoC3D6ZczyRg3OZxDqU7ueP0jz3ABuCj2KkRO1e
 S2rQIhPUDfR1aFWYTeMavIund8oRyVE=
X-Google-Smtp-Source: ABdhPJxPyL/mZs6gqk9GOpw8abyocMMPhOGRrIKKUfmnv0WEsTh39pZUb0tzLtK1UrkxTqLo0zb8pw==
X-Received: by 2002:a65:52c8:: with SMTP id z8mr25620658pgp.266.1595409560492; 
 Wed, 22 Jul 2020 02:19:20 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:19:20 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 25/76] target/riscv: rvv-0.9: fault-only-first unit stride
 load
Date: Wed, 22 Jul 2020 17:15:48 +0800
Message-Id: <20200722091641.8834-26-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x52d.google.com
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

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/helper.h                   | 27 +++---------
 target/riscv/insn32.decode              | 14 +++----
 target/riscv/insn_trans/trans_rvv.inc.c | 31 ++++----------
 target/riscv/vector_helper.c            | 56 +++++++++----------------
 4 files changed, 38 insertions(+), 90 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 4890b2aa02..db032fd47f 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -140,28 +140,11 @@ DEF_HELPER_6(vsxei64_8_v, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsxei64_16_v, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsxei64_32_v, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsxei64_64_v, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_5(vlbff_v_b, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlbff_v_h, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlbff_v_w, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlbff_v_d, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlhff_v_h, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlhff_v_w, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlhff_v_d, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlwff_v_w, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlwff_v_d, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vleff_v_b, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vleff_v_h, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vleff_v_w, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vleff_v_d, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlbuff_v_b, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlbuff_v_h, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlbuff_v_w, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlbuff_v_d, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlhuff_v_h, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlhuff_v_w, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlhuff_v_d, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlwuff_v_w, void, ptr, ptr, tl, env, i32)
-DEF_HELPER_5(vlwuff_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle8ff_v, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle16ff_v, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle32ff_v, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vle64ff_v, void, ptr, ptr, tl, env, i32)
+
 #ifdef TARGET_RISCV64
 DEF_HELPER_6(vamoswapw_v_d, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vamoswapd_v_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 46542d162e..b0aaa186b8 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -249,14 +249,6 @@ vsse16_v    ... 010 . ..... ..... 101 ..... 0100111 @r_nfvm
 vsse32_v    ... 010 . ..... ..... 110 ..... 0100111 @r_nfvm
 vsse64_v    ... 010 . ..... ..... 111 ..... 0100111 @r_nfvm
 
-vlbff_v    ... 100 . 10000 ..... 000 ..... 0000111 @r2_nfvm
-vlhff_v    ... 100 . 10000 ..... 101 ..... 0000111 @r2_nfvm
-vlwff_v    ... 100 . 10000 ..... 110 ..... 0000111 @r2_nfvm
-vleff_v    ... 000 . 10000 ..... 111 ..... 0000111 @r2_nfvm
-vlbuff_v   ... 000 . 10000 ..... 000 ..... 0000111 @r2_nfvm
-vlhuff_v   ... 000 . 10000 ..... 101 ..... 0000111 @r2_nfvm
-vlwuff_v   ... 000 . 10000 ..... 110 ..... 0000111 @r2_nfvm
-
 # Vector indexed load insns.
 vlxei8_v      ... 011 . ..... ..... 000 ..... 0000111 @r_nfvm
 vlxei16_v     ... 011 . ..... ..... 101 ..... 0000111 @r_nfvm
@@ -269,6 +261,12 @@ vsxei16_v     ... 0-1 . ..... ..... 101 ..... 0100111 @r_nfvm
 vsxei32_v     ... 0-1 . ..... ..... 110 ..... 0100111 @r_nfvm
 vsxei64_v     ... 0-1 . ..... ..... 111 ..... 0100111 @r_nfvm
 
+# Vector unit-stride fault-only-first load insns.
+vle8ff_v      ... 000 . 10000 ..... 000 ..... 0000111 @r2_nfvm
+vle16ff_v     ... 000 . 10000 ..... 101 ..... 0000111 @r2_nfvm
+vle32ff_v     ... 000 . 10000 ..... 110 ..... 0000111 @r2_nfvm
+vle64ff_v     ... 000 . 10000 ..... 111 ..... 0000111 @r2_nfvm
+
 #*** Vector AMO operations are encoded under the standard AMO major opcode ***
 vamoswapw_v     00001 . . ..... ..... 110 ..... 0101111 @r_wdvm
 vamoaddw_v      00000 . . ..... ..... 110 ..... 0101111 @r_wdvm
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index b902462741..19c6866838 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -959,24 +959,12 @@ static bool ldff_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
 {
     uint32_t data = 0;
     gen_helper_ldst_us *fn;
-    static gen_helper_ldst_us * const fns[7][4] = {
-        { gen_helper_vlbff_v_b,  gen_helper_vlbff_v_h,
-          gen_helper_vlbff_v_w,  gen_helper_vlbff_v_d },
-        { NULL,                  gen_helper_vlhff_v_h,
-          gen_helper_vlhff_v_w,  gen_helper_vlhff_v_d },
-        { NULL,                  NULL,
-          gen_helper_vlwff_v_w,  gen_helper_vlwff_v_d },
-        { gen_helper_vleff_v_b,  gen_helper_vleff_v_h,
-          gen_helper_vleff_v_w,  gen_helper_vleff_v_d },
-        { gen_helper_vlbuff_v_b, gen_helper_vlbuff_v_h,
-          gen_helper_vlbuff_v_w, gen_helper_vlbuff_v_d },
-        { NULL,                  gen_helper_vlhuff_v_h,
-          gen_helper_vlhuff_v_w, gen_helper_vlhuff_v_d },
-        { NULL,                  NULL,
-          gen_helper_vlwuff_v_w, gen_helper_vlwuff_v_d }
+    static gen_helper_ldst_us * const fns[4] = {
+        gen_helper_vle8ff_v, gen_helper_vle16ff_v,
+        gen_helper_vle32ff_v, gen_helper_vle64ff_v
     };
 
-    fn =  fns[seq][s->sew];
+    fn = fns[seq];
     if (fn == NULL) {
         return false;
     }
@@ -990,13 +978,10 @@ static bool ldff_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
     return ldff_trans(a->rd, a->rs1, data, fn, s);
 }
 
-GEN_VEXT_TRANS(vlbff_v, 0, r2nfvm, ldff_op, ld_us_check)
-GEN_VEXT_TRANS(vlhff_v, 1, r2nfvm, ldff_op, ld_us_check)
-GEN_VEXT_TRANS(vlwff_v, 2, r2nfvm, ldff_op, ld_us_check)
-GEN_VEXT_TRANS(vleff_v, 3, r2nfvm, ldff_op, ld_us_check)
-GEN_VEXT_TRANS(vlbuff_v, 4, r2nfvm, ldff_op, ld_us_check)
-GEN_VEXT_TRANS(vlhuff_v, 5, r2nfvm, ldff_op, ld_us_check)
-GEN_VEXT_TRANS(vlwuff_v, 6, r2nfvm, ldff_op, ld_us_check)
+GEN_VEXT_TRANS(vle8ff_v,  8,  0, r2nfvm, ldff_op, ld_us_check)
+GEN_VEXT_TRANS(vle16ff_v, 16, 1, r2nfvm, ldff_op, ld_us_check)
+GEN_VEXT_TRANS(vle32ff_v, 32, 2, r2nfvm, ldff_op, ld_us_check)
+GEN_VEXT_TRANS(vle64ff_v, 64, 3, r2nfvm, ldff_op, ld_us_check)
 
 /*
  *** vector atomic operation
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 1c4aba21c6..35ce006698 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -557,7 +557,7 @@ vext_ldff(void *vd, void *v0, target_ulong base,
           CPURISCVState *env, uint32_t desc,
           vext_ldst_elem_fn *ldst_elem,
           clear_fn *clear_elem,
-          uint32_t esz, uint32_t msz, uintptr_t ra)
+          uint32_t esz, uintptr_t ra)
 {
     void *host;
     uint32_t i, k, vl = 0;
@@ -572,24 +572,24 @@ vext_ldff(void *vd, void *v0, target_ulong base,
         if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
-        addr = base + nf * i * msz;
+        addr = base + nf * i * esz;
         if (i == 0) {
-            probe_pages(env, addr, nf * msz, ra, MMU_DATA_LOAD);
+            probe_pages(env, addr, nf * esz, ra, MMU_DATA_LOAD);
         } else {
             /* if it triggers an exception, no need to check watchpoint */
-            remain = nf * msz;
+            remain = nf * esz;
             while (remain > 0) {
                 offset = -(addr | TARGET_PAGE_MASK);
                 host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD,
                                          cpu_mmu_index(env, false));
                 if (host) {
 #ifdef CONFIG_USER_ONLY
-                    if (page_check_range(addr, nf * msz, PAGE_READ) < 0) {
+                    if (page_check_range(addr, nf * esz, PAGE_READ) < 0) {
                         vl = i;
                         goto ProbeSuccess;
                     }
 #else
-                    probe_pages(env, addr, nf * msz, ra, MMU_DATA_LOAD);
+                    probe_pages(env, addr, nf * esz, ra, MMU_DATA_LOAD);
 #endif
                 } else {
                     vl = i;
@@ -614,7 +614,7 @@ ProbeSuccess:
             continue;
         }
         while (k < nf) {
-            target_ulong addr = base + (i * nf + k) * msz;
+            target_ulong addr = base + (i * nf + k) * esz;
             ldst_elem(env, addr, i + k * vlmax, vd, ra);
             k++;
         }
@@ -629,36 +629,18 @@ ProbeSuccess:
     }
 }
 
-#define GEN_VEXT_LDFF(NAME, MTYPE, ETYPE, LOAD_FN, CLEAR_FN)     \
-void HELPER(NAME)(void *vd, void *v0, target_ulong base,         \
-                  CPURISCVState *env, uint32_t desc)             \
-{                                                                \
-    vext_ldff(vd, v0, base, env, desc, LOAD_FN, CLEAR_FN,        \
-              sizeof(ETYPE), sizeof(MTYPE), GETPC());            \
-}
-
-GEN_VEXT_LDFF(vlbff_v_b,  int8_t,   int8_t,   ldb_b,  clearb)
-GEN_VEXT_LDFF(vlbff_v_h,  int8_t,   int16_t,  ldb_h,  clearh)
-GEN_VEXT_LDFF(vlbff_v_w,  int8_t,   int32_t,  ldb_w,  clearl)
-GEN_VEXT_LDFF(vlbff_v_d,  int8_t,   int64_t,  ldb_d,  clearq)
-GEN_VEXT_LDFF(vlhff_v_h,  int16_t,  int16_t,  ldh_h,  clearh)
-GEN_VEXT_LDFF(vlhff_v_w,  int16_t,  int32_t,  ldh_w,  clearl)
-GEN_VEXT_LDFF(vlhff_v_d,  int16_t,  int64_t,  ldh_d,  clearq)
-GEN_VEXT_LDFF(vlwff_v_w,  int32_t,  int32_t,  ldw_w,  clearl)
-GEN_VEXT_LDFF(vlwff_v_d,  int32_t,  int64_t,  ldw_d,  clearq)
-GEN_VEXT_LDFF(vleff_v_b,  int8_t,   int8_t,   lde_b,  clearb)
-GEN_VEXT_LDFF(vleff_v_h,  int16_t,  int16_t,  lde_h,  clearh)
-GEN_VEXT_LDFF(vleff_v_w,  int32_t,  int32_t,  lde_w,  clearl)
-GEN_VEXT_LDFF(vleff_v_d,  int64_t,  int64_t,  lde_d,  clearq)
-GEN_VEXT_LDFF(vlbuff_v_b, uint8_t,  uint8_t,  ldbu_b, clearb)
-GEN_VEXT_LDFF(vlbuff_v_h, uint8_t,  uint16_t, ldbu_h, clearh)
-GEN_VEXT_LDFF(vlbuff_v_w, uint8_t,  uint32_t, ldbu_w, clearl)
-GEN_VEXT_LDFF(vlbuff_v_d, uint8_t,  uint64_t, ldbu_d, clearq)
-GEN_VEXT_LDFF(vlhuff_v_h, uint16_t, uint16_t, ldhu_h, clearh)
-GEN_VEXT_LDFF(vlhuff_v_w, uint16_t, uint32_t, ldhu_w, clearl)
-GEN_VEXT_LDFF(vlhuff_v_d, uint16_t, uint64_t, ldhu_d, clearq)
-GEN_VEXT_LDFF(vlwuff_v_w, uint32_t, uint32_t, ldwu_w, clearl)
-GEN_VEXT_LDFF(vlwuff_v_d, uint32_t, uint64_t, ldwu_d, clearq)
+#define GEN_VEXT_LDFF(NAME, ETYPE, LOAD_FN, CLEAR_FN)     \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,  \
+                  CPURISCVState *env, uint32_t desc)      \
+{                                                         \
+    vext_ldff(vd, v0, base, env, desc, LOAD_FN, CLEAR_FN, \
+              sizeof(ETYPE), GETPC());                    \
+}
+
+GEN_VEXT_LDFF(vle8ff_v,  int8_t,  lde_b, clearb)
+GEN_VEXT_LDFF(vle16ff_v, int16_t, lde_h, clearh)
+GEN_VEXT_LDFF(vle32ff_v, int32_t, lde_w, clearl)
+GEN_VEXT_LDFF(vle64ff_v, int64_t, lde_d, clearq)
 
 /*
  *** Vector AMO Operations (Zvamo)
-- 
2.17.1


