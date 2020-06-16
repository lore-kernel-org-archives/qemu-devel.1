Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28B9C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70D342071A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EKFLSXqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D342071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8MO-0000TY-M4
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 05:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LG-0007AP-8y
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:18 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34978)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LE-00041h-NG
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:18 -0400
Received: by mail-wm1-x343.google.com with SMTP id q25so2422715wmj.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 02:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=cx+K11zqaqFJtEKXVMyZHbwPzSYF8gzBxEyuytPXzag=;
 b=EKFLSXqCvcd/HVRyRoUSQHHySyoSBQf1sL3JU0leOBpUiGzC0gDW63dRVNqvhzlLMS
 dmYts0gwTehgcxtkiKgiNEtn08LuyD3CREFXXx80ZTSicETdbNc7GA/vtMeKN1f/SP4u
 zdl+IR7CprJn0yxrq87FcQjz1c3KDCGyK/CusqibztYsjsJIj4WiIQMema+ps8LRoFdi
 jNTx02AINzqZyd/U/G5JC1j6T2Enngbnt5Cwoex0yNA/1EldSeQPC6tg+PCoWuv1MEC1
 mhMjrVAvZbu3Mcad3CuA2VNHdVf7UKvn8jERoLKooywoHTpgJh2X3hDrNX/5zRD/5Tdx
 7r2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cx+K11zqaqFJtEKXVMyZHbwPzSYF8gzBxEyuytPXzag=;
 b=lcdWHoZK0OILmqD3PGjYfzEi4Vv+q+59QoL2YzWuFSxwgrgnjGgBTufXNzu5u8cQL3
 /TeLFDCpsE9WXTnS+4vzmspCqLSZrdJkwclcwql2VUPJA//SmjZev+K9Uk6YVMlcpqdy
 cVWMmYWbtIHVWd9vLaiXkun9i99lBnlEgCI/+H3uZPDOOvf9VhGbWDcjEh7CvR+eguKZ
 UX9OaVt1V5AalWjPHd5hmR4aktRj/XJiwdM+RJ2vKV1LXU4uDP/WQILbWsfVw3rBT2oW
 KQPr3StiiXzzOdm6G2wa/USWJXjvPEms+hemE9hRP1v+7QlA5G7MdoUs/P1yY4KIWOhs
 MAvw==
X-Gm-Message-State: AOAM530KRDaemPx0ffIyQe/fPT5wbH8GeYZCYQ1KwR0s5Pkq+CF60eXB
 QJ9ivWaAlKruuHLLVhZDXjjTVkL+Fsd51w==
X-Google-Smtp-Source: ABdhPJx/IxNEPlRH1cKDrh0Xn9RjF792lNSt61VIGjJxudjdbITKOUfplCucHIk2r/a9JI2eBonH8Q==
X-Received: by 2002:a05:600c:2116:: with SMTP id
 u22mr2281807wml.97.1592301435024; 
 Tue, 16 Jun 2020 02:57:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z12sm31090851wrg.9.2020.06.16.02.57.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 02:57:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/23] target/arm: Add 'static' and 'const' annotations to
 VSHLL function arrays
Date: Tue, 16 Jun 2020 10:56:47 +0100
Message-Id: <20200616095702.25848-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616095702.25848-1-peter.maydell@linaro.org>
References: <20200616095702.25848-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mark the arrays of function pointers in trans_VSHLL_S_2sh() and
trans_VSHLL_U_2sh() as both 'static' and 'const'.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-neon.inc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index c2cc10913f8..7c4888a80c9 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1644,7 +1644,7 @@ static bool do_vshll_2sh(DisasContext *s, arg_2reg_shift *a,
 
 static bool trans_VSHLL_S_2sh(DisasContext *s, arg_2reg_shift *a)
 {
-    NeonGenWidenFn *widenfn[] = {
+    static NeonGenWidenFn * const widenfn[] = {
         gen_helper_neon_widen_s8,
         gen_helper_neon_widen_s16,
         tcg_gen_ext_i32_i64,
@@ -1654,7 +1654,7 @@ static bool trans_VSHLL_S_2sh(DisasContext *s, arg_2reg_shift *a)
 
 static bool trans_VSHLL_U_2sh(DisasContext *s, arg_2reg_shift *a)
 {
-    NeonGenWidenFn *widenfn[] = {
+    static NeonGenWidenFn * const widenfn[] = {
         gen_helper_neon_widen_u8,
         gen_helper_neon_widen_u16,
         tcg_gen_extu_i32_i64,
-- 
2.20.1


