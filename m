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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95FBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:23:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CA6120756
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k19H/1Br"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA6120756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkui0-00089j-Rh
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 15:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkugz-0006Qd-FW
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:22:49 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:51685)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkugw-0003oz-Qh
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:22:49 -0400
Received: by mail-wm1-x332.google.com with SMTP id b82so680340wmb.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 12:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=y6MEAtmIgLHd+FyjQxuLwBlqoSNdcHikAqFlNucbeMU=;
 b=k19H/1BrUeUMtqhxXJjB8ECY8YaJbtlBhcMy+98hFgPAwmUtQVzvD+fqC1/lkCqnBS
 3ZrwuZs/abGKy1djYAFxSR6RdiUBuGsZwW1S06UYQjiAS4Z9Zh0o1ICg+8fDnyy69Ups
 AApwDp+OUoHkf1hmQEWsMFVUqik6JkrIrnZkruH7+kuWjLJPwyZ9G4dzLMZnxO3diD2j
 CdOoUZNwZGDUDoqcGRhStcNs8k1RX5ZKA0hlvpH837I40SkBBzfgP52Gm+tfMcDEPTtK
 Q9yc0uPv6pxalzx0r2riyjkRz7bv9sh3UwXJ8HRMm8n0fWVQX75MuMfY9p/h/ElYcOLQ
 mlow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=y6MEAtmIgLHd+FyjQxuLwBlqoSNdcHikAqFlNucbeMU=;
 b=o5+jjOd3KbfH+Cq5SGsB5OmiFUZIp0LX08TBYaFPrSAS4j/gMn4OfrO7sxpABUr3A5
 GvDcfoSLFph2r3D620bwag6+ii7gZspHIqWSU4QpPuyif75XeSGj/M3O3vZdxnlpXNes
 DQFtVr9ADytAtRn9+ECUhIHD1ZPKimh2eV8bpWfm+WfMklTPc1dVPSvkfryFLF1PZwkp
 SF7dVLLqGTcopaPZaPIvr7pyq+7qKtWPWm3n/UPQzVOMvsbTdi6QjmgfvqGriY4Cn7He
 BEfc33g7XraRCmtFzBniUa+DLjBqers9m9wdjoOFIep3dh3yJFUaFRDR954rSQtQl133
 Ea6A==
X-Gm-Message-State: AOAM531YUCgSn7WhnllDaj6TiYN809qysz+TOzRnBfDbQij/o3IA5xIm
 RhEeWf5GHc28w62GmRFW5ZZ4uSZx
X-Google-Smtp-Source: ABdhPJyDgS+QBIy+coTMtchUt6q8IhG7e3rL5zoZW3TlYt7/7Q4/lEzfjfUNLSGVJEbP7TJKwXDhkg==
X-Received: by 2002:a1c:3b43:: with SMTP id i64mr884073wma.112.1592248965193; 
 Mon, 15 Jun 2020 12:22:45 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id 50sm27823909wra.1.2020.06.15.12.22.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jun 2020 12:22:44 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 06/18] target/mips: msa: Split helpers for DPADD_U.<H|W|D>
