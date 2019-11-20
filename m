Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D894C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:59:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE66522445
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iwyJKwB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE66522445
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXNhp-00084L-Nd
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 05:59:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iXNgU-0006xt-TG
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:58:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iXNgT-0006px-Rq
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:58:06 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:38598)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iXNgT-0006oa-K0
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:58:05 -0500
Received: by mail-wr1-x432.google.com with SMTP id i12so27602138wro.5
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 02:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XeyUojK+/nu5ychU994uN2lD73y0e0nlSIm4GEVUPX0=;
 b=iwyJKwB1WdIg6pykxYTx6kd9C5hlLfCHn2xXnnyirXn1J5IB+RWfsii1LZh1KpvROV
 XHkoKe5CdiiFrxrGh9ae6TN/WzXamQthdZAtuUxYUnxIlHKs6mPm3de2DjVizBusjqQD
 R/neMrW/2zA3gPzUZjbdlrm2B0a/VRnR5CASAQg+pahROeX8HyTFZs5vzoGlPpHtAqw5
 mg4Xzw3hkYzgRrU3J2O/IvFu3cBRCXyXODUIh55sv3CCsuersFgomoDXRMX9mLIbvpDj
 XurNFFNa0yNUeSfxdYI6f9byJp+B2+jTa3xvoqci47Cmd7rEUh+SAFAP3eVo1Lem6yrC
 E2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XeyUojK+/nu5ychU994uN2lD73y0e0nlSIm4GEVUPX0=;
 b=ZifWJH/WhGJX9mnYf8vMSa+yujgoua55iwfaslB8dvcm0RN4I9tYHf0+EyVQOpLTAx
 /yxXIfWlPBAh1qXPAXipshjHk760ruhMrOf0OUG8bTJDX6mR+oS2l3S1VeKbvSAgfPgy
 VDs8cuzjtXUeDNGn5/NKD16afSvUQwZyLQLBI5bNWD9c2QSCWAW99KmC2lH0AH+QGVhN
 N+nOefaqT/AHaUshzB2gHO2xBsgPHbvKgDO42qZ6fxsvxmnyTkcrkv2NJsSgeuptsdwB
 MetFfUN8oPGJR2Tcka3tHcDGn959hKZ4sYJohsZLgxwO66W8th/cZ2ei8KiBWNgYa+Ys
 PUnw==
X-Gm-Message-State: APjAAAXHukAarfVb8YaGludsbZLFFJmt+Uh0z9ParAv/MmoLXysHXpED
 5wrJA6/wLDr/ImENvpUDSZaVDA==
X-Google-Smtp-Source: APXvYqzO7MT4jZQerRMmjNSzkPjnZSHdvjvaKz+N9NcBdt/t/R0mKHnyXJiItdUYQBItF5tkkVBr+Q==
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr2376645wru.52.1574247484437;
 Wed, 20 Nov 2019 02:58:04 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w13sm30076147wrm.8.2019.11.20.02.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 02:58:02 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 450611FF87;
 Wed, 20 Nov 2019 10:58:01 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL for rc3 0/5] a few doc and testing tweaks
Date: Wed, 20 Nov 2019 10:57:56 +0000
Message-Id: <20191120105801.2735-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 39e2821077e6dcf788b7c2a9ef50970ec7995437:

  Update version for v4.2.0-rc2 release (2019-11-19 19:34:10 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-rc3-testing-and-tcg-201119-1

for you to fetch changes up to 22c30b2d20e828edadbd992c1d4c4bfd0f3433ba:

  tests/tcg: modify multiarch tests to work with clang (2019-11-20 10:53:31 +0000)

----------------------------------------------------------------
A few test and doc fixes:

  - tweak DEBUG behaviour for vm-test-build
  - rename and update plug docs for versioning
  - slim down MAIN_SOFTMMU_TARGETS

----------------------------------------------------------------
Alex Bennée (4):
      tests/vm: make --interactive (and therefore DEBUG=1) unconditional
      docs/devel: rename plugins.rst to tcg-plugins.rst
      docs/devel: update tcg-plugins.rst with API versioning details
      .travis.yml: drop 32 bit systems from MAIN_SOFTMMU_TARGETS

Taylor Simpson (1):
      tests/tcg: modify multiarch tests to work with clang

 docs/devel/index.rst                        |  2 +-
 docs/devel/{plugins.rst => tcg-plugins.rst} | 27 +++++++++++++++++++++------
 tests/tcg/multiarch/float_helpers.c         |  2 --
 tests/tcg/multiarch/linux-test.c            |  6 +++++-
 .travis.yml                                 |  2 +-
 MAINTAINERS                                 |  1 +
 tests/vm/basevm.py                          |  2 +-
 7 files changed, 30 insertions(+), 12 deletions(-)
 rename docs/devel/{plugins.rst => tcg-plugins.rst} (83%)

-- 
2.20.1


