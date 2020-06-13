Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FE5C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 15:29:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1DB42078A
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 15:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utcUDzCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DB42078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jk85l-00043E-7f
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 11:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jk7yz-0001Id-Lp
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 11:22:09 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44268)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jk7yx-0002mu-Gz
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 11:22:09 -0400
Received: by mail-wr1-x444.google.com with SMTP id y17so12758203wrn.11
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2020 08:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OQY+EkFsg6wufaeuEyZNFGzcdGKaVFfbL9drxz9j3dA=;
 b=utcUDzCsZ1pokgEYVUXx0bHdmlYLq7kmywvuf7M5HlvUXBniLR1bHL08W3Ss+U/BgW
 x+OmAdYrfTD0Hy08+gniQoxltwD+PmvUBVh2hNRQB97c+EkKP7fQte0+vCRR6q+EjyiN
 RFz8je17OGdGAK4cajKQofZgKFgLHGToZE9BHL4hywTZZEJXQZcnoym7Eg7TPk8dGkIi
 hDjOVC/0VysfMvgNywiX7PapmVx27R856/3YhJnEpOkCPQ5P7xOmD5zxVYtqQqFn5r/P
 srs1qB8qEkhchpK+mrA0KZiMNNzzwd8mYsw9aTfdTX9Z6ONsvOlHrxu3/+CHxz9HG5Ol
 zXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OQY+EkFsg6wufaeuEyZNFGzcdGKaVFfbL9drxz9j3dA=;
 b=gWoU9CCv1DuyO/PJY+u0nzjNbObnufy5OO+EGYADNUtUD3XFm49cuCWd3DqBAa+JKp
 KbEuMPJLMrnxdyXqQfD5yTeAWppDgwoGu3qTuyB4g+E5uttejDFOWxNrKUbfTNVCTDZX
 93wq6Pm54SPT/+LMBb1fax1/1NV+ZjH3OLXRjsOPvlCiaC1xAsX8PKSQpZg9Hilmcc3t
 iEjHVOP1j2gCPvk49pag2BYsCzhu30L8yeX5z5Kppe7dtulzGTyAdJND3JMnq5UQ2+AI
 33ecHk6OBgRJg7eGkxVkbsZGNhZnen37g7g9HE0amOfYAOQqxAV1HGWWQE7pNcnvbr4p
 KrUA==
X-Gm-Message-State: AOAM530QjrXC99H+RPHgNU5Uiruceg1T4GYedtK9Yz5ujzEmBS0CHNxO
 r8PFQzOfM1ZQtyqscxuV7+XghwXX3ac=
X-Google-Smtp-Source: ABdhPJzkzRhb5x5PCl7SQi/RcpqyIZzw2DlQ19fTzSnkV+Xv0OPU39BHwCt9QEuR6FS/4cyRVePS8w==
X-Received: by 2002:adf:fdcc:: with SMTP id i12mr21352493wrs.313.1592061720853; 
 Sat, 13 Jun 2020 08:22:00 -0700 (PDT)
Received: from localhost.localdomain (net212-32-245-109.mbb.telenor.rs.
 [109.245.32.212])
 by smtp.gmail.com with ESMTPSA id 67sm16045399wrk.49.2020.06.13.08.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2020 08:22:00 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 10/14] target/mips: msa: Split helpers for SUBS_U.<B|H|W|D>
Date: Sat, 13 Jun 2020 17:21:29 +0200
Message-Id: <20200613152133.8964-11-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200613152133.8964-1-aleksandar.qemu.devel@gmail.com>
References: <20200613152133.8964-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Achieves clearer code and slightly better performance.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/helper.h     |  6 ++-
 target/mips/msa_helper.c | 82 ++++++++++++++++++++++++++++++++++++----
 target/mips/translate.c  | 15 +++++++-
 3 files changed, 93 insertions(+), 10 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index a93402a2d3..61dc1ed626 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -983,6 +983,11 @@ DEF_HELPER_4(msa_subs_s_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_subs_s_w, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_subs_s_d, void, env, i32, i32, i32)
 
+DEF_HELPER_4(msa_subs_u_b, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_subs_u_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_subs_u_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_subs_u_d, void, env, i32, i32, i32)
+
 DEF_HELPER_4(msa_ilvev_b, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_ilvev_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_ilvev_w, void, env, i32, i32, i32)
