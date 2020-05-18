Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B83C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F4020643
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIq3uFur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F4020643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jamMf-0004V0-3d
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 16:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jam63-0006u0-KX
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:10:48 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:43954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jam62-0002Mt-OJ
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:10:47 -0400
Received: by mail-lj1-x242.google.com with SMTP id l19so11258794lje.10
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 13:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tvHv6ieSztT/9Hms9qoXsF7IE1ifhIG84W+vyr/LrZc=;
 b=WIq3uFurIYrsLsmi/oTBwrzCByU9pPjF9KxhWJCwJsPpq3JaSpJPCv/HsnY+paGXtc
 +R2aOr+s58Z7Ati1naupMwPiHCVAxZPQxfUU2xbxCrbuzq/ETWdaBTZtE9dVI6547t3l
 vBrsYI+i6tCGOxHcFunHTikNrHB84RSXcDmlGrmHcTSIaly1MjOOjwHmdRSw0zRP1Kxw
 D3QIxi2v40ZjX0ul3t5bIzh8vBieHFGxdceNdXEyQI00Meqpntt5doIli9m4iEeh1Cih
 5DL67r+SkPHXO5obuR1O4BUiaXhPwDBq7sJ4nqiBFxstk/4vaiMXVWwAVBgq2pBr2m/V
 Iwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tvHv6ieSztT/9Hms9qoXsF7IE1ifhIG84W+vyr/LrZc=;
 b=Wmos4auCpyIkkeEBsaKGsfJKgcZqO+F1CVYhHd9ybnK+FQzm6BYWICS3p9/3whxeDe
 IRUcTJpE+vMkQhpaY7NzV8vJu7JCV3rQVnYR1TnVeKBLVgwQ/OhQVtwOslUxDtS9XDAf
 /YzDhhg5rTPo8hGBw11a2o61gM7ZQTuzjyZYI/GQpmTmsf9CYmb6lDsGYIkd649m1S8v
 5N1JqYf7bw/NuS2W+3kUCnarDG3SJk/1ZZsk/286OwLVnhS5gkKlitFNns6xeoBt/jsZ
 XjIiDzjnCzByj69l4oqhoeFBqMFzbCN3xjJ5rzAxhceUulv25n1dx8ZOjfQRNNewdwY/
 AkEw==
X-Gm-Message-State: AOAM5329/oh0Inv8d2VLQESkZ1/ThbeGG9GdRUj5j82VhaiBNNTTpsd0
 PG63/sx8FYOkUCmpBe+HvXTR5YLGMbU=
X-Google-Smtp-Source: ABdhPJzzWSKw81ONlKKzYfQ6U1u6DXzXAUH89cfsLv0zVvotm64CZJx5qwB/2ZCmYs0qCavoTjLW+w==
X-Received: by 2002:a2e:95c5:: with SMTP id y5mr5706728ljh.229.1589832644709; 
 Mon, 18 May 2020 13:10:44 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id c78sm8700591lfd.63.2020.05.18.13.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 13:10:44 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 19/21] target/mips: msa: Split helpers for MSUBV.<B|H|W|D>
Date: Mon, 18 May 2020 22:09:18 +0200
Message-Id: <20200518200920.17344-20-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518200920.17344-1-aleksandar.qemu.devel@gmail.com>
References: <20200518200920.17344-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
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
 target/mips/msa_helper.c | 79 ++++++++++++++++++++++++++++++++++++----
 target/mips/translate.c  | 19 ++++++++--
 3 files changed, 93 insertions(+), 11 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index e479a22559..7ca0036807 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -955,6 +955,11 @@ DEF_HELPER_4(msa_maddv_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_maddv_w, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_maddv_d, void, env, i32, i32, i32)
 
+DEF_HELPER_4(msa_msubv_b, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_msubv_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_msubv_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_msubv_d, void, env, i32, i32, i32)
+
 DEF_HELPER_4(msa_asub_s_b, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_asub_s_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_asub_s_w, void, env, i32, i32, i32)
