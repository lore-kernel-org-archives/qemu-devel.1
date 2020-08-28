Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F3CC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B49D52075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCbmiexA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49D52075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBalk-0005Z6-06
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacj-0004h1-Ff
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:41 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34384)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBach-0004Kz-Og
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:41 -0400
Received: by mail-wr1-x443.google.com with SMTP id f7so640965wrw.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/e5J1WsCAl3VazC9uY1P3J1kjcwirQS7CBU+doQWHjY=;
 b=aCbmiexApt6Y9R4mAV35KE162c7DN1itt0UKatj2k694mj8/5JOGIrKY9WGo5QQhAF
 LhtVeCNt85JUDMSOQdOb4pLrrVDg/jlZucTBZ+Rn3AZ34n7j4kBi80qg8IoQbbTILaXy
 oodB3PnMz2FNngeeQWbWb/S64ezcBLELnA6smYYeIV74RAn5n+mnw/VzaB81LkmiIT17
 0DA+P0AW+ZEtdTUSUac4Zb+3PC+zuzFCPas0v+0AuvGOgpc9f80fMqBO5jl+Lz54CQqV
 VRUGvqbSCog2z4B7V4vU7Xv8r5Q/5Sb+ze3z5wJUwmL2VyaogmGLQ3/wJSuPlBDO7cbt
 ugiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/e5J1WsCAl3VazC9uY1P3J1kjcwirQS7CBU+doQWHjY=;
 b=NxN2MWB/ij8Gwxk4q8eGtyA2KEuvjxjNBJuYIuvETyT6FT6yZzmdKCdS30n4yhTkdg
 0yw1Fl4GLMXFRWO2zYKXkX/vYCo8/nRfUpTgDl8TUdqRFWC81QeYXIx2Iam0a8sH04uL
 lI8H+s1Rq45MeB8zElWERO8Q3wJQkPzUrn4HGRTzxw8C4NtAkXnyFeKgVVYFf7iOdfOD
 KFbw2n9Ab4pVKPqnuOlByQ8T6SmXhvY6cZB/ji11eaS9qvCBcjQ97G2v3m9dqOTMaeFc
 yZMCylWDy1Avw4Vao/AUg1jiGoM7Ewjoz4n0eOCN+8gMZ88e3TXQVGl5BZBlBzzf99J/
 EsVQ==
X-Gm-Message-State: AOAM530TLueV3YeOmMyKIaCpngqNJ8b7jrhXI0mSvH73lko2nLMcYABA
 sufMKzd4hiYJutDaEdzmBu01FAkvEdp2F/Yw
X-Google-Smtp-Source: ABdhPJzwFS5phPWTc+6monjMPOKdiSMpH3WlYvA0Y7oq6GxiRacmFUIAXF+/9yrlAub8cF1Ur2owLg==
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr642599wrx.244.1598606678058;
 Fri, 28 Aug 2020 02:24:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/35] target/arm: Split out gen_gvec_fn_zz
Date: Fri, 28 Aug 2020 10:23:58 +0100
Message-Id: <20200828092413.22206-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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

Model the new function on gen_gvec_fn2 in translate-a64.c, but
indicating which kind of register and in which order.  Since there
is only one user of do_vector2_z, fold it into do_mov_z.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200815013145.539409-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index d97cb37d83f..f1803eb72bf 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -143,15 +143,13 @@ static int pred_gvec_reg_size(DisasContext *s)
 }
 
 /* Invoke a vector expander on two Zregs.  */
-static bool do_vector2_z(DisasContext *s, GVecGen2Fn *gvec_fn,
-                         int esz, int rd, int rn)
+
+static void gen_gvec_fn_zz(DisasContext *s, GVecGen2Fn *gvec_fn,
+                           int esz, int rd, int rn)
 {
-    if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        gvec_fn(esz, vec_full_reg_offset(s, rd),
-                vec_full_reg_offset(s, rn), vsz, vsz);
-    }
-    return true;
+    unsigned vsz = vec_full_reg_size(s);
+    gvec_fn(esz, vec_full_reg_offset(s, rd),
+            vec_full_reg_offset(s, rn), vsz, vsz);
 }
 
 /* Invoke a vector expander on three Zregs.  */
@@ -170,7 +168,10 @@ static bool do_vector3_z(DisasContext *s, GVecGen3Fn *gvec_fn,
 /* Invoke a vector move on two Zregs.  */
 static bool do_mov_z(DisasContext *s, int rd, int rn)
 {
-    return do_vector2_z(s, tcg_gen_gvec_mov, 0, rd, rn);
+    if (sve_access_check(s)) {
+        gen_gvec_fn_zz(s, tcg_gen_gvec_mov, MO_8, rd, rn);
+    }
+    return true;
 }
 
 /* Initialize a Zreg with replications of a 64-bit immediate.  */
-- 
2.20.1