@@ -1079,7 +1084,6 @@ DEF_HELPER_5(msa_srlri_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_binsl_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_binsr_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_subv_df, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(msa_subs_u_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_subsus_u_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_subsuu_s_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_mulv_df, void, env, i32, i32, i32, i32)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index f08beba123..bce32abf77 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -3728,6 +3728,80 @@ void helper_msa_subs_s_d(CPUMIPSState *env,
 }
 
 
+static inline int64_t msa_subs_u_df(uint32_t df, int64_t arg1, int64_t arg2)
+{
+    uint64_t u_arg1 = UNSIGNED(arg1, df);
+    uint64_t u_arg2 = UNSIGNED(arg2, df);
+    return (u_arg1 > u_arg2) ? u_arg1 - u_arg2 : 0;
+}
+
+void helper_msa_subs_u_b(CPUMIPSState *env,
+                         uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->b[0]  = msa_subs_u_df(DF_BYTE, pws->b[0],  pwt->b[0]);
+    pwd->b[1]  = msa_subs_u_df(DF_BYTE, pws->b[1],  pwt->b[1]);
+    pwd->b[2]  = msa_subs_u_df(DF_BYTE, pws->b[2],  pwt->b[2]);
+    pwd->b[3]  = msa_subs_u_df(DF_BYTE, pws->b[3],  pwt->b[3]);
+    pwd->b[4]  = msa_subs_u_df(DF_BYTE, pws->b[4],  pwt->b[4]);
+    pwd->b[5]  = msa_subs_u_df(DF_BYTE, pws->b[5],  pwt->b[5]);
+    pwd->b[6]  = msa_subs_u_df(DF_BYTE, pws->b[6],  pwt->b[6]);
+    pwd->b[7]  = msa_subs_u_df(DF_BYTE, pws->b[7],  pwt->b[7]);
+    pwd->b[8]  = msa_subs_u_df(DF_BYTE, pws->b[8],  pwt->b[8]);
+    pwd->b[9]  = msa_subs_u_df(DF_BYTE, pws->b[9],  pwt->b[9]);
+    pwd->b[10] = msa_subs_u_df(DF_BYTE, pws->b[10], pwt->b[10]);
+    pwd->b[11] = msa_subs_u_df(DF_BYTE, pws->b[11], pwt->b[11]);
+    pwd->b[12] = msa_subs_u_df(DF_BYTE, pws->b[12], pwt->b[12]);
+    pwd->b[13] = msa_subs_u_df(DF_BYTE, pws->b[13], pwt->b[13]);
+    pwd->b[14] = msa_subs_u_df(DF_BYTE, pws->b[14], pwt->b[14]);
+    pwd->b[15] = msa_subs_u_df(DF_BYTE, pws->b[15], pwt->b[15]);
+}
+
+void helper_msa_subs_u_h(CPUMIPSState *env,
+                         uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->h[0]  = msa_subs_u_df(DF_HALF, pws->h[0],  pwt->h[0]);
+    pwd->h[1]  = msa_subs_u_df(DF_HALF, pws->h[1],  pwt->h[1]);
+    pwd->h[2]  = msa_subs_u_df(DF_HALF, pws->h[2],  pwt->h[2]);
+    pwd->h[3]  = msa_subs_u_df(DF_HALF, pws->h[3],  pwt->h[3]);
+    pwd->h[4]  = msa_subs_u_df(DF_HALF, pws->h[4],  pwt->h[4]);
+    pwd->h[5]  = msa_subs_u_df(DF_HALF, pws->h[5],  pwt->h[5]);
+    pwd->h[6]  = msa_subs_u_df(DF_HALF, pws->h[6],  pwt->h[6]);
+    pwd->h[7]  = msa_subs_u_df(DF_HALF, pws->h[7],  pwt->h[7]);
+}
+
+void helper_msa_subs_u_w(CPUMIPSState *env,
+                         uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->w[0]  = msa_subs_u_df(DF_WORD, pws->w[0],  pwt->w[0]);
+    pwd->w[1]  = msa_subs_u_df(DF_WORD, pws->w[1],  pwt->w[1]);
+    pwd->w[2]  = msa_subs_u_df(DF_WORD, pws->w[2],  pwt->w[2]);
+    pwd->w[3]  = msa_subs_u_df(DF_WORD, pws->w[3],  pwt->w[3]);
+}
+
+void helper_msa_subs_u_d(CPUMIPSState *env,
+                         uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0]  = msa_subs_u_df(DF_DOUBLE, pws->d[0],  pwt->d[0]);
+    pwd->d[1]  = msa_subs_u_df(DF_DOUBLE, pws->d[1],  pwt->d[1]);
+}
+
+
 /*
  * Interleave
  * ----------
@@ -5138,13 +5212,6 @@ MSA_TEROP_IMMU_DF(binsli, binsl)
 MSA_TEROP_IMMU_DF(binsri, binsr)
 #undef MSA_TEROP_IMMU_DF
 
-static inline int64_t msa_subs_u_df(uint32_t df, int64_t arg1, int64_t arg2)
-{
-    uint64_t u_arg1 = UNSIGNED(arg1, df);
-    uint64_t u_arg2 = UNSIGNED(arg2, df);
-    return (u_arg1 > u_arg2) ? u_arg1 - u_arg2 : 0;
-}
-
 static inline int64_t msa_subsus_u_df(uint32_t df, int64_t arg1, int64_t arg2)
 {
     uint64_t u_arg1 = UNSIGNED(arg1, df);
@@ -5302,7 +5369,6 @@ void helper_msa_ ## func ## _df(CPUMIPSState *env, uint32_t df,         \
 }
 
 MSA_BINOP_DF(subv)
-MSA_BINOP_DF(subs_u)
 MSA_BINOP_DF(subsus_u)
 MSA_BINOP_DF(subsuu_s)
 MSA_BINOP_DF(mulv)
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 7b54d60f70..cdf5e939de 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -29326,7 +29326,20 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
         gen_helper_msa_subv_df(cpu_env, tdf, twd, tws, twt);
         break;
     case OPC_SUBS_U_df:
-        gen_helper_msa_subs_u_df(cpu_env, tdf, twd, tws, twt);
+        switch (df) {
+        case DF_BYTE:
+            gen_helper_msa_subs_u_b(cpu_env, twd, tws, twt);
+            break;
+        case DF_HALF:
+            gen_helper_msa_subs_u_h(cpu_env, twd, tws, twt);
+            break;
+        case DF_WORD:
+            gen_helper_msa_subs_u_w(cpu_env, twd, tws, twt);
+            break;
+        case DF_DOUBLE:
+            gen_helper_msa_subs_u_d(cpu_env, twd, tws, twt);
+            break;
+        }
         break;
     case OPC_SPLAT_df:
         gen_helper_msa_splat_df(cpu_env, tdf, twd, tws, twt);
-- 
2.20.1


