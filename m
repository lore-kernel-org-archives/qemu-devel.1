Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E20C388F2
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE9E2085B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zyunfGmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE9E2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuAp-0000zw-B3
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu15-0005Hm-O1
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:39 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:35868)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu14-0003w6-1I
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:39 -0400
Received: by mail-wm1-x329.google.com with SMTP id e2so2519114wme.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=1TAKmnrXBfL6eR3DBczCUzOiCIS8y/1ety/iZUsCGWo=;
 b=zyunfGmtNVncBEf5Ay26fz6kmDe8+2y54N+7Te8xyjAEL/4mySA6rfhOaeouHKj96h
 TQnT5SLhxbfNDkEqooV/RGvMUGOoR5ND6Wwc39kqW54z1vDtpkIv1+tGJ1FxeYuH+zNO
 sX2fH6LD6We2gIIbp54wcHrMiSJ6Auc3p4fWhsVei1Pjq9k6FFFssDLGCVUbwLKBxQGe
 L3sak0MaU68dS+Ye3Y0St+grK20/Q0KC5TS2/3WtRX++Yjkfag6tS81s06fDRRbtXqOM
 Xv9p7OAWzp2SKnLyFxZoFbUj/ZsMT0tEiMZgFMZ2DczO7KDgp1kvdEKZCfEzHE70cLpT
 1D/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1TAKmnrXBfL6eR3DBczCUzOiCIS8y/1ety/iZUsCGWo=;
 b=M22bPef0idxIKqdT7WWx28VVL2nCdUYhPcuXIW45/igdi/evX0HwdWebaNGNiD9Rr7
 7U1vtg/imNc8ED2SkExQ3GC50u3FdTD4P+61GeNgnp9wEbNArMjwnLhyZgeVJu/PFM7g
 WF3jHbaH7IA02ck+slEFz8MfN+44rT0L03tkeT3QN+ej5Y8jS0oyKJvXiJoKRUWTGQ+k
 mftiuHqeCJ87IB3ytS8NGeac8yBKul8Kk8oYgcbtfNywq+wKAum9x6IxAjK828LHMDOF
 zPYmIRqIMLCMGlqkebt6w5jvyIqgUoyQcv52PHig8zZRiPCewM8eYTOiEanxxV+Mglqu
 UMuQ==
X-Gm-Message-State: AOAM533sPXsZDR0k6lP45/xcmusdQLA3mphORMElcvfPLRAVXZC/3c3m
 Fa7NWZ+a9ukr+VUy0okbqWiCCOWyzeOSfQ==
X-Google-Smtp-Source: ABdhPJxDYBb9c5svNh/4mW31Tb8OxvkbB05ZzqVYUrOSGXyDRFD6f8XcA0BxLGnzUiFNIzxeZoO/9Q==
X-Received: by 2002:a1c:e403:: with SMTP id b3mr2884543wmh.79.1603209456318;
 Tue, 20 Oct 2020 08:57:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/41] target/arm: Don't allow BLX imm for M-profile
Date: Tue, 20 Oct 2020 16:56:39 +0100
Message-Id: <20201020155656.8045-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

The BLX immediate insn in the Thumb encoding always performs
a switch from Thumb to Arm state. This would be totally useless
in M-profile which has no Arm decoder, and so the instruction
does not exist at all there. Make the encoding UNDEF for M-profile.

(This part of the encoding space is used for the branch-future
and low-overhead-loop insns in v8.1M.)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20201019151301.2046-6-peter.maydell@linaro.org
---
 target/arm/translate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 9f2201ca577..dc3a4031db7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7918,6 +7918,14 @@ static bool trans_BLX_i(DisasContext *s, arg_BLX_i *a)
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


