Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0026C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C43E2173E
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jpShrlLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C43E2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX7vP-0002OV-KA
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 14:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX7ht-0007B0-GU
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:26:45 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42666)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX7hs-0007X9-FT
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:26:45 -0400
Received: by mail-pl1-x641.google.com with SMTP id k19so1095132pll.9
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 11:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OLaptGH79qJSf/fUPP+jaZzrz3bBaRrtnif3pIsh4/Y=;
 b=jpShrlLGwdQ2koVlsRdMZAlg60yIfDcP+35JWsKwP4mOYhgUzGofm3nsE9fncvV7et
 5mYLHRpXN8HzwJOd/ofVWFcEOOcDdF2+EtzA2OWfff8fN43B577uLL3Ap+tfJBOJ8c9M
 ehdRcKoQbahyr01IN2RWIUBCfAiCe86O1NeuPd8CyfPLNQ3mZh1/qS4xygPtIdwzQdMy
 +ytxrbrEFQNGGQO4MUW/kaC+Fkhf+xdSm+yjEuu2ULA8gSF2tp+4xwKNZOV13GKaEB0T
 fuHGJ5oycRLFLLdRdE7aKq33VBmRkRuTX1hxGzsqkLUyVkQ2Mxt2iDFsBH4S9DKNxSxY
 gGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OLaptGH79qJSf/fUPP+jaZzrz3bBaRrtnif3pIsh4/Y=;
 b=i5qypjd7CtlwcexEjEKyMzmEawChYuwHScLT2MorSGXgxujRAr6+8CaNSGc1BVl4Pz
 NlXaczAn4yCDzluNUniv4w4DPzJ4ezDr1w34iJeD9pvndl6z7OvJoSoy6TSwhIqF2usN
 dKi8pzcpWpxEjixdV5eoMjRGuDo8yfFDIXHo79sleTmZRZViSGaYl/2H5hpL+RYxS2Tw
 c3IgkqdRaqS/lnAm9aH8tkPnAOX00XFG0QG8beVAf3aAefZaR68AWaUCuBIX7cOZW6YJ
 Lc47KOst+VO4KPma/Q60A55oktevXQjvjulB0WUC/55DPfI0F5TdS8uKRFHW7pJv2e3t
 /RTA==
X-Gm-Message-State: AGi0PuaOV/R7h9FJkLCBHQbJRoeU5csFUXZSqR8WHgKWNjb9sjOBHalR
 PtMPl/otETZ/GMpikaKkeO9asCsMOvc=
X-Google-Smtp-Source: APiQypK2V1jPKeXBJI3LsPaAH4LCEkr40GhVU2VNIQq/QzVyDSKq4bqPLAt1xj7dg7HxkjJ8e5UnFw==
X-Received: by 2002:a17:90b:3547:: with SMTP id
 lt7mr2319145pjb.14.1588962402807; 
 Fri, 08 May 2020 11:26:42 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id u9sm2421775pfn.197.2020.05.08.11.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 11:26:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 18/19] tcg/i386: Use tcg_constant_vec with tcg vec expanders
