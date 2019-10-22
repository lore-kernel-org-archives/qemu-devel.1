Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803AACA9EB9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:19:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B8222184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hS9U0lcL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8222184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMzh1-0004aM-Vk
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 15:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iMzef-0002QI-6s
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iMzee-0005Ko-2H
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:17 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:52808)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iMzec-0005D0-2g
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:15 -0400
Received: by mail-wm1-x331.google.com with SMTP id r19so18588234wmh.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 12:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KiDA2cJ0DTJfxqnwbgK1IdDPGYCe7Quzjtxag58HSlE=;
 b=hS9U0lcLs/HkUxrCswFOn+TrQlA7ykzcifrDPFewXZPj0FC7Of478hMnSavOVFCg/s
 SYrFphbQaeogf7eWaO4dlWYz4V2mMcDnCJAlZ3qpjMk4yf+r/f6Iyq0+DHL0oCXQncWu
 S9dQ2RvhSXqENqpz+YMqyVf3bpWKJtopnuSEGj7ZHI8boPREFa1WQpjKyJ9OXD8BFR7Y
 3Nd3C+rX2NnyqmflLbWFDRJeebDaOv8a41uFmEAXbl9iSdlipsxlnzL6//k+LSnxsqdU
 yHaU4LattFc9zlgUJuuEn7wXU6vDepYSm8fdMtJTR2eu8nb12NBQ0qFylv3S7oBtKZlY
 7Gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KiDA2cJ0DTJfxqnwbgK1IdDPGYCe7Quzjtxag58HSlE=;
 b=eno4cZaAMcEyK2BOOSttxl5TaJM8n2hUgCqa494k5CeW/CyvQBG3SdFFspoU4BVJKz
 fbrhnZkBoKk//tz4FbIYf+KcaGdk7XWsL+4B0CvEfPAdCzumT1LABMXsAhwu0imlWwxx
 bACE2mf0m7IWL4xwoaVwu0oGvViYRNRPsrPcqLR9N9pPsodVdj1Uib7KSwBZzkIwGmPv
 L0XQIjcASUuN8Yop2KqGpMxMRWZ0XEyLiNFXo2a05e+5VqYoX29eO394VN8mZ7Frt4aS
 MBBWaONVBP7jQVtuEgM4Ti9y0mGbLdvNNrI95tABV4mSZNEt7Jh+oUSFRmOlxwNVKZVb
 nSzA==
X-Gm-Message-State: APjAAAUNYQ9/vUqqbubFpW8S93r//bJJ0rhEWBK21em7tE/85SS7G6Ak
 YnoOOPZ4Z7tDsc15KApJWxehbw==
X-Google-Smtp-Source: APXvYqzujeF8H1WCRd+IkA76OBOS5fZUrTWs1HjBDEkQumkhaMvGpCClI7pPYWqKqn/g0OW/MCO+nA==
X-Received: by 2002:a1c:5458:: with SMTP id p24mr4163602wmi.32.1571771828178; 
 Tue, 22 Oct 2019 12:17:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g184sm12826147wma.8.2019.10.22.12.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 12:17:05 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7A6851FF90;
 Tue, 22 Oct 2019 20:17:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 03/19] travis.yml: Use libsdl2 instead of libsdl1.2,
 and install libsdl2-image
Date: Tue, 22 Oct 2019 20:16:48 +0100
Message-Id: <20191022191704.6134-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022191704.6134-1-alex.bennee@linaro.org>
References: <20191022191704.6134-1-alex.bennee@linaro.org>
MIME-Version: 1.0
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

We've removed support for SDL 1.2 quite a while ago already, so let's
use SDL 2 now in Travis to get test coverage for SDL again.
And while we're at it, also add libsdl2-image-dev which can be used
by QEMU nowadays, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191009170701.14756-3-thuth@redhat.com>
---
 .travis.yml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 7be2a9949f5..b446e04e8ae 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -39,7 +39,8 @@ addons:
       - libpixman-1-dev
       - libpng12-dev
       - librados-dev
-      - libsdl1.2-dev
+      - libsdl2-dev
+      - libsdl2-image-dev
       - libseccomp-dev
       - libspice-protocol-dev
       - libspice-server-dev
@@ -309,7 +310,8 @@ matrix:
             - libpixman-1-dev
             - libpng12-dev
             - librados-dev
-            - libsdl1.2-dev
+            - libsdl2-dev
+            - libsdl2-image-dev
             - libseccomp-dev
             - libspice-protocol-dev
             - libspice-server-dev
-- 
2.20.1


