Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27918C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:36:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF06F20787
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GHvLLkox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF06F20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy8MU-0001Ew-8A
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 02:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jy8Fl-0007PI-Ph
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:29:21 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39656)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jy8Fk-0006vr-7t
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:29:21 -0400
Received: by mail-wr1-x442.google.com with SMTP id q5so705436wru.6
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 23:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ltWiVwdUknugsiDwNPNQ/zuHjy+8DNFqI6hfoHm84KU=;
 b=GHvLLkoxkpao1nPfCrN0SbryTXyG9S4FyTHb6vOW0CnHx+giro9PQ4S8MLrrUJSbOK
 rDfMnMDzcmqEc/5igOMO1WgKsotlj3/pe2rGKG7FIAliCqf+ov9donIDGHyTft4tyOpc
 HbOnHW+18cZxnxW4xRS7/0MxWLGtLyi2Gd6tBCarjrfbV7udqPSKjZ/puX+Bi1bBuqx+
 v1Hl1EJGu52P4zT1Os1piGjxdqRCd5dDuLV3nXE5Rp27N0NY+kiGzSocy4rbJyWH/syA
 Jo8VG/nJYh8vJFenvQB3kB7YWESLFPwtajfKUkTFkEB17cl/v2K6GMizUFSMGTc/mPk0
 IwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ltWiVwdUknugsiDwNPNQ/zuHjy+8DNFqI6hfoHm84KU=;
 b=lvFKGX0vlbzDlywkZvlUDS5knssVh0cTEtbTs+H7rtDFNUel1YZ/MBMQcTGeILfjN4
 eHTXdWiU9gC7grnauQdDPJUIlLikWry2TNRumplSNFc4w57MjwKIvqwO+Je9OnxZrLq7
 rjNpelDPWLPOlibjN/POqtiWYJJSPCz/KnSiK2kT0ZVq7wziTgICM/Cr4iO0ynQj1h1H
 gpLtfeOcL6kB1dYpyzhbS2k4HMLQpeRtTNJFcOtDIfrZ2v+HRg7mUVfBRyGaRZoqCS/k
 HZXDiPY98eSuhqLPnl7uD4sI6HB0Duuu23vQBxBIanpkk9OA6qMtaPQOMUlG32f9Ydcp
 r55w==
X-Gm-Message-State: AOAM5316uSeg9YLuPC3Vca5p3tW5YC8D0/Z9IY9W0y/n60ervyC/kXrp
 5QJ6EwchCJe0+K/F0IQVRWkYP2W30Mo=
X-Google-Smtp-Source: ABdhPJx5WPi0QlB2sSZ04waoWE8NVJyqAS/IOusW5FTbNrEdMtwGDrp/M58GJ97Mgtfec82beb+8mA==
X-Received: by 2002:a05:6000:12c5:: with SMTP id
 l5mr32281935wrx.219.1595399358737; 
 Tue, 21 Jul 2020 23:29:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 60sm15886959wrs.20.2020.07.21.23.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 23:29:11 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E5D661FF99;
 Wed, 22 Jul 2020 07:29:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 10/12] tests/docker: fix binfmt_misc image building
Date: Wed, 22 Jul 2020 07:29:00 +0100
Message-Id: <20200722062902.24509-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200722062902.24509-1-alex.bennee@linaro.org>
References: <20200722062902.24509-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we updated the arguments for docker.py we missed a bit.

Fixes: dfae6284
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index a104e9df281..9119dff97de 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -78,7 +78,7 @@ docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/debian-bootstrap.docker
 			DEB_ARCH=$(DEB_ARCH)					\
 			DEB_TYPE=$(DEB_TYPE) 					\
 			$(if $(DEB_URL),DEB_URL=$(DEB_URL),)			\
-			$(DOCKER_SCRIPT) build qemu/debian-$* $< 		\
+			$(DOCKER_SCRIPT) build -t qemu/debian-$* -f $< 		\
 			$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) 		\
 			$(if $(NOUSER),,--add-current-user) 			\
 			$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))	\
-- 
2.20.1


