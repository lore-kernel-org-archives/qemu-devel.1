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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B789AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F220207D3
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBYJQXHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F220207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkumN-0001VD-MI
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 15:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkuh5-0006dC-0d
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:22:55 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45207)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkuh2-0003qU-WE
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:22:54 -0400
Received: by mail-wr1-x430.google.com with SMTP id c3so18272969wru.12
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 12:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7HXj1vegb9I+RQsAUyfbJXvupzJ3jlIovDfaa6vKVts=;
 b=VBYJQXHL5mYQPVzKfuR6aYJ746XdIvlezyd4keXiVGdgy0BMym//Be3qmj0iJjjt4P
 PUZjLumsRvKGnZHeluAQyBpaJtfzvK2XgsVm9Xr5nUehAJd9lp+CQlgYbsM4+mX++3op
 GcU7Rr7PjGDdvpbCwrSMOt21aWyzH0TxuQe3PM3dfP0fNhl3IRlNpB4Qq7dJTmBwYGYh
 1niNUC5kvzuuWeocYgOSiu76cm1haujs02QbnYbn9dFrU9AJRgLec9X/+jUfG/8bVIs4
 oidOXeN2nv5sxkT/iLvpcG6w6ISIZCqe0DD/I+FWa7rwkxL9uYsg3kvVI9bsbYWAv7ht
 RwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7HXj1vegb9I+RQsAUyfbJXvupzJ3jlIovDfaa6vKVts=;
 b=L5iEmN838fa5dqC1Qh55ztZn67Engjl3T6UxavzXMnOp6FqC+mkYDxMkzAAIS9wHJv
 I7EAKu2pWl0O3JCiz0jJyUQS9jWHdiLIuloyhxrfrRdljTqebTUQkCmVpxzvGlXaFIB7
 0lGCRX+NjYBHLlu3KTc81P01alLpPCEew8u+V+Oeq2VHupjvzX6D374C5jLUER4FEFi8
 mS5i06VAWhreTeLluSA4hXMGIpXy+Wm+YsHxFj6Tyqjptme02+gciT0q59km2kvMS3dV
 77kJKIqKwZqhpMG0/QEMymoI0Cy/wUmgmYnTkl0S3eLb6yp8+8iWOlq86OEuu7jCQ00/
 Cr8w==
X-Gm-Message-State: AOAM532kwU0lunKMMPQRL6FNhcw/PSl1NSmHvdkS81ankcfNnv5aRmme
 m+Xu6EhRqVmqWsxNDgXXRk5ZQOIE
X-Google-Smtp-Source: ABdhPJzbjEsVrSbtqHoAgHsAe/HjIRaZ212Jcz7E3VBxglIVe6j1UbQO3CSuaQVhRlPBVzs+yW10pQ==
X-Received: by 2002:adf:e744:: with SMTP id c4mr32381292wrn.71.1592248971380; 
 Mon, 15 Jun 2020 12:22:51 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id 50sm27823909wra.1.2020.06.15.12.22.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jun 2020 12:22:51 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 15/18] target/mips: msa: Split helpers for SUBV.<B|H|W|D>
Date: Mon, 15 Jun 2020 21:22:30 +0200
Message-Id: <1592248953-8162-16-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592248953-8162-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1592248953-8162-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x430.google.com
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
Message-Id: <20200613152133.8964-14-aleksandar.qemu.devel@gmail.com>
---
 target/mips/helper.h     |  6 +++-
 target/mips/msa_helper.c | 81 ++++++++++++++++++++++++++++++++++++++++++------
 target/mips/translate.c  | 15 ++++++++-
 3 files changed, 91 insertions(+), 11 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 4795c97..5d7ba6a 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -998,6 +998,11 @@ DEF_HELPER_4(msa_subsuu_s_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_subsuu_s_w, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_subsuu_s_d, void, env, i32, i32, i32)
 
+DEF_HELPER_4(msa_subv_b, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_subv_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_subv_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_subv_d, void, env, i32, i32, i32)
+
 DEF_HELPER_4(msa_ilvev_b, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_ilvev_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_ilvev_w, void, env, i32, i32, i32)
