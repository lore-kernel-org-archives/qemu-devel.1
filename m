Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33B6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:40:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95CBE20714
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pETC4hta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95CBE20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkuyH-0007xH-QB
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 15:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkunI-0003rX-LF
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:29:20 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:53837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkunE-0004lN-Kn
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:29:20 -0400
Received: by mail-wm1-x330.google.com with SMTP id l26so685535wme.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 12:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sO9x+bHLkdx0btvbwsMdriZmCPg7AHoA9rMG8PY8+c8=;
 b=pETC4htaTmHRXj0MQ1BL1VD0MS1FpjeNc0BtIXemYKxm5NfwPtorPS6t1Gr+4CPxGE
 ieaNBQQvUsImWLaPfshZGGDPVHPs/EXt+bnUfrvctw/R0zLf0WYPZBmRPNogX+jW/nOm
 43Pv4kZP+Xlb0Z3Q7EkjYrotGwytsORKTWQm6BQh7SZz0qP0yF2KANbMIWDbIiPAxRsb
 7PkPc3J4YGtIntwQ2RowMLLai6Uc2w3KFoUDYboiKpJZnjDKVPJUDYXeRUupUM0xQ6ye
 4mrFS0CWh7sXIqbJBy4ecr8TSMstkPDGaIuzqYtLztz0HzR87tYXY5wDptOlPuooN/8/
 ExAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sO9x+bHLkdx0btvbwsMdriZmCPg7AHoA9rMG8PY8+c8=;
 b=W3eSHG0PHOgJCiSIvLe8kDmHPCz3QVZTfw8wZp4JJ26Vysjs0CEGtqlfJzIPMsG9Fg
 VwKjk9AZueQ/UQ8lmBpn8J6P++rOuM6SnGmnGfxvqpf1Qim/onexIndc9ej4Ndy65HLA
 W9fE2eTpxY6f3/KUCtC6ZdvQmQ5+XUm8ebNC198C9mQSbcc5jhwy+y55ePd9p7d+8HWr
 RTPkGQCU6Vshzq2ZxtLvRbzVSv2qBfIaxXNuPJWzR3pfHfXyrTGj/MjxQgTGIAznpIBX
 B0xvD2jwwQxRKB0pRrddW7HOEAsnHk3sMagbTk4UvKXGbAb1N5hlq3uuckPtaR49wrvj
 Gmhw==
X-Gm-Message-State: AOAM531csLtVfNClgT1kAJIQKK/lMgYaGwuKskedoUQXF0rxgwcwwk/4
 ZlnP5Sf7D56YZbqJw42GxYL+v6xj
X-Google-Smtp-Source: ABdhPJzJuM4uYs3iMPlTg38HUUcty1uWAczBs80Ux80/1W1CDx5Eo3NALeZ+o865TDmsHZyXoBvXmA==
X-Received: by 2002:a1c:154:: with SMTP id 81mr838053wmb.23.1592249354810;
 Mon, 15 Jun 2020 12:29:14 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id 138sm713098wma.23.2020.06.15.12.29.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jun 2020 12:29:14 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 16/18] target/mips: msa: Split helpers for MULV.<B|H|W|D>
Date: Mon, 15 Jun 2020 21:28:58 +0200
Message-Id: <1592249340-8365-17-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592249340-8365-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1592249340-8365-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x330.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Achieves clearer code and slightly better performance.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <20200613152133.8964-15-aleksandar.qemu.devel@gmail.com>
---
 target/mips/helper.h     |  6 +++-
 target/mips/msa_helper.c | 79 +++++++++++++++++++++++++++++++++++++++++++-----
 target/mips/translate.c  | 15 ++++++++-
 3 files changed, 91 insertions(+), 9 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 5d7ba6a..e97655d 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -960,6 +960,11 @@ DEF_HELPER_4(msa_msubv_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_msubv_w, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_msubv_d, void, env, i32, i32, i32)
 
+DEF_HELPER_4(msa_mulv_b, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_mulv_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_mulv_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_mulv_d, void, env, i32, i32, i32)
+
 DEF_HELPER_4(msa_asub_s_b, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_asub_s_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_asub_s_w, void, env, i32, i32, i32)
