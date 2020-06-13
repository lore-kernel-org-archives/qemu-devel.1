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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DC5C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 15:27:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A479B2078A
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 15:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgBukdfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A479B2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jk847-00014H-Up
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 11:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jk7yv-00017g-Go
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 11:22:05 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53967)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jk7yt-0002kj-Oy
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 11:22:05 -0400
Received: by mail-wm1-x341.google.com with SMTP id l26so10507213wme.3
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2020 08:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w300LlCtFwSijdS00tFHCv/tm4JEQ5Js/KiT5pQAUWg=;
 b=ZgBukdfP20tVe9bYdnLK5DpdEaGBPTpydY/qf0BGQQA/2ZDCUh46VujzEAZ0VY/bLz
 jcf4fIcih89fhsWv/eEaOOwVXBo/XIc0xNaW2SKrVA70rZkiaDgg3gY5zyCHElEd/Hwe
 PpV/GQdwW6/wI5B16mAVObp1MGiVZRSPBcs0sBiuKLDShPybT9cn9iNnh70bdtUbLgqL
 vxRmLD5ZxdYhvIS3H0qos+y+PbBl3FNZNDAXvk+phQ7VeDPLeBRGNxvNawQHPSaANZiu
 C6LWLauq5M0qISqsORMb9MEltGi865p/gX3hqwaJfMZowNEXDNIiCs6zxxC/L0VPHXon
 6UAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w300LlCtFwSijdS00tFHCv/tm4JEQ5Js/KiT5pQAUWg=;
 b=uQd1BIA7aIwqFqQxf0CGJX6TyHnzQirDzcnQHGiAFObfunfIa5z+9Av7LI5aDI2zOc
 DKWuDjw9ndOkxc2bdlR/JkQW4cv1OfGRbb494jIJBqYN9AYOo8+TEKWHRIKOPN2DjJBT
 kmCaajwEJ4HxSB8F70y4uD+siJbs4Zik/2YX6+K6fNXv97eUCiomkWf3Zo1bJTA+Hh4D
 6ciVYshY/Xe/Ucz423D/CRwIC89qDbSNrYcFLlf75y7cbMt2z/ZvXkDS7Q5GxAbc0n5n
 C+bZkiH2bN5vAKz+7zi1q2n9uMpoV5Yv8plA3eJeLa7ryNwQ9GEHgY2Rccfrt6O7UcjN
 K+5g==
X-Gm-Message-State: AOAM533xSLDo7DtZAw5yU740D2FxGhltnSVL97xX4UxIK4Lbq994y6Jh
 5yWVLCuxjZ6/EDsjje84euz/reetsM4=
X-Google-Smtp-Source: ABdhPJxbS32T5LTBzniSH+Kn1NyPacwnaIl7DgFPpxY3FLjK2YNCV5yPvA5yYICoXUp05Y1bOHmWgQ==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr4390208wmb.61.1592061715799; 
 Sat, 13 Jun 2020 08:21:55 -0700 (PDT)
Received: from localhost.localdomain (net212-32-245-109.mbb.telenor.rs.
 [109.245.32.212])
 by smtp.gmail.com with ESMTPSA id 67sm16045399wrk.49.2020.06.13.08.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2020 08:21:55 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 06/14] target/mips: msa: Split helpers for DPSUB_U.<H|W|D>
Date: Sat, 13 Jun 2020 17:21:25 +0200
Message-Id: <20200613152133.8964-7-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200613152133.8964-1-aleksandar.qemu.devel@gmail.com>
References: <20200613152133.8964-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x341.google.com
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