Date: Mon, 15 Jun 2020 21:22:21 +0200
Message-Id: <1592248953-8162-7-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592248953-8162-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1592248953-8162-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x332.google.com
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
Message-Id: <20200613152133.8964-5-aleksandar.qemu.devel@gmail.com>
---
 target/mips/helper.h     |  4 ++-
 target/mips/msa_helper.c | 67 ++++++++++++++++++++++++++++++++++++++----------
 target/mips/translate.c  | 12 ++++++++-
 3 files changed, 68 insertions(+), 15 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 16f2d53..155b6bb 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -1084,7 +1084,9 @@ DEF_HELPER_5(msa_dotp_u_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_4(msa_dpadd_s_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_dpadd_s_w, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_dpadd_s_d, void, env, i32, i32, i32)
-DEF_HELPER_5(msa_dpadd_u_df, void, env, i32, i32, i32, i32)
+DEF_HELPER_4(msa_dpadd_u_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_dpadd_u_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_dpadd_u_d, void, env, i32, i32, i32)
 DEF_HELPER_5(msa_dpsub_s_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_dpsub_u_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_sld_df, void, env, i32, i32, i32, i32)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 086b56f..9741c94 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -2290,6 +2290,60 @@ void helper_msa_dpadd_s_d(CPUMIPSState *env,
 }
 
 
+static inline int64_t msa_dpadd_u_df(uint32_t df, int64_t dest, int64_t arg1,
+                                     int64_t arg2)
+{
+    int64_t even_arg1;
+    int64_t even_arg2;
+    int64_t odd_arg1;
+    int64_t odd_arg2;
+    UNSIGNED_EXTRACT(even_arg1, odd_arg1, arg1, df);
+    UNSIGNED_EXTRACT(even_arg2, odd_arg2, arg2, df);
+    return dest + (even_arg1 * even_arg2) + (odd_arg1 * odd_arg2);
+}
+
+void helper_msa_dpadd_u_h(CPUMIPSState *env,
+                          uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->h[0]  = msa_dpadd_u_df(DF_HALF, pwd->h[0],  pws->h[0],  pwt->h[0]);
+    pwd->h[1]  = msa_dpadd_u_df(DF_HALF, pwd->h[1],  pws->h[1],  pwt->h[1]);
+    pwd->h[2]  = msa_dpadd_u_df(DF_HALF, pwd->h[2],  pws->h[2],  pwt->h[2]);
+    pwd->h[3]  = msa_dpadd_u_df(DF_HALF, pwd->h[3],  pws->h[3],  pwt->h[3]);
+    pwd->h[4]  = msa_dpadd_u_df(DF_HALF, pwd->h[4],  pws->h[4],  pwt->h[4]);
+    pwd->h[5]  = msa_dpadd_u_df(DF_HALF, pwd->h[5],  pws->h[5],  pwt->h[5]);
+    pwd->h[6]  = msa_dpadd_u_df(DF_HALF, pwd->h[6],  pws->h[6],  pwt->h[6]);
+    pwd->h[7]  = msa_dpadd_u_df(DF_HALF, pwd->h[7],  pws->h[7],  pwt->h[7]);
+}
+
+void helper_msa_dpadd_u_w(CPUMIPSState *env,
+                          uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->w[0]  = msa_dpadd_u_df(DF_WORD, pwd->w[0],  pws->w[0],  pwt->w[0]);
+    pwd->w[1]  = msa_dpadd_u_df(DF_WORD, pwd->w[1],  pws->w[1],  pwt->w[1]);
+    pwd->w[2]  = msa_dpadd_u_df(DF_WORD, pwd->w[2],  pws->w[2],  pwt->w[2]);
+    pwd->w[3]  = msa_dpadd_u_df(DF_WORD, pwd->w[3],  pws->w[3],  pwt->w[3]);
+}
+
+void helper_msa_dpadd_u_d(CPUMIPSState *env,
+                          uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0]  = msa_dpadd_u_df(DF_DOUBLE, pwd->d[0],  pws->d[0],  pwt->d[0]);
+    pwd->d[1]  = msa_dpadd_u_df(DF_DOUBLE, pwd->d[1],  pws->d[1],  pwt->d[1]);
+}
+
+
 /*
  * Int Max Min
  * -----------
@@ -5009,18 +5063,6 @@ void helper_msa_sld_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_sld_df(df, pwd, pws, env->active_tc.gpr[rt]);
 }
 
-static inline int64_t msa_dpadd_u_df(uint32_t df, int64_t dest, int64_t arg1,
-                                     int64_t arg2)
-{
-    int64_t even_arg1;
-    int64_t even_arg2;
-    int64_t odd_arg1;
-    int64_t odd_arg2;
-    UNSIGNED_EXTRACT(even_arg1, odd_arg1, arg1, df);
-    UNSIGNED_EXTRACT(even_arg2, odd_arg2, arg2, df);
-    return dest + (even_arg1 * even_arg2) + (odd_arg1 * odd_arg2);
-}
-
 static inline int64_t msa_dpsub_s_df(uint32_t df, int64_t dest, int64_t arg1,
                                      int64_t arg2)
 {
@@ -5171,7 +5213,6 @@ void helper_msa_ ## func ## _df(CPUMIPSState *env, uint32_t df, uint32_t wd,  \
     }                                                                         \
 }
 
-MSA_TEROP_DF(dpadd_u)
 MSA_TEROP_DF(dpsub_s)
 MSA_TEROP_DF(dpsub_u)
 MSA_TEROP_DF(binsl)
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 47ac4ea..0f99768 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -29413,7 +29413,17 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
             }
             break;
         case OPC_DPADD_U_df:
-            gen_helper_msa_dpadd_u_df(cpu_env, tdf, twd, tws, twt);
+            switch (df) {
+            case DF_HALF:
+                gen_helper_msa_dpadd_u_h(cpu_env, twd, tws, twt);
+                break;
+            case DF_WORD:
+                gen_helper_msa_dpadd_u_w(cpu_env, twd, tws, twt);
+                break;
+            case DF_DOUBLE:
+                gen_helper_msa_dpadd_u_d(cpu_env, twd, tws, twt);
+                break;
+            }
             break;
         case OPC_DPSUB_S_df:
             gen_helper_msa_dpsub_s_df(cpu_env, tdf, twd, tws, twt);
-- 
2.7.4