@@ -1098,7 +1103,6 @@ DEF_HELPER_5(msa_srlri_df, void, env, i32, i32, i32, i32)
 
 DEF_HELPER_5(msa_binsl_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_binsr_df, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(msa_mulv_df, void, env, i32, i32, i32, i32)
 
 DEF_HELPER_4(msa_dotp_s_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_dotp_s_w, void, env, i32, i32, i32)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index d099e00..6865add 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -3360,6 +3360,78 @@ void helper_msa_msubv_d(CPUMIPSState *env,
 }
 
 
+static inline int64_t msa_mulv_df(uint32_t df, int64_t arg1, int64_t arg2)
+{
+    return arg1 * arg2;
+}
+
+void helper_msa_mulv_b(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->b[0]  = msa_mulv_df(DF_BYTE, pws->b[0],  pwt->b[0]);
+    pwd->b[1]  = msa_mulv_df(DF_BYTE, pws->b[1],  pwt->b[1]);
+    pwd->b[2]  = msa_mulv_df(DF_BYTE, pws->b[2],  pwt->b[2]);
+    pwd->b[3]  = msa_mulv_df(DF_BYTE, pws->b[3],  pwt->b[3]);
+    pwd->b[4]  = msa_mulv_df(DF_BYTE, pws->b[4],  pwt->b[4]);
+    pwd->b[5]  = msa_mulv_df(DF_BYTE, pws->b[5],  pwt->b[5]);
+    pwd->b[6]  = msa_mulv_df(DF_BYTE, pws->b[6],  pwt->b[6]);
+    pwd->b[7]  = msa_mulv_df(DF_BYTE, pws->b[7],  pwt->b[7]);
+    pwd->b[8]  = msa_mulv_df(DF_BYTE, pws->b[8],  pwt->b[8]);
+    pwd->b[9]  = msa_mulv_df(DF_BYTE, pws->b[9],  pwt->b[9]);
+    pwd->b[10] = msa_mulv_df(DF_BYTE, pws->b[10], pwt->b[10]);
+    pwd->b[11] = msa_mulv_df(DF_BYTE, pws->b[11], pwt->b[11]);
+    pwd->b[12] = msa_mulv_df(DF_BYTE, pws->b[12], pwt->b[12]);
+    pwd->b[13] = msa_mulv_df(DF_BYTE, pws->b[13], pwt->b[13]);
+    pwd->b[14] = msa_mulv_df(DF_BYTE, pws->b[14], pwt->b[14]);
+    pwd->b[15] = msa_mulv_df(DF_BYTE, pws->b[15], pwt->b[15]);
+}
+
+void helper_msa_mulv_h(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->h[0]  = msa_mulv_df(DF_HALF, pws->h[0],  pwt->h[0]);
+    pwd->h[1]  = msa_mulv_df(DF_HALF, pws->h[1],  pwt->h[1]);
+    pwd->h[2]  = msa_mulv_df(DF_HALF, pws->h[2],  pwt->h[2]);
+    pwd->h[3]  = msa_mulv_df(DF_HALF, pws->h[3],  pwt->h[3]);
+    pwd->h[4]  = msa_mulv_df(DF_HALF, pws->h[4],  pwt->h[4]);
+    pwd->h[5]  = msa_mulv_df(DF_HALF, pws->h[5],  pwt->h[5]);
+    pwd->h[6]  = msa_mulv_df(DF_HALF, pws->h[6],  pwt->h[6]);
+    pwd->h[7]  = msa_mulv_df(DF_HALF, pws->h[7],  pwt->h[7]);
+}
+
+void helper_msa_mulv_w(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->w[0]  = msa_mulv_df(DF_WORD, pws->w[0],  pwt->w[0]);
+    pwd->w[1]  = msa_mulv_df(DF_WORD, pws->w[1],  pwt->w[1]);
+    pwd->w[2]  = msa_mulv_df(DF_WORD, pws->w[2],  pwt->w[2]);
+    pwd->w[3]  = msa_mulv_df(DF_WORD, pws->w[3],  pwt->w[3]);
+}
+
+void helper_msa_mulv_d(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0]  = msa_mulv_df(DF_DOUBLE, pws->d[0],  pwt->d[0]);
+    pwd->d[1]  = msa_mulv_df(DF_DOUBLE, pws->d[1],  pwt->d[1]);
+}
+
+
 /*
  * Int Subtract
  * ------------
@@ -5444,11 +5516,6 @@ MSA_TEROP_IMMU_DF(binsli, binsl)
 MSA_TEROP_IMMU_DF(binsri, binsr)
 #undef MSA_TEROP_IMMU_DF
 
-static inline int64_t msa_mulv_df(uint32_t df, int64_t arg1, int64_t arg2)
-{
-    return arg1 * arg2;
-}
-
 #define CONCATENATE_AND_SLIDE(s, k)             \
     do {                                        \
         for (i = 0; i < s; i++) {               \
@@ -5566,8 +5633,6 @@ void helper_msa_ ## func ## _df(CPUMIPSState *env, uint32_t df,         \
     }                                                                   \
 }
 
-MSA_BINOP_DF(mulv)
-
 MSA_BINOP_DF(mul_q)
 MSA_BINOP_DF(mulr_q)
 #undef MSA_BINOP_DF
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 9ca17ed..9fad58e 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -29315,7 +29315,20 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case OPC_MULV_df:
-        gen_helper_msa_mulv_df(cpu_env, tdf, twd, tws, twt);
+        switch (df) {
+        case DF_BYTE:
+            gen_helper_msa_mulv_b(cpu_env, twd, tws, twt);
+            break;
+        case DF_HALF:
+            gen_helper_msa_mulv_h(cpu_env, twd, tws, twt);
+            break;
+        case DF_WORD:
+            gen_helper_msa_mulv_w(cpu_env, twd, tws, twt);
+            break;
+        case DF_DOUBLE:
+            gen_helper_msa_mulv_d(cpu_env, twd, tws, twt);
+            break;
+        }
         break;
     case OPC_SLD_df:
         gen_helper_msa_sld_df(cpu_env, tdf, twd, tws, twt);
-- 
2.7.4


