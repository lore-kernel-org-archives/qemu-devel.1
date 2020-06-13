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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D25DC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 15:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB1DD2078A
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 15:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="si59/GC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1DD2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jk8BP-00019n-2b
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 11:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jk7z3-0001Tg-SV
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 11:22:13 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:34827)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jk7z1-0002o1-Vw
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 11:22:13 -0400
Received: by mail-wm1-x329.google.com with SMTP id q25so10650881wmj.0
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2020 08:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NQjFJdWuFw8eLqcFkHl+IhX0r/S4J/dMRQ5TJLbrRco=;
 b=si59/GC7WNa1Isv4K/O6xw+WboyMIEU4qzQoNVRyX/TgDYPEHeZDT+N7S884yid/lW
 4QOo/6MFhgzSwXoQjRA+hQSDLmjoFY1KbmXxR6qvu8eCs2uzJ/XIfGM4elGbK4OhpIxD
 7/Wpi28bDSbv9dlmydMQVoRimEy0WCRv89mrjW3MA34vrdi93ovHRc1sbxPa6g3BVsfy
 Wih6vJqKVd5UX8lwRFfBSnivpAf+SROrit/jO7OY9PhRhGCBzwWC2iMXdD/440xpvj07
 6PT1jQ5obs+rKYHyw/2w5ydHnYs0SM2IYjkZjA8/wLXLlRuOcBBjkXNJmx6SC7ackM9W
 nLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NQjFJdWuFw8eLqcFkHl+IhX0r/S4J/dMRQ5TJLbrRco=;
 b=hvGNZLPhbeqOysbtIIKh4x6EwYKeXuhS5ymC9TOT+s6Gi79Lqc+9aR8F3gBp5bhnzn
 eMv+//oCOLhCygv/AsUpwECJ0XvdcZ3LsOLNFYhksuhnIsyf6+gYxods2HoZ/nabifx4
 3/btTNyb3BzLMIKpiL7wd4iE/UvoNW1MRUjdhckcRenYz8UQtCi7hXSpItLIbd4AoqDx
 SptvIuXHX7v6NpTeZG6YE0BrGLH0AIcoacL4KhCQMHrzFe4BhV72EFilyn3xv9iv5t6j
 dd4ObVUFhpyq9UNUIE9NPsqHqJXYz2BfrbkhZUlDTqd+5tzo5y1531wg9ODuyWOtX1Ak
 31Pg==
X-Gm-Message-State: AOAM5315cfIetNSsj3fePu6l87tBfTiEXXH5He95fQY0mg9HdchVR+32
 Wys9QPms0BEk7oC++K9AiI7nFioIQyY=
X-Google-Smtp-Source: ABdhPJyRk/GteEqiHmXQ0s7SEQBNbsLZOpr9Ubk3WistJsCD+/YFvMy9fqh2jGaY8cNWn2fJ6Eo7Sg==
X-Received: by 2002:a1c:9993:: with SMTP id b141mr4044682wme.113.1592061725372; 
 Sat, 13 Jun 2020 08:22:05 -0700 (PDT)
Received: from localhost.localdomain (net212-32-245-109.mbb.telenor.rs.
 [109.245.32.212])
 by smtp.gmail.com with ESMTPSA id 67sm16045399wrk.49.2020.06.13.08.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2020 08:22:04 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 14/14] target/mips: msa: Split helpers for MULV.<B|H|W|D>
Date: Sat, 13 Jun 2020 17:21:33 +0200
Message-Id: <20200613152133.8964-15-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200613152133.8964-1-aleksandar.qemu.devel@gmail.com>
References: <20200613152133.8964-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x329.google.com
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
 target/mips/msa_helper.c | 79 ++++++++++++++++++++++++++++++++++++----
 target/mips/translate.c  | 15 +++++++-
 3 files changed, 91 insertions(+), 9 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 5d7ba6a847..e97655dc0e 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -960,6 +960,11 @@ DEF_HELPER_4(msa_msubv_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_msubv_w, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_msubv_d, void, env, i32, i32, i32)
 
+DEF_HELPER_4(msa_mulv_b, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_mulv_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_mulv_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_mulv_d, void, env, i32, i32, i32)
+
 DEF_HELPER_4(msa_asub_s_b, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_asub_s_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_asub_s_w, void, env, i32, i32, i32)
