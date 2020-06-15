Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CD6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:23:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 774EB20756
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhSolBpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774EB20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkuhu-00085S-Nz
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 15:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkugy-0006Ow-KT
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:22:48 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:53797)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkugw-0003oy-LK
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:22:48 -0400
Received: by mail-wm1-x32e.google.com with SMTP id l26so667115wme.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 12:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lJFNcAr2PTehLumxuWaD2JP+ifoFJuahvTqLADXR2uw=;
 b=BhSolBpNJvmBvs4dLjneeVSPpXxRfii5ixGJZ98nyoot8Q9jGLX0UHijvERENsg0DR
 W8EXFisyPbmrztE2ZHOflBhmsXM9Qmugrp9dQKX5xvwwQHWiw41x6HKT7FzY2QLKKJtE
 1vcx8QgPzsa6ATUpuuPWGrbyUB+aD/eofSvTVjzzrvlEBtJNGv//WAvfCoYWZtimCU7a
 ItoNh/vZmwp2xu0xm6b/8YQkgNXoQAtE6fPrIerNdtN/fa9/8vbF+n1t+s5VojrwQA9a
 oREF0at9kbdE03L/owdpSjFTw7VZp6uBUo9SO6J9nJ3Xs9r/Dn1dXb+GOhXPiz/pcBl/
 EkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lJFNcAr2PTehLumxuWaD2JP+ifoFJuahvTqLADXR2uw=;
 b=XglSounhteyp4grK837jyd+z1NCml3/I0aKMSq3frTfggUGwhxQuGPIr2n+ZWSXP0A
 8zCgyxmFFSZV3lb4FWxxEQETd0B5wqGHGbZCev+jsIOyV9cMDGx8q0+/6c4FtP17+8Be
 jX4+gCkYw72pnkrzYg1xDewJiGTcPkIirfLp72OmqriPtXe7foSSdqKhktgxwRJ5xNJP
 4ggd8eDFQ5zCv6DSK8HYMFDE+yUSSV8CmcMA46C9WUEFawjRjIkbZOKYk4qve/i5NULB
 nIPtORzZZ/FoVFZwVioqMx+CD8TOVI/l/S5Xj8m5fsRApjkKkVi2p+/o+Ti18CF8CkUW
 3Vhw==
X-Gm-Message-State: AOAM531jiSEUdNxK7I2fF2Ul2N6bD2PMp9+c02IQJBnIPpPUECgn+Amy
 VD4Lg4UYaIiRiBP0CKmAerzKYP85
X-Google-Smtp-Source: ABdhPJxsJrkuqAGT89l1sbKOyfcyROfa+qSpbKTdGz7Kiu/Na1zvgRvmOjNdJNR0j13MHt0Ta1UppA==
X-Received: by 2002:a1c:e90a:: with SMTP id q10mr881746wmc.140.1592248964629; 
 Mon, 15 Jun 2020 12:22:44 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id 50sm27823909wra.1.2020.06.15.12.22.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jun 2020 12:22:44 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 05/18] target/mips: msa: Split helpers for DPADD_S.<H|W|D>
