Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8D8C4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 755D3221EC
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="euXPpleq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755D3221EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLyy-0006Z3-Fy
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHD-00006t-Aa
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:31 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHB-00077j-MK
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:31 -0400
Received: by mail-pf1-x442.google.com with SMTP id b124so3977875pfg.13
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FnLvIpl6tkY/ABtv3jqDiaV7bxS8ugwGLaJksYt9Yyk=;
 b=euXPpleqtCkeomfnGxAyEtMI+D77EYq12Sh9xonMCtfGYa3pEU3pBNuBVk9Hn3m7to
 w+EY7K3KkmBR9bDmFi8a3vk33rN5VvGjMJsZx6WULm6mhliQw+htt1VSTIz9rbNatsKc
 1fu+xKSaXZsbhMx1nxopWgvH87JHsnDekVJgiupVFuqVepxA7F2jTyP7Dq2XI7EQd7wU
 xXKlW6tV5czNKe4n4pRGace/+9YbbxwLFJH+2jQ2ZnpfOUZtn7EUDqIaIu4eadfUp08D
 vKjy/TJlwLlnnljoiuq83aYKksZz2jWnSf7AQK7eZ4C3S3d26WwZYAfLWauOMckwzkmd
 jOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FnLvIpl6tkY/ABtv3jqDiaV7bxS8ugwGLaJksYt9Yyk=;
 b=FPZyBiIjKhOzA7y1FSOTOqGDWeUBpkG0z0t6r/VcQPLYMOiQgQHBBtiEe47sKBx6hj
 DvuYW7hj92PA02t5B6c1zISxEkzgVoFYbnimi2P5BF4sL8n2od+VaHcw5h7y2+7sUYZB
 QBPpLItqafRM7L60antsOnzcIxXW7gAXPZVL1Ug1AHDRAj11ib17heDmax9UDhHfp9hf
 HsmrAacluVKpyBjFRrT4npdazjA4JFu+pdnDUvYG1hgVc7uUyL86JyfeyLIXSvCFd+t4
 ZUydEHRLorf4g3Qb7weqiQdFSgvrTx+U9ZwlayFiiTU7afvSkIRPwJSdsN2imGnvj//U
 aCmQ==
X-Gm-Message-State: AOAM533LSmDsCQ8/odiZ/s3cwtUIR5IWqbN7me0FdV5rScGkPMA/606p
 Z/jbKuIPpu/mJEzeEVTFvpOXpAeKP1bQ9w==
X-Google-Smtp-Source: ABdhPJxNRtKPQnlVMARrsKDz04Flt+HAhQYWDbu70R48HtijhUc8JV7aS3RjcpFyz5fBuQ0NvrwM2g==
X-Received: by 2002:a62:1dc1:0:b029:13e:d13d:a051 with SMTP id
 d184-20020a621dc10000b029013ed13da051mr32287944pfd.23.1600454307941; 
 Fri, 18 Sep 2020 11:38:27 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:38:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 26/81] target/arm: Implement SVE2 integer absolute
 difference and accumulate
Date: Fri, 18 Sep 2020 11:36:56 -0700
Message-Id: <20200918183751.2787647-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve.decode      |  6 ++++++
 target/arm/translate-sve.c | 21 +++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 90a9d6552a..b5450b1d4d 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1266,3 +1266,9 @@ URSRA           01000101 .. 0 ..... 1110 11 ..... .....  @rd_rn_tszimm_shr
 
 SRI             01000101 .. 0 ..... 11110 0 ..... .....  @rd_rn_tszimm_shr
 SLI             01000101 .. 0 ..... 11110 1 ..... .....  @rd_rn_tszimm_shl
+
+## SVE2 integer absolute difference and accumulate
+
+# TODO: Use @rda and %reg_movprfx here.
+SABA            01000101 .. 0 ..... 11111 0 ..... .....  @rd_rn_rm
+UABA            01000101 .. 0 ..... 11111 1 ..... .....  @rd_rn_rm
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 33e575ce72..e21f078af7 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6448,3 +6448,24 @@ static bool trans_SLI(DisasContext *s, arg_rri_esz *a)
 {
     return do_sve2_fn2i(s, a, gen_gvec_sli);
 }
+
+static bool do_sve2_fn_zzz(DisasContext *s, arg_rrr_esz *a, GVecGen3Fn *fn)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        gen_gvec_fn_zzz(s, fn, a->esz, a->rd, a->rn, a->rm);
+    }
+    return true;
+}
+
+static bool trans_SABA(DisasContext *s, arg_rrr_esz *a)
+{
+    return do_sve2_fn_zzz(s, a, gen_gvec_saba);
+}
+
+static bool trans_UABA(DisasContext *s, arg_rrr_esz *a)
+{
+    return do_sve2_fn_zzz(s, a, gen_gvec_uaba);
+}
-- 
2.25.1


