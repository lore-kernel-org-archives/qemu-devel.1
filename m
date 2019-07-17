Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78ADC76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:44:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4B01208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CPP5cG6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B01208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkDy-0005yh-LJ
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 09:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55256)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkDc-0004w4-12
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkDa-0004Sw-Px
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:39 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hnkDa-0004SQ-Im
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:38 -0400
Received: by mail-wm1-x344.google.com with SMTP id p74so22209164wme.4
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 06:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=H6TUokZ8kcSbW7C3KySOq9tB4s1u4+MlccQhokaZu1Q=;
 b=CPP5cG6CiPjIi6HY5aa5TOR+/AiHdj84mfafcqZnCK63AnHwFLTty19WL8Za2407Px
 JZkVYUkvwsl3HLdyrfXSSr1PpKKUwxZdL+2eYabQ7eha9sHONoiCj1S4PA3qWvdO+DRE
 zx9YaJQ9Y/S1XTItSjOtLtIkTvOKvr4nohK7nRamFjDgQbeqYz7FMJMb5r5Buu6leOmb
 QLa3MsE7mlauZt8mOkHPTBTalhCSMw4GEFD6Ti0X8LINeWPCBAlgD9xBUIMk9IEfGRcM
 zxw8j/2QB4BT+Eoh29D2fDNegKyE1z5FM73qlhHk958AfBsEz0BNG38ze2A46SAzONqY
 ISbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=H6TUokZ8kcSbW7C3KySOq9tB4s1u4+MlccQhokaZu1Q=;
 b=JNh1Xm45tqOAPJhYQVyI+q0zcjKaov3Pc9exWDqRrQn/lPwvEVhJPyRInIaNSUPcaI
 MuSH35Yi29rqiHTZ7TItMhkR0np5TdS4Kwvr5R/82jQEmzwUh6mZSFV0/Bfn6qow2FcD
 OzQ/Xm/TuwM1VPe30/kOe2FywDsEekyAqbU7AGE0uaKpz8KUbCYRPV/sbXez2eYDE1XR
 wK0hRxMlbgiRsNsFCLWaLh25goP+8FzWARpghATYJjxQoLXYrQTdzX+UkGUk9SJltliG
 1mubo0ahjfgPKe9BRgsN9JE8sKnepjnSliMR9FUrpw7npPMntVh7qr9CWlVIatqvMFpj
 ElhQ==
X-Gm-Message-State: APjAAAXM6D3Nzi7XxhOT5kWqx37crGbzDjeSQyQrm5YAOm2SLb3/E7S/
 JEQBl7GJAGSD97LcWMpUpo5/lQ==
X-Google-Smtp-Source: APXvYqxljRWt5rt8QuApzA4g9c0DNHSdkrqESIVveLgjJmi1snTt1nOK+cmSrJLGuZ+1qP1NBEkl/A==
X-Received: by 2002:a7b:cbcb:: with SMTP id n11mr35740060wmi.54.1563371017289; 
 Wed, 17 Jul 2019 06:43:37 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id r11sm27475253wre.14.2019.07.17.06.43.36
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 06:43:36 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D53611FF87;
 Wed, 17 Jul 2019 14:43:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 14:43:12 +0100
Message-Id: <20190717134335.15351-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH  v2 00/23] testing/next for 4.1-rc2 (win, travis,
 iotests)
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is my current queue for testing/next which I shall submit a PR
for on Tuesday in time for rc2. This update adds:

  - fixes for Windows builds under docker (+installer)
  - build fix for --no-default-devices
  - tweak to docker DEBUG behaviour
  - run iotests in make check
  - use travis_retry to deal with flaky tests

Rather than just disabling flaky tests I've enabled travis_retry on
the check phase. This basically avoids me manually triggering rebuilds
to turn the build green again. I think this is OK because actual
breakages will just fail again and we want the CI status to be a
reliable indicator of something gone wrong rather than being ignored
as probably a flaky test. There is a danger that we might be missing
the introduction of flakiness into the build but I suspect we wouldn't
have picked it up those cases anyway. I think soak/stress tests are
probably best handled by maintainers anyway.

The following patches need review
 patch 0017/hw i386 also turn off VMMOUSE is VMPORT is disabl.patch
 patch 0018/travis enable travis_retry for check phase.patch
 patch 0019/tests docker invoke the DEBUG shell with noprofil.patch

Alex Bennée (7):
  tests/docker: add test-misc for building tools & docs
  tests/migration-test: don't spam the logs when we fail
  tests/dockerfiles: update the win cross builds to stretch
  shippable: re-enable the windows cross builds
  hw/i386: also turn off VMMOUSE is VMPORT is disabled
  travis: enable travis_retry for check phase
  tests/docker: invoke the DEBUG shell with --noprofile/--norc

Marc-André Lureau (1):
  archive-source: also create a stash for submodules

Philippe Mathieu-Daudé (11):
  tests/docker: Install Sphinx in the Ubuntu images
  tests/docker: Install Sphinx in the Fedora image
  tests/docker: Install Ubuntu images noninteractively
  tests/docker: Install Sphinx in the Debian images
  tests/docker: Install the NSIS tools in the MinGW capable images
  tests/docker: Set the correct cross-PKG_CONFIG_PATH in the MXE images
  tests/docker: Install texinfo in the Fedora image
  buildsys: The NSIS Windows build requires the documentation installed
  buildsys: The NSIS Windows build requires qemu-nsis.bmp installed
  tests/docker: Let the test-mingw test generate a NSIS installer
  NSIS: Add missing firmware blobs

Thomas Huth (4):
  tests/qemu-iotests/check: Allow tests without groups
  tests/qemu-iotests/group: Remove some more tests from the "auto" group
  tests: Run the iotests during "make check" again
  gitlab-ci: Remove qcow2 tests that are handled by "make check" already

 .gitlab-ci.yml                                |  13 +-
 .shippable.yml                                |   9 +-
 .travis.yml                                   |   2 +-
 Makefile                                      |   3 +-
 hw/i386/Kconfig                               |   4 +-
 qemu.nsi                                      |   3 +
 scripts/archive-source.sh                     |  18 +--
 tests/Makefile.include                        |  10 +-
 tests/check-block.sh                          |  44 +++++--
 tests/docker/Makefile.include                 |   6 +-
 .../dockerfiles/debian-win32-cross.docker     |  10 +-
 .../dockerfiles/debian-win64-cross.docker     |  10 +-
 tests/docker/dockerfiles/debian10.docker      |   1 +
 ...{debian8-mxe.docker => debian9-mxe.docker} |  11 +-
 tests/docker/dockerfiles/debian9.docker       |   1 +
 tests/docker/dockerfiles/fedora.docker        |   4 +
 tests/docker/dockerfiles/ubuntu.docker        |   3 +-
 tests/docker/dockerfiles/ubuntu1804.docker    |   3 +-
 tests/docker/run                              |   4 +-
 tests/docker/test-mingw                       |   4 +-
 tests/docker/test-misc                        |  22 ++++
 tests/migration-test.c                        |  19 ++-
 tests/qemu-iotests-quick.sh                   |   8 --
 tests/qemu-iotests/check                      |   4 +-
 tests/qemu-iotests/group                      | 120 +++++++++---------
 25 files changed, 204 insertions(+), 132 deletions(-)
 rename tests/docker/dockerfiles/{debian8-mxe.docker => debian9-mxe.docker} (56%)
 create mode 100755 tests/docker/test-misc
 delete mode 100755 tests/qemu-iotests-quick.sh

-- 
2.20.1


