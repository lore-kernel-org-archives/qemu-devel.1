Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F96AC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C2632173C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3XgOo58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2632173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58171 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOma1-0000hJ-Gh
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:11:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmOA-00072Y-Tu
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmOA-0004vU-0L
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:22 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hOmO9-0004ug-R2
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:21 -0400
Received: by mail-wm1-x342.google.com with SMTP id f2so4079102wmj.3
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 09:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=6WJJoU9/+ULEvlFfrODWtYDGLHuXZHxFQnWAN9OdsAc=;
	b=o3XgOo58XEAWsXpoq8h3BLhNl2S1ydFFj3N+eCM8OqMuaRrfBsy6hwxkB1tsEqdTMJ
	cDN4VyUQAB8Z/Kn7Qb0YAW1ZKohB6FjNwnkj43tqhJUsmiwLs+22gfNhXD6aXgbcCN1B
	4rfAK7tV5cHUkbaduJu7RL32tx/2BeYybqmSG858i4YmfrXAzJsrJ///TJ/DgnlPueBB
	m9I5hlAOSxwP7Ljeq9o08i2r+aQfrnCzBkwCZ7q2MDno7v0KaY+YmoLADcEnrsd420Jz
	OhCrJpvsAwRcITlZeuH8qbXn4lCRgsCstWr1Dii4LIyvgNINtzS3t/wK1KW+ltNKV4Cy
	jWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=6WJJoU9/+ULEvlFfrODWtYDGLHuXZHxFQnWAN9OdsAc=;
	b=SZslaSAwk5FFxE+vJnsAZ7PLud4htEX2N8pRlAd4rDwcVznFdiREdJpRga0gkfJGGN
	25oUKfkE3L+q5EOL8SsIBXWeS6h237w0msX0pJaEMiDC4mtD58HGA8LwfAnHsONefN/C
	2sQUN0GJqElE9LgjnyCBHrtEu7POfnnOBcWFuzeBGrIrqTpAzLLocBV9xcrhaVLRlq/U
	iN0Tz0Fr/Qzs3DmyNbNlqKCm7JRUlSnlaNVbI2uMGnUp3sYKvXJrhIHDBl6Xpy4QgS5/
	Tkg0H6KaayXa9qjLyiTMmoUeFLWpWIpnHS7ht40nTbpEKF85C771ntOrp8r+e7y/LneR
	C1Gg==
X-Gm-Message-State: APjAAAVgnoqU6Fjv5lT4lPzR+B2cz4mWjkIfKowWTXbPvzjoO8T6A7xj
	3wAF9ltSWLbI2/8HEdToic0FAw==
X-Google-Smtp-Source: APXvYqy5QDOBpTXPK99MlBcC88Hn2cHTlSgMkGoWzGBoOv+IgWSjZ3jCZLcJ/3hwiww21RaYWbgoeQ==
X-Received: by 2002:a1c:1941:: with SMTP id 62mr3610037wmz.100.1557421160779; 
	Thu, 09 May 2019 09:59:20 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id z5sm7894192wre.70.2019.05.09.09.59.16
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 09:59:18 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 26F8E1FF9D;
	Thu,  9 May 2019 17:59:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 17:59:01 +0100
Message-Id: <20190509165912.10512-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509165912.10512-1-alex.bennee@linaro.org>
References: <20190509165912.10512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v1 13/23] Makefile: fix coverage-report
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 337f2311f actually claimed to do this in the commit log but
didn't actually. Oops.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index a971247cac8..78d83244849 100644
--- a/Makefile
+++ b/Makefile
@@ -995,7 +995,7 @@ $(filter %.1 %.7 %.8,$(DOCS)): scripts/texi2pod.pl
 %/coverage-report.html:
 	@mkdir -p $*
 	$(call quiet-command,\
-		gcovr -r $(SRC_PATH) --object-directory $(BUILD_PATH) \
+		gcovr -r $(SRC_PATH) --object-directory $(BUILD_DIR) \
 		-p --html --html-details -o $@, \
 		"GEN", "coverage-report.html")
 
-- 
2.20.1


