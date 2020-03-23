Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA1DC54FCF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC3CD20722
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fNZHTZXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3CD20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGPpN-0001Be-RG
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 12:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jGPjg-00011s-3y
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jGPje-0002UH-UX
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:32 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:42040)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jGPje-0002Tt-An
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:30 -0400
Received: by mail-wr1-x433.google.com with SMTP id h15so5618468wrx.9
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 09:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uu/UhD38gJ6eW0AaVvw7CVG5JlfdO8i7Z1wsvr8hc94=;
 b=fNZHTZXnMy/JrT6BLwdIimu3nt9xL7jagfb8fftKM1ueESt6l8mdbzS4d48NE014r4
 mnw72RzUjBYgvzW8OmETDKPvwKSXAvzzs7pP/ZpenXwV+lKFDOWhESME4Vjn2m/klAYA
 L1sp1vPFmOrnnD2O85cNBXvFyKfQbvU1SQVQzvHI4DHtIExXHVPtLM+ET6gdnd0jkQmP
 pxJylmV6BQBbnv1UOB9YIpySpDU77vlFBZ7PmykrPxwjWtwMPIwKOs33lIP92nqNLu90
 Tenz+QiTSTR/vhY5TRQAzOwAJzK2cp5FjGwYc1qr4+yAui0eEBOdGa/7y8qxsf7qiywo
 s6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uu/UhD38gJ6eW0AaVvw7CVG5JlfdO8i7Z1wsvr8hc94=;
 b=ejrRfcSWeAWDOx4t2xAWUN0msACpZbzCeevH9lYRQCmMAaAvRTHLXfF2XhQDM0Oa1d
 56/IPD7rAvvJHYRPIvtOQQlqfKaUD7QkpX7+cFP9sEhWgPo4EgcCLN8/o74a7Oejmakp
 ipSLKJeo67sU/hVNljXgbhtKEdKyViRrY4VuvSASCX6dY1U+j44fPBOHtTZHNN4+on7p
 MU0mZYo7Qhi07Q6y/mr5koxWLHwh9JNDC6yFpjoaNLJYm0vjjsB2cioSgciDgKOWRASG
 RLprVa7SnlyNP/xGJtj3aM/NdZnIlI8CTUBjv7eqzLa06M5JOwcBGfj4IFCqa8edfckc
 yQVw==
X-Gm-Message-State: ANhLgQ3h6BIVpK7uG8m/bVKGcR+fivZhizW+ijFaaSbcOK4Y0FF8TFKh
 /RYmYVMa6WDs4eKGWFkqRE4+hw==
X-Google-Smtp-Source: ADFU+vs/xfnEisHn846jdbqBQ4vnfDIPp2erOFAhZkr1eYuSItYtU6/vFFj7XaDmZ5STGqx53KLd1w==
X-Received: by 2002:a5d:6045:: with SMTP id j5mr29286186wrt.401.1584980129312; 
 Mon, 23 Mar 2020 09:15:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q8sm25217708wrc.8.2020.03.23.09.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 09:15:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 87FD11FF99;
 Mon, 23 Mar 2020 16:15:16 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 10/11] tests/docker: Add libepoxy and libudev packages to
 the Fedora image
Date: Mon, 23 Mar 2020 16:15:13 +0000
Message-Id: <20200323161514.23952-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323161514.23952-1-alex.bennee@linaro.org>
References: <20200323161514.23952-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Install optional dependencies of QEMU to get better coverage.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200322120104.21267-5-philmd@redhat.com>
---
 tests/docker/dockerfiles/fedora.docker | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 174979c7af4..4bd2c953af8 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -29,6 +29,7 @@ ENV PACKAGES \
     libblockdev-mpath-devel \
     libcap-ng-devel \
     libcurl-devel \
+    libepoxy-devel \
     libfdt-devel \
     libiscsi-devel \
     libjpeg-devel \
@@ -38,6 +39,7 @@ ENV PACKAGES \
     libseccomp-devel \
     libssh-devel \
     libubsan \
+    libudev-devel \
     libusbx-devel \
     libxml2-devel \
     libzstd-devel \
-- 
2.20.1


