Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AA9C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFB69208D5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sLJIx19L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB69208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBaq0-0006YY-4n
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacq-00052I-PA
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:48 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42813)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBaco-0004M0-V6
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:48 -0400
Received: by mail-wr1-x444.google.com with SMTP id c18so618589wrm.9
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=pLOsYLSLQGhbGrUxiIPuU1+9qEP5TpgYgTkWz6q1G+c=;
 b=sLJIx19LI5vmZukFWxBSc7hd+5O4o0nGbMXmtAOrEbD/v+F3vGtJljkM0n3qt/zvAk
 5giPjBk6A9Pu+mrBdSxFULGQeBf6QSmH+cZoNpP4xYU+vnJy23Nqnlx7INhC6gnihoEV
 BEGNi5Ai1O1s+EfaEfsSRcn9LVvyX8wE89EkiZupdapdfkPA8ZFwlxK42Y2eugY0Gb+D
 mA522resoHuLMoA6LtfORp9E3trR6ki7XQWlaT+K5nkmuBr7ua5c1UzqyIVxMfbY3qCA
 qvsAuvOf4FhwkhFaKt/lCZYibZRiv9h/NC0JSca0X03JnSSreMDnXpr/Sf54MHQ7x7Xh
 vixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pLOsYLSLQGhbGrUxiIPuU1+9qEP5TpgYgTkWz6q1G+c=;
 b=FKyOW89Q575ta1ChvAxJfi/I6gjpmD4MZ5a7OaDVJ1PEHcEutfuAP0s9wLJBtDXnc2
 G5+OHGP8MAfMHT/Hb9mJ/EsbNAjeXICDIiCbMrQnA/84qFui3rOakoDV6oj+iCpbESlO
 t8dVptRJl4pTw0Kb14gYH7yRupiQG1SBqqYwylanMahhrZYLe5/Xik5RjeygfzcubAgG
 9k21neSRYSA3jMPk10eaDXf+LdXIWNS4lj/b1btWdeANKSHjMQgBsht9uHe5W5uJm0TH
 PtKwM1Kb21Ai5+HeidMa0Lpi7594FmgSC0ADMK/ANPI2eFigLGFKEYg7TJD0ZWf8Wo4/
 yD2A==
X-Gm-Message-State: AOAM5329AzFAzFABjptDB5u+R74dY+JK3LkAD7ElgjUlY0NC9VLOKeU/
 M9xN6hJH76NCWujvl/MSCZLpO78nMoEXOG84
X-Google-Smtp-Source: ABdhPJx6zch39uQi0+9rjcFeq2hlLYfz1G0QmLtS7d45qnZpMPYJi6Yk+u+GsQKwg2E/xU80C954RQ==
X-Received: by 2002:adf:ee83:: with SMTP id b3mr604289wro.163.1598606685291;
 Fri, 28 Aug 2020 02:24:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/35] target/arm: Use tcg_gen_gvec_bitsel for trans_SEL_pppp
Date: Fri, 28 Aug 2020 10:24:03 +0100
Message-Id: <20200828092413.22206-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The gvec operation was added after the initial implementation
of the SEL instruction and was missed in the conversion.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200815013145.539409-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 5dfc129e73b..a747fff01f8 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -1188,34 +1188,19 @@ static bool trans_EOR_pppp(DisasContext *s, arg_rprr_s *a)
     return do_pppp_flags(s, a, &op);
 }
 
-static void gen_sel_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
-{
-    tcg_gen_and_i64(pn, pn, pg);
-    tcg_gen_andc_i64(pm, pm, pg);
-    tcg_gen_or_i64(pd, pn, pm);
-}
-
-static void gen_sel_pg_vec(unsigned vece, TCGv_vec pd, TCGv_vec pn,
-                           TCGv_vec pm, TCGv_vec pg)
-{
-    tcg_gen_and_vec(vece, pn, pn, pg);
-    tcg_gen_andc_vec(vece, pm, pm, pg);
-    tcg_gen_or_vec(vece, pd, pn, pm);
-}
-
 static bool trans_SEL_pppp(DisasContext *s, arg_rprr_s *a)
 {
-    static const GVecGen4 op = {
-        .fni8 = gen_sel_pg_i64,
-        .fniv = gen_sel_pg_vec,
-        .fno = gen_helper_sve_sel_pppp,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-    };
-
     if (a->s) {
         return false;
     }
-    return do_pppp_flags(s, a, &op);
+    if (sve_access_check(s)) {
+        unsigned psz = pred_gvec_reg_size(s);
+        tcg_gen_gvec_bitsel(MO_8, pred_full_reg_offset(s, a->rd),
+                            pred_full_reg_offset(s, a->pg),
+                            pred_full_reg_offset(s, a->rn),
+                            pred_full_reg_offset(s, a->rm), psz, psz);
+    }
+    return true;
 }
 
 static void gen_orr_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
-- 
2.20.1


