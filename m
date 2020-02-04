Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E4CC3524D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:41:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5C221927
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wIbyPr81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5C221927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz38g-0003is-23
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 13:41:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iz37i-00023n-7L
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iz37g-0002Wy-Kk
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:33 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:34837)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iz37g-0002RD-Co
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:32 -0500
Received: by mail-wm1-x32c.google.com with SMTP id b17so4995737wmb.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 10:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L1850xTVl+Qy3iLgT4kzafBhdTXBE5VtTzVpgUmJu54=;
 b=wIbyPr818SD4VxmCnUVtegvffJ1LO7Ztoa9jv3544CE0WIgcRtohFXbaKza8QAe4rm
 m0A1ofnlHk9zKMT2wrRag9kxsfnJfwSzL1H63H3/3tijv2O1c+a+xE15zvFmIXRfkTF3
 68fnwxdEl6GYLAZp2GzPaYKTKHN4xlPgrDbY1NqjAOlvnfAXj9GBGwefY+a5Uu0WNinh
 N7yr/H4UW6ndm69cMaOQ6UnwmCvlv/GySZs1EHmKTDb7WFvRf2ics/ywRDF4+KszybDc
 oz3R4hUe7zy0hx4xsJ56gwi58gymYu4wrPi95qW6aAnsHOd4zkaNHkPL7vc281jlkEQn
 GTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L1850xTVl+Qy3iLgT4kzafBhdTXBE5VtTzVpgUmJu54=;
 b=MwzcP+IiI0lEtblaoCu9Kj2zMCikcUl7H8aXr4KFlAAc1JBl3mxLEGQgwY31DwUcRQ
 5JrZkoP+H2d2V5malJROhqeKIbrUcsLvHkoL+KlTzPIjzgnoIKvZ51LpbacaAl0+OUmi
 3VUPUHITHRpxiM70hNmR1k1JRL1UuRJtUEpu4i+E5/p6bdwIs2/r0sG8GMH0oTw6drKh
 +03fBTdQOeAKHzgpqf7Z8E2vVq8XkuwT3qUBCE5E6ArM4en3kZ8p+QaZotLZtU2wfsiL
 sUcKXTigK+U/wXoulftBDg+pL0TJfjyNoWnlFBiWZs4ZkpsvItxr7amEL/9Ag8Dds8h2
 40+A==
X-Gm-Message-State: APjAAAURwQJ0/ByGUrSAJY+hyUBmCRPTVMXwvAaScnjHPTvErvC3a1jY
 1uBU5czWdx3VY9Mm1S0bgMwjYg==
X-Google-Smtp-Source: APXvYqxSgbm8h7rjN2DZHWh3ROWuLFavno4j/q46lP6JO+zYeIEvDSgVcrNwXxveoQdM3ForzU3Ysw==
X-Received: by 2002:a1c:740a:: with SMTP id p10mr351110wmc.65.1580841630732;
 Tue, 04 Feb 2020 10:40:30 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s8sm29575083wrt.57.2020.02.04.10.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 10:40:29 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 608F91FF87;
 Tue,  4 Feb 2020 18:40:28 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 00/16] testing updates
Date: Tue,  4 Feb 2020 18:40:12 +0000
Message-Id: <20200204184028.13708-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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

The following changes since commit 7bd9d0a9e26c7a3c67c0f174f0009ba19969b158:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-02-04' into staging (2020-02-04 16:12:31 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-040220-1

for you to fetch changes up to 68e5b85e41fe7684e58cd077772b7d1e8bc092c7:

  .travis.yml: ensure python3-sphinx installed for docs (2020-02-04 17:13:29 +0000)

----------------------------------------------------------------
Testing updates and build fixes:

  - move more cross compilers to buster
  - fix build breakage (hppa Kconfig)
  - disable docs on shippable
  - build docs under bionic with python3
  - travis.yml re-factoring
  - check capabilities of non-docker compilers
  - smarter make -j parallelism

----------------------------------------------------------------
Alex Bennée (13):
      tests/docker: move most cross compilers to buster base
      tests/docker: better handle symlinked libs
      .shippable: --disable-docs for cross-compile tests
      .travis.yml: build documents under bionic
      .travis.yml: move cache flushing to early common phase
      .travis.yml: probe for number of available processors
      tests/tcg: add a configure compiler check for ARMv8.1 and SVE
      tests/tcg: gate pauth-% tests on having compiler support
      .travis.yml: introduce TEST_BUILD_CMD and use it for check-tcg
      .travis.yml: drop the travis_retry from tests
      .travis.yml: drop cris-linux-user from the plugins test
      .travis.yml: single thread build-tcg
      .travis.yml: ensure python3-sphinx installed for docs

Philippe Mathieu-Daudé (2):
      .travis.yml: Drop superfluous use of --python=python3 parameter
      .travis.yml: Add description to each job

Wainer dos Santos Moschetta (1):
      travis.yml: Install genisoimage package

 .shippable.yml                                     |   2 +-
 .travis.yml                                        | 166 ++++++++++++++-------
 tests/docker/Makefile.include                      |  16 +-
 tests/docker/docker.py                             |  16 +-
 tests/docker/dockerfiles/debian-amd64.docker       |   2 +-
 tests/docker/dockerfiles/debian-armel-cross.docker |   2 +-
 tests/docker/dockerfiles/debian-armhf-cross.docker |   2 +-
 .../dockerfiles/debian-mips64el-cross.docker       |   2 +-
 .../docker/dockerfiles/debian-mipsel-cross.docker  |   2 +-
 .../docker/dockerfiles/debian-ppc64el-cross.docker |   2 +-
 tests/docker/dockerfiles/debian-s390x-cross.docker |   2 +-
 tests/tcg/aarch64/Makefile.softmmu-target          |  12 +-
 tests/tcg/aarch64/Makefile.target                  |   2 +
 tests/tcg/configure.sh                             |  18 +++
 14 files changed, 168 insertions(+), 78 deletions(-)

-- 
2.20.1