@@ -1098,7 +1103,6 @@ DEF_HELPER_5(msa_srlri_df, void, env, i32, i32, i32, i32)
 
 DEF_HELPER_5(msa_binsl_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_binsr_df, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(msa_mulv_df, void, env, i32, i32, i32, i32)
 
 DEF_HELPER_4(msa_dotp_s_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_dotp_s_w, void, env, i32, i32, i32)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index d099e00b40..6865addaf6 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -3360,6 +3360,78 @@ void helper_msa_msubv_d(CPUMIPSState *env,
 }
 
 
+static inline int64_t msa_mulv_df(uint32_t df, int64_t arg1, int64_t arg2)
+{
+    return arg1 * arg2;
+}
+
+void helper_msa_mulv_b(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->b[0]  = msa_mulv_df(DF_BYTE, pws->b[0],  pwt->b[0]);
+    pwd->b[1]  = msa_mulv_df(DF_BYTE, pws->b[1],  pwt->b[1]);
+    pwd->b[2]  = msa_mulv_df(DF_BYTE, pws->b[2],  pwt->b[2]);
+    pwd->b[3]  = msa_mulv_df(DF_BYTE, pws->b[3],  pwt->b[3]);
+    pwd->b[4]  = msa_mulv_df(DF_BYTE, pws->b[4],  pwt->b[4]);
+    pwd->b[5]  = msa_mulv_df(DF_BYTE, pws->b[5],  pwt->b[5]);
+    pwd->b[6]  = msa_mulv_df(DF_BYTE, pws->b[6],  pwt->b[6]);
+    pwd->b[7]  = msa_mulv_df(DF_BYTE, pws->b[7],  pwt->b[7]);
+    pwd->b[8]  = msa_mulv_df(DF_BYTE, pws->b[8],  pwt->b[8]);
+    pwd->b[9]  = msa_mulv_df(DF_BYTE, pws->b[9],  pwt->b[9]);
+    pwd->b[10] = msa_mulv_df(DF_BYTE, pws->b[10], pwt->b[10]);
+    pwd->b[11] = msa_mulv_df(DF_BYTE, pws->b[11], pwt->b[11]);
+    pwd->b[12] = msa_mulv_df(DF_BYTE, pws->b[12], pwt->b[12]);
+    pwd->b[13] = msa_mulv_df(DF_BYTE, pws->b[13], pwt->b[13]);
+    pwd->b[14] = msa_mulv_df(DF_BYTE, pws->b[14], pwt->b[14]);
+    pwd->b[15] = msa_mulv_df(DF_BYTE, pws->b[15], pwt->b[15]);
+}
+
+void helper_msa_mulv_h(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->h[0]  = msa_mulv_df(DF_HALF, pws->h[0],  pwt->h[0]);
+    pwd->h[1]  = msa_mulv_df(DF_HALF, pws->h[1],  pwt->h[1]);
+    pwd->h[2]  = msa_mulv_df(DF_HALF, pws->h[2],  pwt->h[2]);
+    pwd->h[3]  = msa_mulv_df(DF_HALF, pws->h[3],  pwt->h[3]);
+    pwd->h[4]  = msa_mulv_df(DF_HALF, pws->h[4],  pwt->h[4]);
+    pwd->h[5]  = msa_mulv_df(DF_HALF, pws->h[5],  pwt->h[5]);
+    pwd->h[6]  = msa_mulv_df(DF_HALF, pws->h[6],  pwt->h[6]);
+    pwd->h[7]  = msa_mulv_df(DF_HALF, pws->h[7],  pwt->h[7]);
+}
+
+void helper_msa_mulv_w(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->w[0]  = msa_mulv_df(DF_WORD, pws->w[0],  pwt->w[0]);
+    pwd->w[1]  = msa_mulv_df(DF_WORD, pws->w[1],  pwt->w[1]);
+    pwd->w[2]  = msa_mulv_df(DF_WORD, pws->w[2],  pwt->w[2]);
+    pwd->w[3]  = msa_mulv_df(DF_WORD, pws->w[3],  pwt->w[3]);
+}
+
+void helper_msa_mulv_d(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0]  = msa_mulv_df(DF_DOUBLE, pws->d[0],  pwt->d[0]);
+    pwd->d[1]  = msa_mulv_df(DF_DOUBLE, pws->d[1],  pwt->d[1]);
+}
+
+
 /*
  * Int Subtract
  * ------------
@@ -5444,11 +5516,6 @@ MSA_TEROP_IMMU_DF(binsli, binsl)
 MSA_TEROP_IMMU_DF(binsri, binsr)
 #undef MSA_TEROP_IMMU_DF
 
-static inline int64_t msa_mulv_df(uint32_t df, int64_t arg1, int64_t arg2)
-{
-    return arg1 * arg2;
-}
-
 #define CONCATENATE_AND_SLIDE(s, k)             \
     do {                                        \
         for (i = 0; i < s; i++) {               \
@@ -5566,8 +5633,6 @@ void helper_msa_ ## func ## _df(CPUMIPSState *env, uint32_t df,         \
     }                                                                   \
 }
 
-MSA_BINOP_DF(mulv)
-
 MSA_BINOP_DF(mul_q)
 MSA_BINOP_DF(mulr_q)
 #undef MSA_BINOP_DF
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 6a6df58d29..8fe79cc4ca 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -29314,7 +29314,20 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case OPC_MULV_df:
-        gen_helper_msa_mulv_df(cpu_env, tdf, twd, tws, twt);
+        switch (df) {
+        case DF_BYTE:
+            gen_helper_msa_mulv_b(cpu_env, twd, tws, twt);
+            break;
+        case DF_HALF:
+            gen_helper_msa_mulv_h(cpu_env, twd, tws, twt);
+            break;
+        case DF_WORD:
+            gen_helper_msa_mulv_w(cpu_env, twd, tws, twt);
+            break;
+        case DF_DOUBLE:
+            gen_helper_msa_mulv_d(cpu_env, twd, tws, twt);
+            break;
+        }
         break;
     case OPC_SLD_df:
         gen_helper_msa_sld_df(cpu_env, tdf, twd, tws, twt);
-- 
2.20.1


