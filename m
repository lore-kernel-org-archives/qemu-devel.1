Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46268C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:32:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 114E22075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJhtrhTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114E22075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBakN-0002IN-8k
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacn-0004tL-Nt
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:45 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51192)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacm-0004Le-16
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:45 -0400
Received: by mail-wm1-x341.google.com with SMTP id t2so306038wma.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=MWlZ8zGrzkDTEuMxVtVOCu3a0nHyJlBFFKe1aN/nKn8=;
 b=VJhtrhTO3vnrq2IVsphidbjo5wSp4R/x/MX55FsikNDlHfndhnyElxe/9BFgWJlwV/
 uoDquycvYWM9mwu73pwi7sct6JJEH/g3nQdu8TJAz+k88OdtN2zx0RnzJ+rMVbhL84xy
 Hw5/5MB6gTH9EIosL6+jjwPh1uuHqF8Kl8xh4m6xvySyPHqLw8o63eXH/TsWjbGGTZfU
 kzRUjIkFn3HaaUUdAaUSN8OvdU/HN/3SwXFxgzpgHylz8kEJFMeH+DEjEnp7Tg0l7Gh2
 dh2XDY0LY3X2IKEaMx/vokXibq9uNL+79MintO0jsXLMZYfLX8YAwaYiSSC3DLm/hwSy
 MTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MWlZ8zGrzkDTEuMxVtVOCu3a0nHyJlBFFKe1aN/nKn8=;
 b=Wokv1VzG2caQWN+UHzAXY75d/EtY7AsQC78sT8aLnUQUs1ssSUlRKtFXBQkaNKI1iP
 Z2m6NlvLIeux8+qOaVvaQgyE85ieVa+aTuDP3Er4NQO+wVPhh/wcEhTX073C0SqdLn3p
 Ouef7OUxiU7MH7Az95dqffFJtfvrMgju+1Gd2PpJCPeCJsnKNgfHPCKVNqrAIfD0vEwA
 ieCK6Zd7so0UT3yicF30hyVJ2nurAsb2sJFVyqA7StJm1HVHqMgivoQtuCU5e+qSmoDo
 zqdXFmR4P1oHQGa8ucsOtEx0g8AaltqSn/j4rS7bRbmLh7khi7xp0kTuQBSv9Pzo9HTE
 Rdhw==
X-Gm-Message-State: AOAM531ykEwmLwb+sGqfkrHiuTTpOMixejtqAIh8b9xHmqGZKVpHHR4Y
 gQAswxlLEQrMbhEn4XOD1YjhQvY1j9F0R8u9
X-Google-Smtp-Source: ABdhPJw2Q6QzbNBph032hfvYnnKYsj3DXp1G+JPq/EpjJ4/o0rcWGImCZGRWbfOMeOdPQN2n7TK6AA==
X-Received: by 2002:a1c:7c0d:: with SMTP id x13mr692937wmc.164.1598606682263; 
 Fri, 28 Aug 2020 02:24:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/35] target/arm: Merge do_vector2_p into do_mov_p
Date: Fri, 28 Aug 2020 10:24:01 +0100
Message-Id: <20200828092413.22206-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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

This is the only user of the function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200815013145.539409-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 9a3d060c052..6dac70359b6 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -178,18 +178,6 @@ static void do_dupi_z(DisasContext *s, int rd, uint64_t word)
     tcg_gen_gvec_dup_imm(MO_64, vec_full_reg_offset(s, rd), vsz, vsz, word);
 }
 
-/* Invoke a vector expander on two Pregs.  */
-static bool do_vector2_p(DisasContext *s, GVecGen2Fn *gvec_fn,
-                         int esz, int rd, int rn)
-{
-    if (sve_access_check(s)) {
-        unsigned psz = pred_gvec_reg_size(s);
-        gvec_fn(esz, pred_full_reg_offset(s, rd),
-                pred_full_reg_offset(s, rn), psz, psz);
-    }
-    return true;
-}
-
 /* Invoke a vector expander on three Pregs.  */
 static bool do_vector3_p(DisasContext *s, GVecGen3Fn *gvec_fn,
                          int esz, int rd, int rn, int rm)
@@ -221,7 +209,12 @@ static bool do_vecop4_p(DisasContext *s, const GVecGen4 *gvec_op,
 /* Invoke a vector move on two Pregs.  */
 static bool do_mov_p(DisasContext *s, int rd, int rn)
 {
-    return do_vector2_p(s, tcg_gen_gvec_mov, 0, rd, rn);
+    if (sve_access_check(s)) {
+        unsigned psz = pred_gvec_reg_size(s);
+        tcg_gen_gvec_mov(MO_8, pred_full_reg_offset(s, rd),
+                         pred_full_reg_offset(s, rn), psz, psz);
+    }
+    return true;
 }
 
 /* Set the cpu flags as per a return from an SVE helper.  */
-- 
2.20.1


