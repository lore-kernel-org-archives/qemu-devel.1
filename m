Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E33C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D26320672
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rP3PH5pn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D26320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsavt-0004av-Br
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 19:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jsaq9-00010e-SO
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 19:48:01 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jsaq8-0000tw-4Q
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 19:48:01 -0400
Received: by mail-pg1-x542.google.com with SMTP id p3so19120209pgh.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 16:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w4M2hm6SX88vAmypNF1BsgknJj1VWHgn1OPZgKWy19o=;
 b=rP3PH5pn3cHoWiTiVWYVO+/ONDyUnV5NjDkJ0vWu5zjzfsvMdOJ8NvQZwxQg1XzZb4
 1iTcy/pPEIHKrfeswMOU5zNZOdL/lH+TIu1QiEZjRQ+pWxaH+CSVwlEEp5lGbzZWNMdP
 faP08pJIB8O3FHQNdRRTF/h+Y0eqoLRJ1m0SKw/pzueMjyTNfOVc+dc6ykbJPtt8sQEh
 WJ6qlO4Bt+0ix8dOLuTE+s0hCGwnwB8a3pPZH1uIyqRRZRkcAq7hu69aelrx5DMgTEcd
 mLtfjLfId0zVi2gVvPxifXuXDQdCl95a0BkW0MFIlVT+l/p0xk0RbrqvnWcI9BjohjZT
 9Bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w4M2hm6SX88vAmypNF1BsgknJj1VWHgn1OPZgKWy19o=;
 b=ZUcTHSt3o1ptSVp4YCa5mu0Rml3rxgQ3rUDj+xF0Dx+sXREUP8oO0+5d3r4iw6ok9r
 b1kgYjW9KpQJR/w7DvW4yaOlVTZ9a5mBeSQ2osCXcasTfhQvo+1X5PhelkjjSp7ky5cC
 nM0AkG6gWg9f4dh0ammzZJ4FiFWn0WAGytBAVr4cpTxYbe3poFjRpAuw6VDoVN/yvZiX
 gHftMWJytVDIwbeVKi0Ly8V3ckvht4vVLIPzZ9MSyZPyV79iZj4KeRk6M6fRcggnv3lV
 iGov5wqaVu1sRcCiddbJdsJ1vYqW4bv2XCye2qXZ4xWx8AfvXMsC86YZLzxcVYbs+qDm
 sg4w==
X-Gm-Message-State: AOAM530qwzwhAuxq/GBB39dH/HOvF/Nlm9TTuJD1hdSweqNUOnIFNajb
 /QzkXSiGgdrhOYME0sgiyqbHul0y
X-Google-Smtp-Source: ABdhPJyF6GSH7/awMhty4aPXkrw9O9RlPN9Dl3tYQM4KCv1/JUkzQ46fVcLdG8Fy135BmHoPOq9F+g==
X-Received: by 2002:a63:20d:: with SMTP id 13mr42640123pgc.166.1594079278773; 
 Mon, 06 Jul 2020 16:47:58 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id e15sm19647649pgt.17.2020.07.06.16.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 16:47:58 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/21] target/xtensa: don't access BR regfile directly
Date: Mon,  6 Jul 2020 16:47:24 -0700
Message-Id: <20200706234737.32378-9-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200706234737.32378-1-jcmvbkbc@gmail.com>
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

BR registers used in FPU comparison opcodes are available as opcode
arguments for translators. Use them. This simplifies comparison helpers
interface and makes them usable in FLIX bundles.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/fpu_helper.c | 42 +++++++++++++++++---------------------
 target/xtensa/helper.h     | 14 ++++++-------
 target/xtensa/translate.c  | 20 ++++++++++++++----
 3 files changed, 42 insertions(+), 34 deletions(-)

diff --git a/target/xtensa/fpu_helper.c b/target/xtensa/fpu_helper.c
index 57a284924045..fae6836d3223 100644
--- a/target/xtensa/fpu_helper.c
+++ b/target/xtensa/fpu_helper.c
@@ -118,49 +118,45 @@ float32 HELPER(uitof_s)(CPUXtensaState *env, uint32_t v, uint32_t scale)
                           (int32_t)scale, &env->fp_status);
 }
 
