Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0A3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A52D206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BdAC4oJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A52D206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshjz-00065R-NN
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshj0-0004KK-8N
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:09:06 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:34558)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshiy-000437-3P
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:09:05 -0400
Received: by mail-wr1-x436.google.com with SMTP id f7so40959352wrw.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4oVoHDVvHj+LMEZpZo3Fd9S0fHCCOIodaZdFR3DmLW8=;
 b=BdAC4oJEtexYbeyteb9iaVJmZOVSsDCofnsvAYKyqyLs8f4dHdn+FHMtJecdt9BBZf
 HhDLGMWiib0Iyb6D3+ZBEK4GOTpenGc6ImqBFekIHZCZ2e4nG3fdHSU24c988jHFqyyN
 CmQBzS48z+YHRzoIbyVf1OubeeHTqpleatGOZx21vs6VynjO4Ub6YkeYnS/Ln117kjZ8
 qvoz9lTVJTlZJQaAwp9EzRKkojAKnt9vWdEXpVJhLknR3jAZN/c3QEid11Dpl/jc9Ibh
 t6L2S+i7XwIniLNq0ux3RPPUvL2aMypHpBUvbw09MtmZDjQLqwXZCU8nznTGMDJkjDMo
 X22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4oVoHDVvHj+LMEZpZo3Fd9S0fHCCOIodaZdFR3DmLW8=;
 b=L1sszZ7HhKjreTBlAwJI3TOWTRsi6m5WJvkMJX5W/bWC5JKj7Id9cyUxUyBYoYtwLZ
 GxdRw25rgKnE+NyCSoJWtetGlxyaH2gYIi3zhOInqOPEu5U7u8pIWLHwanUE3Lu5TuiS
 Etb37aB8uUATkBFVSyI27eEPP1sXamWRGQ0EGSccO4jNaARdlb36wqc03ZCy4tsgaWva
 r6+GEhSDC/OAxChoGHoukML0ROhorMnOOfGqOfv5Sc+DJYCSxDSTgpQr3qzX0i91yziN
 rOOVn5ErQw6bLaBv/sgicJhEgqlabaBXlPSIdSTijb0IqylkNf4Lyj0X77wGcuwhaW1H
 A+rA==
X-Gm-Message-State: AOAM530ieBJ4XjUlkdO+HMwIuJA0fycRhQda3itLI6f3I5kGe8mzWjSC
 XGZogwUKzVx6hi2ForuzA5EmZg==
X-Google-Smtp-Source: ABdhPJxuqcRQPmPzO5AbYdqgsKSUq2Svq81orX1hNdjy5tAXmu3sUa26w4pkJ4GAQRi03R/w4Pi/3Q==
X-Received: by 2002:adf:828b:: with SMTP id 11mr56415856wrc.58.1594105742671; 
 Tue, 07 Jul 2020 00:09:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v15sm2115466wmh.24.2020.07.07.00.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:08:59 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7DE521FF7E;
 Tue,  7 Jul 2020 08:08:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 00/41] testing updates (vm, gitlab, misc build fixes)
Date: Tue,  7 Jul 2020 08:08:17 +0100
Message-Id: <20200707070858.6622-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

There will be some docker failures until the official repository has
seeded but local builds should continue to work.

----

The following changes since commit eb6490f544388dd24c0d054a96dd304bc7284450:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200703' into staging (2020-07-04 16:08:41 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-and-misc-070720-1

for you to fetch changes up to 6a726e8ca0286e3ed69945abd447099f6f6a903c:

  tests/qht-bench: Adjust threshold computation (2020-07-07 07:57:41 +0100)

----------------------------------------------------------------
Testing and build updates:

  - tests/vm support for aarch64 VMs
  - tests/tcg better cross-compiler detection
  - update docker tooling to support registries
  - gitlab build docker images and store in registry
  - gitlab use docker images for builds
  - a number of skipIf updates to support move
  - linux-user MAP_FIXED_NOREPLACE fix
  - qht-bench compiler tweaks
  - configure fix for secret keyring
  - tsan fiber annotation clean-up

