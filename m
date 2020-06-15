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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366D7C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF72B20756
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2eWJvOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF72B20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkurv-0003en-6g
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 15:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkunA-0003VW-1H
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:29:12 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:36067)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkun8-0004jn-0u
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:29:11 -0400
Received: by mail-wr1-x429.google.com with SMTP id q11so18355990wrp.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 12:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hFoUngZUAV/wOrxq7CCZMZM/tNgP1n6Jxk0PPIrAqpg=;
 b=c2eWJvOj9zSAc6KuaeA2Rlia9o9cJLM1Cjszw67naQ62Pbj2QRecXaVL80mIwQHTBI
 NiYrcbLFElkQYVHNmOXF89WgvQlVVgAEfj++EL/aNaFFvbIQZXVWbhE3PFI4CmU0WDe/
 wo+T4iLrvImRBvSri6VWqXmjrDQX1Sf+4vMVk+muYACWqKA8PTmn/yPsWzzuWadgg/LN
 VnLWC6PXnOBRSfuu1JKdWUtOBe05/H6T3UPt+i6K19YPXtn+WgrO4T8hfMMjo7U/HARq
 YQ/g4kfkjhiE9HkjjtiJC9FBAkEM6/SgaNSwxgIZheNi8VoT+EUD5O6E1gUXci3G8/gj
 O4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=hFoUngZUAV/wOrxq7CCZMZM/tNgP1n6Jxk0PPIrAqpg=;
 b=LnJdgWZUW1FWH4tlE5x/7y+pA5moBI2snJAQ/R68H06T8J82j5z1KDFjYCOu1oqES7
 8lGA6BUmU+2KCXmNPT6wIG6U9WPBsfYIzpqUPn2Wu8b6rb1jYlmpDPzVAd/w0+bxtrlk
 /1CUn++m3n2T7o/F6h9f/N6q2Btk95xNbv6AW3yo/84BKpDjlStdki7Nh3YrCfS+meW7
 WR34fHcYFke2BFwcfTyOl3Dt1r8REPpwOoDH8oyTMZ7b6rq2uixPI4yC9nH7mEAqmICh
 6TJ79UXVFDehlHIt82WXWXg3OE/WiauEDD9ql9I+CTCIucfEiS7OT8Q8hjTFOO47ikjl
 /U4Q==
X-Gm-Message-State: AOAM530R4V5diRDv2xBm9y4rzZoogJADqfeFHMHOWD1Mw/Qh70qVhkjT
 5SyxP2IyZHmKVlE5cB3Bn7l5UXYW
X-Google-Smtp-Source: ABdhPJzfkgb2wvFkZdchaMfsmWX74iBws5fmqfVyXkAWB6U1xOf19QTbnJoFFZHui4h3Op5D6eKIcg==
X-Received: by 2002:adf:aa94:: with SMTP id h20mr28533444wrc.327.1592249348583; 
 Mon, 15 Jun 2020 12:29:08 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id 138sm713098wma.23.2020.06.15.12.29.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jun 2020 12:29:08 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 07/18] target/mips: msa: Split helpers for DPSUB_S.<H|W|D>
Date: Mon, 15 Jun 2020 21:28:49 +0200
Message-Id: <1592249340-8365-8-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592249340-8365-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1592249340-8365-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x429.google.com
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
Message-Id: <20200613152133.8964-6-aleksandar.qemu.devel@gmail.com>
---
 target/mips/helper.h     |  4 ++-
 target/mips/msa_helper.c | 67 ++++++++++++++++++++++++++++++++++++++----------
 target/mips/translate.c  | 12 ++++++++-
 3 files changed, 68 insertions(+), 15 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 155b6bb..2de1454 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -1087,7 +1087,9 @@ DEF_HELPER_4(msa_dpadd_s_d, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_dpadd_u_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_dpadd_u_w, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_dpadd_u_d, void, env, i32, i32, i32)
-DEF_HELPER_5(msa_dpsub_s_df, void, env, i32, i32, i32, i32)
+DEF_HELPER_4(msa_dpsub_s_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_dpsub_s_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_dpsub_s_d, void, env, i32, i32, i32)
 DEF_HELPER_5(msa_dpsub_u_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_sld_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_splat_df, void, env, i32, i32, i32, i32)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 9741c94..934f705 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -2344,6 +2344,60 @@ void helper_msa_dpadd_u_d(CPUMIPSState *env,
 }
 
 
