Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EEBC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C05CA20675
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQXh9TLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C05CA20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36413 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGNoU-0004C0-V6
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:07:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfJ-0004r7-PC
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfH-0001Lw-TS
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:21 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNfF-0001I5-Qd
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:19 -0400
Received: by mail-wr1-x441.google.com with SMTP id k17so22247627wrx.10
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=1XGXCtBKeeVzqgmtbhUu5EKggmcEdNkp9mStUCKfAYg=;
	b=aQXh9TLCiBDKxxFyc7z9c676WM+L2EGWTfMRBCFMewS+xTqueC6QV3JY+RO/rOdQri
	ei1Hz8LZ7SXdlnP+0obacr6NjovfYJVVUCJtH3O3OUrUVspkV5vqZzyz0TxP8JJIaGfV
	3C1s8WRE5W+InPTOebW+oCRxicrDZg5he7neg9m/AeWRvL8HjcHMuxlKamq9fJ5ZA+rG
	EOHaLy23Sr1Q8j4tLH5qz/BC2oX91/tzY3UW2l+0aG7re+wnwaGg8etVOEE/uoLjv7ys
	yFXEPIqo83/0MqzOlD3xHD8ASh01fIJyD/BLiQ832DYajG8co0IulFeWauGHHEaTCbW5
	RR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=1XGXCtBKeeVzqgmtbhUu5EKggmcEdNkp9mStUCKfAYg=;
	b=U5+jmnfRuZ2iFrowJYtT49iM4/F5bBetmcFyCJ82NuS/DeQf26vMfaVM8yhOmJXpyc
	2PaV7J1LMqujlWlK+8KR0LWB9ZGjFvdazN5vM3KwKf4sNyDObbsBJX39hiBVdV8eoyeT
	KHnGh0Go2Bjr2h8XV/lN8m41/rDVCGrfaRV73f2xa6Q0Xkp+7gdQ5h1CVqBZkDxNxezQ
	5u7rnz0khC+/C5LI2AtvRbjWAbGJJM0QNbRHKso88tRVVRFXSqx65POzQHePgS5iWneq
	fTBbNeBlZyFXD4hr5nBypWRt8EPlRpY9UDhgHcrjkkQ3Shc/SFsudZoXCKu/xSnRAmfQ
	fEHw==
X-Gm-Message-State: APjAAAUPCqhhABrcmKCc1hYX6aMugcNJ0QYxVTeNkF+jQXrkYTFs/HkH
	dJ/96YqUTA5b4Y3Y96yx3p4ZAA==
X-Google-Smtp-Source: APXvYqwRFMBP2LN+h0ov2Of/tRKw4IqMefPh9rJJR2iTWY+3QhpIn0eg86yc4q4dCAeBTarObDlDqg==
X-Received: by 2002:adf:ec0a:: with SMTP id x10mr51756800wrn.193.1555419496176;
	Tue, 16 Apr 2019 05:58:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	v184sm39476572wma.6.2019.04.16.05.58.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 05:58:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 13:57:31 +0100
Message-Id: <20190416125744.27770-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH 13/26] target/arm: Clean excReturn bits when
 tail chaining
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416125731.E3Qdro8_vrC7H4uF7NuO1Tn8Wv9Ud2JmmPftSyx3yyk@z>

The TailChain() pseudocode specifies that a tail chaining
exception should sanitize the excReturn all-ones bits and
(if there is no FPU) the excReturn FType bits; we weren't
doing this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8e72e1097ce..fe8e78fe36d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8081,6 +8081,14 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
     qemu_log_mask(CPU_LOG_INT, "...taking pending %s exception %d\n",
                   targets_secure ? "secure" : "nonsecure", exc);
 
+    if (dotailchain) {
+        /* Sanitize LR FType and PREFIX bits */
+        if (!arm_feature(env, ARM_FEATURE_VFP)) {
+            lr |= R_V7M_EXCRET_FTYPE_MASK;
+        }
+        lr = deposit32(lr, 24, 8, 0xff);
+    }
+
     if (arm_feature(env, ARM_FEATURE_V8)) {
         if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
             (lr & R_V7M_EXCRET_S_MASK)) {
-- 
2.20.1