----------------------------------------------------------------
Alex Bennée (23):
      tests/vm: switch from optsparse to argparse
      tests/vm: allow us to take advantage of MTTCG
      tests/docker: check for an parameters not empty string
      tests/docker: change tag naming scheme of our images
      .gitignore: un-ignore .gitlab-ci.d
      gitlab: build containers with buildkit and metadata
      tests/docker: add --registry support to tooling
      tests/docker: add packages needed for check-acceptance
      tests/acceptance: skip s390x_ccw_vrtio_tcg on GitLab
      tests/acceptance: fix dtb path for machine_rx_gdbsim
      tests/acceptance: skip multicore mips_malta tests on GitLab
      tests/acceptance: skip LinuxInitrd 2gib with v4.16 on GitLab
      gitlab: add acceptance testing to system builds
      tests/tcg: add more default compilers to configure.sh
      tests/docker: add a linux-user testing focused image
      linux-user/elfload: use MAP_FIXED_NOREPLACE in pgb_reserved_va
      gitlab: enable check-tcg for linux-user tests
      gitlab: add avocado asset caching
      gitlab: split build-disabled into two phases
      gitlab: limit re-builds of the containers
      containers.yml: build with docker.py tooling
      testing: add check-build target
      shippable: pull images from registry instead of building

Daniel P. Berrangé (3):
      gitlab: introduce explicit "container" and "build" stages
      gitlab: build all container images during CI
      gitlab: convert jobs to use custom built containers

David Edmondson (1):
      crypto/linux_keyring: fix 'secret_keyring' configure test

Richard Henderson (2):
      tests/qht-bench: Adjust testing rate by -1
      tests/qht-bench: Adjust threshold computation

Robert Foley (10):
      util/coroutine: Cleanup start_switch_fiber_ for TSAN.
      tests/vm: pass args through to BaseVM's __init__
      tests/vm: Add configuration to basevm.py
      tests/vm: Added configuration file support
      tests/vm: Add common Ubuntu python module
      tests/vm: Added a new script for ubuntu.aarch64.
      tests/vm: Added a new script for centos.aarch64.
      tests/vm: change scripts to use self._config
      python/qemu: Add ConsoleSocket for optional use in QEMUMachine
      tests/vm: Add workaround to consume console

