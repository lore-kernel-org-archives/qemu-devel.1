Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE25BC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B37420FC3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lePq4H65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B37420FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8E6-0003xF-Ft
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83Q-0007Tt-Cd
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:36 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:51358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83O-0006AP-Hl
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:36 -0400
Received: by mail-wm1-x32c.google.com with SMTP id w2so1547348wmi.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=EYLlh7Io+uTpQXRIuWjT8kQdi/SDGzf09GdhvDAyEKc=;
 b=lePq4H65vA/rH1VUGOaB7Hf6j6iNSePTO2+TiOMl9OE7SOCRqqtzdTLU/laSlo4FSq
 cYtiHW16ogW6lDvl8SHdvpYGFDt0TRCVcU/fUw98ZuZlwH6VSj3gmrdYTcDBHR+7PFTC
 oZPULcFhbk5JzQ0ZGanK1nO89vkfCKPJpA/LgEtSvOZKG2C3VpWW7GOhaRwdUClsvUpr
 EMXlpSb5aiQ38IR316rjXWJIZNWKwoX1Jcxz9cL90Cq7ylkrrj4eCwjXF1P3wmVor2LG
 FLFrLR5q6MZ8IEZ00y7TFbwkwcvhZhAUQHCz7T4aVGvv0edKJYj8f8Ot5cqgihlOMj8J
 aiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EYLlh7Io+uTpQXRIuWjT8kQdi/SDGzf09GdhvDAyEKc=;
 b=DpvxeGaHMKrCTPZUUSnmFvq4vcR4+7UwZjRDagXuRF9Gj+N6YqG3pVRXChpYK2Og+x
 dHeArrf3X7hAsMDWxSm8o4h2y4Cp8YBFc73bGwHBGFwdc0qMIsGoqacqeDXG1IvXdxyE
 wYK6fJ/kSYFS5RiaQ9w2EHJUaUerKM3vvUo6al1liT6W5QFZPqtmrDh6gKxqBzoZ4Pjp
 h3HS4/u95T+82goMg8WtSs5WQHcz+RDn8gwn49jQ+sNxBUn9jUrAsBEPdiqM/sgu55vq
 h08MBrMZTGhau9+hBf0d3wh9xX1lmBasXnGvkwiEDVTOXWUKdBsDWzUImxdOKwemW2vy
 PsZA==
X-Gm-Message-State: AOAM532wbXUXRTTu48Zbx66jbV8UYsS6mjsguffP9eQCqWJIauyc4VqB
 YsQLgJu7Y+CrHCIs6oQb5iH3SZ4oX+e9EXCP
X-Google-Smtp-Source: ABdhPJyBoOcrATJobfVNylyGxfnvx2hn7Op7AV9OW2EHCRIl+GT86nACK48bG/BePTw66GBO0dUCWQ==
X-Received: by 2002:a1c:c256:: with SMTP id s83mr2286311wmf.93.1598973512557; 
 Tue, 01 Sep 2020 08:18:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.18.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:18:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/47] target/arm: Macroify trans functions for VFMA, VFMS,
 VFNMA, VFNMS
Date: Tue,  1 Sep 2020 16:17:41 +0100
Message-Id: <20200901151823.29785-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Macroify creation of the trans functions for single and double
precision VFMA, VFMS, VFNMA, VFNMS. The repetition was OK for
two sizes, but we're about to add halfprec and it will get a bit
more than seems reasonable.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-6-peter.maydell@linaro.org
---
 target/arm/translate-vfp.c.inc | 50 +++++++++-------------------------
 1 file changed, 13 insertions(+), 37 deletions(-)

diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 15bb23688bd..9937fa569e4 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -1978,26 +1978,6 @@ static bool do_vfm_sp(DisasContext *s, arg_VFMA_sp *a, bool neg_n, bool neg_d)
     return true;
 }
 
-static bool trans_VFMA_sp(DisasContext *s, arg_VFMA_sp *a)
-{
-    return do_vfm_sp(s, a, false, false);
-}
-
-static bool trans_VFMS_sp(DisasContext *s, arg_VFMS_sp *a)
-{
-    return do_vfm_sp(s, a, true, false);
-}
-
-static bool trans_VFNMA_sp(DisasContext *s, arg_VFNMA_sp *a)
-{
-    return do_vfm_sp(s, a, false, true);
-}
-
-static bool trans_VFNMS_sp(DisasContext *s, arg_VFNMS_sp *a)
-{
-    return do_vfm_sp(s, a, true, true);
-}
-
 static bool do_vfm_dp(DisasContext *s, arg_VFMA_dp *a, bool neg_n, bool neg_d)
 {
     /*
@@ -2069,25 +2049,21 @@ static bool do_vfm_dp(DisasContext *s, arg_VFMA_dp *a, bool neg_n, bool neg_d)
     return true;
 }
 
-static bool trans_VFMA_dp(DisasContext *s, arg_VFMA_dp *a)
-{
-    return do_vfm_dp(s, a, false, false);
-}
+#define MAKE_ONE_VFM_TRANS_FN(INSN, PREC, NEGN, NEGD)                   \
+    static bool trans_##INSN##_##PREC(DisasContext *s,                  \
+                                      arg_##INSN##_##PREC *a)           \
+    {                                                                   \
+        return do_vfm_##PREC(s, a, NEGN, NEGD);                         \
+    }
 
-static bool trans_VFMS_dp(DisasContext *s, arg_VFMS_dp *a)
-{
-    return do_vfm_dp(s, a, true, false);
-}
+#define MAKE_VFM_TRANS_FNS(PREC) \
+    MAKE_ONE_VFM_TRANS_FN(VFMA, PREC, false, false) \
+    MAKE_ONE_VFM_TRANS_FN(VFMS, PREC, true, false) \
+    MAKE_ONE_VFM_TRANS_FN(VFNMA, PREC, false, true) \
+    MAKE_ONE_VFM_TRANS_FN(VFNMS, PREC, true, true)
 
-static bool trans_VFNMA_dp(DisasContext *s, arg_VFNMA_dp *a)
-{
-    return do_vfm_dp(s, a, false, true);
-}
-
-static bool trans_VFNMS_dp(DisasContext *s, arg_VFNMS_dp *a)
-{
-    return do_vfm_dp(s, a, true, true);
-}
+MAKE_VFM_TRANS_FNS(sp)
+MAKE_VFM_TRANS_FNS(dp)
 
 static bool trans_VMOV_imm_sp(DisasContext *s, arg_VMOV_imm_sp *a)
 {
-- 
2.20.1


