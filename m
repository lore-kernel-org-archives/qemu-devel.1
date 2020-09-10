Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4552C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:16:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA7C207FB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lxZlN8kX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA7C207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGMRM-0005hH-Ai
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 09:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kGMPw-0003yf-1I
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:15:12 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:39271)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kGMPu-00066N-1Q
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:15:11 -0400
Received: by mail-wr1-x42d.google.com with SMTP id a17so6661706wrn.6
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 06:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=etTkHB81m+vBMnLfUu95h/Yo/Aq1YAWNfTkFHGN6F6s=;
 b=lxZlN8kXoduwhzouTpqnXzP3uYEdI8Ay+pigbL4Re5qXcM9wGFTRzCY5tjgB81Tkmg
 bJBIHP2qpbJCLwsIKMVe70F/6/iL7qIOVp1WMDK03rpqBJQCMUiX3PiJfn/7YcSKKWLd
 6d6gGOrkaRNhzIhrBizC+M0+v98IFCIELXd2ys0d4jm6iDuRMbJCJqgDWYKOhoe/YAZ9
 nFvWDmMXpG0me9b9mgoDkYzsM+BRKoBUUYvYPQWOcGWHqLvjIShhH1LHB16FeIyuawoh
 T1n4U1dFobXbdiDTrUdK2pYm2b7sSmkdz1oXnGnAYLF2B2aoytf7cCCZrju7wmgoj2OX
 rqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=etTkHB81m+vBMnLfUu95h/Yo/Aq1YAWNfTkFHGN6F6s=;
 b=bvdAec6p6kPPBi/UmYfeMtuB+sjbpPcMryZRJ6HvylTxvsv9+ITA9Wk2smVhg3v++d
 YF8s4wnkodoHqOU42+Pv/31Cjj5wKd6NKfGBQ7gMF3+iwT/mU5SryAmu/GrvCG32ACww
 DOzLlkmFGrwy1CkyCFFDXJ35lbd/EwbP9/sYZA8Av/VTDP9jZPKLKn3+WPBFZZGIfB6g
 35+h7Hh7yJBE6lQzQt5+/do6ssBbQ/NrNuusnM0KHnRg8TjC5CLA6Kfq5qQrRm1vWMDY
 qz7RC25coNZSt3x170so359LLLbCwWeAFD2L60jMCpDrjHSZqvlTv3PvisFTI7XNqaCR
 D0XQ==
X-Gm-Message-State: AOAM5326gUHSE9TL+G3IbTNgqaJFbJnS2wJJo9OhHlQ3PK+x64CrrLo9
 p8UyUb7RVf9Rf466C1ErGNv/KQ==
X-Google-Smtp-Source: ABdhPJwvtAhKTCXTrREzXZfch+ZC20uDwHUyBQkPPj/p9l/7vhRWNeks/7QjCDENo7wKckPQkQNS6Q==
X-Received: by 2002:adf:f3c4:: with SMTP id g4mr9181956wrp.168.1599743707471; 
 Thu, 10 Sep 2020 06:15:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r15sm3652440wmn.24.2020.09.10.06.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 06:15:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 621091FF7E;
 Thu, 10 Sep 2020 14:15:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 00/10] testing and other mix fixes
Date: Thu, 10 Sep 2020 14:14:54 +0100
Message-Id: <20200910131504.11341-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 9435a8b3dd35f1f926f1b9127e8a906217a5518a:

  Merge remote-tracking branch 'remotes/kraxel/tags/sirius/ipxe-20200908-pull-request' into staging (2020-09-08 21:21:13 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-fixes-100920-1

for you to fetch changes up to c17a386b6afe608086aa4d260e29662865680b7f:

  plugins: move the more involved plugins to contrib (2020-09-10 10:47:03 +0100)

----------------------------------------------------------------
Various misc and testing fixes:

  - Expand CODING_STYLE.rst a little more
  - usb-host build fix
  - allow check-softfloat unit tests without TCG
  - simplify mips imm_branch so compiler isn't confused
  - mark ppc64abi32 for deprecation
  - more compiler soothing in pch_rev_id
  - allow acceptance to skip missing binaries
  - more a bunch of plugins to contrib

----------------------------------------------------------------
Alex Bennée (7):
      CODING_STYLE.rst: flesh out our naming conventions.
      tests/meson.build: fp tests don't need CONFIG_TCG
      target/mips: simplify gen_compute_imm_branch logic
      docs/system/deprecated: mark ppc64abi32-linux-user for deprecation
      configure: don't enable ppc64abi32-linux-user by default
      hw/i386: make explicit clearing of pch_rev_id
      plugins: move the more involved plugins to contrib

Gerd Hoffmann (1):
      usb-host: restrict workaround to new libusb versions

Pavel Dovgaluk (1):
      tests: bump avocado version

Philippe Mathieu-Daudé (1):
      tests/acceptance: Add Test.fetch_asset(cancel_on_missing=True)

 docs/devel/tcg-plugins.rst                    | 146 ++++++++++++++++++++++++++
 docs/system/deprecated.rst                    |   7 ++
 CODING_STYLE.rst                              |  37 ++++++-
 configure                                     |  48 +++++----
 Makefile                                      |  11 ++
 {tests/plugin => contrib/plugins}/hotblocks.c |   0
 {tests/plugin => contrib/plugins}/hotpages.c  |   0
 {tests/plugin => contrib/plugins}/howvec.c    |   0
 {tests/plugin => contrib/plugins}/lockstep.c  |   0
 hw/i386/pc_piix.c                             |   2 +-
 hw/usb/host-libusb.c                          |   2 +-
 target/mips/translate.c                       |  12 +--
 .travis.yml                                   |   2 +-
 MAINTAINERS                                   |   3 +-
 contrib/plugins/Makefile                      |  42 ++++++++
 tests/Makefile.include                        |   4 +-
 tests/acceptance/avocado_qemu/__init__.py     |  12 +++
 tests/meson.build                             |   3 +-
 tests/plugin/meson.build                      |   4 +-
 tests/requirements.txt                        |   2 +-
 tests/tcg/Makefile.target                     |   3 +-
 21 files changed, 297 insertions(+), 43 deletions(-)
 rename {tests/plugin => contrib/plugins}/hotblocks.c (100%)
 rename {tests/plugin => contrib/plugins}/hotpages.c (100%)
 rename {tests/plugin => contrib/plugins}/howvec.c (100%)
 rename {tests/plugin => contrib/plugins}/lockstep.c (100%)
 create mode 100644 contrib/plugins/Makefile

-- 
2.20.1