Thomas Huth (2):
      gitlab-ci: Fix the change rules after moving the YML files
      travis.yml: Test also the other targets on s390x

 configure                                          |  31 +-
 linux-user/elfload.c                               |  10 +-
 tests/qht-bench.c                                  |  40 ++-
 util/coroutine-ucontext.c                          |  52 ++--
 .gitignore                                         |   1 +
 .gitlab-ci.d/containers.yml                        | 263 ++++++++++++++++
 .gitlab-ci.d/edk2.yml                              |   5 +-
 .gitlab-ci.d/opensbi.yml                           |   5 +-
 .gitlab-ci.yml                                     | 281 ++++++++++-------
 .shippable.yml                                     |   8 +-
 .travis.yml                                        |  62 ++--
 python/qemu/console_socket.py                      | 110 +++++++
 python/qemu/machine.py                             |  23 +-
 tests/Makefile.include                             |  19 +-
 tests/acceptance/boot_linux.py                     |   2 +
 tests/acceptance/linux_initrd.py                   |   3 +
 tests/acceptance/machine_mips_malta.py             |   3 +
 tests/acceptance/machine_rx_gdbsim.py              |   2 +-
 tests/acceptance/replay_kernel.py                  |   2 +-
 tests/docker/Makefile.include                      |  17 +-
 tests/docker/common.rc                             |   2 +-
 tests/docker/docker.py                             |  46 ++-
 .../dockerfiles/debian-all-test-cross.docker       |  53 ++++
 tests/docker/dockerfiles/debian-alpha-cross.docker |   2 +-
 tests/docker/dockerfiles/debian-amd64-cross.docker |   2 +-
 tests/docker/dockerfiles/debian-amd64.docker       |   2 +-
 tests/docker/dockerfiles/debian-arm64-cross.docker |   2 +-
 .../dockerfiles/debian-arm64-test-cross.docker     |   2 +-
 tests/docker/dockerfiles/debian-armel-cross.docker |   2 +-
 tests/docker/dockerfiles/debian-armhf-cross.docker |   2 +-
 tests/docker/dockerfiles/debian-hppa-cross.docker  |   2 +-
 tests/docker/dockerfiles/debian-m68k-cross.docker  |   2 +-
 tests/docker/dockerfiles/debian-mips-cross.docker  |   2 +-
 .../docker/dockerfiles/debian-mips64-cross.docker  |   2 +-
 .../dockerfiles/debian-mips64el-cross.docker       |   2 +-
 .../docker/dockerfiles/debian-mipsel-cross.docker  |   2 +-
 .../docker/dockerfiles/debian-powerpc-cross.docker |   2 +-
 tests/docker/dockerfiles/debian-ppc64-cross.docker |   2 +-
 .../docker/dockerfiles/debian-ppc64el-cross.docker |   2 +-
 .../docker/dockerfiles/debian-riscv64-cross.docker |   2 +-
 tests/docker/dockerfiles/debian-s390x-cross.docker |   2 +-
 tests/docker/dockerfiles/debian-sh4-cross.docker   |   2 +-
 .../docker/dockerfiles/debian-sparc64-cross.docker |   2 +-
 .../docker/dockerfiles/debian-tricore-cross.docker |   2 +-
 tests/docker/dockerfiles/debian-win32-cross.docker |   2 +-
 tests/docker/dockerfiles/debian-win64-cross.docker |   2 +-
 tests/docker/dockerfiles/debian9-mxe.docker        |   2 +-
 tests/docker/dockerfiles/fedora.docker             |   7 +
 tests/docker/dockerfiles/ubuntu2004.docker         |  10 +-
 tests/tcg/Makefile.qemu                            |   4 +-
 tests/tcg/configure.sh                             |  19 +-
 tests/vm/Makefile.include                          |  22 ++
 tests/vm/aarch64vm.py                              | 106 +++++++
 tests/vm/basevm.py                                 | 344 +++++++++++++++------
 tests/vm/centos-8-aarch64.ks                       |  51 +++
 tests/vm/centos.aarch64                            | 227 ++++++++++++++
 tests/vm/conf_example_aarch64.yml                  |  51 +++
 tests/vm/conf_example_x86.yml                      |  50 +++
 tests/vm/fedora                                    |  17 +-
 tests/vm/freebsd                                   |  16 +-
 tests/vm/netbsd                                    |  19 +-
 tests/vm/openbsd                                   |  17 +-
 tests/vm/ubuntu.aarch64                            |  68 ++++
 tests/vm/ubuntu.i386                               |  46 +--
 tests/vm/ubuntuvm.py                               |  60 ++++
 65 files changed, 1839 insertions(+), 383 deletions(-)
 create mode 100644 .gitlab-ci.d/containers.yml
 create mode 100644 python/qemu/console_socket.py
 create mode 100644 tests/docker/dockerfiles/debian-all-test-cross.docker
 create mode 100644 tests/vm/aarch64vm.py
 create mode 100644 tests/vm/centos-8-aarch64.ks
 create mode 100755 tests/vm/centos.aarch64
 create mode 100644 tests/vm/conf_example_aarch64.yml
 create mode 100644 tests/vm/conf_example_x86.yml
 create mode 100755 tests/vm/ubuntu.aarch64
 create mode 100644 tests/vm/ubuntuvm.py

-- 
2.20.1