Date: Mon, 15 Jun 2020 21:22:20 +0200
Message-Id: <1592248953-8162-6-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592248953-8162-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1592248953-8162-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x32e.google.com
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
Message-Id: <20200613152133.8964-4-aleksandar.qemu.devel@gmail.com>
---
 target/mips/helper.h     |  4 ++-
 target/mips/msa_helper.c | 90 ++++++++++++++++++++++++++++++++++--------------
 target/mips/translate.c  | 12 ++++++-
 3 files changed, 78 insertions(+), 28 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 7ca0036..16f2d53 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -1081,7 +1081,9 @@ DEF_HELPER_5(msa_subsuu_s_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_mulv_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_dotp_s_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_dotp_u_df, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(msa_dpadd_s_df, void, env, i32, i32, i32, i32)
+DEF_HELPER_4(msa_dpadd_s_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_dpadd_s_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_dpadd_s_d, void, env, i32, i32, i32)
 DEF_HELPER_5(msa_dpadd_u_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_dpsub_s_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_dpsub_u_df, void, env, i32, i32, i32, i32)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 2b54de0..086b56f 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -2224,7 +2224,70 @@ void helper_msa_div_u_d(CPUMIPSState *env,
  * +---------------+----------------------------------------------------------+
  */
 
-/* TODO: insert Int Dot Product group helpers here */
+#define SIGNED_EXTRACT(e, o, a, df)     \
+    do {                                \
+        e = SIGNED_EVEN(a, df);         \
+        o = SIGNED_ODD(a, df);          \
+    } while (0)
+
+#define UNSIGNED_EXTRACT(e, o, a, df)   \
+    do {                                \
+        e = UNSIGNED_EVEN(a, df);       \
+        o = UNSIGNED_ODD(a, df);        \
+    } while (0)
+
+static inline int64_t msa_dpadd_s_df(uint32_t df, int64_t dest, int64_t arg1,
+                                     int64_t arg2)
+{
+    int64_t even_arg1;
+    int64_t even_arg2;
+    int64_t odd_arg1;
+    int64_t odd_arg2;
+    SIGNED_EXTRACT(even_arg1, odd_arg1, arg1, df);
+    SIGNED_EXTRACT(even_arg2, odd_arg2, arg2, df);
+    return dest + (even_arg1 * even_arg2) + (odd_arg1 * odd_arg2);
+}
+
+void helper_msa_dpadd_s_h(CPUMIPSState *env,
+                          uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->h[0]  = msa_dpadd_s_df(DF_HALF, pwd->h[0],  pws->h[0],  pwt->h[0]);
+    pwd->h[1]  = msa_dpadd_s_df(DF_HALF, pwd->h[1],  pws->h[1],  pwt->h[1]);
+    pwd->h[2]  = msa_dpadd_s_df(DF_HALF, pwd->h[2],  pws->h[2],  pwt->h[2]);
+    pwd->h[3]  = msa_dpadd_s_df(DF_HALF, pwd->h[3],  pws->h[3],  pwt->h[3]);
+    pwd->h[4]  = msa_dpadd_s_df(DF_HALF, pwd->h[4],  pws->h[4],  pwt->h[4]);
+    pwd->h[5]  = msa_dpadd_s_df(DF_HALF, pwd->h[5],  pws->h[5],  pwt->h[5]);
+    pwd->h[6]  = msa_dpadd_s_df(DF_HALF, pwd->h[6],  pws->h[6],  pwt->h[6]);
+    pwd->h[7]  = msa_dpadd_s_df(DF_HALF, pwd->h[7],  pws->h[7],  pwt->h[7]);
+}
+
+void helper_msa_dpadd_s_w(CPUMIPSState *env,
+                          uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->w[0]  = msa_dpadd_s_df(DF_WORD, pwd->w[0],  pws->w[0],  pwt->w[0]);
+    pwd->w[1]  = msa_dpadd_s_df(DF_WORD, pwd->w[1],  pws->w[1],  pwt->w[1]);
+    pwd->w[2]  = msa_dpadd_s_df(DF_WORD, pwd->w[2],  pws->w[2],  pwt->w[2]);
+    pwd->w[3]  = msa_dpadd_s_df(DF_WORD, pwd->w[3],  pws->w[3],  pwt->w[3]);
+}
+
+void helper_msa_dpadd_s_d(CPUMIPSState *env,
+                          uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0]  = msa_dpadd_s_df(DF_DOUBLE, pwd->d[0],  pws->d[0],  pwt->d[0]);
+    pwd->d[1]  = msa_dpadd_s_df(DF_DOUBLE, pwd->d[1],  pws->d[1],  pwt->d[1]);
+}
 
 
 /*
@@ -4785,18 +4848,6 @@ static inline int64_t msa_mulv_df(uint32_t df, int64_t arg1, int64_t arg2)
     return arg1 * arg2;
 }
 
-#define SIGNED_EXTRACT(e, o, a, df)     \
-    do {                                \
-        e = SIGNED_EVEN(a, df);         \
-        o = SIGNED_ODD(a, df);          \
-    } while (0)
-
-#define UNSIGNED_EXTRACT(e, o, a, df)   \
-    do {                                \
-        e = UNSIGNED_EVEN(a, df);       \
-        o = UNSIGNED_ODD(a, df);        \
-    } while (0)
-
 static inline int64_t msa_dotp_s_df(uint32_t df, int64_t arg1, int64_t arg2)
 {
     int64_t even_arg1;
@@ -4958,18 +5009,6 @@ void helper_msa_sld_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_sld_df(df, pwd, pws, env->active_tc.gpr[rt]);
 }
 
-static inline int64_t msa_dpadd_s_df(uint32_t df, int64_t dest, int64_t arg1,
-                                     int64_t arg2)
-{
-    int64_t even_arg1;
-    int64_t even_arg2;
-    int64_t odd_arg1;
-    int64_t odd_arg2;
-    SIGNED_EXTRACT(even_arg1, odd_arg1, arg1, df);
-    SIGNED_EXTRACT(even_arg2, odd_arg2, arg2, df);
-    return dest + (even_arg1 * even_arg2) + (odd_arg1 * odd_arg2);
-}
-
 static inline int64_t msa_dpadd_u_df(uint32_t df, int64_t dest, int64_t arg1,
                                      int64_t arg2)
 {
@@ -5132,7 +5171,6 @@ void helper_msa_ ## func ## _df(CPUMIPSState *env, uint32_t df, uint32_t wd,  \
     }                                                                         \
 }
 
-MSA_TEROP_DF(dpadd_s)
 MSA_TEROP_DF(dpadd_u)
 MSA_TEROP_DF(dpsub_s)
 MSA_TEROP_DF(dpsub_u)
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 7388a16..47ac4ea 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -29400,7 +29400,17 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
             gen_helper_msa_dotp_u_df(cpu_env, tdf, twd, tws, twt);
             break;
         case OPC_DPADD_S_df:
-            gen_helper_msa_dpadd_s_df(cpu_env, tdf, twd, tws, twt);
+            switch (df) {
+            case DF_HALF:
+                gen_helper_msa_dpadd_s_h(cpu_env, twd, tws, twt);
+                break;
+            case DF_WORD:
+                gen_helper_msa_dpadd_s_w(cpu_env, twd, tws, twt);
+                break;
+            case DF_DOUBLE:
+                gen_helper_msa_dpadd_s_d(cpu_env, twd, tws, twt);
+                break;
+            }
             break;
         case OPC_DPADD_U_df:
             gen_helper_msa_dpadd_u_df(cpu_env, tdf, twd, tws, twt);
-- 
2.7.4


