Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA7FC04AB3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0EE621019
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ibiMJ0eA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EE621019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58476 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmoc-0005Yf-80
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:26:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmU5-0003nN-Ji
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmU4-0008BA-3v
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:05:29 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hOmU3-00088H-RW
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:05:27 -0400
Received: by mail-wm1-x342.google.com with SMTP id y17so3237912wmj.0
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=3OsvAqRpGCpyIsZPwRA2TrRs2ee15ZUjq1ExWCyXpJs=;
	b=ibiMJ0eAd6Rc8gH7ufafmwKVLWzWEnig8fbShtf9FiNsWFKRJFaxe6jFZ788hjpmzG
	iDZ/V/D6E0thUxiFRNsoHO/ca+ZL8abITKpxiZlFTD0hFRAdDCSBtIl7YGlPwQARUZlK
	S4d0905179gJHMTSvYHNLFvLcBisUasWHGIWzfGWr8wLlXJjD3Pw38xCq2KozwRC8a6Y
	jBrtkrg8w/nUOiuqt6vC9vFpz86TEafDv71ja//34asZSadzbXuaddk4+jkfReONi3Ah
	YpkmSQjS+2nGwDzqb3xngsdNOCVIDsah3b8zdn+W7IILt9Wm+kKXaDtJ9ltgWHvKneYf
	883g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=3OsvAqRpGCpyIsZPwRA2TrRs2ee15ZUjq1ExWCyXpJs=;
	b=LXWha3sSy3oWhCHz7wlV2QhwFXfNkLg0oGJvuSWOTf6hOcnx85HUc/xN8U/PVNFyGo
	KDXXCbw2SfpZYShxPExBY0ugU+5HHoOQGuZRY9ZhvHAt2cowGVS8GcrY58CCo7u/5uAZ
	DW6j8zM5rxX7N/D1EtU/1pGPNSyekr788YfSmwUVxiwxfAwDKsSyNSJmUojS/RLKDJ8W
	D/qScvoIsGPcZR/ZHpNOnvISwCKaY/PhVu7vzb4YEFf9rADlp7PnRo5sVBGbxxuBME1T
	RuKit2+rf19GPXPK6ho/+Q4mVQTyfIuwBB2nOlX/EfYu18+b6vl9fU6nXDJe2lS4BOhy
	a35g==
X-Gm-Message-State: APjAAAWkcMCzIFlUf6tGFTMNZtsxF0suleZO/bbrTL8r7fOyhA2XES/g
	cWz8GSc49nYiIKmFS/XhqHvY7Zhuz0I=
X-Google-Smtp-Source: APXvYqx/uBp+aJJNZSEQ/2FTaQhQMC9Mxwy9gNE9S2MUiN00r5MvXvt6IlWIZuLJh0aCPCqRkrVr7g==
X-Received: by 2002:a7b:c053:: with SMTP id u19mr3595551wmc.63.1557421523804; 
	Thu, 09 May 2019 10:05:23 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	h24sm4458598wmb.40.2019.05.09.10.05.21
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 10:05:21 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 395F41FF9E;
	Thu,  9 May 2019 17:59:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 17:59:02 +0100
Message-Id: <20190509165912.10512-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509165912.10512-1-alex.bennee@linaro.org>
References: <20190509165912.10512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v1 14/23] Makefile: include per-target build
 directories in coverage report
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 78d83244849..a1c844eb87a 100644
--- a/Makefile
+++ b/Makefile
@@ -995,7 +995,9 @@ $(filter %.1 %.7 %.8,$(DOCS)): scripts/texi2pod.pl
 %/coverage-report.html:
 	@mkdir -p $*
 	$(call quiet-command,\
-		gcovr -r $(SRC_PATH) --object-directory $(BUILD_DIR) \
+		gcovr -r $(SRC_PATH) \
+		$(foreach t, $(TARGET_DIRS), --object-directory $(BUILD_DIR)/$(t)) \
+		 --object-directory $(BUILD_DIR) \
 		-p --html --html-details -o $@, \
 		"GEN", "coverage-report.html")
 
-- 
2.20.1


