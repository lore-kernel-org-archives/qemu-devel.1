Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCA9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 17:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47C7920836
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 17:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lM7GjjAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C7920836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjn9y-0005W4-K9
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 13:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjn26-0002As-Bx
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 12:59:58 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40015)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjn24-0002gK-Kj
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 12:59:58 -0400
Received: by mail-wr1-x441.google.com with SMTP id h5so10456745wrc.7
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 09:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w300LlCtFwSijdS00tFHCv/tm4JEQ5Js/KiT5pQAUWg=;
 b=lM7GjjAlMLLp5PgqtcQQ7M+2Gps30wBtGYhH8EeeuWjMcowpjN5Kr1t88ck5ndH1gP
 oyGnbNokrzIuEishiarIJgrsLqwJvJIa/daQYL5m/2RTBiOosgEm3beRdjD/VS59d3ht
 qdZfdnXqPI97nTkPeoBdMdDapOtPyL46Plijr/6Bkhu43SgnuYtU8tXrqruyTUd9jVuo
 p8lzgeCTYdkcNrWUKCuoA9Ils51Kj44IiMrm3qHBu1wPQ3NdmCkuKcD89E59PtYG19CI
 j8s/Z0kmhnXtq94RSJGTl/lgjVWvMWA+nSG29S1zlyWgw1CO+pxSQK/Cla50Kge/t4lL
 jeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w300LlCtFwSijdS00tFHCv/tm4JEQ5Js/KiT5pQAUWg=;
 b=ArmaW2rc6gm7+rV33d1m7R+g/9Zeum02ABx6OmjLdAMFn+ROCrBuo5RTSn7VtikBul
 2BclQ5c3L53zCUQrzM5Foh3RvbOlpWPyUdWJFJxA0R+NDwQrTSYUSrgu5eaBDOMVyFYs
 zOB16bAeJ1/xojEIYPICUnPtzjXfWQh3Yjmr700NH/6b7073PcjUpLgj0jxgTdow3L6W
 3y9JfKR+W1PiPRXCelp1Jus5UuL9hB9Cm25P5roKCUP1SGLyTtavAbiWJZ/D/1PMZ0dr
 CweFT8zalU7a+SyboeCI6aEdxYzXU4NcA3s5btP3Wz+7ImgMi0LkJ3K6y8CSH/qWSOO1
 SdXQ==
X-Gm-Message-State: AOAM530zA4Ujf9XK+I5Pi8V1Mk30xbOBILHPLuMZA8alQ8LRlw/4ulag
 7gX/0eThg3D6dGJfdZMTe+OgfFDYa+I=
X-Google-Smtp-Source: ABdhPJy0O56mDYOwSZsXPXLpjEjuxLSYYX2nxPBnRgEwdkfLSDf4WdrZUJaMiTAqyn/LjTbqarPjaw==
X-Received: by 2002:adf:d0d0:: with SMTP id z16mr16346761wrh.308.1591981189126; 
 Fri, 12 Jun 2020 09:59:49 -0700 (PDT)
Received: from localhost.localdomain (net212-32-245-109.mbb.telenor.rs.
 [109.245.32.212])
 by smtp.gmail.com with ESMTPSA id f185sm9923653wmf.43.2020.06.12.09.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 09:59:48 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 6/8] target/mips: msa: Split helpers for DPSUB_U.<H|W|D>
Date: Fri, 12 Jun 2020 18:59:05 +0200
Message-Id: <20200612165907.1272-7-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200612165907.1272-1-aleksandar.qemu.devel@gmail.com>
References: <20200612165907.1272-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x441.google.com
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
 target/mips/helper.h     |  4 ++-
 target/mips/msa_helper.c | 67 ++++++++++++++++++++++++++++++++--------
 target/mips/translate.c  | 12 ++++++-
 3 files changed, 68 insertions(+), 15 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 2de14542cd..575f4a524c 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -1090,7 +1090,9 @@ DEF_HELPER_4(msa_dpadd_u_d, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_dpsub_s_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_dpsub_s_w, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_dpsub_s_d, void, env, i32, i32, i32)
-DEF_HELPER_5(msa_dpsub_u_df, void, env, i32, i32, i32, i32)
+DEF_HELPER_4(msa_dpsub_u_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_dpsub_u_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_dpsub_u_d, void, env, i32, i32, i32)
 DEF_HELPER_5(msa_sld_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_splat_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_vshf_df, void, env, i32, i32, i32, i32)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 934f705c1e..33d5251a6b 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -2398,6 +2398,60 @@ void helper_msa_dpsub_s_d(CPUMIPSState *env,
 }
 
 
