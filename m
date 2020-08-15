Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DAFC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:10:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1DD623101
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y0OZ8All"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DD623101
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6xp7-0008NV-1Q
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6xjr-0000Ce-O9
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:04:55 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6xjq-00070q-2Y
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:04:55 -0400
Received: by mail-pf1-x443.google.com with SMTP id a79so5956340pfa.8
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 08:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dBiawe791lYoIBQCs7QK6giwbxNTYFLKTnDb5R8dqS0=;
 b=Y0OZ8AllOD5DujnIV1vAfAMUQ+nhueZA2VLFJ7lFAqqwprfXOJ3CMGbLgVJm1KYndn
 RB0QLVMaNMcYtErlMaDlWSCeUutVOH5UPT3C0UmYaqMejq3UoBV4S0SlOxvKe0OiqMoW
 BG36Y4smEucuvgfSeQFzUFh4kk6wMMFKFpV/c9RfGnk7X5CsQdyjAXAds27zC0WAYJwI
 l9tdVKMM1KP5XWY4O4n7/dn51kaTAt3o9WBVOR7xUYCHsLwRAIuqlruY+RlbMkLA/zz7
 1pwvLMZlxiosFl0cbBFA/T1BQ66CfC81ZbsC3bKXIcmm5kJovYwVMcVWxfPZ/W7+m5ex
 U9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dBiawe791lYoIBQCs7QK6giwbxNTYFLKTnDb5R8dqS0=;
 b=HODZmntwTbtPT92wKI10f78cDM2IMyvAWPNYUoUhIYPBXB3YndYb7+Hr2a+c6S/1P2
 9E6JSzYkqY3+OjPtp/QpQ1mGwwsBqMIvI/vkKBRGY/2la3scNz3eHutDfmFC4ySeCe6w
 3ZcqbRfgG/T9qjLJbtEQ5HjFfmDr/1ItJNjts9mhiWfdeFchaf03n8L2lv/xukcCNvJh
 lfSpCsDqGWmfGBSo00U6hv00N3U672fsoH9eFy45IHXtUlyJhoxPqjljoJR7ky9IxZmg
 6V79RDwARqcXBboALiDp7h6wefh9sKuvQB3Z8fZOHtqzH+gZMOhJTqvVdaPIWFizLkCa
 A4XA==
X-Gm-Message-State: AOAM531EU2NLDNOTofUGwRKmDq46svszAOg/TOoA3DEmSf+WunXqrsCt
 33oAikPl1JGrCMD0PO2DwOznMW4O+4IpOg==
X-Google-Smtp-Source: ABdhPJxcrijQMUwekDanzzRt0b0Xu5cptDD3eT0mz1ke0LiMbAdbeuJ8K6d0s3f1heS0yMkgm28CgQ==
X-Received: by 2002:aa7:8f0d:: with SMTP id x13mr3684359pfr.193.1597455110749; 
 Fri, 14 Aug 2020 18:31:50 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y196sm10625528pfc.202.2020.08.14.18.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 18:31:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/20] target/arm: Split out gen_gvec_fn_zz
Date: Fri, 14 Aug 2020 18:31:27 -0700
Message-Id: <20200815013145.539409-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815013145.539409-1-richard.henderson@linaro.org>
References: <20200815013145.539409-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Model the new function on gen_gvec_fn2 in translate-a64.c, but
indicating which kind of register and in which order.  Since there
is only one user of do_vector2_z, fold it into do_mov_z.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 88a2fb271d..28e27c55b5 100644
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
2.25.1


