Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2C1C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 441D520736
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8L3e8He"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441D520736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWIp1-0007Zx-Az
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 08:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWInz-00066T-BT
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:39 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:42895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWInx-0008Ja-Ez
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:38 -0400
Received: by mail-wr1-x42c.google.com with SMTP id s8so1880372wrt.9
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 05:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dEL/a/ImN1rYjqCt4xsqKBQ8Hzw1yVkwjK2i4M7y2YY=;
 b=e8L3e8HeID6KIlJO0jF7OHZ2Z3gTQ1TSEXJt38hAP32oIXg+zFD/VXQnoenkP+22Oq
 cYMfnDJZhJm4gKBV3WLjSPmWAyUNRZDFzmjuFbKcvKId1M+xgsiYVAp2nHTjeU7jMPD/
 o+S8MiPILQFZcg4/LK1JZO/cvZldDagFckJDra73qooT7VnJUIed3JMrmWaMNWTGIfZ1
 qJg/Gemjly3w2wJwsXKg9rmhBFAb6wC+gHpp4msrEdfq2a9M6WPwljMMXIB5O4hVWex5
 aG8YSgC3t5GtPjR/1AOnAHGwidlHSmRhTtZg/GYOSBn1Y9a50titbKc+ftGTo7yGCnfV
 pV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dEL/a/ImN1rYjqCt4xsqKBQ8Hzw1yVkwjK2i4M7y2YY=;
 b=ZtWcdCQWlCIl0qLi33avuPxQof3VffktIUKWWmFcM1u3K15J9rLjQb63utqr4CdZC5
 KkItqe1+K6WeD5V69JHu0m2YKdF9aoyJXDcr0v0jmFR2usubXGt59JFYRToenr/0rglz
 QmaM6hPDb+3CWr6Pv0pTj6qTX+iCqUJoS/kerC+zIOzLtsOPJSV4jRdMKSxOJvfML3ng
 7j3o/Y42q9A43o2Og6qbC2XT1WG/akqGWUXo2i1TbeXtEInVA0Ba58++7vnSileqTRaA
 GzYXI9mnPriykPaYcbfRfpH6KJu39y0Oo+zaoHNMCPKqj4bLvLLcsMvz76S9Dcsrc8vk
 /SKQ==
X-Gm-Message-State: AGi0PubIcBpz096lvnZpvPYRYxAmYftwSnVj2Xj+7S4t7UvHwzauT2Wy
 OrUoowh5vGbW44pzPI1UkcIDh9mxfHw=
X-Google-Smtp-Source: APiQypJ00Fb8l8QDfc+jre9w/m82j+kT+a9s/8TKuSeoqe3G7lsp9cFF9L1LM5JQ8d9QyC2NgpQK2w==
X-Received: by 2002:a05:6000:1203:: with SMTP id
 e3mr9997532wrx.229.1588766734818; 
 Wed, 06 May 2020 05:05:34 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h137sm10939484wme.0.2020.05.06.05.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 05:05:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D5A2D1FF8C;
 Wed,  6 May 2020 13:05:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 02/14] .travis.yml: drop MacOSX
Date: Wed,  6 May 2020 13:05:17 +0100
Message-Id: <20200506120529.18974-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506120529.18974-1-alex.bennee@linaro.org>
References: <20200506120529.18974-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_FILL_THIS_FORM_SHORT=0.01,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This keeps breaking on Travis so lets just fall back to the Cirrus CI
builds which seem to be better maintained. Fix up the comments while
we are doing this as we never had a windows build.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200501111505.4225-3-alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index a4c3c6c8058..49267b73b36 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -9,9 +9,8 @@ compiler:
 cache:
   # There is one cache per branch and compiler version.
   # characteristics of each job are used to identify the cache:
-  # - OS name (currently, linux, osx, or windows)
+  # - OS name (currently only linux)
   # - OS distribution (for Linux, xenial, trusty, or precise)
-  # - macOS image name (e.g., xcode7.2)
   # - Names and values of visible environment variables set in .travis.yml or Settings panel
   timeout: 1200
   ccache: true
@@ -271,31 +270,6 @@ jobs:
         - TEST_CMD=""
 
 
-    # MacOSX builds - cirrus.yml also tests some MacOS builds including latest Xcode
-
-    - name: "OSX Xcode 10.3"
-      env:
-        - BASE_CONFIG="--disable-docs --enable-tools"
-        - CONFIG="--target-list=i386-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,x86_64-softmmu"
-      os: osx
-      osx_image: xcode10.3
-      compiler: clang
-      addons:
-        homebrew:
-          packages:
-            - ccache
-            - glib
-            - pixman
-            - gnu-sed
-            - python
-          update: true
-      before_script:
-        - brew link --overwrite python
-        - export PATH="/usr/local/opt/ccache/libexec:$PATH"
-        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
-        - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
-
-
     # Python builds
     - name: "GCC Python 3.5 (x86_64-softmmu)"
       env:
-- 
2.20.1


