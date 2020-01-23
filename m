Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA3DC35240
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 23:26:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B975F207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 23:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xjEJYwug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B975F207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iulrl-0005Fh-Vj
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 18:26:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iuloV-00008U-Ms
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 18:23:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iuloT-0007hB-Mn
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 18:23:03 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030]:34079)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iuloT-0007gT-Ec
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 18:23:01 -0500
Received: by mail-pj1-x1030.google.com with SMTP id f2so83832pjq.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 15:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WXgtgFjEX2QCToUnHwizHlyfzg0a8KnJcrxsk37lyNA=;
 b=xjEJYwugtSXtucWFqdJPttgsIfgM//HpqyMyaygToNjiVsWi8pkruwOmgQTV1rkgH/
 rPUqM3B+ZhkIQ6PuyymJ7rzhV8C5HO+iv5KhIXQLAxC4NhMGod9OZHn5IX2L2mGpzBSL
 l86fUU1f4Xejc6jAeS8QhJkTYKsKjJY2q0kCCNk3zwHDcRNerfhj9RPzhalpHmqjaYGw
 4iI7mbHUwoPcqG14rld6o6iY9yNpT+HzWFyPB8Z4wOfBZ0Kma13Fhi8sCHg4U62mjWHt
 5/hdRJOPYDZfe5qcwCtztNBuA9TXHMFKlXxV9/ApHrXvMtijC8r5ZOsRAarhM/GvWo57
 0HuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WXgtgFjEX2QCToUnHwizHlyfzg0a8KnJcrxsk37lyNA=;
 b=XMHAI06Urmz7MTZDckklccm9jg03Sw1F/ICjLJJ8BKfMnAmEbwMEO2hOmh9qeSo/BD
 7ZB4ZA3P5pM8BJRCISw5T17n8p630wY/UsOBAIax5m9MYsNKnSghmVtsBCXxq48aeBjW
 MnKzUm1VocczZy9Vw7N+GOW+Xsf12Cj2Bw/gvrVM9OE0yd16DDDcw0pWub6j9n5qro1e
 7fsgI6E/aTInKnWgvZOnakTCDCV1FacvmGCA7xmYlYAGuZ9kamzvgCV57MKZkNKBH43w
 x6J5HL/KhZrQvA85Z/dU8NVGG9jBonpWabK7sTFYKTeUSV2UYauT/oeEVXoNFrYvdCS0
 GDtw==
X-Gm-Message-State: APjAAAU+gcnF2jcQ13xWRfxTeobezAmA1iY3UFrVWLteyp4dQANsHI8u
 IKFs+961iP5243hHLgd8XDIlTrvR364=
X-Google-Smtp-Source: APXvYqxnY2aDwz+XQwTzxP/lNPPoCkLXYBslv15jwY70KXBrp6BLiEvCVHBCOf+TKXWG9w8cj5yLKQ==
X-Received: by 2002:a17:902:848f:: with SMTP id
 c15mr568382plo.182.1579821779928; 
 Thu, 23 Jan 2020 15:22:59 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id z5sm4136008pfq.3.2020.01.23.15.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 15:22:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] target/s390x: Move DisasFields into DisasContext
Date: Thu, 23 Jan 2020 13:22:47 -1000
Message-Id: <20200123232248.1800-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123232248.1800-1-richard.henderson@linaro.org>
References: <20200123232248.1800-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1030
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
Cc: thuth@redhat.com, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I believe that the separate allocation of DisasFields from DisasContext
was meant to limit the places from which we could access fields.  But
that plan did not go unchanged, and since DisasContext contains a pointer
to fields, the substructure is accessible everywhere.

By allocating the substructure with DisasContext, we improve the locality
of the accesses by avoiding one level of pointer chasing.  In addition,
we avoid a dangling pointer to stack allocated memory, diagnosed by static
checkers.

