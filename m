Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A75AC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:42:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0568F21655
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X3RIdHG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0568F21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpsFG-0002rF-Qq
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39606)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hpsEz-0002Cs-LY
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hpsEx-000494-M4
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:41:53 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:33145)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hpsEx-00047w-Dp
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:41:51 -0400
Received: by mail-wr1-x433.google.com with SMTP id n9so42701142wru.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xaoZEvLN4IL9Dt8w+scYYy+PugidW1l4kvvMHsOXzQw=;
 b=X3RIdHG5aIpTTYg8zSKcH8ADDJ/41HKij53VpMtS+vv49SxNYelzSh3yMLGdYqcGu1
 FUnEZVMIXxPNTUK7r3cXdfgVSejp4Le6E7g5iYJU2MRPagO+neFMf04RRI7RQJZW2/RR
 OMvfXPpXfu3UEo5mwdN+SdHDUjGoBts3YD1m1vyWvfZIX9kPLV73XE4iamrLAfg8SHsZ
 r8lZ492t6eVl0FGf773Tqsm3PK7haGyYCC+1P3s+zWmeDklu/Uvrne4ZpatSSJSGtBw0
 2qKUCjWw1r7Gd7ygTagW4pxOIt/VGNxYF/PYmUGuk1OzaUhtfVTxJkSCZ1vWT+l0Mb+X
 F6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xaoZEvLN4IL9Dt8w+scYYy+PugidW1l4kvvMHsOXzQw=;
 b=Z0U+jG4P89OyWKuOhnits1a7MBGUumlLVwSfM5ITc0o3tGyk4WLwvhvK55X6/jskuq
 GIFCP83L/aBigLNtrAc6r6vP9/P9fo7Dzfj5L4m1MZAOrq7YQnSiV67wqoPykJ46JdhE
 HHHLVYw7CfwPugvB7x6OAs62+yO113LXGHNAw3R3ToiE5v6xQ+FdIa6lCVt8kWALpMYk
 kAstVfprujBNzNxzDQc7Y9wZhY3U/ETLR7844aRJrruVNDu5UbFGGBwPI+6G+uYhuTz/
 ZwMiEm+25QNfnA6ZYlgDzL9y4Gd4UD3xADOm+SwTZDBqlEqVYPhqwCCobqQwUzKltqtU
 rFdA==
X-Gm-Message-State: APjAAAUlh2yucgO+4zqwqPybOUJjcvSh5nG2WLUt/qouxjaG0Mhgpx5l
 dVl47Q/sRyRiwKSVWywzr9g74Q==
X-Google-Smtp-Source: APXvYqybKFBkovfNGhqFus8btkfytxp4yFmoxjvyykXv3BuB5RokgXotirVMWaOxrdwF1iu9bGTUHA==
X-Received: by 2002:adf:b612:: with SMTP id f18mr70121603wre.97.1563878509818; 
 Tue, 23 Jul 2019 03:41:49 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id c7sm35490750wro.70.2019.07.23.03.41.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 03:41:48 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0E9671FFA6;
 Tue, 23 Jul 2019 11:36:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 23 Jul 2019 11:36:08 +0100
Message-Id: <20190723103612.5600-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723103612.5600-1-alex.bennee@linaro.org>
References: <20190723103612.5600-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
Subject: [Qemu-devel] [PULL 19/23] tests/docker: invoke the DEBUG shell with
 --noprofile/--norc
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's very confusing when things work in the debug shell because the
environment is different from what the test is running. Fix this by
ensuring we only have the inherited environment from the run shell.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/docker/run b/tests/docker/run
index 7aebf4b5698..1014871fec0 100755
--- a/tests/docker/run
+++ b/tests/docker/run
@@ -62,7 +62,7 @@ echo "* Prepared to run command:"
 echo "  $CMD"
 echo "* Hit Ctrl-D to continue, or type 'exit 1' to abort"
 echo
-$SHELL
+$SHELL --noprofile --norc
 
 if "$CMD"; then
     exit 0
@@ -72,7 +72,7 @@ elif test -n "$DEBUG"; then
     echo "* Hit Ctrl-D to exit"
     echo
     # Force error after shell exits
-    $SHELL && exit 1
+    $SHELL --noprofile --norc && exit 1
 else
     exit 1
 fi
-- 
2.20.1


