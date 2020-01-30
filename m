Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82799C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 491A3206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZMTgcGIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491A3206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix8CE-0004M9-F7
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 06:41:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ix89n-0001HP-S7
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:38:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ix89m-0008R2-CC
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:38:47 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33220)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ix89m-0008PV-4Q
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:38:46 -0500
Received: by mail-wm1-x344.google.com with SMTP id m10so6257666wmc.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 03:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GYWzU+Yl4eI2jalTIIfeVTyzqasBP2kFB8JOKXhgvmo=;
 b=ZMTgcGIeUUwIH1K6OtmQjN5aYjDIOwFppU4ePD+ELlpH0EpqnWgdlZrjoLbVLw1c8y
 PrLC90XaDfwSETMq9ozVtO79130LhQPWw1UgUMmdcKBoAsKppMfc8PzexPjN8qL+PSyA
 VkpklC57Y1l1jKt2SJkNzDuLAT222hexnE2cWul+Z/SoGTY+hDARkdQG9JyNUuXeiIWI
 np7ELWxe7/KxkTiIkcCRa0NXmE6gha8e6J7rYZBzpfmhcvBkoj/Qi6+Syp9Xlx6kJrjx
 BcmCy8ofliCmFhiBHEpBr3P4E/A9CoLl1zmgIzE9dxus9lUtdHRRchCVMdz1mJ5M5ho6
 SAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GYWzU+Yl4eI2jalTIIfeVTyzqasBP2kFB8JOKXhgvmo=;
 b=rtLPFB5XxCdDRFLQZTJu4ITHbl6oRBnMD6edpq67bB7a7SCcTiguwyuhLLOx02clCj
 Owvh3eYJHwOkBSM3dBjeO+Zop8jLxSSi8LyPkbqsD1qNVjxoajp1E5uQgtwxpGPp8h3p
 McHGJFQTGugLFULi0GN6nK243weodGIaKYcB33sRKFqv+vGu2t+0d+AxvGpEZCf8Kwql
 jr7b9gSe93h0wynudr+I4MffkbzAhVPn/NVYRuGRFvBnSxoiCvF20c4exLjYDge65E4Y
 sEEaFXcTfNCRIlJuJv2j1Ayod8yRVVcMwA9ODQVe9bNpaf8bCQW92HcJONJa2XEWOWbu
 yMOA==
X-Gm-Message-State: APjAAAU1v51jRTQf3SlmLrXJ7ae3c9X1GWpPtFzuNSid34aHo4NE80N3
 Su0SX0cHmdhRNlcFTjjw3QGtmw==
X-Google-Smtp-Source: APXvYqwJ/7ZAXRefDna75rnq3VdRD8wVi6jLNbH7BkfOvC6cL9imfkJWqY7zFSzwT2RRrTznnfBa8A==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr4959285wmj.57.1580384324877;
 Thu, 30 Jan 2020 03:38:44 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w26sm5833886wmi.8.2020.01.30.03.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 03:38:43 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 14B371FF9A;
 Thu, 30 Jan 2020 11:32:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/12] .travis.yml: move cache flushing to early common
 phase
Date: Thu, 30 Jan 2020 11:32:21 +0000
Message-Id: <20200130113223.31046-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130113223.31046-1-alex.bennee@linaro.org>
References: <20200130113223.31046-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We shall be adding more common early setup in a future commit.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index f245765cfe..1b92f40eab 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -82,11 +82,16 @@ git:
   # we want to do this ourselves
   submodules: false
 
+# Common first phase for all steps
+before_install:
+  - if command -v ccache ; then ccache --zero-stats ; fi
 
+# Configure step - may be overridden
 before_script:
-  - if command -v ccache ; then ccache --zero-stats ; fi
   - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
   - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
+
+# Main build & test - rarely overridden - controlled by TEST_CMD
 script:
   - BUILD_RC=0 && make -j3 || BUILD_RC=$?
   - if [ "$BUILD_RC" -eq 0 ] ; then travis_retry ${TEST_CMD} ; else $(exit $BUILD_RC); fi
@@ -268,7 +273,6 @@ matrix:
       before_script:
         - brew link --overwrite python
         - export PATH="/usr/local/opt/ccache/libexec:$PATH"
-        - if command -v ccache ; then ccache --zero-stats ; fi
         - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
         - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
 
@@ -499,9 +503,6 @@ matrix:
         - TEST_CMD="make install -j3"
         - QEMU_VERSION="${TRAVIS_TAG:1}"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
-      before_script:
-        - command -v ccache && ccache --zero-stats
-        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
       script:
         - make -C ${SRC_DIR} qemu-${QEMU_VERSION}.tar.bz2
         - ls -l ${SRC_DIR}/qemu-${QEMU_VERSION}.tar.bz2
-- 
2.20.1


