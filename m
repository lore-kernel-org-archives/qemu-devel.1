Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D8FC4BA0A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:44:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11FFF21D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fGP9Oakb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FFF21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6rMv-0000jO-5G
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 02:44:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6rIF-0000eD-TT
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6rIE-0002g0-Sw
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:43 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:40452)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6rIE-0002dS-Mx
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:42 -0500
Received: by mail-wm1-x331.google.com with SMTP id t14so1834875wmi.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 23:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S9pktUuhm3cFsoTdKjHqI4O8qBGSk0lfZcpYg3JOvj4=;
 b=fGP9Oakb3FdGXUokUWecoPpeib38CtBmH2v2J7SANeKhor+zIrPULhRwJAR3TR8A3m
 zbSDrtOJaUejvc4on6Gphm7RJ7DeUSsQYFZuueHu38r2tanK1PUK6BxmiA1W5yPcIVYk
 LV+/7AmkNcN+Q7p8Ad8B8meG/hMM7bBSK/2RR+vn9mnY3jvhGwY0khY8DrGbfJtJUK6k
 qNm/Fw+zVlqXCHtrJFAe4LfXp+dHw5frWTjkATSbMmoTDJ7YNDIUmBrNzJCinOOEmHMW
 5F6pKzskuiM+DcMYEOBCN4nhGIgqGS9tbaWqFccTWfzp7jGEtx4Q1X205Tf8O8YPjILr
 6D5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S9pktUuhm3cFsoTdKjHqI4O8qBGSk0lfZcpYg3JOvj4=;
 b=YLB04L/X7huDtuS4c/I9yWIk8yaLUZl9Z1yA1XDL5plooTjhuhDPqufkZk9Pz8LprW
 qprG+jTjrhK6N7AOb4MsTg+NqktGzu7I+mP9BJCn0g/lxUDRsCVoobVJtdg+c+Q4vYCY
 /UWfndrZNbu6+sllb0HhPlXNmUdB7geWHl42IpA5/yJb41DYIU4S61lSPAlXfSvJ6CLj
 tIkYZxEgEph6WjkRLjD/dF/wrLz0UkpzF4iu2XpEn28kmlXuHC9fLdGXUfyQK0HuV0ZK
 wms5u2YNqQ8ZysMfhjT+ZYERALSnCo6Bjwi+Tqll1ZDoamK02+lJO9oPM2Pw3csPUUSc
 h5WQ==
X-Gm-Message-State: APjAAAVyuDEScXXYD7k09mFELDFOWKmCvnO7vxai9DlR52aoqsElVEtF
 ESOAJ7K768qGbLU33R/Bugm6WtBVCl0=
X-Google-Smtp-Source: APXvYqw2hxuRb6aSFluCP33qJw4Tiy0FFJSS3zUnwWbWBfEwDbk8bAYfjLo2Le1bG+tVdrRYoSPQ7Q==
X-Received: by 2002:a1c:9602:: with SMTP id y2mr3719317wmd.23.1582702781638;
 Tue, 25 Feb 2020 23:39:41 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j16sm2087315wru.68.2020.02.25.23.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 23:39:36 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D93F31FF96;
 Wed, 26 Feb 2020 07:39:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 07/19] travis.yml: single-thread build-tcg stages
Date: Wed, 26 Feb 2020 07:39:17 +0000
Message-Id: <20200226073929.28237-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200226073929.28237-1-alex.bennee@linaro.org>
References: <20200226073929.28237-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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

This still seems to be a problem for Travis.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200225124710.14152-8-alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 0612998958b..f4020dcc6c8 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -400,7 +400,7 @@ jobs:
     - name: "GCC check-tcg (some-softmmu)"
       env:
         - CONFIG="--enable-debug-tcg --target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
-        - TEST_BUILD_CMD="make -j${JOBS} build-tcg"
+        - TEST_BUILD_CMD="make build-tcg"
         - TEST_CMD="make check-tcg"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
@@ -409,7 +409,7 @@ jobs:
     - name: "GCC plugins check-tcg (some-softmmu)"
       env:
         - CONFIG="--enable-plugins --enable-debug-tcg --target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
-        - TEST_BUILD_CMD="make -j${JOBS} build-tcg"
+        - TEST_BUILD_CMD="make build-tcg"
         - TEST_CMD="make check-tcg"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
-- 
2.20.1


