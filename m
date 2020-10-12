Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B03C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:04:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D0612076C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TuAH7i1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0612076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS0JF-0004nw-3G
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 12:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzti-0003gh-Pu
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:38:02 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRztf-0007m4-Bg
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:38:02 -0400
Received: by mail-wr1-x442.google.com with SMTP id n15so19718084wrq.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WGIKi5XPkewNmleyCkypYY54M4r98inEKdT2tfEXL/0=;
 b=TuAH7i1OAguRSfZl7FwM4jqebo4oN1y474tB9WPZLLndOHpeBnzxAN7AdzrMJss4qy
 wtZqwvH1YKdk9TJd3d1+fKX3v/z+/ghmbViE38Uxj39GgdNluU1jX5hZhyCStpqLPss2
 tAhuweaAIgiscXv/y51GHcQZjhpx1ManRflBHoBOBhKMelI+SdGRV5gWEfU2a5Ns4gs2
 VROVmEjD/3fw45vBGf3BvtgNCcXYpASfnA6zmSoxKX2p06d6Wnk636Z3Lb9sOslftn4N
 BFo4N59jAy4hFBgRLi0Kj9g6BqjxmtzwW/03kN+faYDDv2cxGfN8qQ4ypkbzklpn8Qne
 NVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WGIKi5XPkewNmleyCkypYY54M4r98inEKdT2tfEXL/0=;
 b=r8wHIatH1kLsq8z56sTjiowIm0c2Yqg7KRvDejx1U1Wt2UdHpcktK3nLQaa+m4nX7O
 2RfLava6GVWgNS5aSgVvSi2/giuU30Vq06EwK5ByERVpmDlQrf6qw8LX2c3b7WKz4p09
 0wzs1eHAvbN/n5e0udicZDRPj6HAsF0DBwMjKyfNtzBLJ2hUwW7L0LZvm+kSoDJW246n
 Pk01OhSty6CWRyob93DsOu/OpNZHoq2UIgxD5a4+ui+G/oP7oKFndeqtEJSq2Npx32RH
 RW+2xZCeEF+PgtVjjMO9iqBWj4GciTLFbeVGYbiNVIAUhr7lqSCPeFcO9d6QZHV5NIHA
 Fm9g==
X-Gm-Message-State: AOAM533Ct+XF5XP/kJIz0pn91WkmGnIQz0bfDA7IX9ADFjUvAYfN2aXq
 FqE4IEyrTEBf5ic6/tzXub8iXRT8S+iMDpgO
X-Google-Smtp-Source: ABdhPJzh23Ql7c4Zbq9AXnX4Img9g8YrKyVVnLZP3CtpJbuKpM2ZouTEJ1o4fEaCCZjuXSmyjA287g==
X-Received: by 2002:a5d:6a51:: with SMTP id t17mr14303446wrw.80.1602517074090; 
 Mon, 12 Oct 2020 08:37:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y66sm7095961wmd.14.2020.10.12.08.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:37:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 05/10] target/arm: Don't allow BLX imm for M-profile
Date: Mon, 12 Oct 2020 16:37:41 +0100
Message-Id: <20201012153746.9996-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153746.9996-1-peter.maydell@linaro.org>
References: <20201012153746.9996-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The BLX immediate insn in the Thumb encoding always performs
a switch from Thumb to Arm state. This would be totally useless
in M-profile which has no Arm decoder, and so the instruction
does not exist at all there. Make the encoding UNDEF for M-profile.

(This part of the encoding space is used for the branch-future
and low-overhead-loop insns in v8.1M.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index a7923a31b56..0c35efb1014 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7880,6 +7880,14 @@ static bool trans_BLX_i(DisasContext *s, arg_BLX_i *a)
 {
     TCGv_i32 tmp;
 
+    /*
+     * BLX <imm> would be useless on M-profile; the encoding space
+     * is used for other insns from v8.1M onward, and UNDEFs before that.
+     */
+    if (arm_dc_feature(s, ARM_FEATURE_M)) {
+        return false;
+    }
+
     /* For A32, ARM_FEATURE_V5 is checked near the start of the uncond block. */
     if (s->thumb && (a->imm & 2)) {
         return false;
-- 
2.20.1


