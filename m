Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCA0C47425
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29F6120780
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SxO4C52x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F6120780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO01i-0000s5-3T
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 10:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsX-0004xd-Au
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:17 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:39419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsV-0002xx-Jz
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:16 -0400
Received: by mail-wr1-x433.google.com with SMTP id k10so6120653wru.6
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 07:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=y6I5QICCFwQmxXiOl7eP0bsK70GOlJj1SrtQFboL2uA=;
 b=SxO4C52xk83epbAoQkGCOu+1ksTdDpdeBcLMC0SkSra0nvVtgLRNIYB1Ki1HhxDPYf
 xHoc+kpbRk6l0kZwiLkajkENLrmrpKJ6CW1TvNd0cX0rUaT8tmEEIN5fC+vdi9gzNgyW
 4sEY2zqwkNG1xsbtpZhMT+apD+cFmZFpOUDLvhFalv/bDrSmRRqk41hFnJ/HctTF/zlL
 A8ty0VmXxINbFxpNHMWoD/ubh5tdsrK68EV27iwsr5gipPMnzVR7Z8RvZAUdb79Qxezv
 iGW9olo/97U/bjZW5RTHn6QO0TO0hwSmzUiTNjQ3O3Cod6KHWjmG9H6cgTyhNLsLL0wC
 mj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y6I5QICCFwQmxXiOl7eP0bsK70GOlJj1SrtQFboL2uA=;
 b=DbJfFO25Y2Ver8ngBuG3xnFbHqMWNyV/N1WOKudBt2ResahThXK48TYezUUqwSS+lR
 /H5SrlmUX4Cxj+FUBeDMc/q+1NQJeiobzpWQhz3AsBKPSRAx2HOyU1mjvf6jHuWnwAie
 xJAtumH35kqW0muaH1DBoakaWmWwDvzfcRRoffNSjB0LrSUuxDCa0tJYUvBBryLDC9I5
 +IhJU9BN5szGSIQpVsOG+JQZSrRlQq5dbBWXWNWq16UjG2vrXRBL+k6OLANVCALTut7U
 gKG76Rvfd54UlW/9Wt1jIMdd1CKID1nDMxdXbLgA1YJHdy7ZS63B9ufk4bmbymz+scMF
 7KXg==
X-Gm-Message-State: AOAM530/lv3si3pa0HicrPVHFOt4rfDegfgK9l1DcsvrNitXkgzRnv8+
 Kdlcu3Xhodg8WSy5pGha2Gp5dS9V5XB+2WSx
X-Google-Smtp-Source: ABdhPJy+5wQgs0kvFVa92k4FTHKABvp87KoLSOLgt0SYcuMNvYMz24pa07WQmNKWqLpwFNWT+ygGBQ==
X-Received: by 2002:a5d:4f82:: with SMTP id d2mr9371112wru.65.1601563693944;
 Thu, 01 Oct 2020 07:48:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 70sm342052wme.15.2020.10.01.07.48.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 07:48:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/18] target/arm: Fix SVE splice
Date: Thu,  1 Oct 2020 15:47:48 +0100
Message-Id: <20201001144759.5964-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201001144759.5964-1-peter.maydell@linaro.org>
References: <20201001144759.5964-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

While converting to gen_gvec_ool_zzzp, we lost passing
a->esz as the data argument to the function.

Fixes: 36cbb7a8e71
Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200918000500.2690937-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index c0d8a5863a2..9095586fc93 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -2689,7 +2689,7 @@ static bool trans_SPLICE(DisasContext *s, arg_rprr_esz *a)
 {
     if (sve_access_check(s)) {
         gen_gvec_ool_zzzp(s, gen_helper_sve_splice,
-                          a->rd, a->rn, a->rm, a->pg, 0);
+                          a->rd, a->rn, a->rm, a->pg, a->esz);
     }
     return true;
 }
-- 
2.20.1


