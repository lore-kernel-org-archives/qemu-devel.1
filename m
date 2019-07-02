Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9ECC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB8BC2082F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DtuFjMWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8BC2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiFzq-0003xu-0L
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 06:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46859)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hiFyM-0003Mp-RS
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hiFyI-0008JY-SD
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:25:14 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:40749)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hiFyI-0008GP-He
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:25:10 -0400
Received: by mail-wr1-x429.google.com with SMTP id p11so17154712wre.7
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 03:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YZd/z68KOnLf211ZAuhnwfM2ktRG6laDbBCdwMHgYkQ=;
 b=DtuFjMWD+uHtB6CObLbG8maXn3eEg/nkpza2gnuc4tBYA64BJgOd9wl3gk1xy7qKtz
 fwz2hKVns0b4fQSBo8J/gcBrQBKt1D+a/hQTwbimc25Ccs7OnK6ex+HE470CFNPACciS
 tF4yKhFHclLjZpUTgCINuXWlXfBV1K4mVdut7cLZOeZ1DHr4mtCs0fe2XaVSwk5UAhBW
 1Wg7GQzh9qymywQB77088AR0mfYFEqsr8s+XgLOriFDCLk7XyBWiu95az/F3AHhwJuIV
 DENlWMBJnnXrG7IRhyBVW2ihrNDvwFT8BcHlsQPfQ0kte7MF7IdaS89Gb9mTQHrQ7V44
 dsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YZd/z68KOnLf211ZAuhnwfM2ktRG6laDbBCdwMHgYkQ=;
 b=XqFtnti93uxZUCqriBfr2J1XBP5tbHoldBgbogijTpY9ncb85DipnzhnRReJb4Gzwk
 PNdCW1ULNpRYe/b+hDjgDONJ1MsJoTtJ+xlsHdtnlZOnZyTr87mR/qq9YdVuNOcrKwgg
 A0gebXromAtZXb6FbruBh+wZT3n0R5xUM2gESp2bT6HJ+W+vnh5bphVGHEX1GUvuxkQ9
 2mdrGbbx4OnRDVmkPQKG1QM5Szc1grZp7sM+socJFRzownQu5O3ZGAmyDMJzPrE1S3I7
 3GNO43gqC3bCXXGTehhK9Zqw9FBFDlq/1z4djzDyKt0zWIDH35Sl5gNJbDJXrcrMM2L9
 SYCA==
X-Gm-Message-State: APjAAAXRuLpc6lbaCVYcHpaoDqzWtA2niyd3D3uu3rWsEtAUK+DNMnrj
 ab6ycASbt+P9ga2Fj4yGHJZ8KQ==
X-Google-Smtp-Source: APXvYqwMAaMy5m7Cp394V/TEhUofww240R3QZ5VT2zDYx4BY6neuWwTwx8x50xjY+MWc1nQN2arL6g==
X-Received: by 2002:adf:e705:: with SMTP id c5mr23968770wrm.270.1562063106722; 
 Tue, 02 Jul 2019 03:25:06 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x17sm9173378wrq.64.2019.07.02.03.25.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 02 Jul 2019 03:25:06 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D194B1FF87;
 Tue,  2 Jul 2019 11:25:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 11:25:05 +0100
Message-Id: <20190702102505.32044-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: [Qemu-devel] [PULL v2 00/20] testing/next for 4.1
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

The following changes since commit 7d0e02405fc02a181319b1ab8681d2f72246b7c6:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull-request' into staging (2019-07-01 17:40:32 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-next-020719-2

for you to fetch changes up to 83fb8fd71de2f80afd4ec83761357d5f0dacd9c9:

  migration: move port_attr inside CONFIG_LINUX (2019-07-02 07:52:35 +0100)

----------------------------------------------------------------
Various testing fixes:

   - tests/vm updates and clean-ups
   - tests/vm serial autobuild on host
   - ensure MacOS builds do "brew update"
   - ensure we test --static user builds
   - fix hyperv compile failure
   - fix missing var warning for OpenBSD (v2)

This brings my testing back to green on all CI services. Please note
the BSD installs will throw out some warnings during the setup phase.
They shouldn't re-occur once the images are built.

----------------------------------------------------------------
Alex Bennée (4):
      .travis.yml: default the --disable-system build to --static
      .travis.yml: force a brew update for MacOS builds
      target/i386: fix feature check in hyperv-stub.c
      migration: move port_attr inside CONFIG_LINUX

Cleber Rosa (4):
      tests/vm: avoid extra compressed image copy
      tests/vm: avoid image presence check and removal
      tests/vm: pin ubuntu.i386 image
      tests/vm: add source repos on ubuntu.i386

Gerd Hoffmann (11):
      tests/vm: send proxy environment variables over ssh
      tests/vm: use ssh with pty unconditionally
      tests/vm: run test builds on snapshot
      tests/vm: proper guest shutdown
      tests/vm: add vm-boot-{ssh,serial}-<guest> targets
      tests/vm: serial console support helpers
      tests/vm: openbsd autoinstall, using serial console
      tests/vm: freebsd autoinstall, using serial console
      tests/vm: netbsd autoinstall, using serial console
      tests/vm: fedora autoinstall, using serial console
      tests/vm: ubuntu.i386: apt proxy setup

Philippe Mathieu-Daudé (1):
      Makefile: Rename the 'vm-test' target as 'vm-help'

 .travis.yml               |   3 +-
 Makefile                  |   4 +-
 docs/devel/testing.rst    |   4 +-
 migration/rdma.c          |   3 +-
 target/i386/hyperv-stub.c |   2 +-
 tests/vm/Makefile.include |  28 ++++++-
 tests/vm/basevm.py        | 135 ++++++++++++++++++++++++++++-----
 tests/vm/centos           |   6 +-
 tests/vm/fedora           | 189 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/vm/freebsd          | 180 ++++++++++++++++++++++++++++++++++++++++---
 tests/vm/netbsd           | 187 ++++++++++++++++++++++++++++++++++++++++++---
 tests/vm/openbsd          | 159 ++++++++++++++++++++++++++++++++++----
 tests/vm/ubuntu.i386      |  11 ++-
 13 files changed, 842 insertions(+), 69 deletions(-)
 create mode 100755 tests/vm/fedora

-- 
2.20.1


