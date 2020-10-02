Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60652C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:41:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD16A2068E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hw+HZgX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD16A2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOJRJ-0001mM-Lf
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 07:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJMx-0006nf-5R
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:37:00 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:54698)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJMo-0007bY-Gn
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:36:57 -0400
Received: by mail-wm1-x333.google.com with SMTP id s13so1319421wmh.4
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 04:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SQyO3Kef6zcKpO5tCbzV7xmtVYwXRFNO6UXv4vz6r0Y=;
 b=hw+HZgX7Iqx5ER4BcS6PTK05vFZMep+OtcgfxCV0M7hh14PjwIzeu55zMQW7elfgiN
 c+VmjFOxP5PlNnPf8o0ERTlWvbWilokP8XZ8p5bLk5o1nXdFwzx30aP3IZOUb0Igjgqk
 MErDhYS7FWD4FpgHR1wqYxYJBMRelJNANBfCA0NJ9AVCTLRNMiG4ph/FktXz1uxOmfCP
 FXTrbc7A6ebl70X7mCY81/9jzE8pKRflRzpUV1fqbnGO+LgAXJityV4xwtCRMj8mOeYU
 GSEicVg4McdZLoBxHeeMBqLa3PPphrm2m/mqmrgWk0B7B2pzfCg0Ny58q8tr+tXrE+Ve
 zdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SQyO3Kef6zcKpO5tCbzV7xmtVYwXRFNO6UXv4vz6r0Y=;
 b=dQx7FYHCei53mH971CLRqMxj7lWDMX1mCVCMyt3N1VMFXCqPOg58TuhYdlnER8rBSR
 Fhz8wgyW60EsKc7/IrbUCqbk7z0tXVrMH8JQKRSgY0430I8H9Uz49JAd4Z1uwpNAufW5
 VwSObQIJO381GqA9js2ZFtx6FTtOKcz2DLMjuAsFsiQlj2Ojqr3kJ1EAh1vjZChVDBzz
 TFSQQr5Ajm7N9U7z1c64uycQNlOkIqy2VHsFmnGRzgk45j/UetOnm4ilr20wD2sa9EWL
 N3Q8qcn2Rrf+cFt3Fl4FlAsqJlO8S9xw+4qv2DErSLHsUrEmgSiD+MqIn4jwzAK81nsY
 qgdQ==
X-Gm-Message-State: AOAM533nloYvxfgc6F6kyooHmQsssG5SHwWLKrMa5LMgx1yAOd9/kc/U
 MqQ3BG50lerdqiOrcJrwiHpLqQ==
X-Google-Smtp-Source: ABdhPJxbE+9Jnn4SIslVbqU3NIMZCVTfdNb22Vcaav810IDJeechSp5nfyk+s4hY20Fz8/EtWHzJow==
X-Received: by 2002:a1c:68d5:: with SMTP id d204mr462815wmc.100.1601638607812; 
 Fri, 02 Oct 2020 04:36:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u127sm1627596wmu.48.2020.10.02.04.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 04:36:46 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E54B61FF7E;
 Fri,  2 Oct 2020 12:36:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 00/14] testing updates (python, plugins)
Date: Fri,  2 Oct 2020 12:36:31 +0100
Message-Id: <20201002113645.17693-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

The following changes since commit b5ce42f5d138d7546f9faa2decbd6ee8702243a3:

  Merge remote-tracking branch 'remotes/jsnow-gitlab/tags/ide-pull-request' into staging (2020-10-01 19:55:10 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-and-python-021020-1

for you to fetch changes up to 2614670b7585ce4ec503546bc3023844d392f270:

  gitlab: split deprecated job into build/check stages (2020-10-02 12:31:34 +0100)

----------------------------------------------------------------
Python testing updates:

  - drop python 3.5 test from travis
  - replace Debian 9 containers with 10
  - increase cross build timeout
  - bump minimum python version in configure
  - move user plugins tests to gitlab
  - split deprecated builds into build and test

----------------------------------------------------------------
Alex Bennée (2):
      gitlab: move linux-user plugins test across to gitlab
      gitlab: split deprecated job into build/check stages

Thomas Huth (12):
      migration: Silence compiler warning in global_state_store_running()
      travis.yml: Drop the default softmmu builds
      travis.yml: Update Travis to use Bionic and Focal instead of Xenial
      travis.yml: Drop the superfluous Python 3.6 build
      travis.yml: Drop the Python 3.5 build
      tests/docker: Use Fedora containers for MinGW cross-builds in the gitlab-CI
      gitlab-ci: Remove the Debian9-based containers and containers-layer3
      tests/docker: Update the tricore container to debian 10
      shippable.yml: Remove the Debian9-based MinGW cross-compiler tests
      tests/docker: Remove old Debian 9 containers
      gitlab-ci: Increase the timeout for the cross-compiler builds
      configure: Bump the minimum required Python version to 3.6

 docs/conf.py                                       |  4 +-
 configure                                          |  4 +-
 migration/global_state.c                           |  4 +-
 .gitlab-ci.d/containers.yml                        | 38 ++++---------
 .gitlab-ci.d/crossbuilds.yml                       |  5 +-
 .gitlab-ci.yml                                     | 29 +++++++++-
 .shippable.yml                                     |  4 --
 .travis.yml                                        | 66 +++++-----------------
 tests/docker/Makefile.include                      |  2 +-
 .../docker/dockerfiles/debian-tricore-cross.docker |  2 +-
 tests/docker/dockerfiles/debian-win32-cross.docker | 38 -------------
 tests/docker/dockerfiles/debian-win64-cross.docker | 45 ---------------
 tests/docker/dockerfiles/debian9-mxe.docker        | 21 -------
 tests/docker/dockerfiles/debian9.docker            | 32 -----------
 tests/docker/dockerfiles/fedora-win32-cross.docker | 42 ++++++++++++++
 tests/docker/dockerfiles/fedora-win64-cross.docker | 38 +++++++++++++
 tests/qemu-iotests/iotests.py                      |  2 -
 17 files changed, 142 insertions(+), 234 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-win32-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-win64-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian9-mxe.docker
 delete mode 100644 tests/docker/dockerfiles/debian9.docker
 create mode 100644 tests/docker/dockerfiles/fedora-win32-cross.docker
 create mode 100644 tests/docker/dockerfiles/fedora-win64-cross.docker

-- 
2.20.1


