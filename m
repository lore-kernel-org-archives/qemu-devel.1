Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF64EC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC94206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zyiR2Eht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC94206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7c5y-0000qP-Op
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqv-0000mw-DX
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqu-0000cN-73
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:21 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:33087)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bqu-0000bg-0H
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:20 -0400
Received: by mail-wr1-x430.google.com with SMTP id u16so18454301wrr.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I86s17YWZNBBJTM3o+byHjhL/ANYpndSLZTN6qLv0h4=;
 b=zyiR2EhtYIoe+jLx9GExD4a60IMvdrKaIC721l0qv/bibnVps8sUx6o+aLV9+dct3y
 mPszUiH2oHMpZ5ORiOORmDnXFQksmQN7jKIjuubH+dqhqY0O10MaxObsHhZXlI7Th127
 qP2DK8y9rvI+qDUNPD7IKyXumyp81OHDkZVy+gi2A9DykXpZAFr0dIbcl2lMeudcFU6V
 H8izwbmUBog2p/zWUp2XxFHxGfQwOvFtOYadwAMrnbMctsjC4GQZasR5RSklBuK3bWXl
 iCMeD2IdanfCO6Ng6STPXbWwXPm1IdgWk3Wm4dzu4WTVhIidGLw3nWQECMRFNUvAUDj3
 Vdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I86s17YWZNBBJTM3o+byHjhL/ANYpndSLZTN6qLv0h4=;
 b=GVSTeSuq82+S74gXco+uXu3frZIHfbwC6HE2aztIj2v6q8yL/TJ7j2e5aP5Zh4q3bc
 2IUMGs2Jx0lEfswqbK/qmko0ajz0mJh2FmyRD0iIwylRLlfx5o6XpU4T7wn0dAqEz3YE
 0j5D63B/n0+7HwFMCKYD6/nVLGkp3EDlAmRI2aS5N4nU2TFH5vo9Ua0F0/mg0LeSh5mW
 /1MTnEXakLWzYpgqfd7xB3uNnvhx89qYyPWwTZA9iR0Z7hhMlFdsd0ndby6nO9ujn3Tc
 9s1Ap730NvU+y5+bHz2tlc4k/IIxZn4ajUXsh4I+DqPrWHTRdXhhG7NWsYYjqwXhCut8
 XTOg==
X-Gm-Message-State: APjAAAWdXTa9vn46MWpV37DZnG5mRwFij8zH97nbpYot1KGEYIE3uCmj
 WGvmbvAnNp9PtVwf5DP0eBcmAQ==
X-Google-Smtp-Source: APXvYqwo6E4ZZEmt1uVWM5+4MnGKGRoSNNAiUKPUAt6K8WlAFejOzZswyF+BuZR/81Jk6Kr0z9TThQ==
X-Received: by 2002:a5d:66d2:: with SMTP id k18mr24602491wrw.7.1568105419022; 
 Tue, 10 Sep 2019 01:50:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b18sm418252wrr.21.2019.09.10.01.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:50:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0434E1FFBD;
 Tue, 10 Sep 2019 09:43:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:41 +0100
Message-Id: <20190910084349.28817-38-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
Subject: [Qemu-devel] [PULL 37/45] .travis.yml: Cache Avocado cache
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Avocado tests download artifacts from various sources.
These sources sometime have network issues resulting in build
failures. Cache Avocado cache to reduce build failure.

See https://docs.travis-ci.com/user/caching/#arbitrary-directories

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 0e3c2b0021c..097a844d68b 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -9,6 +9,8 @@ cache:
   timeout: 1200
   ccache: true
   pip: true
+  directories:
+  - $HOME/avocado/data/cache
 
 
 addons:
-- 
2.20.1


