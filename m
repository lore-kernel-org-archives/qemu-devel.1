Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88482C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 10:25:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E2D321738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 10:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9mv2PE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2D321738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51280 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIsbz-00066f-HF
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 06:25:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hIsYl-0003Zc-Bj
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:21:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hIsYh-0005tK-Uh
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:21:53 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hIsYh-0005sd-55; Tue, 23 Apr 2019 06:21:51 -0400
Received: by mail-wm1-x342.google.com with SMTP id o25so17968142wmf.5;
	Tue, 23 Apr 2019 03:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ySd4AUfqBNWvA2Z6t9UrsK4PMBuGSvwY8aBGM960t1k=;
	b=b9mv2PE5HAAI6hPtiXjtuazWP+/lZ2qjkXnATF0MHj8P28H0eH4wxewukbqV6I8FAT
	ckBOjHfmFtVrBY71xZChb5ls19yJFBo5IsbzfdTkO6Purg2EI+VqLJDS1l0in6wQV7+3
	nuqk84knBvtJITuLHOTMBKiN8eCtyLWOJx+qecJl120j7JfPFkuvmcEIlV5rI2iMnY49
	mqyIntNFQx1stjQEAxpfoaFZYmVIP2noolH3jN53gU3uM5X3PhUHZLasn52PHdHV5BRu
	eAhMjco5jRZ3KcYm80PhOTOUEty8SY3HySq3jt7w1D1jNUlVQ70usURZA/1VExXKJ0xf
	x/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=ySd4AUfqBNWvA2Z6t9UrsK4PMBuGSvwY8aBGM960t1k=;
	b=gLWw+ZPsnSbwho5Qzz687otgm8VbsMaLgK2CKcyHC3vkn62afLwwGE752ky7TKE8Vs
	wHiiJ9qkG2Tcdd/BrE8Euhy/bKtuj0liWfCAfLmSrVI/UgJIhP0kRFPcHCH01cwv2q9A
	I51LncrmJ2u6876ziMROgsg7LRS6E4WMNYIOH4g8evby5jaEISbzMUVWPkJVkRlP1Wie
	MfiPkMME/AkYUV/bU1mQuf5oWHjJAf8ntcVCdehPpeMen9gVpBhbjnAjbId/ezvZLluF
	iViMySfqegvgl295LDAdD4pV3Qg4PKhlLVdfVqiJG/Ui/w4cvJVrFm/Ew0cmBRxwVPZr
	1VlA==
X-Gm-Message-State: APjAAAWyad1UkIkxOT4ffD0Mm0+gseeDzYvrtbGHddEvSx/JzqvjWHKU
	5VYfANP+IvI/89yKWt9YCq8=
X-Google-Smtp-Source: APXvYqxQSFzlu7AP/N3WOMU5TQS+gy7ZKkHozYCgisdMUDagApkTcsBFV1hvvNdlzl1aAGq8ELgcTg==
X-Received: by 2002:a1c:2246:: with SMTP id i67mr1716345wmi.148.1556014910199; 
	Tue, 23 Apr 2019 03:21:50 -0700 (PDT)
Received: from x1.local (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	j190sm17934653wmb.19.2019.04.23.03.21.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 03:21:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 12:21:45 +0200
Message-Id: <20190423102145.14812-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190423102145.14812-1-f4bug@amsat.org>
References: <20190423102145.14812-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH 2/2] target/tricore: Use tcg_gen_abs_tl
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423102145.HXJoUlbRyhsuO069bgb7Xfi9qCmc88jVRQMZh3fv-lM@z>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/tricore/translate.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index b12c391be5..e0692e9018 100644
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
2.19.1