Date: Fri,  8 May 2020 11:26:15 -0700
Message-Id: <20200508182616.18318-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508182616.18318-1-richard.henderson@linaro.org>
References: <20200508182616.18318-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 5e73e5d02b..cce28c81d7 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -3519,7 +3519,7 @@ static void expand_vec_rotv(TCGType type, unsigned vece, TCGv_vec v0,
 static void expand_vec_mul(TCGType type, unsigned vece,
                            TCGv_vec v0, TCGv_vec v1, TCGv_vec v2)
 {
-    TCGv_vec t1, t2, t3, t4;
+    TCGv_vec t1, t2, t3, t4, zero;
 
     tcg_debug_assert(vece == MO_8);
 
@@ -3537,11 +3537,11 @@ static void expand_vec_mul(TCGType type, unsigned vece,
     case TCG_TYPE_V64:
         t1 = tcg_temp_new_vec(TCG_TYPE_V128);
         t2 = tcg_temp_new_vec(TCG_TYPE_V128);
-        tcg_gen_dup16i_vec(t2, 0);
+        zero = tcg_constant_vec(TCG_TYPE_V128, MO_8, 0);
         vec_gen_3(INDEX_op_x86_punpckl_vec, TCG_TYPE_V128, MO_8,
-                  tcgv_vec_arg(t1), tcgv_vec_arg(v1), tcgv_vec_arg(t2));
+                  tcgv_vec_arg(t1), tcgv_vec_arg(v1), tcgv_vec_arg(zero));
         vec_gen_3(INDEX_op_x86_punpckl_vec, TCG_TYPE_V128, MO_8,
-                  tcgv_vec_arg(t2), tcgv_vec_arg(t2), tcgv_vec_arg(v2));
+                  tcgv_vec_arg(t2), tcgv_vec_arg(zero), tcgv_vec_arg(v2));
         tcg_gen_mul_vec(MO_16, t1, t1, t2);
         tcg_gen_shri_vec(MO_16, t1, t1, 8);
         vec_gen_3(INDEX_op_x86_packus_vec, TCG_TYPE_V128, MO_8,
@@ -3556,15 +3556,15 @@ static void expand_vec_mul(TCGType type, unsigned vece,
         t2 = tcg_temp_new_vec(type);
         t3 = tcg_temp_new_vec(type);
         t4 = tcg_temp_new_vec(type);
-        tcg_gen_dup16i_vec(t4, 0);
+        zero = tcg_constant_vec(TCG_TYPE_V128, MO_8, 0);
         vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_8,
-                  tcgv_vec_arg(t1), tcgv_vec_arg(v1), tcgv_vec_arg(t4));
+                  tcgv_vec_arg(t1), tcgv_vec_arg(v1), tcgv_vec_arg(zero));
         vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_8,
-                  tcgv_vec_arg(t2), tcgv_vec_arg(t4), tcgv_vec_arg(v2));
+                  tcgv_vec_arg(t2), tcgv_vec_arg(zero), tcgv_vec_arg(v2));
         vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_8,
-                  tcgv_vec_arg(t3), tcgv_vec_arg(v1), tcgv_vec_arg(t4));
+                  tcgv_vec_arg(t3), tcgv_vec_arg(v1), tcgv_vec_arg(zero));
         vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_8,
-                  tcgv_vec_arg(t4), tcgv_vec_arg(t4), tcgv_vec_arg(v2));
+                  tcgv_vec_arg(t4), tcgv_vec_arg(zero), tcgv_vec_arg(v2));
         tcg_gen_mul_vec(MO_16, t1, t1, t2);
         tcg_gen_mul_vec(MO_16, t3, t3, t4);
         tcg_gen_shri_vec(MO_16, t1, t1, 8);
@@ -3592,7 +3592,7 @@ static bool expand_vec_cmp_noinv(TCGType type, unsigned vece, TCGv_vec v0,
         NEED_UMIN = 8,
         NEED_UMAX = 16,
     };
-    TCGv_vec t1, t2;
+    TCGv_vec t1, t2, t3;
     uint8_t fixup;
 
     switch (cond) {
@@ -3663,9 +3663,9 @@ static bool expand_vec_cmp_noinv(TCGType type, unsigned vece, TCGv_vec v0,
     } else if (fixup & NEED_BIAS) {
         t1 = tcg_temp_new_vec(type);
         t2 = tcg_temp_new_vec(type);
-        tcg_gen_dupi_vec(vece, t2, 1ull << ((8 << vece) - 1));
-        tcg_gen_sub_vec(vece, t1, v1, t2);
-        tcg_gen_sub_vec(vece, t2, v2, t2);
+        t3 = tcg_constant_vec(type, vece, 1ull << ((8 << vece) - 1));
+        tcg_gen_sub_vec(vece, t1, v1, t3);
+        tcg_gen_sub_vec(vece, t2, v2, t3);
         v1 = t1;
         v2 = t2;
         cond = tcg_signed_cond(cond);
-- 
2.20.1


