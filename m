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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D20C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 15:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 536522078A
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 15:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRb/D+HH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536522078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jk864-0004aS-Ld
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 11:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jk7yw-00019Y-7N
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 11:22:06 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55457)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jk7yu-0002kx-C4
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 11:22:05 -0400
Received: by mail-wm1-x342.google.com with SMTP id c71so10496878wmd.5
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2020 08:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QwP8Kk0dHA2cGIlbQWbWtur7MCwUGP6d3O58JClugcU=;
 b=pRb/D+HHQjig69n84PGcey6H9+GH7+unztsabfxI/N5+ZaEIAMmSfdj3xLlHwb6m6Y
 UeU9Ei1TiYbF0fgCuhaCCHaTxlPjC9/IcegcD/MI9k1DZDgiVHv4WNKCnbO3LrtvRFP6
 +tLzEyNwQPv6p27qWsEJIXPRtbZuT6qQ2R2uOq68xOltfNv1BH9XfbHYXzIozk/G1iN6
 ha1R82qkDowqoAHO4Pc7MsvszqZeX1HpljzYh2T79WRo6JMEsMUKz2hXrALyVYuZrVKH
 tGPBec5iVA3i3bKXzgk0kCvGybx5jVaav1COmoYI6O2Vb+eRAHK0wJYocWFV0B/L5VuX
 rjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QwP8Kk0dHA2cGIlbQWbWtur7MCwUGP6d3O58JClugcU=;
 b=DOqM4V9UEQNKT/0wagIcv/DxRT+7/ZXLRoK1AXvHczHzn7iwG16nGf5uEmdxXqtxlx
 pmmtnETmMWRIVVo4jqxoptRRNsJC9BiVqM5QGcQRqsGtUD8RklZqNL2pLRVwWNY9j9mg
 E5sgnXHrpX6hQWCT4OIcaKkYE3gGtnL+qMhFyPvbpkq6Z0CWiAUaS9BE8cyo0o9/qHga
 8TZn+IRtrj7D8mkfh2HxW44V/xLqDjwStyW7cYfU4cxogOK4Ys85UB+1WaxepDup9m8x
 pUur6xmqb4/XMEODxN2QjnLs8z9zFfLgYXPzsH883jPpAGK0Pjo83+cK6dRcS7ktu3Fj
 n84A==
X-Gm-Message-State: AOAM531USHMJhfomOUaVJsPH3ZlFn/wcRWLsCtwptXYbbWzeISs9co5g
 ai9A7oJncml/XIiuP0ddVvZHKkxAze0=
X-Google-Smtp-Source: ABdhPJztbWPp/WmFFnSYCU4KeU1eFIgus6rtRh3N3PadA3lIOA6Nhmc0ydLVDJANLS1w0BlxuFkq4w==
X-Received: by 2002:a1c:e914:: with SMTP id q20mr4140364wmc.145.1592061717791; 
 Sat, 13 Jun 2020 08:21:57 -0700 (PDT)
Received: from localhost.localdomain (net212-32-245-109.mbb.telenor.rs.
 [109.245.32.212])
 by smtp.gmail.com with ESMTPSA id 67sm16045399wrk.49.2020.06.13.08.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2020 08:21:57 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 07/14] target/mips: msa: Split helpers for DOTP_S.<H|W|D>
