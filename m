Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4172CC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:17:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CD0821726
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v30EqjJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD0821726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cf7-0006nG-6d
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c3s-0000qy-5Z
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c3r-0003RZ-0O
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:28 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:38213)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5c3q-0003Qy-QS
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:26 -0400
Received: by mail-wr1-x430.google.com with SMTP id l11so211189wrx.5
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RZ6UCCmDQGiaJqZTOCfEgLv5zu9MkUOibodewE9UvRo=;
 b=v30EqjJMH8BmvMqwQKLEiqct6fZkZnpWRILVtdxfe0kfH6Y/Xw2F3HKVQQ9QQjLu+8
 Hdim7zvcT6sebcUjHfDN/fBnwEHa38G4f6hotyxaFQcUwIvfpGrfbZaEZUpVWL0AzvF/
 QDdNkz5MLGESvSFJpIDEqdSsMcGX7nAsgCZAJuMd3JmCrqG+ZQlXQKKjZn1ui+R3UJNk
 iqCFf8rKBjE3nUFLKk0sGeBZHr8paXg8YLASibM+IybugiLQzbfJVHJy8hdteBeoNiUW
 FGxIfXx+pajWzCKeh9bO1DIB/8T3tyt05Gez3TRcjzmU8SuL2fG2gKvO2blxtvyBRNy3
 1wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RZ6UCCmDQGiaJqZTOCfEgLv5zu9MkUOibodewE9UvRo=;
 b=jWWGU95E6cxgJcbNVlluHhTh9U7RlD/hIAeFLek1zd17d27E+XK8Kib764Z1gO+f9K
 0SEkMI+SOOmtzH1Jj6iNNZJF2FYwl5sZNmJUgrLEd5SXRsbkDLnKYDFcYQMcCBNgh/E8
 J6HYtkqb2NLhmE4HqNrvX7/u5wZolz1tTgD9/cMjDA56yIq1do8pNzm481PBU8h5hMMU
 b/2R5HnCbvp5lWFwSk5xigrME1ZlBrQi4zoQ52wz/6tEbsdoL9kB0cHMIv3jyzJBuDIP
 17rkLbSPVAU1mo31ZskIHdEV04PFRXHVonYucxXhfzZ/S0a1o3GbT5dUm8OA4jf2nVeg
 qzVg==
X-Gm-Message-State: APjAAAXQJY4uRz0eao8AYGTid1sRBnG1b+fuXiWUvWPLyJky7uQ3mmpS
 DGjKyhiOLmOU7YabDaeGYH/ECA==
X-Google-Smtp-Source: APXvYqxKaRuRcWc+tfRStHN53vgfGH0Q2mNj3OmYBeVDoHSAQQtrca4aHWi2EspJT1PpGsmwcpD73A==
X-Received: by 2002:a5d:5444:: with SMTP id w4mr33955790wrv.180.1567629565690; 
 Wed, 04 Sep 2019 13:39:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r65sm263483wmr.9.2019.09.04.13.39.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:39:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 94E6B1FFBC;
 Wed,  4 Sep 2019 21:30:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:30:06 +0100
Message-Id: <20190904203013.9028-36-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
Subject: [Qemu-devel] [PATCH  v1 35/42] .travis.yml: Enable ccache on OSX
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

By default, ccache is not installed on macOS environments.

See https://docs.travis-ci.com/user/caching/#ccache-on-macos

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .travis.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 5a878ae6ae9..2dd26486abc 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -45,6 +45,7 @@ addons:
       - gcovr
   homebrew:
     packages:
+      - ccache
       - glib
       - pixman
       - gnu-sed
@@ -80,6 +81,7 @@ git:
 
 
 before_script:
+  - if [ "$TRAVIS_OS_NAME" == "osx" ] ; then export PATH="/usr/local/opt/ccache/libexec:$PATH" ; fi
   - command -v ccache && ccache --zero-stats
   - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
   - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
-- 
2.20.1