Launchpad: https://bugs.launchpad.net/bugs/1661815
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/translate.c        | 22 +++++++++---------
 target/s390x/translate_vx.inc.c | 40 ++++++++++++++++-----------------
 2 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 51a1d865c0..3674fee10c 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -139,7 +139,7 @@ struct DisasFields {
 struct DisasContext {
     DisasContextBase base;
     const DisasInsn *insn;
-    DisasFields *fields;
+    DisasFields fields;
     uint64_t ex_value;
     /*
      * During translate_one(), pc_tmp is used to determine the instruction
@@ -1094,14 +1094,14 @@ typedef enum {
 
 static bool have_field1(const DisasContext *s, enum DisasFieldIndexO c)
 {
-    return (s->fields->presentO >> c) & 1;
+    return (s->fields.presentO >> c) & 1;
 }
 
 static int get_field1(const DisasContext *s, enum DisasFieldIndexO o,
                       enum DisasFieldIndexC c)
 {
     assert(have_field1(s, o));
-    return s->fields->c[c];
+    return s->fields.c[c];
 }
 
 /* Describe the layout of each field in each format.  */
@@ -3763,7 +3763,7 @@ static DisasJumpType op_risbg(DisasContext *s, DisasOps *o)
     int pos, len, rot;
 
     /* Adjust the arguments for the specific insn.  */
-    switch (s->fields->op2) {
+    switch (s->fields.op2) {
     case 0x55: /* risbg */
     case 0x59: /* risbgn */
         i3 &= 63;
@@ -3804,7 +3804,7 @@ static DisasJumpType op_risbg(DisasContext *s, DisasOps *o)
     len = i4 - i3 + 1;
     pos = 63 - i4;
     rot = i5 & 63;
-    if (s->fields->op2 == 0x5d) {
+    if (s->fields.op2 == 0x5d) {
         pos += 32;
     }
 
@@ -3873,7 +3873,7 @@ static DisasJumpType op_rosbg(DisasContext *s, DisasOps *o)
     tcg_gen_rotli_i64(o->in2, o->in2, i5);
 
     /* Operate.  */
-    switch (s->fields->op2) {
+    switch (s->fields.op2) {
     case 0x55: /* AND */
         tcg_gen_ori_i64(o->in2, o->in2, ~mask);
         tcg_gen_and_i64(o->out, o->out, o->in2);
@@ -4489,7 +4489,7 @@ static DisasJumpType op_stnosm(DisasContext *s, DisasOps *o)
     tcg_gen_qemu_st8(t, o->addr1, get_mem_index(s));
     tcg_temp_free_i64(t);
 
-    if (s->fields->op == 0xac) {
+    if (s->fields.op == 0xac) {
         tcg_gen_andi_i64(psw_mask, psw_mask,
                          (i2 << 56) | 0x00ffffffffffffffull);
     } else {
@@ -6000,7 +6000,7 @@ static void in2_i2_32u_shl(DisasContext *s, DisasOps *o)
 #ifndef CONFIG_USER_ONLY
 static void in2_insn(DisasContext *s, DisasOps *o)
 {
-    o->in2 = tcg_const_i64(s->fields->raw_insn);
+    o->in2 = tcg_const_i64(s->fields.raw_insn);
 }
 #define SPEC_in2_insn 0
 #endif
@@ -6299,15 +6299,13 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
 {
     const DisasInsn *insn;
     DisasJumpType ret = DISAS_NEXT;
-    DisasFields f;
     DisasOps o = {};
 
     /* Search for the insn in the table.  */
-    insn = extract_insn(env, s, &f);
+    insn = extract_insn(env, s, &s->fields);
 
     /* Set up the strutures we use to communicate with the helpers. */
     s->insn = insn;
-    s->fields = &f;
 
     /* Emit insn_start now that we know the ILEN.  */
     tcg_gen_insn_start(s->base.pc_next, s->cc_op, s->ilen);
@@ -6315,7 +6313,7 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
     /* Not found means unimplemented/illegal opcode.  */
     if (insn == NULL) {
         qemu_log_mask(LOG_UNIMP, "unimplemented opcode 0x%02x%02x\n",
-                      f.op, f.op2);
+                      s->fields.op, s->fields.op2);
         gen_illegal_opcode(s);
         return DISAS_NORETURN;
     }
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index e1a2d25c2f..24558cce80 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -732,7 +732,7 @@ static DisasJumpType op_vmr(DisasContext *s, DisasOps *o)
     }
 
     tmp = tcg_temp_new_i64();
-    if (s->fields->op2 == 0x61) {
+    if (s->fields.op2 == 0x61) {
         /* iterate backwards to avoid overwriting data we might need later */
         for (dst_idx = NUM_VEC_ELEMENTS(es) - 1; dst_idx >= 0; dst_idx--) {
             src_idx = dst_idx / 2;
@@ -796,7 +796,7 @@ static DisasJumpType op_vpk(DisasContext *s, DisasOps *o)
         return DISAS_NORETURN;
     }
 
-    switch (s->fields->op2) {
+    switch (s->fields.op2) {
     case 0x97:
         if (get_field(s, m5) & 0x1) {
             gen_gvec_3_ptr(v1, v2, v3, cpu_env, 0, vpks_cc[es - 1]);
@@ -1038,7 +1038,7 @@ static DisasJumpType op_vstl(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_vup(DisasContext *s, DisasOps *o)
 {
-    const bool logical = s->fields->op2 == 0xd4 || s->fields->op2 == 0xd5;
+    const bool logical = s->fields.op2 == 0xd4 || s->fields.op2 == 0xd5;
     const uint8_t v1 = get_field(s, v1);
     const uint8_t v2 = get_field(s, v2);
     const uint8_t src_es = get_field(s, m3);
@@ -1052,7 +1052,7 @@ static DisasJumpType op_vup(DisasContext *s, DisasOps *o)
     }
 
     tmp = tcg_temp_new_i64();
-    if (s->fields->op2 == 0xd7 || s->fields->op2 == 0xd5) {
+    if (s->fields.op2 == 0xd7 || s->fields.op2 == 0xd5) {
         /* iterate backwards to avoid overwriting data we might need later */
         for (dst_idx = NUM_VEC_ELEMENTS(dst_es) - 1; dst_idx >= 0; dst_idx--) {
             src_idx = dst_idx;
@@ -1389,7 +1389,7 @@ static DisasJumpType op_vec(DisasContext *s, DisasOps *o)
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
-    if (s->fields->op2 == 0xdb) {
+    if (s->fields.op2 == 0xdb) {
         es |= MO_SIGN;
     }
 
@@ -1567,7 +1567,7 @@ static DisasJumpType op_vmx(DisasContext *s, DisasOps *o)
         return DISAS_NORETURN;
     }
 
-    switch (s->fields->op2) {
+    switch (s->fields.op2) {
     case 0xff:
         gen_gvec_fn_3(smax, es, v1, v2, v3);
         break;
@@ -1677,7 +1677,7 @@ static DisasJumpType op_vma(DisasContext *s, DisasOps *o)
         return DISAS_NORETURN;
     }
 
-    switch (s->fields->op2) {
+    switch (s->fields.op2) {
     case 0xaa:
         fn = &g_vmal[es];
         break;
@@ -1764,7 +1764,7 @@ static DisasJumpType op_vm(DisasContext *s, DisasOps *o)
         return DISAS_NORETURN;
     }
 
-    switch (s->fields->op2) {
+    switch (s->fields.op2) {
     case 0xa2:
         gen_gvec_fn_3(mul, es, get_field(s, v1),
                       get_field(s, v2), get_field(s, v3));
@@ -1967,7 +1967,7 @@ static DisasJumpType op_vesv(DisasContext *s, DisasOps *o)
         return DISAS_NORETURN;
     }
 
-    switch (s->fields->op2) {
+    switch (s->fields.op2) {
     case 0x70:
         gen_gvec_fn_3(shlv, es, v1, v2, v3);
         break;
@@ -1998,7 +1998,7 @@ static DisasJumpType op_ves(DisasContext *s, DisasOps *o)
     }
 
     if (likely(!get_field(s, b2))) {
-        switch (s->fields->op2) {
+        switch (s->fields.op2) {
         case 0x30:
             gen_gvec_fn_2i(shli, es, v1, v3, d2);
             break;
@@ -2015,7 +2015,7 @@ static DisasJumpType op_ves(DisasContext *s, DisasOps *o)
         shift = tcg_temp_new_i32();
         tcg_gen_extrl_i64_i32(shift, o->addr1);
         tcg_gen_andi_i32(shift, shift, NUM_VEC_ELEMENT_BITS(es) - 1);
-        switch (s->fields->op2) {
+        switch (s->fields.op2) {
         case 0x30:
             gen_gvec_fn_2s(shls, es, v1, v3, shift);
             break;
@@ -2038,7 +2038,7 @@ static DisasJumpType op_vsl(DisasContext *s, DisasOps *o)
     TCGv_i64 shift = tcg_temp_new_i64();
 
     read_vec_element_i64(shift, get_field(s, v3), 7, ES_8);
-    if (s->fields->op2 == 0x74) {
+    if (s->fields.op2 == 0x74) {
         tcg_gen_andi_i64(shift, shift, 0x7);
     } else {
         tcg_gen_andi_i64(shift, shift, 0x78);
@@ -2084,7 +2084,7 @@ static DisasJumpType op_vsra(DisasContext *s, DisasOps *o)
     TCGv_i64 shift = tcg_temp_new_i64();
 
     read_vec_element_i64(shift, get_field(s, v3), 7, ES_8);
-    if (s->fields->op2 == 0x7e) {
+    if (s->fields.op2 == 0x7e) {
         tcg_gen_andi_i64(shift, shift, 0x7);
     } else {
         tcg_gen_andi_i64(shift, shift, 0x78);
@@ -2101,7 +2101,7 @@ static DisasJumpType op_vsrl(DisasContext *s, DisasOps *o)
     TCGv_i64 shift = tcg_temp_new_i64();
 
     read_vec_element_i64(shift, get_field(s, v3), 7, ES_8);
-    if (s->fields->op2 == 0x7c) {
+    if (s->fields.op2 == 0x7c) {
         tcg_gen_andi_i64(shift, shift, 0x7);
     } else {
         tcg_gen_andi_i64(shift, shift, 0x78);
@@ -2524,7 +2524,7 @@ static DisasJumpType op_vfa(DisasContext *s, DisasOps *o)
         return DISAS_NORETURN;
     }
 
-    switch (s->fields->op2) {
+    switch (s->fields.op2) {
     case 0xe3:
         fn = se ? gen_helper_gvec_vfa64s : gen_helper_gvec_vfa64;
         break;
@@ -2555,7 +2555,7 @@ static DisasJumpType op_wfc(DisasContext *s, DisasOps *o)
         return DISAS_NORETURN;
     }
 
-    if (s->fields->op2 == 0xcb) {
+    if (s->fields.op2 == 0xcb) {
         gen_gvec_2_ptr(get_field(s, v1), get_field(s, v2),
                        cpu_env, 0, gen_helper_gvec_wfc64);
     } else {
@@ -2581,7 +2581,7 @@ static DisasJumpType op_vfc(DisasContext *s, DisasOps *o)
     }
 
     if (cs) {
-        switch (s->fields->op2) {
+        switch (s->fields.op2) {
         case 0xe8:
             fn = se ? gen_helper_gvec_vfce64s_cc : gen_helper_gvec_vfce64_cc;
             break;
@@ -2595,7 +2595,7 @@ static DisasJumpType op_vfc(DisasContext *s, DisasOps *o)
             g_assert_not_reached();
         }
     } else {
-        switch (s->fields->op2) {
+        switch (s->fields.op2) {
         case 0xe8:
             fn = se ? gen_helper_gvec_vfce64s : gen_helper_gvec_vfce64;
             break;
@@ -2630,7 +2630,7 @@ static DisasJumpType op_vcdg(DisasContext *s, DisasOps *o)
         return DISAS_NORETURN;
     }
 
-    switch (s->fields->op2) {
+    switch (s->fields.op2) {
     case 0xc3:
         fn = se ? gen_helper_gvec_vcdg64s : gen_helper_gvec_vcdg64;
         break;
@@ -2688,7 +2688,7 @@ static DisasJumpType op_vfma(DisasContext *s, DisasOps *o)
         return DISAS_NORETURN;
     }
 
-    if (s->fields->op2 == 0x8f) {
+    if (s->fields.op2 == 0x8f) {
         fn = se ? gen_helper_gvec_vfma64s : gen_helper_gvec_vfma64;
     } else {
         fn = se ? gen_helper_gvec_vfms64s : gen_helper_gvec_vfms64;
-- 
2.20.1