-static inline void set_br(CPUXtensaState *env, bool v, uint32_t br)
+uint32_t HELPER(un_s)(CPUXtensaState *env, float32 a, float32 b)
 {
-    if (v) {
-        env->sregs[BR] |= br;
-    } else {
-        env->sregs[BR] &= ~br;
-    }
-}
-
-void HELPER(un_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
-{
-    set_br(env, float32_unordered_quiet(a, b, &env->fp_status), br);
+    return float32_unordered_quiet(a, b, &env->fp_status);
 }
 
-void HELPER(oeq_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
+uint32_t HELPER(oeq_s)(CPUXtensaState *env, float32 a, float32 b)
 {
-    set_br(env, float32_eq_quiet(a, b, &env->fp_status), br);
+    return float32_eq_quiet(a, b, &env->fp_status);
 }
 
-void HELPER(ueq_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
+uint32_t HELPER(ueq_s)(CPUXtensaState *env, float32 a, float32 b)
 {
     FloatRelation v = float32_compare_quiet(a, b, &env->fp_status);
-    set_br(env, v == float_relation_equal || v == float_relation_unordered, br);
+
+    return v == float_relation_equal ||
+           v == float_relation_unordered;
 }
 
-void HELPER(olt_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
+uint32_t HELPER(olt_s)(CPUXtensaState *env, float32 a, float32 b)
 {
-    set_br(env, float32_lt_quiet(a, b, &env->fp_status), br);
+    return float32_lt_quiet(a, b, &env->fp_status);
 }
 
-void HELPER(ult_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
+uint32_t HELPER(ult_s)(CPUXtensaState *env, float32 a, float32 b)
 {
     FloatRelation v = float32_compare_quiet(a, b, &env->fp_status);
-    set_br(env, v == float_relation_less || v == float_relation_unordered, br);
+
+    return v == float_relation_less ||
+           v == float_relation_unordered;
 }
 
-void HELPER(ole_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
+uint32_t HELPER(ole_s)(CPUXtensaState *env, float32 a, float32 b)
 {
-    set_br(env, float32_le_quiet(a, b, &env->fp_status), br);
+    return float32_le_quiet(a, b, &env->fp_status);
 }
 
-void HELPER(ule_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
+uint32_t HELPER(ule_s)(CPUXtensaState *env, float32 a, float32 b)
 {
     FloatRelation v = float32_compare_quiet(a, b, &env->fp_status);
-    set_br(env, v != float_relation_greater, br);
+
+    return v != float_relation_greater;
 }
diff --git a/target/xtensa/helper.h b/target/xtensa/helper.h
index a692254fe10a..bbada1c0b864 100644
--- a/target/xtensa/helper.h
+++ b/target/xtensa/helper.h
@@ -59,13 +59,13 @@ DEF_HELPER_FLAGS_3(ftoui_s, TCG_CALL_NO_RWG_SE, i32, f32, i32, i32)
 DEF_HELPER_3(itof_s, f32, env, i32, i32)
 DEF_HELPER_3(uitof_s, f32, env, i32, i32)
 
-DEF_HELPER_4(un_s, void, env, i32, f32, f32)
-DEF_HELPER_4(oeq_s, void, env, i32, f32, f32)
-DEF_HELPER_4(ueq_s, void, env, i32, f32, f32)
-DEF_HELPER_4(olt_s, void, env, i32, f32, f32)
-DEF_HELPER_4(ult_s, void, env, i32, f32, f32)
-DEF_HELPER_4(ole_s, void, env, i32, f32, f32)
-DEF_HELPER_4(ule_s, void, env, i32, f32, f32)
+DEF_HELPER_3(un_s,  i32, env, f32, f32)
+DEF_HELPER_3(oeq_s, i32, env, f32, f32)
+DEF_HELPER_3(ueq_s, i32, env, f32, f32)
+DEF_HELPER_3(olt_s, i32, env, f32, f32)
+DEF_HELPER_3(ult_s, i32, env, f32, f32)
+DEF_HELPER_3(ole_s, i32, env, f32, f32)
+DEF_HELPER_3(ule_s, i32, env, f32, f32)
 
 DEF_HELPER_2(rer, i32, env, i32)
 DEF_HELPER_3(wer, void, env, i32, i32)
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index f859cd3f0818..85bd63dffc9f 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -6319,7 +6319,7 @@ enum {
 static void translate_compare_s(DisasContext *dc, const OpcodeArg arg[],
                                 const uint32_t par[])
 {
-    static void (* const helper[])(TCGv_env env, TCGv_i32 bit,
+    static void (* const helper[])(TCGv_i32 res, TCGv_env env,
                                    TCGv_i32 s, TCGv_i32 t) = {
         [COMPARE_UN] = gen_helper_un_s,
         [COMPARE_OEQ] = gen_helper_oeq_s,
@@ -6329,10 +6329,22 @@ static void translate_compare_s(DisasContext *dc, const OpcodeArg arg[],
         [COMPARE_OLE] = gen_helper_ole_s,
         [COMPARE_ULE] = gen_helper_ule_s,
     };
-    TCGv_i32 bit = tcg_const_i32(1 << arg[0].imm);
+    TCGv_i32 zero = tcg_const_i32(0);
+    TCGv_i32 res = tcg_temp_new_i32();
+    TCGv_i32 set_br = tcg_temp_new_i32();
+    TCGv_i32 clr_br = tcg_temp_new_i32();
 
-    helper[par[0]](cpu_env, bit, arg[1].in, arg[2].in);
-    tcg_temp_free(bit);
+    tcg_gen_ori_i32(set_br, arg[0].in, 1 << arg[0].imm);
+    tcg_gen_andi_i32(clr_br, arg[0].in, ~(1 << arg[0].imm));
+
+    helper[par[0]](res, cpu_env, arg[1].in, arg[2].in);
+    tcg_gen_movcond_i32(TCG_COND_NE,
+                        arg[0].out, res, zero,
+                        set_br, clr_br);
+    tcg_temp_free(zero);
+    tcg_temp_free(res);
+    tcg_temp_free(set_br);
+    tcg_temp_free(clr_br);
 }
 
 static void translate_float_s(DisasContext *dc, const OpcodeArg arg[],
-- 
2.20.1


