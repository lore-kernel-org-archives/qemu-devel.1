Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BB1C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B118C2085A
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eMB/7OBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B118C2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjLKQ-00072R-QB
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 06:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51552)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hjLIU-0005WR-3R
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hjLIM-0007tY-To
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:18:26 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:45665)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hjLIM-0007gE-Hn
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:18:22 -0400
Received: by mail-wr1-x42e.google.com with SMTP id f9so9323454wre.12
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 03:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wEfktrQywFhKxuIx8l/huyZVo0awGrzKRqSSmGMFpUE=;
 b=eMB/7OBnxgA9WpXA++JPO5mgJ8SqoI3KSJCmHuy1owARppjsKUi59/5sIlZ5FSYXCh
 sBWvhUcJvAmuYB5C/7dSgC663N1/oVDkp5t/noMJ2bAYLTXb1pxS8Qcvwal7QUpNf3UU
 JrVV54DSVFiY1IaAli5aY4Hd7zairZckMcKItlejs8r53PiQvVRVJveqX08DrjY4WW7n
 U+DO1WK0FBYQj0ThyRNp5lP/k/GsTDnhyIcSOnz7FJaXiRcQhFX33JdpX6ldDBWfd1BO
 /1dp47tngL9gnTLcZLol0A08Vn5f9MaThp+z+OQ4Sup9WuvZcMbpKQZv+qxNIpoouk3w
 n58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wEfktrQywFhKxuIx8l/huyZVo0awGrzKRqSSmGMFpUE=;
 b=GFlUXhpd/6AYEg9OPpjsi++RO1P8l8WQ/SB6aMdpJ97684O01o2snoUXycGUXcbTEc
 kGKsLFWVj4hquDlcoTj5pQ2u67mErz0aJCP6SfE+zBnALff7lSADrFsceDGPgnkhxSSy
 sIL8LaJNOIfNnC7iSXqMQrc8FeXSKU6yP/9pKtSy3cnJWyacn5fiphwxEUilxYnxPocE
 MIvxy4sEMQIqKsBEduPyR5bVlh4iP4sl0PDXjOEk2KBCb84PrY4hAE8QkBhKw41JsRnD
 fS9Ppi5pOFQcFf1kJgvoMfWTm77AQqUdG+H5K8cNtqQS8bimjFkISewq/nYZEgFOJvGI
 zp+w==
X-Gm-Message-State: APjAAAXEGQDoor4RyhtD0sbdo1JsoLt3gXV065F/HjsP+KTKbaItCOPI
 7PokmsTx9qFOMlNmf9tm5MGLyg==
X-Google-Smtp-Source: APXvYqzA0yCJdz+08cyRdXT4KeVq2zyrs9We8VIeIUmBqGtLvAamUhyqBUPkBXbiCHlOnZIfzsmy+w==
X-Received: by 2002:adf:e50b:: with SMTP id j11mr3356743wrm.351.1562321897635; 
 Fri, 05 Jul 2019 03:18:17 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id h133sm10380430wme.28.2019.07.05.03.18.17
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 05 Jul 2019 03:18:17 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B578A1FF87;
 Fri,  5 Jul 2019 11:18:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  5 Jul 2019 11:18:16 +0100
Message-Id: <20190705101816.10291-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
Subject: [Qemu-devel] [PULL v3 00/19] testing/next for 4.1 (tests/vm,
 Travis and hyperv build fix)
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

The following changes since commit 57dfc2c4d51e770ed3f617e5d1456d1e2bacf3f0:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190704-1' into staging (2019-07-04 17:32:24 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-next-050719-3

for you to fetch changes up to 1f4abd81f7dfeb9d622b37368bef22a6481ebc66:

  migration: move port_attr inside CONFIG_LINUX (2019-07-04 19:23:07 +0100)

----------------------------------------------------------------
Various testing fixes:

   - tests/vm updates and clean-ups
   - tests/vm serial autobuild on host (-netbsd v3)
   - ensure MacOS builds do "brew update"
   - ensure we test --static user builds
   - fix hyperv compile failure
   - fix missing var warning for OpenBSD (v2)

This brings my testing back to green on all CI services. Please note
the BSD installs will throw out some warnings during the setup phase.
They shouldn't re-occur once the images are built. NetBSD has been
dropped for now given slow install issues.

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

Gerd Hoffmann (10):
      tests/vm: send proxy environment variables over ssh
      tests/vm: use ssh with pty unconditionally
      tests/vm: run test builds on snapshot
      tests/vm: proper guest shutdown
      tests/vm: add vm-boot-{ssh,serial}-<guest> targets
      tests/vm: serial console support helpers
      tests/vm: openbsd autoinstall, using serial console
      tests/vm: freebsd autoinstall, using serial console
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
 tests/vm/netbsd           |   6 +-
 tests/vm/openbsd          | 159 ++++++++++++++++++++++++++++++++++----
 tests/vm/ubuntu.i386      |  11 ++-
 13 files changed, 667 insertions(+), 63 deletions(-)
 create mode 100755 tests/vm/fedora

--
2.20.1