@@ -1074,7 +1079,6 @@ DEF_HELPER_5(msa_subs_u_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_subsus_u_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_subsuu_s_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_mulv_df, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(msa_msubv_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_dotp_s_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_dotp_u_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_dpadd_s_df, void, env, i32, i32, i32, i32)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 6af9d3b752..a0aac3ee10 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -2955,6 +2955,78 @@ void helper_msa_maddv_d(CPUMIPSState *env,
     pwd->d[1]  = msa_maddv_df(DF_DOUBLE, pwd->d[1],  pws->d[1],  pwt->d[1]);
 }
 
+static inline int64_t msa_msubv_df(uint32_t df, int64_t dest, int64_t arg1,
+                                   int64_t arg2)
+{
+    return dest - arg1 * arg2;
+}
+
+void helper_msa_msubv_b(CPUMIPSState *env,
+                        uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->b[0]  = msa_msubv_df(DF_BYTE, pwt->b[0],  pws->b[0],  pwt->b[0]);
+    pwd->b[1]  = msa_msubv_df(DF_BYTE, pwt->b[1],  pws->b[1],  pwt->b[1]);
+    pwd->b[2]  = msa_msubv_df(DF_BYTE, pwt->b[2],  pws->b[2],  pwt->b[2]);
+    pwd->b[3]  = msa_msubv_df(DF_BYTE, pwt->b[3],  pws->b[3],  pwt->b[3]);
+    pwd->b[4]  = msa_msubv_df(DF_BYTE, pwt->b[4],  pws->b[4],  pwt->b[4]);
+    pwd->b[5]  = msa_msubv_df(DF_BYTE, pwt->b[5],  pws->b[5],  pwt->b[5]);
+    pwd->b[6]  = msa_msubv_df(DF_BYTE, pwt->b[6],  pws->b[6],  pwt->b[6]);
+    pwd->b[7]  = msa_msubv_df(DF_BYTE, pwt->b[7],  pws->b[7],  pwt->b[7]);
+    pwd->b[8]  = msa_msubv_df(DF_BYTE, pwt->b[8],  pws->b[8],  pwt->b[8]);
+    pwd->b[9]  = msa_msubv_df(DF_BYTE, pwt->b[9],  pws->b[9],  pwt->b[9]);
+    pwd->b[10] = msa_msubv_df(DF_BYTE, pwt->b[10], pws->b[10], pwt->b[10]);
+    pwd->b[11] = msa_msubv_df(DF_BYTE, pwt->b[11], pws->b[11], pwt->b[11]);
+    pwd->b[12] = msa_msubv_df(DF_BYTE, pwt->b[12], pws->b[12], pwt->b[12]);
+    pwd->b[13] = msa_msubv_df(DF_BYTE, pwt->b[13], pws->b[13], pwt->b[13]);
+    pwd->b[14] = msa_msubv_df(DF_BYTE, pwt->b[14], pws->b[14], pwt->b[14]);
+    pwd->b[15] = msa_msubv_df(DF_BYTE, pwt->b[15], pws->b[15], pwt->b[15]);
+}
+
+void helper_msa_msubv_h(CPUMIPSState *env,
+                        uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->h[0]  = msa_msubv_df(DF_HALF, pwd->h[0],  pws->h[0],  pwt->h[0]);
+    pwd->h[1]  = msa_msubv_df(DF_HALF, pwd->h[1],  pws->h[1],  pwt->h[1]);
+    pwd->h[2]  = msa_msubv_df(DF_HALF, pwd->h[2],  pws->h[2],  pwt->h[2]);
+    pwd->h[3]  = msa_msubv_df(DF_HALF, pwd->h[3],  pws->h[3],  pwt->h[3]);
+    pwd->h[4]  = msa_msubv_df(DF_HALF, pwd->h[4],  pws->h[4],  pwt->h[4]);
+    pwd->h[5]  = msa_msubv_df(DF_HALF, pwd->h[5],  pws->h[5],  pwt->h[5]);
+    pwd->h[6]  = msa_msubv_df(DF_HALF, pwd->h[6],  pws->h[6],  pwt->h[6]);
+    pwd->h[7]  = msa_msubv_df(DF_HALF, pwd->h[7],  pws->h[7],  pwt->h[7]);
+}
+
+void helper_msa_msubv_w(CPUMIPSState *env,
+                        uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->w[0]  = msa_msubv_df(DF_WORD, pwd->w[0],  pws->w[0],  pwt->w[0]);
+    pwd->w[1]  = msa_msubv_df(DF_WORD, pwd->w[1],  pws->w[1],  pwt->w[1]);
+    pwd->w[2]  = msa_msubv_df(DF_WORD, pwd->w[2],  pws->w[2],  pwt->w[2]);
+    pwd->w[3]  = msa_msubv_df(DF_WORD, pwd->w[3],  pws->w[3],  pwt->w[3]);
+}
+
+void helper_msa_msubv_d(CPUMIPSState *env,
+                        uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0]  = msa_msubv_df(DF_DOUBLE, pwd->d[0],  pws->d[0],  pwt->d[0]);
+    pwd->d[1]  = msa_msubv_df(DF_DOUBLE, pwd->d[1],  pws->d[1],  pwt->d[1]);
+}
+
 
 /*
  * Int Subtract
@@ -4886,12 +4958,6 @@ void helper_msa_sld_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_sld_df(df, pwd, pws, env->active_tc.gpr[rt]);
 }
 
-static inline int64_t msa_msubv_df(uint32_t df, int64_t dest, int64_t arg1,
-                                   int64_t arg2)
-{
-    return dest - arg1 * arg2;
-}
-
 static inline int64_t msa_dpadd_s_df(uint32_t df, int64_t dest, int64_t arg1,
                                      int64_t arg2)
 {
@@ -5066,7 +5132,6 @@ void helper_msa_ ## func ## _df(CPUMIPSState *env, uint32_t df, uint32_t wd,  \
     }                                                                         \
 }
 
-MSA_TEROP_DF(msubv)
 MSA_TEROP_DF(dpadd_s)
 MSA_TEROP_DF(dpadd_u)
 MSA_TEROP_DF(dpsub_s)
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 42f2a759e5..6b6a92a84f 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -29073,6 +29073,22 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
             break;
         }
         break;
+    case OPC_MSUBV_df:
+        switch (df) {
+        case DF_BYTE:
+            gen_helper_msa_msubv_b(cpu_env, twd, tws, twt);
+            break;
+        case DF_HALF:
+            gen_helper_msa_msubv_h(cpu_env, twd, tws, twt);
+            break;
+        case DF_WORD:
+            gen_helper_msa_msubv_w(cpu_env, twd, tws, twt);
+            break;
+        case DF_DOUBLE:
+            gen_helper_msa_msubv_d(cpu_env, twd, tws, twt);
+            break;
+        }
+        break;
     case OPC_ASUB_S_df:
         switch (df) {
         case DF_BYTE:
@@ -29305,9 +29321,6 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
     case OPC_SUBSUS_U_df:
         gen_helper_msa_subsus_u_df(cpu_env, tdf, twd, tws, twt);
         break;
-    case OPC_MSUBV_df:
-        gen_helper_msa_msubv_df(cpu_env, tdf, twd, tws, twt);
-        break;
     case OPC_SUBSUU_S_df:
         gen_helper_msa_subsuu_s_df(cpu_env, tdf, twd, tws, twt);
         break;
-- 
2.20.1


