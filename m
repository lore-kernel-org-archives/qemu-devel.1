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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C588DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 17:03:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9072120801
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 17:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsDRTfW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9072120801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjn5A-0007iq-QD
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 13:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjn2B-0002OB-6n
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 13:00:03 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:39462)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjn29-0002gl-3y
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 13:00:02 -0400
Received: by mail-wr1-x432.google.com with SMTP id t18so10449291wru.6
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 09:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Kt8b8LurUGGd2vw4sKhwFyJB+XWGk3iJ2cYFa6ucIZ8=;
 b=FsDRTfW7YMmofisffN1bWpzcUKwkni77tewnHl2aiDZIupPfHrSZZn0U6obY6smd5o
 x2z3l4bznMsTNw6WDOCsX6i5vNfuJpSnOL9zGYC8Vufr9pDU8o2K09u9bcwx4HsGs3nY
 t1oUVZU2yp3pi1yf4bY+FRphu6us+Y79ERS6T/JYe7aarzWSDxOEH4WJU4hUesccLDHp
 xIt5exri98Dr06CPyXbXIzbfKnpuDUxa1kA078wvWd7S5kwQgpcg3f1D+tWzUPs8mC2S
 6TxCmuv/5jM480S4J+q2Cd2WEhOCAJlaZZyzuaaSzAVrnw9hoXbbvPAJ/OJxqTXOjLhK
 G0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Kt8b8LurUGGd2vw4sKhwFyJB+XWGk3iJ2cYFa6ucIZ8=;
 b=HI42S4BVv4xB3NoVQcFbtDMfOmZaG2Chyi7DFXOkL7xZ5RG9rLDr5VEgDKPGrpQtVJ
 aIif8sj+P18mETuhFz6jo1mAW/KeGW7/0Gs7EvhwPtXYSjg7Hr41ZjMCzrI62mlsexn5
 FzvE0l6I3ayEmGdmdYt1gX7m21DVFix2RXEXlXlJEli/HKHaXJelhTeabz5sPpSYOMT5
 mPh2NMcvvkvU9f52xRF6l0hkCl+nodtuqSCSCxBFFVCoNJIoLS0lznzIjZ12L18tHdTp
 D8ayhe08UKQJWE5q0xTCX6Tcvwgcaapplt8jbBu2Vy0nhrvtqKi9Oq6SEwLT+SQeuqcs
 k1Gw==
X-Gm-Message-State: AOAM531oRL6RS93kMt3MJ8rq0YwXYHa+EUhRIofcbLc4vn2TkDYjPBoz
 98aVvoxJEQjOj0REsF31S0WYhpvhIe4=
X-Google-Smtp-Source: ABdhPJxlz5uP5x310WYiBwp6RR4ES8ZTKUSTqwV6bUJu9RzmKYzHgUzSsiQH2RMdYp9/0J6HGbeUGQ==
X-Received: by 2002:a5d:4bc5:: with SMTP id l5mr16187707wrt.104.1591981193623; 
 Fri, 12 Jun 2020 09:59:53 -0700 (PDT)
Received: from localhost.localdomain (net212-32-245-109.mbb.telenor.rs.
 [109.245.32.212])
 by smtp.gmail.com with ESMTPSA id f185sm9923653wmf.43.2020.06.12.09.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 09:59:53 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 8/8] target/mips: msa: Split helpers for DOTP_U.<H|W|D>
