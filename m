Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09200C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8CC1207DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FO2o6tuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CC1207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA9Aq-0007zV-0U
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95h-0005GE-FM
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:37 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:39168)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95f-0004oh-Oo
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:37 -0400
Received: by mail-wm1-x329.google.com with SMTP id g75so7525423wme.4
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 02:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=zQb4tl+pl+QQR0fGrgrVlmupRVf20x7rz7QGSNEoC2Q=;
 b=FO2o6tuIwP5vs5bt5twZZz05/tJukZ5wgONKegeSipg46qnPYSS0xU9glbW9EJxTq8
 n+5PrIvWAr1sonLAoobbid/W063/svVS+5B5yTtpf/xmQLJ2SJ5g//7W1VQcr69bApYF
 gYTYSvU59QggRe5Mbhcc7kqn2WFIjpjJyWTd1N4iIr55Oufew6gijeU1W6YUJ8f2YzdW
 qt/YOSdj5RTZvRFbeXE833bRXmWAr8byGjTO2qleexMm5dpF6S6Y0/zdj54UrY5tG74r
 t7aTUCL84gLwK/4c7ejr17SmPpq5SzZ+GJGrmOD6lxHZnqw6q3PAVH06gugsZ+L6gyr2
 vkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zQb4tl+pl+QQR0fGrgrVlmupRVf20x7rz7QGSNEoC2Q=;
 b=opxlJnXsgVJ9/ErRyjaN6whaNTFlSNZ+RJIvUnemOEy3y9cIO8ORyh4OIr0kGHufga
 N0EmweooqS9K0ozKFfInne0ev3VNsYxFobG/MWCV3dXsCViGvA8Z+63ovKCD2FGxv1cz
 /49G9zTXG+DuG/E8C99Be9ijyqh5ijgW9b9KTlEmWsKJ43b1HJHCEiAA4LcbWksF346f
 moq7Cm5ke1MRmfRvHMnOwCFfJoYLr1o3xibmm0BftGOcTIF1uJPAIGc4SIiAnlZbVjdp
 nTp9d1IGI5MYAqw4MjQMwAEAmB4Gn3/F1Q3c9og/QFkwV7zWFUuErm2L+3YgW+ypDw7B
 HGOQ==
X-Gm-Message-State: AOAM531Am2+HV1YCUdGlWeMAm+dYOOXNGW7go6yjsNypYAGrRuKEkGzP
 h6VQgFpJ/0OJGyWJPpn/Apb12BqBNSa8Fchs
X-Google-Smtp-Source: ABdhPJxf+L8allWN1Iepi1YJF20WSnIYkPcPmMZIv9a2vd9aDHBBk3iDta6gICGRF1wx8GcnT7XB3Q==
X-Received: by 2002:a1c:5455:: with SMTP id p21mr1784156wmi.146.1598262514108; 
 Mon, 24 Aug 2020 02:48:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q6sm24877057wma.22.2020.08.24.02.48.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 02:48:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/27] target/arm: Tidy up disas_arm_insn()
Date: Mon, 24 Aug 2020 10:48:01 +0100
Message-Id: <20200824094811.15439-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824094811.15439-1-peter.maydell@linaro.org>
References: <20200824094811.15439-1-peter.maydell@linaro.org>
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

The only thing left in the "legacy decoder" is the handling
of disas_xscale_insn(), and we can simplify the code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200803111849.13368-5-peter.maydell@linaro.org
---
 target/arm/translate.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 6ee920eec53..362d1cc50fb 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8342,26 +8342,18 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         return;
     }
     /* fall back to legacy decoder */
-
-    switch ((insn >> 24) & 0xf) {
-    case 0xc:
-    case 0xd:
-    case 0xe:
-    {
-        /* First check for coprocessor space used for XScale/iwMMXt insns */
-        int cpnum = (insn >> 8) & 0xf;
-
-        if (arm_dc_feature(s, ARM_FEATURE_XSCALE) && (cpnum < 2)) {
+    /* TODO: convert xscale/iwmmxt decoder to decodetree ?? */
+    if (arm_dc_feature(s, ARM_FEATURE_XSCALE)) {
+        if (((insn & 0x0c000e00) == 0x0c000000)
+            && ((insn & 0x03000000) != 0x03000000)) {
+            /* Coprocessor insn, coprocessor 0 or 1 */
             disas_xscale_insn(s, insn);
-            break;
+            return;
         }
-        /* fall through */
-    }
-    default:
-    illegal_op:
-        unallocated_encoding(s);
-        break;
     }
+
+illegal_op:
+    unallocated_encoding(s);
 }
 
 static bool thumb_insn_is_16bit(DisasContext *s, uint32_t pc, uint32_t insn)
-- 
2.20.1


