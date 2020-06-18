Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E9CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:35:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85BEC2067D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iSNvsbF7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85BEC2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmGj-00013r-Dg
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm9N-0003Dd-6V
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:27:41 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43158)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm9G-0002R8-UL
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:27:40 -0400
Received: by mail-pl1-x641.google.com with SMTP id g12so1898900pll.10
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LZL+dDMhzUt93arvpWQQJPSTREHQqTYfTwzJjttMTfc=;
 b=iSNvsbF77Gs3ZEB4ZL0L3TJ6R9mD8vfmYlDEA08drQ+UL+gf9XvNABdK8LhALR2HHa
 wymk4P2IMvX3Cr1IIWuy0usxOlh1pSqnUkulhhNCEWNQ3+BM1v2PViH+ahhDeO8pIh6i
 SB5qLRfYKNNp2iDiWV2moNOvBckB/vp5tstEqcdSQUAIhM3AkdXLgX62MX1O5vhzPfrs
 wygBVxZ1ods5RM1P2bo3rkV4vhOg1KAw4BDNWT6jQtUsyfXKXB2xoosvmOdXktOl/7t+
 YwJ+LLhd9f6svrDZz2XKgS0MxgqgfWnCBAflsCQQQ4C43jsQE7tvNO5afRBFRVjbBoPM
 4eyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LZL+dDMhzUt93arvpWQQJPSTREHQqTYfTwzJjttMTfc=;
 b=j4VGLArVFdYw3FRfd/KUhU96Qm2AGE6FSP4d5Tg626ILNPDUB6erM3pbx7Zl6cl9Iu
 5IMAFiMXaqk+jlNfkHzNT51Sj9KI+ob8Qrw58sJDzNicfhzbIYu1qPjB10HgR8wd8LZY
 7ZSQsERHj7IH0OW1SbdmaWjVA7GkCtj0GiEDKjNulOQPZq6RXyYqX0H4wBUSCk7Yt1Ga
 gFFJ21z7GhCbPOQeF8Bs8tg/ByAyfN3j1HJPW5JsvUnx7WblY1tim27/QUDqN8rZ+wyU
 324rPDwBM6Uzs/cdyubidGo4XxdadtnLiDg2+R/J8epy6xRXDOfXWPgjtoDt43UG5O9L
 kwnA==
X-Gm-Message-State: AOAM533pMTGO7DPbXluRGLquyquDRARZ0pz+WjtxO7BCuOo/2bk9dXfh
 r3VCk4CKp9zCEx8v1Q71eJm5xA5CMUA=
X-Google-Smtp-Source: ABdhPJyYzJ2y+PCl9ZyInwEwaMglzqBdjxdBHUkD1zAU+9ZhNHOg+iu1QSExWC5H0eQBV79c+Glk1g==
X-Received: by 2002:a17:902:744b:: with SMTP id
 e11mr2063612plt.71.1592454453256; 
 Wed, 17 Jun 2020 21:27:33 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id u61sm964897pjb.7.2020.06.17.21.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:27:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 012/100] target/arm: Split out gen_gvec_ool_zzz
Date: Wed, 17 Jun 2020 21:25:16 -0700
Message-Id: <20200618042644.1685561-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 53 +++++++++++++-------------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 3e9bbaca94..6bdd62d4f2 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -142,6 +142,17 @@ static int pred_gvec_reg_size(DisasContext *s)
     return size_for_gvec(pred_full_reg_size(s));
 }
 
+/* Invoke an out-of-line helper on 3 Zregs. */
+static void gen_gvec_ool_zzz(DisasContext *s, gen_helper_gvec_3 *fn,
+                             int rd, int rn, int rm, int data)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    tcg_gen_gvec_3_ool(vec_full_reg_offset(s, rd),
+                       vec_full_reg_offset(s, rn),
+                       vec_full_reg_offset(s, rm),
+                       vsz, vsz, data, fn);
+}
+
 /* Invoke an out-of-line helper on 2 Zregs and a predicate. */
 static void gen_gvec_ool_zzp(DisasContext *s, gen_helper_gvec_3 *fn,
                              int rd, int rn, int pg, int data)
@@ -769,11 +780,7 @@ static bool do_zzw_ool(DisasContext *s, arg_rrr_esz *a, gen_helper_gvec_3 *fn)
         return false;
     }
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           vec_full_reg_offset(s, a->rm),
-                           vsz, vsz, 0, fn);
+        gen_gvec_ool_zzz(s, fn, a->rd, a->rn, a->rm, 0);
     }
     return true;
 }
@@ -947,11 +954,7 @@ static bool trans_RDVL(DisasContext *s, arg_RDVL *a)
 static bool do_adr(DisasContext *s, arg_rrri *a, gen_helper_gvec_3 *fn)
 {
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           vec_full_reg_offset(s, a->rm),
-                           vsz, vsz, a->imm, fn);
+        gen_gvec_ool_zzz(s, fn, a->rd, a->rn, a->rm, a->imm);
     }
     return true;
 }
@@ -1012,11 +1015,7 @@ static bool trans_FTSSEL(DisasContext *s, arg_rrr_esz *a)
         return false;
     }
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           vec_full_reg_offset(s, a->rm),
-                           vsz, vsz, 0, fns[a->esz]);
+        gen_gvec_ool_zzz(s, fns[a->esz], a->rd, a->rn, a->rm, 0);
     }
     return true;
 }
@@ -2067,11 +2066,7 @@ static bool trans_TBL(DisasContext *s, arg_rrr_esz *a)
     };
 
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           vec_full_reg_offset(s, a->rm),
-                           vsz, vsz, 0, fns[a->esz]);
+        gen_gvec_ool_zzz(s, fns[a->esz], a->rd, a->rn, a->rm, 0);
     }
     return true;
 }
@@ -2244,11 +2239,7 @@ static bool do_zzz_data_ool(DisasContext *s, arg_rrr_esz *a, int data,
                             gen_helper_gvec_3 *fn)
 {
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           vec_full_reg_offset(s, a->rm),
-                           vsz, vsz, data, fn);
+        gen_gvec_ool_zzz(s, fn, a->rd, a->rn, a->rm, data);
     }
     return true;
 }
@@ -3373,11 +3364,7 @@ static bool trans_DOT_zzz(DisasContext *s, arg_DOT_zzz *a)
     };
 
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           vec_full_reg_offset(s, a->rm),
-                           vsz, vsz, 0, fns[a->u][a->sz]);
+        gen_gvec_ool_zzz(s, fns[a->u][a->sz], a->rd, a->rn, a->rm, 0);
     }
     return true;
 }
@@ -3390,11 +3377,7 @@ static bool trans_DOT_zzx(DisasContext *s, arg_DOT_zzx *a)
     };
 
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           vec_full_reg_offset(s, a->rm),
-                           vsz, vsz, a->index, fns[a->u][a->sz]);
+        gen_gvec_ool_zzz(s, fns[a->u][a->sz], a->rd, a->rn, a->rm, a->index);
     }
     return true;
 }
-- 
2.25.1


