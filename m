Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D08C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33CB92081C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lI+ZCsSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33CB92081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36653 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLhnT-0000FE-HU
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 01:28:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRn-0006mf-5N
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRk-00036B-4k
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:23 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:39747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRj-00035g-Uv
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:20 -0400
Received: by mail-pl1-x62a.google.com with SMTP id e92so7750733plb.6
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=a21zCVCqlzAtHHyCClfYkOw1IN8eWmtRYOfzkfNSAPM=;
	b=lI+ZCsSCRXehjcQIaioXtGb36Bh1J7W4lYamcvkF6MGQM0OCr4osxnh4lQ6zoj22Mr
	LMuq8PUhEJD0nTjBd30SvLPhV8fcS2nqPZfkdkDCxtLYJdUk5vl+kua/PjIpTsvR7mX5
	wPERvQ+V3FKVXHo9vSLNiBPLWPHYguF8HCIhiY3J9iuZQm5SF+rh5bWuJBkpVQNu6Avt
	OvfveOpBJdMnXFO5Tk59FXnttk3upPNSDhsnGb/HDk3PIDZXoeGMbFL4iZs8V/fSVHpa
	fDtT/VV9SIpsolsIUYL660lFtsgCvV1qAAYKyip1M82f8LL+cgIr6srnSy8PUsvke+Kl
	cplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=a21zCVCqlzAtHHyCClfYkOw1IN8eWmtRYOfzkfNSAPM=;
	b=TCjCbPBwUN1Kt5oL6bzC9jxR56IwCy1yhEKlJv/Mzuvmqj6NaGjzxhq3OItYbsffln
	IGrwCzFsfUp4EaX0xdzyMznlyu3uVO3SUhiMN2J/m8wx59f+ibbdfW6hYm3W3e4WN1iK
	EtUmUz8zvMG1eA8HTULvNibTRsSlXJHKC+d9avcgeGDpyTsIagsBt4x8ZNUS5yg6E52/
	pb2blgsnLa62TcXkFaN4ozWibHCqhTK0isDV40eMSz5+hFz/5NGm9lkfuuF/YEHj9Sym
	rIo65/Vyg75l7l0ETnAftwnXp+Hhv/STmfEF8tzSGkdyi3wzmnnS50/6ywvhv25YFPM4
	Ut8A==
X-Gm-Message-State: APjAAAWDWDcF4EfBKZezTqFo8C6V1Ji6L0fJOrpNJdTx8sdZEFFRHYo3
	G4aHY9lGVP+Azy5CyJWTvUhT00HPDKo=
X-Google-Smtp-Source: APXvYqx3WaUuggUf+F6oaQZBXkez2un7kbYBIjQO+j0XT5ACXZFn71J/5HizbkHMeNEGj10IEwcHqw==
X-Received: by 2002:a17:902:4101:: with SMTP id
	e1mr77183560pld.25.1556687178692; 
	Tue, 30 Apr 2019 22:06:18 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	t127sm9687251pfb.106.2019.04.30.22.06.17
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 22:06:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 22:05:35 -0700
Message-Id: <20190501050536.15580-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501050536.15580-1-richard.henderson@linaro.org>
References: <20190501050536.15580-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::62a
Subject: [Qemu-devel] [PATCH v2 28/29] target/tricore: Use tcg_gen_abs_tl
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501050535.BbAi6WLewxRWgtCxirOYJiYK0bem3VHq64atGTGVV7k@z>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20190423102145.14812-3-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/tricore/translate.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 8f6416144e..06c4485e55 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -2415,11 +2415,7 @@ gen_msubadr32s_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
 
 static inline void gen_abs(TCGv ret, TCGv r1)
 {
-    TCGv temp = tcg_temp_new();
-    TCGv t0 = tcg_const_i32(0);
-
-    tcg_gen_neg_tl(temp, r1);
-    tcg_gen_movcond_tl(TCG_COND_GE, ret, r1, t0, r1, temp);
+    tcg_gen_abs_tl(ret, r1);
     /* overflow can only happen, if r1 = 0x80000000 */
     tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_PSW_V, r1, 0x80000000);
     tcg_gen_shli_tl(cpu_PSW_V, cpu_PSW_V, 31);
@@ -2430,9 +2426,6 @@ static inline void gen_abs(TCGv ret, TCGv r1)
     tcg_gen_xor_tl(cpu_PSW_AV, ret, cpu_PSW_AV);
     /* calc SAV bit */
     tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
-
-    tcg_temp_free(temp);
-    tcg_temp_free(t0);
 }
 
 static inline void gen_absdif(TCGv ret, TCGv r1, TCGv r2)
@@ -6617,13 +6610,8 @@ static void decode_rr_divide(CPUTriCoreState *env, DisasContext *ctx)
         tcg_gen_movi_tl(cpu_PSW_AV, 0);
         if (!tricore_feature(env, TRICORE_FEATURE_131)) {
             /* overflow = (abs(D[r3+1]) >= abs(D[r2])) */
-            tcg_gen_neg_tl(temp, temp3);
-            /* use cpu_PSW_AV to compare against 0 */
-            tcg_gen_movcond_tl(TCG_COND_LT, temp, temp3, cpu_PSW_AV,
-                               temp, temp3);
-            tcg_gen_neg_tl(temp2, cpu_gpr_d[r2]);
-            tcg_gen_movcond_tl(TCG_COND_LT, temp2, cpu_gpr_d[r2], cpu_PSW_AV,
-                               temp2, cpu_gpr_d[r2]);
+            tcg_gen_abs_tl(temp, temp3);
+            tcg_gen_abs_tl(temp2, cpu_gpr_d[r2]);
             tcg_gen_setcond_tl(TCG_COND_GE, cpu_PSW_V, temp, temp2);
         } else {
             /* overflow = (D[b] == 0) */
@@ -6655,13 +6643,8 @@ static void decode_rr_divide(CPUTriCoreState *env, DisasContext *ctx)
         tcg_gen_movi_tl(cpu_PSW_AV, 0);
         if (!tricore_feature(env, TRICORE_FEATURE_131)) {
             /* overflow = (abs(D[r3+1]) >= abs(D[r2])) */
-            tcg_gen_neg_tl(temp, temp3);
-            /* use cpu_PSW_AV to compare against 0 */
-            tcg_gen_movcond_tl(TCG_COND_LT, temp, temp3, cpu_PSW_AV,
-                               temp, temp3);
-            tcg_gen_neg_tl(temp2, cpu_gpr_d[r2]);
-            tcg_gen_movcond_tl(TCG_COND_LT, temp2, cpu_gpr_d[r2], cpu_PSW_AV,
-                               temp2, cpu_gpr_d[r2]);
+            tcg_gen_abs_tl(temp, temp3);
+            tcg_gen_abs_tl(temp2, cpu_gpr_d[r2]);
             tcg_gen_setcond_tl(TCG_COND_GE, cpu_PSW_V, temp, temp2);
         } else {
             /* overflow = (D[b] == 0) */
-- 
2.17.1


