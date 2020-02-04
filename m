Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9357C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:47:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B14622087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WsgQtKZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14622087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz3Dw-0006Of-Qa
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 13:47:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iz37s-0002N1-CQ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iz37q-0003Go-Qe
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:44 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45913)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iz37q-0003EC-Jm
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:42 -0500
Received: by mail-wr1-x430.google.com with SMTP id a6so24376103wrx.12
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 10:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YbdnoWYrcrFJCkRmA0BnB9+YlHXUY82nQYA3dnh99Us=;
 b=WsgQtKZOciuja1Lc87Hw+DFr+OrESuvVO4pv13Qd8Oouo0nGJ13JQsWj4+77CTezMw
 FbYA6RRZiktMGWiwkHYjkdBzzFElkG02hMnzBBm249DzZI3+wQt5akCmIdU0cnJf4Am3
 TimutzkTirxBInV4VKyCqXgNzRt/I3UfXcsz5UPWWPMFkbQ/M6SsFzrg4gCu/ZOqBwvP
 0qNaAho0leRWkc5IHDx1P2bB5+yK2M9qte53xbBIyGGr7nSf5iMYMCJIX1216UFu+gzB
 4DduT66TEPbXlmHzDbF2na7HIAuV4xhhYq+Xwktv46sPzT7RQZkkiKz8dLnjuZVAE+M3
 1JyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YbdnoWYrcrFJCkRmA0BnB9+YlHXUY82nQYA3dnh99Us=;
 b=GXt1sJU0SwrIF9Ft/JsYT8Yjiz7uVpiMffz5M/jHS9xunPLLvMIHmW7lf2FOUSL+nU
 nQYHmoV7VbfjfKSNpgEFogn/hX9nFW5kk22H2gBy5yl3W4JlBwhyRnfeZ98mz4IOQmmI
 Fd1+Y3oCVkqMqKxQajoNLvhMI7RT+est4QtSvdO6Ur/VvasfpLqTUdPCaNgcvre41Gk0
 tjrdMsNhevuNnpXbPlEiHwr+QWYndl7/XJI42zg3sFgTGmo0/vhm8nCxbGLIu+QWhddc
 BajlIloxbMjHPL3E8d8rCTaK4tSKHTEPJLdbWgSOjFwRSIWkpL9oYTDflyCzISnMacbh
 YXeA==
X-Gm-Message-State: APjAAAUpK7OtK2HeEp7K/LFvRAZjJ7+lfiaqH2MVe7SXFYAQcPAC1w+x
 OYtcXdMIEmQy2drOIxWphkvQmg==
X-Google-Smtp-Source: APXvYqwc22RxrykAtdFidxnAkp88lzmYkvIU8u7oKlc5iCUIwWJ7bqz0FB83XdlN+o/Tm+kmOXPkcQ==
X-Received: by 2002:adf:f244:: with SMTP id b4mr22297562wrp.88.1580841641708; 
 Tue, 04 Feb 2020 10:40:41 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b18sm31284711wru.50.2020.02.04.10.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 10:40:37 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2085E1FF98;
 Tue,  4 Feb 2020 18:40:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 08/16] .travis.yml: move cache flushing to early common phase
Date: Tue,  4 Feb 2020 18:40:20 +0000
Message-Id: <20200204184028.13708-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200204184028.13708-1-alex.bennee@linaro.org>
References: <20200204184028.13708-1-alex.bennee@linaro.org>
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

We shall be adding more common early setup in a future commit.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200203090932.19147-11-alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index f245765cfed..1b92f40eab2 100644
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