Date: Sat, 13 Jun 2020 17:21:26 +0200
Message-Id: <20200613152133.8964-8-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200613152133.8964-1-aleksandar.qemu.devel@gmail.com>
References: <20200613152133.8964-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x342.google.com
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
 target/mips/helper.h     |  5 ++-
 target/mips/msa_helper.c | 66 ++++++++++++++++++++++++++++++++--------
 target/mips/translate.c  | 12 +++++++-
 3 files changed, 69 insertions(+), 14 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 575f4a524c..06df3de744 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -1079,7 +1079,10 @@ DEF_HELPER_5(msa_subs_u_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_subsus_u_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_subsuu_s_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_mulv_df, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(msa_dotp_s_df, void, env, i32, i32, i32, i32)
+
+DEF_HELPER_4(msa_dotp_s_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_dotp_s_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_dotp_s_d, void, env, i32, i32, i32)
 DEF_HELPER_5(msa_dotp_u_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_4(msa_dpadd_s_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_dpadd_s_w, void, env, i32, i32, i32)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 33d5251a6b..201283fdd9 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -2236,6 +2236,60 @@ void helper_msa_div_u_d(CPUMIPSState *env,
         o = UNSIGNED_ODD(a, df);        \
     } while (0)
 
+
+static inline int64_t msa_dotp_s_df(uint32_t df, int64_t arg1, int64_t arg2)
+{
+    int64_t even_arg1;
+    int64_t even_arg2;
+    int64_t odd_arg1;
+    int64_t odd_arg2;
+    SIGNED_EXTRACT(even_arg1, odd_arg1, arg1, df);
+    SIGNED_EXTRACT(even_arg2, odd_arg2, arg2, df);
+    return (even_arg1 * even_arg2) + (odd_arg1 * odd_arg2);
+}
+
+void helper_msa_dotp_s_h(CPUMIPSState *env,
+                         uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->h[0]  = msa_dotp_s_df(DF_HALF, pws->h[0],  pwt->h[0]);
+    pwd->h[1]  = msa_dotp_s_df(DF_HALF, pws->h[1],  pwt->h[1]);
+    pwd->h[2]  = msa_dotp_s_df(DF_HALF, pws->h[2],  pwt->h[2]);
+    pwd->h[3]  = msa_dotp_s_df(DF_HALF, pws->h[3],  pwt->h[3]);
+    pwd->h[4]  = msa_dotp_s_df(DF_HALF, pws->h[4],  pwt->h[4]);
+    pwd->h[5]  = msa_dotp_s_df(DF_HALF, pws->h[5],  pwt->h[5]);
+    pwd->h[6]  = msa_dotp_s_df(DF_HALF, pws->h[6],  pwt->h[6]);
+    pwd->h[7]  = msa_dotp_s_df(DF_HALF, pws->h[7],  pwt->h[7]);
+}
+
+void helper_msa_dotp_s_w(CPUMIPSState *env,
+                         uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->w[0]  = msa_dotp_s_df(DF_WORD, pws->w[0],  pwt->w[0]);
+    pwd->w[1]  = msa_dotp_s_df(DF_WORD, pws->w[1],  pwt->w[1]);
+    pwd->w[2]  = msa_dotp_s_df(DF_WORD, pws->w[2],  pwt->w[2]);
+    pwd->w[3]  = msa_dotp_s_df(DF_WORD, pws->w[3],  pwt->w[3]);
+}
+
+void helper_msa_dotp_s_d(CPUMIPSState *env,
+                         uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0]  = msa_dotp_s_df(DF_DOUBLE, pws->d[0],  pwt->d[0]);
+    pwd->d[1]  = msa_dotp_s_df(DF_DOUBLE, pws->d[1],  pwt->d[1]);
+}
+
+
 static inline int64_t msa_dpadd_s_df(uint32_t df, int64_t dest, int64_t arg1,
                                      int64_t arg2)
 {
@@ -5010,17 +5064,6 @@ static inline int64_t msa_mulv_df(uint32_t df, int64_t arg1, int64_t arg2)
     return arg1 * arg2;
 }
 
-static inline int64_t msa_dotp_s_df(uint32_t df, int64_t arg1, int64_t arg2)
-{
-    int64_t even_arg1;
-    int64_t even_arg2;
-    int64_t odd_arg1;
-    int64_t odd_arg2;
-    SIGNED_EXTRACT(even_arg1, odd_arg1, arg1, df);
-    SIGNED_EXTRACT(even_arg2, odd_arg2, arg2, df);
-    return (even_arg1 * even_arg2) + (odd_arg1 * odd_arg2);
-}
-
 static inline int64_t msa_dotp_u_df(uint32_t df, int64_t arg1, int64_t arg2)
 {
     int64_t even_arg1;
@@ -5155,7 +5198,6 @@ MSA_BINOP_DF(subs_u)
 MSA_BINOP_DF(subsus_u)
 MSA_BINOP_DF(subsuu_s)
 MSA_BINOP_DF(mulv)
-MSA_BINOP_DF(dotp_s)
 MSA_BINOP_DF(dotp_u)
 
 MSA_BINOP_DF(mul_q)
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3dda242643..f0bab46378 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -29393,7 +29393,17 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
             }
             break;
         case OPC_DOTP_S_df:
-            gen_helper_msa_dotp_s_df(cpu_env, tdf, twd, tws, twt);
+            switch (df) {
+            case DF_HALF:
+                gen_helper_msa_dotp_s_h(cpu_env, twd, tws, twt);
+                break;
+            case DF_WORD:
+                gen_helper_msa_dotp_s_w(cpu_env, twd, tws, twt);
+                break;
+            case DF_DOUBLE:
+                gen_helper_msa_dotp_s_d(cpu_env, twd, tws, twt);
+                break;
+            }
             break;
         case OPC_DOTP_U_df:
             gen_helper_msa_dotp_u_df(cpu_env, tdf, twd, tws, twt);
-- 
2.20.1