+static inline int64_t msa_dpsub_u_df(uint32_t df, int64_t dest, int64_t arg1,
+                                     int64_t arg2)
+{
+    int64_t even_arg1;
+    int64_t even_arg2;
+    int64_t odd_arg1;
+    int64_t odd_arg2;
+    UNSIGNED_EXTRACT(even_arg1, odd_arg1, arg1, df);
+    UNSIGNED_EXTRACT(even_arg2, odd_arg2, arg2, df);
+    return dest - ((even_arg1 * even_arg2) + (odd_arg1 * odd_arg2));
+}
+
+void helper_msa_dpsub_u_h(CPUMIPSState *env,
+                          uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->h[0]  = msa_dpsub_u_df(DF_HALF, pwd->h[0],  pws->h[0],  pwt->h[0]);
+    pwd->h[1]  = msa_dpsub_u_df(DF_HALF, pwd->h[1],  pws->h[1],  pwt->h[1]);
+    pwd->h[2]  = msa_dpsub_u_df(DF_HALF, pwd->h[2],  pws->h[2],  pwt->h[2]);
+    pwd->h[3]  = msa_dpsub_u_df(DF_HALF, pwd->h[3],  pws->h[3],  pwt->h[3]);
+    pwd->h[4]  = msa_dpsub_u_df(DF_HALF, pwd->h[4],  pws->h[4],  pwt->h[4]);
+    pwd->h[5]  = msa_dpsub_u_df(DF_HALF, pwd->h[5],  pws->h[5],  pwt->h[5]);
+    pwd->h[6]  = msa_dpsub_u_df(DF_HALF, pwd->h[6],  pws->h[6],  pwt->h[6]);
+    pwd->h[7]  = msa_dpsub_u_df(DF_HALF, pwd->h[7],  pws->h[7],  pwt->h[7]);
+}
+
+void helper_msa_dpsub_u_w(CPUMIPSState *env,
+                          uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->w[0]  = msa_dpsub_u_df(DF_WORD, pwd->w[0],  pws->w[0],  pwt->w[0]);
+    pwd->w[1]  = msa_dpsub_u_df(DF_WORD, pwd->w[1],  pws->w[1],  pwt->w[1]);
+    pwd->w[2]  = msa_dpsub_u_df(DF_WORD, pwd->w[2],  pws->w[2],  pwt->w[2]);
+    pwd->w[3]  = msa_dpsub_u_df(DF_WORD, pwd->w[3],  pws->w[3],  pwt->w[3]);
+}
+
+void helper_msa_dpsub_u_d(CPUMIPSState *env,
+                          uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0]  = msa_dpsub_u_df(DF_DOUBLE, pwd->d[0],  pws->d[0],  pwt->d[0]);
+    pwd->d[1]  = msa_dpsub_u_df(DF_DOUBLE, pwd->d[1],  pws->d[1],  pwt->d[1]);
+}
+
+
 /*
  * Int Max Min
  * -----------
@@ -5117,18 +5171,6 @@ void helper_msa_sld_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_sld_df(df, pwd, pws, env->active_tc.gpr[rt]);
 }
 
-static inline int64_t msa_dpsub_u_df(uint32_t df, int64_t dest, int64_t arg1,
-                                     int64_t arg2)
-{
-    int64_t even_arg1;
-    int64_t even_arg2;
-    int64_t odd_arg1;
-    int64_t odd_arg2;
-    UNSIGNED_EXTRACT(even_arg1, odd_arg1, arg1, df);
-    UNSIGNED_EXTRACT(even_arg2, odd_arg2, arg2, df);
-    return dest - ((even_arg1 * even_arg2) + (odd_arg1 * odd_arg2));
-}
-
 static inline int64_t msa_madd_q_df(uint32_t df, int64_t dest, int64_t arg1,
                                     int64_t arg2)
 {
@@ -5255,7 +5297,6 @@ void helper_msa_ ## func ## _df(CPUMIPSState *env, uint32_t df, uint32_t wd,  \
     }                                                                         \
 }
 
-MSA_TEROP_DF(dpsub_u)
 MSA_TEROP_DF(binsl)
 MSA_TEROP_DF(binsr)
 MSA_TEROP_DF(madd_q)
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 2576905e5b..3dda242643 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -29438,7 +29438,17 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
             }
             break;
         case OPC_DPSUB_U_df:
-            gen_helper_msa_dpsub_u_df(cpu_env, tdf, twd, tws, twt);
+            switch (df) {
+            case DF_HALF:
+                gen_helper_msa_dpsub_u_h(cpu_env, twd, tws, twt);
+                break;
+            case DF_WORD:
+                gen_helper_msa_dpsub_u_w(cpu_env, twd, tws, twt);
+                break;
+            case DF_DOUBLE:
+                gen_helper_msa_dpsub_u_d(cpu_env, twd, tws, twt);
+                break;
+            }
             break;
         }
         break;
-- 
2.20.1


