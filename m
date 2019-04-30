Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88366C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DB1F2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s7zetSty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB1F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50284 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLW9w-00028s-IK
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:03:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLW29-00048d-1Y
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLVzp-0000oo-Lw
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:46 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLVzp-0000oO-FR
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:45 -0400
Received: by mail-wm1-x344.google.com with SMTP id y197so4621953wmd.0
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=6QQdh13NNxE5UoxkV4nhJZifhNMFpyl1bUv+VGDgceM=;
	b=s7zetStyMVwOtgGHGCMZPOj51UB3ZdZUA+KwqJGKu83xP/Svqk7SH/x0GdfLOs46xb
	K1VAxh6NDZ8cxDCmuioNfgw1p7D6pmD8ijRq5ne5Z5CkwNGp++ZwFjUdVtNgLCoSPXRZ
	7w+Fa+jsK3DnoUVyjMqGdUJs7dVpu8LaDmi5fr4SrSI2t+850M+7QhjQUFb14Mr5hjqf
	HJDAHYHwG8yHiOUoGyH3EW8cBWUDs6N4fNcxHW5pkzBdsACvGt6iGTX4Jjt2xoi7ptw6
	DC3rqCBuuqIjD/cDn5srCuiEoddyGWhj2t6dBb8ZLeE+0JqH2ukGHvtYgMiBksl90Rr7
	PP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=6QQdh13NNxE5UoxkV4nhJZifhNMFpyl1bUv+VGDgceM=;
	b=JLFy39PR0/clgOKNUQ2pseiYEbvOCD1QQ9ls6Dvvq5GGrkwIeBS4BZi9fmc1slaj8m
	nTNdfNrqao7VC4w3R1cv6rWjrwpS43jgikAlRa7RQ8QxRCx7zXmi2Apmpqi37PgQssc/
	kp4X3zJ9J3RFNMgdAUYHFiYhJBLSvU2zq3eMX/IWQHtxrE2MPDS3EKuPQs3PbTURbXu1
	sbCAXjaowq6bkAC3ekp2sz5hasFxp13RCr1CfbGAqd2k9hTo9SWX+lDnX8dJ9hG8grRZ
	lRvQZQtLNyJj/RFjmg99xyUHyDo4d4d7dqnANhKl0Hea1QkWooLGkA/tWuYVPfEY0ER/
	zuYg==
X-Gm-Message-State: APjAAAUtZVGXmOu4HVX5vYWssAG6q3V5utKZiSM+Ciq642/HOFHYsFe1
	lVskK86aj1mP5YC72O2qREbBP8nW47U=
X-Google-Smtp-Source: APXvYqwW/q2Shp69TsVLH43g5nVAeSN7lBMPWr6jWrZTckKSDSl8xb13o1bboWrWSmMuzdmA7JHooQ==
X-Received: by 2002:a1c:c012:: with SMTP id q18mr3813035wmf.140.1556643164460; 
	Tue, 30 Apr 2019 09:52:44 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	d10sm3595630wmb.15.2019.04.30.09.52.38
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 30 Apr 2019 09:52:43 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 26AA41FF9D;
	Tue, 30 Apr 2019 17:52:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 17:52:32 +0100
Message-Id: <20190430165234.32272-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430165234.32272-1-alex.bennee@linaro.org>
References: <20190430165234.32272-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v5 13/15] Makefile: fix coverage-report
 reference to BUILD_DIR
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430165232.2w-thjvUBFnLLWVze-a0cpaxAj4rnm2einedQMK8_Iw@z>

Commit 337f2311f actually claimed to do this in the commit log but
didn't actually. Oops.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 626a04d305..45dfe1b585 100644
--- a/Makefile
+++ b/Makefile
@@ -992,7 +992,7 @@ $(filter %.1 %.7 %.8,$(DOCS)): scripts/texi2pod.pl
 %/coverage-report.html:
 	@mkdir -p $*
 	$(call quiet-command,\
-		gcovr -r $(SRC_PATH) --object-directory $(BUILD_PATH) \
+		gcovr -r $(SRC_PATH) --object-directory $(BUILD_DIR) \
 		-p --html --html-details -o $@, \
 		"GEN", "coverage-report.html")
 
-- 
2.20.1