@@ -1093,7 +1098,6 @@ DEF_HELPER_5(msa_srlri_df, void, env, i32, i32, i32, i32)
 
 DEF_HELPER_5(msa_binsl_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_binsr_df, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(msa_subv_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_mulv_df, void, env, i32, i32, i32, i32)
 
 DEF_HELPER_4(msa_dotp_s_h, void, env, i32, i32, i32)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 27a9c36..d099e00 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -3553,9 +3553,6 @@ void helper_msa_asub_u_d(CPUMIPSState *env,
 }
 
 
-/* TODO: insert the rest of Int Subtract group helpers here */
-
-
 static inline int64_t msa_hsub_s_df(uint32_t df, int64_t arg1, int64_t arg2)
 {
     return SIGNED_ODD(arg1, df) - SIGNED_EVEN(arg2, df);
@@ -3970,6 +3967,78 @@ void helper_msa_subsuu_s_d(CPUMIPSState *env,
 }
 
 
+static inline int64_t msa_subv_df(uint32_t df, int64_t arg1, int64_t arg2)
+{
+    return arg1 - arg2;
+}
+
+void helper_msa_subv_b(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->b[0]  = msa_subv_df(DF_BYTE, pws->b[0],  pwt->b[0]);
+    pwd->b[1]  = msa_subv_df(DF_BYTE, pws->b[1],  pwt->b[1]);
+    pwd->b[2]  = msa_subv_df(DF_BYTE, pws->b[2],  pwt->b[2]);
+    pwd->b[3]  = msa_subv_df(DF_BYTE, pws->b[3],  pwt->b[3]);
+    pwd->b[4]  = msa_subv_df(DF_BYTE, pws->b[4],  pwt->b[4]);
+    pwd->b[5]  = msa_subv_df(DF_BYTE, pws->b[5],  pwt->b[5]);
+    pwd->b[6]  = msa_subv_df(DF_BYTE, pws->b[6],  pwt->b[6]);
+    pwd->b[7]  = msa_subv_df(DF_BYTE, pws->b[7],  pwt->b[7]);
+    pwd->b[8]  = msa_subv_df(DF_BYTE, pws->b[8],  pwt->b[8]);
+    pwd->b[9]  = msa_subv_df(DF_BYTE, pws->b[9],  pwt->b[9]);
+    pwd->b[10] = msa_subv_df(DF_BYTE, pws->b[10], pwt->b[10]);
+    pwd->b[11] = msa_subv_df(DF_BYTE, pws->b[11], pwt->b[11]);
+    pwd->b[12] = msa_subv_df(DF_BYTE, pws->b[12], pwt->b[12]);
+    pwd->b[13] = msa_subv_df(DF_BYTE, pws->b[13], pwt->b[13]);
+    pwd->b[14] = msa_subv_df(DF_BYTE, pws->b[14], pwt->b[14]);
+    pwd->b[15] = msa_subv_df(DF_BYTE, pws->b[15], pwt->b[15]);
+}
+
+void helper_msa_subv_h(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->h[0]  = msa_subv_df(DF_HALF, pws->h[0],  pwt->h[0]);
+    pwd->h[1]  = msa_subv_df(DF_HALF, pws->h[1],  pwt->h[1]);
+    pwd->h[2]  = msa_subv_df(DF_HALF, pws->h[2],  pwt->h[2]);
+    pwd->h[3]  = msa_subv_df(DF_HALF, pws->h[3],  pwt->h[3]);
+    pwd->h[4]  = msa_subv_df(DF_HALF, pws->h[4],  pwt->h[4]);
+    pwd->h[5]  = msa_subv_df(DF_HALF, pws->h[5],  pwt->h[5]);
+    pwd->h[6]  = msa_subv_df(DF_HALF, pws->h[6],  pwt->h[6]);
+    pwd->h[7]  = msa_subv_df(DF_HALF, pws->h[7],  pwt->h[7]);
+}
+
+void helper_msa_subv_w(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->w[0]  = msa_subv_df(DF_WORD, pws->w[0],  pwt->w[0]);
+    pwd->w[1]  = msa_subv_df(DF_WORD, pws->w[1],  pwt->w[1]);
+    pwd->w[2]  = msa_subv_df(DF_WORD, pws->w[2],  pwt->w[2]);
+    pwd->w[3]  = msa_subv_df(DF_WORD, pws->w[3],  pwt->w[3]);
+}
+
+void helper_msa_subv_d(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0]  = msa_subv_df(DF_DOUBLE, pws->d[0],  pwt->d[0]);
+    pwd->d[1]  = msa_subv_df(DF_DOUBLE, pws->d[1],  pwt->d[1]);
+}
+
+
 /*
  * Interleave
  * ----------
@@ -5194,11 +5263,6 @@ void helper_msa_shf_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_move_v(pwd, pwx);
 }
 
-static inline int64_t msa_subv_df(uint32_t df, int64_t arg1, int64_t arg2)
-{
-    return arg1 - arg2;
-}
-
 #define MSA_BINOP_IMM_DF(helper, func)                                  \
 void helper_msa_ ## helper ## _df(CPUMIPSState *env, uint32_t df,       \
                         uint32_t wd, uint32_t ws, int32_t u5)           \
@@ -5502,7 +5566,6 @@ void helper_msa_ ## func ## _df(CPUMIPSState *env, uint32_t df,         \
     }                                                                   \
 }
 
-MSA_BINOP_DF(subv)
 MSA_BINOP_DF(mulv)
 
 MSA_BINOP_DF(mul_q)
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 6d9ae1d..9ca17ed 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -29324,7 +29324,20 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
         gen_helper_msa_vshf_df(cpu_env, tdf, twd, tws, twt);
         break;
     case OPC_SUBV_df:
-        gen_helper_msa_subv_df(cpu_env, tdf, twd, tws, twt);
+        switch (df) {
+        case DF_BYTE:
+            gen_helper_msa_subv_b(cpu_env, twd, tws, twt);
+            break;
+        case DF_HALF:
+            gen_helper_msa_subv_h(cpu_env, twd, tws, twt);
+            break;
+        case DF_WORD:
+            gen_helper_msa_subv_w(cpu_env, twd, tws, twt);
+            break;
+        case DF_DOUBLE:
+            gen_helper_msa_subv_d(cpu_env, twd, tws, twt);
+            break;
+        }
         break;
     case OPC_SUBS_U_df:
         switch (df) {
-- 
2.7.4