+static inline int64_t msa_dpsub_s_df(uint32_t df, int64_t dest, int64_t arg1,
+                                     int64_t arg2)
+{
+    int64_t even_arg1;
+    int64_t even_arg2;
+    int64_t odd_arg1;
+    int64_t odd_arg2;
+    SIGNED_EXTRACT(even_arg1, odd_arg1, arg1, df);
+    SIGNED_EXTRACT(even_arg2, odd_arg2, arg2, df);
+    return dest - ((even_arg1 * even_arg2) + (odd_arg1 * odd_arg2));
+}
+
+void helper_msa_dpsub_s_h(CPUMIPSState *env,
+                          uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->h[0]  = msa_dpsub_s_df(DF_HALF, pwd->h[0],  pws->h[0],  pwt->h[0]);
+    pwd->h[1]  = msa_dpsub_s_df(DF_HALF, pwd->h[1],  pws->h[1],  pwt->h[1]);
+    pwd->h[2]  = msa_dpsub_s_df(DF_HALF, pwd->h[2],  pws->h[2],  pwt->h[2]);
+    pwd->h[3]  = msa_dpsub_s_df(DF_HALF, pwd->h[3],  pws->h[3],  pwt->h[3]);
+    pwd->h[4]  = msa_dpsub_s_df(DF_HALF, pwd->h[4],  pws->h[4],  pwt->h[4]);
+    pwd->h[5]  = msa_dpsub_s_df(DF_HALF, pwd->h[5],  pws->h[5],  pwt->h[5]);
+    pwd->h[6]  = msa_dpsub_s_df(DF_HALF, pwd->h[6],  pws->h[6],  pwt->h[6]);
+    pwd->h[7]  = msa_dpsub_s_df(DF_HALF, pwd->h[7],  pws->h[7],  pwt->h[7]);
+}
+
+void helper_msa_dpsub_s_w(CPUMIPSState *env,
+                          uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->w[0]  = msa_dpsub_s_df(DF_WORD, pwd->w[0],  pws->w[0],  pwt->w[0]);
+    pwd->w[1]  = msa_dpsub_s_df(DF_WORD, pwd->w[1],  pws->w[1],  pwt->w[1]);
+    pwd->w[2]  = msa_dpsub_s_df(DF_WORD, pwd->w[2],  pws->w[2],  pwt->w[2]);
+    pwd->w[3]  = msa_dpsub_s_df(DF_WORD, pwd->w[3],  pws->w[3],  pwt->w[3]);
+}
+
+void helper_msa_dpsub_s_d(CPUMIPSState *env,
+                          uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0]  = msa_dpsub_s_df(DF_DOUBLE, pwd->d[0],  pws->d[0],  pwt->d[0]);
+    pwd->d[1]  = msa_dpsub_s_df(DF_DOUBLE, pwd->d[1],  pws->d[1],  pwt->d[1]);
+}
+
+
 /*
  * Int Max Min
  * -----------
@@ -5063,18 +5117,6 @@ void helper_msa_sld_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_sld_df(df, pwd, pws, env->active_tc.gpr[rt]);
 }
 
-static inline int64_t msa_dpsub_s_df(uint32_t df, int64_t dest, int64_t arg1,
-                                     int64_t arg2)
-{
-    int64_t even_arg1;
-    int64_t even_arg2;
-    int64_t odd_arg1;
-    int64_t odd_arg2;
-    SIGNED_EXTRACT(even_arg1, odd_arg1, arg1, df);
-    SIGNED_EXTRACT(even_arg2, odd_arg2, arg2, df);
-    return dest - ((even_arg1 * even_arg2) + (odd_arg1 * odd_arg2));
-}
-
 static inline int64_t msa_dpsub_u_df(uint32_t df, int64_t dest, int64_t arg1,
                                      int64_t arg2)
 {
@@ -5213,7 +5255,6 @@ void helper_msa_ ## func ## _df(CPUMIPSState *env, uint32_t df, uint32_t wd,  \
     }                                                                         \
 }
 
-MSA_TEROP_DF(dpsub_s)
 MSA_TEROP_DF(dpsub_u)
 MSA_TEROP_DF(binsl)
 MSA_TEROP_DF(binsr)
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 0f99768..caf3adf 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -29426,7 +29426,17 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
             }
             break;
         case OPC_DPSUB_S_df:
-            gen_helper_msa_dpsub_s_df(cpu_env, tdf, twd, tws, twt);
+            switch (df) {
+            case DF_HALF:
+                gen_helper_msa_dpsub_s_h(cpu_env, twd, tws, twt);
+                break;
+            case DF_WORD:
+                gen_helper_msa_dpsub_s_w(cpu_env, twd, tws, twt);
+                break;
+            case DF_DOUBLE:
+                gen_helper_msa_dpsub_s_d(cpu_env, twd, tws, twt);
+                break;
+            }
             break;
         case OPC_DPSUB_U_df:
             gen_helper_msa_dpsub_u_df(cpu_env, tdf, twd, tws, twt);
-- 
2.7.4


