Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA456C74A4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 10:38:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 827082064B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 10:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fcp8Mafa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827082064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlWTK-0001J7-JB
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 06:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37671)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hlWSU-0000sK-BO
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:37:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hlWST-0003Tv-8T
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:37:50 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46555)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hlWST-0003Sq-1b
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 06:37:49 -0400
Received: by mail-wr1-x441.google.com with SMTP id z1so5678687wru.13
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 03:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=u/6SvhtREvU6SkK9m1R46tVlenPl2fhco/m7l+MFKSg=;
 b=Fcp8Mafah92j/wB486VwXsbmLPP5ad8141d6MOnFcq2pqQw3wLL67VH6Nu5RNbKWKN
 b5JpPHGwuvkBbk0G2qTOtHG7n2d6ldgyzlNpJKMNhYTfYO/xVB1bhwFT4CB3Ks5BYt4f
 tBMlO31yfHIikN9osFMvnbz+e09oestZ9RJ/Pvw9sbebzlf+cWioHWp5sJt/L1QWt5JH
 b+B7B1A8tBB6HD/z3Ln+9XjVoVjlSm84Cnqwg0Tnq5tKXBDxlejDTqIfSBnP+FgasfcZ
 q14pf5qPErVrEjam9aXCflWjI4rOdI4ejAlKHuEsNKO9W8EeJmi6cXoeBhNvEW9j2E1O
 SS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=u/6SvhtREvU6SkK9m1R46tVlenPl2fhco/m7l+MFKSg=;
 b=PAblZrNElWVcxSWBHioahMuOGYVcujedxyZwkFWhsPxQ+u9YP+tIu3OlhXZH+4Zj/T
 E3r7KaGSl5MfMiySKuyr0BnAg/KIDul8LlpHzbOc1RUDJ1JZurtHmThj/YP2YwJMGXjR
 xiDR0JqSrVAi5roG+Lnz5T2S1tNGpT5TNDe6XT6/vkYtJyTxs5JrUWoD2mnuaQnYkBIL
 /Eog6P3ceQYysEFBHiucToZDClNytSKQ7anpO+voO1wcJHa8z76ehLrTWhK6zthGiv0q
 KMtdcI/CMnDxgRTXyC1CTrt9E0nIANOs29IK8VS2O6LAQWKvdCLbRHUuQ9idNjMDPpZ1
 G9iQ==
X-Gm-Message-State: APjAAAUR+0f/RKVKvwG/vvyCUAKwoE4R5HCMK6JaPEPstf16HONCW3S6
 5e7BIQO/OWdFWIn8hK9O8dS6lA==
X-Google-Smtp-Source: APXvYqz7c384YrKDMomoSekDab4FpJYE/W3uQ/uDJ6sJKX5hafmOOOWT1PU+4fqkzlpA75grG6l/Wg==
X-Received: by 2002:adf:eb06:: with SMTP id s6mr4616212wrn.151.1562841467462; 
 Thu, 11 Jul 2019 03:37:47 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id h8sm4790564wmf.12.2019.07.11.03.37.46
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 03:37:46 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 34FD51FF87;
 Thu, 11 Jul 2019 11:37:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 11:37:37 +0100
Message-Id: <20190711103737.10017-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v2 for 4.1] target/arm: report ARMv8-A FP
 support for AArch32 -cpu max
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 1836078@bugs.launchpad.net, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we converted to using feature bits in 602f6e42cfbf we missed out
the fact (dp && arm_dc_feature(s, ARM_FEATURE_V8)) was supported for
-cpu max configurations. This caused a regression in the GCC test
suite. Fix this by setting the appropriate bits in mvfr1.FPHP to
report ARMv8-A with FP support (but not ARMv8.2-FP16).

Fixes: https://bugs.launchpad.net/qemu/+bug/1836078
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e75a64a25a..ad164a773b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2452,6 +2452,10 @@ static void arm_max_initfn(Object *obj)
             t = FIELD_DP32(t, ID_ISAR6, SPECRES, 1);
             cpu->isar.id_isar6 = t;
 
+            t = cpu->isar.mvfr1;
+            t = FIELD_DP32(t, MVFR1, FPHP, 2);     /* v8.0 FP support */
+            cpu->isar.mvfr1 = t;
+
             t = cpu->isar.mvfr2;
             t = FIELD_DP32(t, MVFR2, SIMDMISC, 3); /* SIMD MaxNum */
             t = FIELD_DP32(t, MVFR2, FPMISC, 4);   /* FP MaxNum */
-- 
2.20.1


