Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96351C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 610392072E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LcxIqMwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610392072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipYjW-0000K1-9a
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 09:24:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipYeV-000159-5p
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipYeT-0005tk-1o
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:10 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:44546)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipYeS-0005pW-Qp
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:08 -0500
Received: by mail-wr1-x430.google.com with SMTP id q10so7535085wrm.11
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 06:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=26KkoYcZGF/Z1EiiFPHfujld0lbwHRd6NWNSd+b9VcU=;
 b=LcxIqMwBlAtpSPOHRRyruqvEbQl0dgyARiOdCDSmmBKhowQ5HVfYKCESyrx6mdTelH
 gE7w2NuUTgWyY/fcY39fqxqCbyKUXbJTjBCTmMm6ZBEsoD0z0QRtoMLpsLaSsrsDxrNS
 bE8QGgb4sYDbZBDyTmNSk7dllorI7GNH95YD3j0pyNW/89BNG5xOri5kDJ7FGpLsYPlP
 CPZl/zYXoJQMkjCDvUZZQSriAWci9QpRGHKWKOlw5Y3XXCkl8pc20LBeLE2dOITuV+Ve
 tKKpDnsbUft05oW+1vULN4XOxgBc7rJsQ+w/ucVOI5oJoSRMjz3Qo7dtxBGhYXehx2eF
 MnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=26KkoYcZGF/Z1EiiFPHfujld0lbwHRd6NWNSd+b9VcU=;
 b=bNb+9zOZW1YpUYeOCHzVDbR8YqXDZWbXATRMtS+b64oOw6WfZ1D/vqpfiXJiZBtOae
 vlgc5a+geDwrrF9T6XeQkwh58ribs/1SRE9A+wbmG1oU5Ai+SghriB/tzbI+UezJBZd6
 g19qaAsIQj0sn5Jazq8jgwnP4WSXZz0cEfSWKJdDA5TdQ7TCtS41ypKjwaLMcTlC6/qS
 jCzsjrZPuWv1lRnHgKOHvgIznKMrEN9KQU86vMfJ2qwAOUuOjnNG+SDLpf++xbz1RoG1
 Guq943aFCCOLf9VrlrJQCMCNsF7Gy/GP/sKvm47gDvyH1BqSJS0MsTrNhwP8JP6WQwL5
 fbtg==
X-Gm-Message-State: APjAAAV7fXBY6NP9L8mp1pPPJLfEtQepzNwAK7Kd042+le8wLmX/W2JK
 D2sEaYAlg1t8s1csKaaWNrDPOQ==
X-Google-Smtp-Source: APXvYqz0cpoPWfrNCGE9PaFZD+wAt+kl2nFOAnEhnjan98SPZSpPzlNziCwMi//Yi3m1zwb5uNGVEA==
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr12008091wrq.232.1578579547641; 
 Thu, 09 Jan 2020 06:19:07 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u16sm2984008wmj.41.2020.01.09.06.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 06:19:06 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 760291FF93;
 Thu,  9 Jan 2020 14:18:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 06/14] travis.yml: duplicate before_script for MacOSX
Date: Thu,  9 Jan 2020 14:18:50 +0000
Message-Id: <20200109141858.14376-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109141858.14376-1-alex.bennee@linaro.org>
References: <20200109141858.14376-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rather than keep the hack in the global code lets "Think Different"
and have a special copy for MacOSX.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 848a2714efe..6826618ea81 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -89,7 +89,6 @@ git:
 
 
 before_script:
-  - if [ "$TRAVIS_OS_NAME" == "osx" ] ; then export PATH="/usr/local/opt/ccache/libexec:$PATH" ; fi
   - if command -v ccache ; then ccache --zero-stats ; fi
   - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
   - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
@@ -240,6 +239,11 @@ matrix:
       os: osx
       osx_image: xcode10.3
       compiler: clang
+      before_script:
+        - export PATH="/usr/local/opt/ccache/libexec:$PATH"
+        - if command -v ccache ; then ccache --zero-stats ; fi
+        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
+        - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
 
 
     # Python builds
-- 
2.20.1


