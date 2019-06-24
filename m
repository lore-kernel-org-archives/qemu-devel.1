Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898EBC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:05:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E9E20820
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZJaBFGNn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E9E20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51460 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfPbI-0001EB-Jf
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 10:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41606)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGJ-0006jQ-Ti
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:44:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGG-0007gw-VC
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:59 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:50525)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hfPGG-0007WK-L5
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:56 -0400
Received: by mail-wm1-x32b.google.com with SMTP id c66so12881340wmf.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 06:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KxVNBoteG2ZKNWG79/wL8DSFUaTRSU+Jwkvg0mrRqy0=;
 b=ZJaBFGNnbPwK7O1wxovlElcbI5VeMEZq8hWNjdV3ZYNCu5j3cc9x0BnL7bsNi7b6gq
 Vfe+aWAbLYKSVPhO6sRGn9u+6RtJu4CJgXg6x5HLspWmKtKhqtOaDKyf/CNOepxGlmOl
 EssENbXG5zEDXffoz1NEkl2/aFgn4K1fOfcxtzkivlwf8VZx4cufjTqosYKbd/z4rPO+
 jWC7owKfFpPW8avzRyk2V1wnBr0KLRSaQDuCDSoYL+e8rDe9UpLqaiemYfOQTnv3nrLh
 YKINfixWGmPclt6YGf8BhdVjfhaot4F8hMoGTMIvVwEwLcTzqaV7VxctzuaX7LeCMKFM
 8/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KxVNBoteG2ZKNWG79/wL8DSFUaTRSU+Jwkvg0mrRqy0=;
 b=srOuXYvmVE/A8z0YnVJ/j2VDShYYDPRfIXZS0v4CVk+ELKQQj+Api6F+F5jjKjYYRV
 bcWE1e4aGwB/7C0OJlsuIxXIkH0+jrqJVwGH6k3vhRmia3bR1029mj59z2QDiw7+5mJa
 JVlj7WbxJ8VSv5L6HDk93H6wPa0O2oa+KjtLirS5Il/p8r2D6Jcrrjpdyay53EomxyAb
 H91FPuE46tkw3Cwq/xj7IQRWI4QGaomhrhIQwsXqcYFkR48bVFQG8IdVwBd1Ok4YCBlb
 Px1owdXXz6qH9kw3upIP8FJvMSprwDVWvfgjin8cS+uOYbrfanivjtfKMoxtyyjY7W3t
 qKGQ==
X-Gm-Message-State: APjAAAUJQiDb5pklotL0aJx8nd2dBHikQDPuMRLZvjNjRovpaN5MDGdE
 zFHDMozCG0q9pgOrNXVjONLfC0zSEfA=
X-Google-Smtp-Source: APXvYqz8Qew/loJl4dWPd/44D9wwJDwh8G6KATvE9MuOWO329Px1Rq+QcdpDHagkKYD1YExKyJZ8Fw==
X-Received: by 2002:a7b:c148:: with SMTP id z8mr10195590wmi.142.1561383829425; 
 Mon, 24 Jun 2019 06:43:49 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id a7sm11151625wrs.94.2019.06.24.06.43.42
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 06:43:48 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ECD8A1FFA3;
 Mon, 24 Jun 2019 14:43:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon, 24 Jun 2019 14:43:35 +0100
Message-Id: <20190624134337.10532-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624134337.10532-1-alex.bennee@linaro.org>
References: <20190624134337.10532-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
Subject: [Qemu-devel] [PULL 17/19] .travis.yml: force a brew update for
 MacOS builds
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

It looks like the Travis image package databases are out of date
causing the build to error with:

  Error: Your Homebrew is outdated. Please run `brew update`.
  Error: Kernel.exit

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/.travis.yml b/.travis.yml
index 9750dc905c..a891ce2485 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -43,6 +43,7 @@ addons:
       - glib
       - pixman
       - gnu-sed
+    update: true
 
 
 # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
-- 
2.20.1


