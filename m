Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D792C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:43:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ABDF206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPVQ3miu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABDF206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtImx-0004gV-Aa
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtIS3-0002fK-BB
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:22:03 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:55961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtIS1-00017g-LP
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:22:02 -0400
Received: by mail-pj1-x1042.google.com with SMTP id ch3so174621pjb.5
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 15:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nZ5afr8ytfOjn2RptCucwZK6dg7U6HVvYySJ5JOYCZ4=;
 b=lPVQ3miuHsps3VvuCAQL4s7j7sKvnoFZKV3BlPxQoB77ZQFKGE6wzjIx4pomzyfhNO
 n3StPjOmmSj+JXYIObOTLrRWBDpf1i4z+jXKoYrhhiLLLGr9xqjBU86gmUV6N5UEa0rt
 T9pD/bKv4Fpiloq7tGyVRZreOBZjdzWj5ydDqrP1e82UESo7fEkZz0C63fe8wfou37xQ
 /NXPHNP4E6K0ebYiL2sKigaAXzmw5/PvJRaFD1CGtHet7tTpKuWYSJSRe3FbgUE40Tsx
 QwtPsVtQEse/Pz2cZ5r0816Yy2lEGOlbFRE8xhbEMOK9SO4qRNGcAIBvZIEBSQ9SAR+c
 Rk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nZ5afr8ytfOjn2RptCucwZK6dg7U6HVvYySJ5JOYCZ4=;
 b=jD6Sj0x1M6Qxb7t75h2DMxyW8iOdKNChixIfnhsCc4UytlhFBG05KGQ1haK9YS/Vrr
 gXM4olGr69zB54WMG0qhBJvyjTG6eNo9W5/442JllpgoVQddM4egUBu+0OnaN2hwSqAZ
 qizAnM5qHslA8MwN9QIU02gPsPy5VTqrwJSPcwW5FBNEqnfPam1KGbowvEDO5J+g+ExE
 mlrdiQIUaJIiSJRFMy5nU7zkKHSFPVXITEm6baCy8K/7n51OP/bu7NCdDCl78pfzsko0
 WcIbGJK5r2oxOZQn0Hh4/hHz8lBeLW4KL31kdnMsshzPpD4TvQ3ouVmDCuGC37YkfL/n
 gHpg==
X-Gm-Message-State: AOAM533FhID8ZI2Qa3zTo/9YSBr8DqOOf1Sr3ifsD7nkhjN42l83s1q+
 Dfj3tSk6xdrq5D0IUPyDXwG8mDZ3
X-Google-Smtp-Source: ABdhPJwabbYM7KfpMAsra3la81wGYZyqPl+oiiOWPQXL6FbZKA0xJEnUk/ByjeXE92MJVXUBo7ggHA==
X-Received: by 2002:a17:90b:120a:: with SMTP id
 gl10mr11140096pjb.44.1594246920294; 
 Wed, 08 Jul 2020 15:22:00 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id t73sm693517pfc.78.2020.07.08.15.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 15:21:59 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/21] target/xtensa: don't access BR regfile directly
Date: Wed,  8 Jul 2020 15:20:48 -0700
Message-Id: <20200708222101.24568-9-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200708222101.24568-1-jcmvbkbc@gmail.com>
References: <20200708222101.24568-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

BR registers used in FPU comparison opcodes are available as opcode
arguments for translators. Use them. This simplifies comparison helpers
interface and makes them usable in FLIX bundles.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