Date: Fri, 12 Jun 2020 18:59:07 +0200
Message-Id: <20200612165907.1272-9-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200612165907.1272-1-aleksandar.qemu.devel@gmail.com>
References: <20200612165907.1272-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x432.google.com
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
 target/mips/msa_helper.c | 65 ++++++++++++++++++++++++++++++++--------
 target/mips/translate.c  | 12 +++++++-
 3 files changed, 67 insertions(+), 14 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 06df3de744..05d5533dfb 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -1083,7 +1083,9 @@ DEF_HELPER_5(msa_mulv_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_4(msa_dotp_s_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_dotp_s_w, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_dotp_s_d, void, env, i32, i32, i32)
-DEF_HELPER_5(msa_dotp_u_df, void, env, i32, i32, i32, i32)
+DEF_HELPER_4(msa_dotp_u_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_dotp_u_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_dotp_u_d, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_dpadd_s_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_dpadd_s_w, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_dpadd_s_d, void, env, i32, i32, i32)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 201283fdd9..84d0073918 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -2290,6 +2290,59 @@ void helper_msa_dotp_s_d(CPUMIPSState *env,
 }
 
 
+static inline int64_t msa_dotp_u_df(uint32_t df, int64_t arg1, int64_t arg2)
+{
+    int64_t even_arg1;
+    int64_t even_arg2;
+    int64_t odd_arg1;
+    int64_t odd_arg2;
+    UNSIGNED_EXTRACT(even_arg1, odd_arg1, arg1, df);
+    UNSIGNED_EXTRACT(even_arg2, odd_arg2, arg2, df);
+    return (even_arg1 * even_arg2) + (odd_arg1 * odd_arg2);
+}
+
+void helper_msa_dotp_u_h(CPUMIPSState *env,
+                         uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->h[0]  = msa_dotp_u_df(DF_HALF, pws->h[0],  pwt->h[0]);
+    pwd->h[1]  = msa_dotp_u_df(DF_HALF, pws->h[1],  pwt->h[1]);
+    pwd->h[2]  = msa_dotp_u_df(DF_HALF, pws->h[2],  pwt->h[2]);
+    pwd->h[3]  = msa_dotp_u_df(DF_HALF, pws->h[3],  pwt->h[3]);
+    pwd->h[4]  = msa_dotp_u_df(DF_HALF, pws->h[4],  pwt->h[4]);
+    pwd->h[5]  = msa_dotp_u_df(DF_HALF, pws->h[5],  pwt->h[5]);
+    pwd->h[6]  = msa_dotp_u_df(DF_HALF, pws->h[6],  pwt->h[6]);
+    pwd->h[7]  = msa_dotp_u_df(DF_HALF, pws->h[7],  pwt->h[7]);
+}
+
+void helper_msa_dotp_u_w(CPUMIPSState *env,
+                         uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->w[0]  = msa_dotp_u_df(DF_WORD, pws->w[0],  pwt->w[0]);
+    pwd->w[1]  = msa_dotp_u_df(DF_WORD, pws->w[1],  pwt->w[1]);
+    pwd->w[2]  = msa_dotp_u_df(DF_WORD, pws->w[2],  pwt->w[2]);
+    pwd->w[3]  = msa_dotp_u_df(DF_WORD, pws->w[3],  pwt->w[3]);
+}
+
+void helper_msa_dotp_u_d(CPUMIPSState *env,
+                         uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0]  = msa_dotp_u_df(DF_DOUBLE, pws->d[0],  pwt->d[0]);
+    pwd->d[1]  = msa_dotp_u_df(DF_DOUBLE, pws->d[1],  pwt->d[1]);
+}
+
+
 static inline int64_t msa_dpadd_s_df(uint32_t df, int64_t dest, int64_t arg1,
                                      int64_t arg2)
 {
@@ -5064,17 +5117,6 @@ static inline int64_t msa_mulv_df(uint32_t df, int64_t arg1, int64_t arg2)
     return arg1 * arg2;
 }
 
-static inline int64_t msa_dotp_u_df(uint32_t df, int64_t arg1, int64_t arg2)
-{
-    int64_t even_arg1;
-    int64_t even_arg2;
-    int64_t odd_arg1;
-    int64_t odd_arg2;
-    UNSIGNED_EXTRACT(even_arg1, odd_arg1, arg1, df);
-    UNSIGNED_EXTRACT(even_arg2, odd_arg2, arg2, df);
-    return (even_arg1 * even_arg2) + (odd_arg1 * odd_arg2);
-}
-
 #define CONCATENATE_AND_SLIDE(s, k)             \
     do {                                        \
         for (i = 0; i < s; i++) {               \
@@ -5198,7 +5240,6 @@ MSA_BINOP_DF(subs_u)
 MSA_BINOP_DF(subsus_u)
 MSA_BINOP_DF(subsuu_s)
 MSA_BINOP_DF(mulv)
-MSA_BINOP_DF(dotp_u)
 
 MSA_BINOP_DF(mul_q)
 MSA_BINOP_DF(mulr_q)
diff --git a/target/mips/translate.c b/target/mips/translate.c
index f0bab46378..b56bdf54af 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -29406,7 +29406,17 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
             }
             break;
         case OPC_DOTP_U_df:
-            gen_helper_msa_dotp_u_df(cpu_env, tdf, twd, tws, twt);
+            switch (df) {
+            case DF_HALF:
+                gen_helper_msa_dotp_u_h(cpu_env, twd, tws, twt);
+                break;
+            case DF_WORD:
+                gen_helper_msa_dotp_u_w(cpu_env, twd, tws, twt);
+                break;
+            case DF_DOUBLE:
+                gen_helper_msa_dotp_u_d(cpu_env, twd, tws, twt);
+                break;
+            }
             break;
         case OPC_DPADD_S_df:
             switch (df) {
-- 
2.20.1


