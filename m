Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD49C10F29
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 21:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B9E92253D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 21:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tI0y360I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9E92253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBQQw-0004r2-Jk
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 17:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBQPs-0003EI-0M
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 17:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBQPq-0005go-UC
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 17:58:27 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:39066)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBQPq-0005fi-Nq
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 17:58:26 -0400
Received: by mail-wr1-x430.google.com with SMTP id r15so8141902wrx.6
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 14:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2n3nGOj14Qa+RXY1pY3cDWtilSqrSMjx7cEnFu1bzAg=;
 b=tI0y360IxNZcmSKHSZt+fRHEfyRNE7SQC7aqAXfgjLVUs9ydbRMBvpjbyF4bnwt1Op
 AySe8OaxX1q6etNx5N6PXNyd0D7NJQm/cFTSBtB5N3vIgcxSjHmYfwGQYOOr2HRDulMU
 6IPqMfnSNutKju149yK8S24LaAKQ3stdUEsJZ1r8eeY1PIbYBmSQ+GdyBKQh3IzsJcWj
 KMds8aapMCEzt52g6L2Y5Vhf21Dmqqpdj9fiMgeLMRYyNZe2F1o8e5qJk7Vn5zuPqCLR
 QIJWmgnP9lBJbTWhnMpQq6ibF9cRdWY2KAKQlTQ9yuNQGecRYgyPlOWpdqA6xNvoG+vF
 Zyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2n3nGOj14Qa+RXY1pY3cDWtilSqrSMjx7cEnFu1bzAg=;
 b=cpe6aIYtma0abyfQkt4qvYczVRa3TJ2Fxr3HYdZv/10bMFF4ncPOAcVEIoB5AyEjrV
 6y6m7X63zRH7xtwNO67neumisKfUcFHB1B2Jru8IXDaBXvv+sgKboRd+9mn3cRgegVmJ
 yWn1HYueC63welV+DfhIGk1NyFqjyy6puVVCTwPTJ8uxVBOshCCHPeER0Riry6j3+Q7O
 6QaxS4BIQHMPMefhu5+yGrchiW12sTfR1LlOBnP0n5RUBVsqYwWH6TBmHJeGZr+0bS6V
 pgvvM8vj/2AxD0766lV5in+oTNp5BVuWb7BbIvIfhJcMnrjznDVmy/0UvGWxi6yVbSwt
 c0NQ==
X-Gm-Message-State: ANhLgQ2PBzPEnp7jqx5CKs/8+sYkbsHHKY2ivY57a4Ccgsk55uiI5vZe
 d39NXRFBGqk1j9QFGUbUnVuEKw==
X-Google-Smtp-Source: ADFU+vu01FclDTE79/VoHYeB4tnZHNFy0CBsbCSItxwPUFAn5EQsQ9ecvMgstSQsU71ZU6taCvn/mg==
X-Received: by 2002:a05:6000:101:: with SMTP id
 o1mr9165661wrx.239.1583791105719; 
 Mon, 09 Mar 2020 14:58:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f17sm42207068wrm.3.2020.03.09.14.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 14:58:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/5] docs: Move arm-cpu-features.rst into the system manual
Date: Mon,  9 Mar 2020 21:58:17 +0000
Message-Id: <20200309215818.2021-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309215818.2021-1-peter.maydell@linaro.org>
References: <20200309215818.2021-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now we have somewhere to put arm-specific rst documentation,
we can move arm-cpu-features.rst from the docs/ top level
directory into docs/system/arm/.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 .../{arm-cpu-features.rst => system/arm/cpu-features.rst} | 8 +-------
 docs/system/target-arm.rst                                | 6 ++++++
 2 files changed, 7 insertions(+), 7 deletions(-)
 rename docs/{arm-cpu-features.rst => system/arm/cpu-features.rst} (99%)

diff --git a/docs/arm-cpu-features.rst b/docs/system/arm/cpu-features.rst
similarity index 99%
rename from docs/arm-cpu-features.rst
rename to docs/system/arm/cpu-features.rst
index fc1623aeca5..7495b7b672b 100644
--- a/docs/arm-cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -1,11 +1,5 @@
+Arm CPU Features
 ================
-ARM CPU Features
-================
-
-Examples of probing and using ARM CPU features
-
-Introduction
-============
 
 CPU features are optional features that a CPU of supporting type may
 choose to implement or not.  In QEMU, optional CPU features have
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 86ea6f2f568..1425bd5303a 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -78,3 +78,9 @@ undocumented; you can get a complete list by running
    arm/stellaris
    arm/musicpal
    arm/sx1
+
+Arm CPU features
+================
+
+.. toctree::
+   arm/cpu-features
-- 
2.20.1


