Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35375C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:58:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06AAE20663
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LgaZbsP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06AAE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdFt-0003so-8o
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 09:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdEQ-00027W-TY
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:56:58 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdEO-0005nv-HQ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:56:58 -0400
Received: by mail-wm1-x344.google.com with SMTP id l2so21873072wmf.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 06:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vB/KPgb5Uja+xNxDseE5L9RGmWnM9PawUYrgpjYGHU4=;
 b=LgaZbsP/Km2kB5luPgDEIBVg/P+sxrYCxJq84YIKvDYMXVQa9eraHJvoBLa556MP6f
 xWrA2rNdHNUqBD7IfDOmbLNsz1jzFNVID2be1+L0s3j+wGPxjuMXxDrNo+fyReqVXB74
 oRPCEej1tUlt4UgLsU52JyR5Xpy7sbdHWSaJ/Jlw2TVWzvuFAxHB7VbUg85PmsRGp25l
 YnXvvpHUvHkbufcqPzcSEMFvi4SJxKdYJLYgegI0zjkMoUMVKVaDx9+2nuss92SDlmQH
 qsW/16RWGK+j4FRuMwAa8p/Me+rdd76jOGmwvGCM+MAkgtr/axvG1JepjQVHrbLkpk5b
 Kp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vB/KPgb5Uja+xNxDseE5L9RGmWnM9PawUYrgpjYGHU4=;
 b=kvCjlfJFYVltmPijTS8wJTDbCTN3SQtatj16sVEqTBX9mkEVmGo6dHBTdfJrA9z4Ol
 qGc5Omq5muy12VhnlmCu56ZbdtPg45XGbjnOJw+/6TthmyqnX72ecEDSri6cgmK6qJN2
 CBWJPKPGs1Tg/WcP11jZwQKbzBULjElri8inVRdCfzxlWoOvstefoIkZHGfvwghePt/Y
 Oe9IvSCX46+QjggVmfbVVX1rGXN/GFNDmJFka639nr759SSD887AAz2JTQsjiHEvqJEl
 R04swwfmT/9L6zNmPRN70mK6ZWTfTy++0dcNIojYkYoMyIptLZoIYl6dPEuUhIl5FUVK
 07RA==
X-Gm-Message-State: AOAM533B5cXjjnur97X3vJbyVrb7GzALQrHDFeYRBEavGRRIwI43NQZY
 YKPlVaFhuif6+rZlc8QKMymqyDSMmWc=
X-Google-Smtp-Source: ABdhPJwzPKZqJRsb0XbplVtL9rFeuDi5bdIHAoS8LVp3AHLCZizBvsvcx1vJ2ATQWpCJ1rnPJ6a1uA==
X-Received: by 2002:a1c:ed17:: with SMTP id l23mr26673036wmh.175.1593611814810; 
 Wed, 01 Jul 2020 06:56:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u23sm7938956wru.94.2020.07.01.06.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 06:56:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D3B401FF7E;
 Wed,  1 Jul 2020 14:56:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v4 00/40] testing/next (vm, gitlab, fixes)
Date: Wed,  1 Jul 2020 14:56:12 +0100
Message-Id: <20200701135652.1366-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is the next iteration of my testing/next queue. It has grown by a
further 9 patches. The last iteration was:

  https://patchew.org/QEMU/20200626181357.26211-1-alex.bennee@linaro.org/

I've ironed out the final problems with GitLab failures through a
combination of fixes for linux-user and applying skipIf for
problematic acceptance tests. The MIPS malta failures can be
reproduced locally but at nowhere near the rate of the CI system which
seems to fail every time. The other failure:

  linux_initrd.py:LinuxInitrd.test_with_2gib_file_should_work_with_linux_v4_16

is a bit of a mystery. It works fine in the same container when run
locally. Obviously with all this churn I didn't get to cut the PR I
was planning so it will be cut from this version.

The following need review:

  - shippable: pull images from registry instead of building
  - testing: add check-build target
  - containers.yml: build with docker.py tooling
  - linux-user/elfload: use MAP_FIXED_NOREPLACE in pgb_reserved_va
  - tests/tcg: add more default compilers to configure.sh
  - tests/acceptance: skip LinuxInitrd 2gib with v4.16 on GitLab
  - tests/acceptance: skip multicore mips_malta tests on GitLab
  - tests/acceptance: fix dtb path for machine_rx_gdbsim
  - tests/acceptance: skip s390x_ccw_vrtio_tcg on GitLab
  - tests/docker: add --registry support to tooling
  - gitlab: build containers with buildkit and metadata
  - hw/isa: check for current_cpu before generating IRQ

Alex Bennée (24):
  hw/isa: check for current_cpu before generating IRQ
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

Philippe Mathieu-Daudé (1):
  iotests: Fix 051 output after qdev_init_nofail() removal

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

Thomas Huth (1):
  gitlab-ci: Fix the change rules after moving the YML files

 configure                                     |  31 +-
 hw/isa/lpc_ich9.c                             |   2 +-
 linux-user/elfload.c                          |  10 +-
 util/coroutine-ucontext.c                     |  52 ++-
 .gitignore                                    |   1 +
 .gitlab-ci.d/containers.yml                   | 263 +++++++++++++
 .gitlab-ci.d/edk2.yml                         |   5 +-
 .gitlab-ci.d/opensbi.yml                      |   5 +-
 .gitlab-ci.yml                                | 281 ++++++++------
 .shippable.yml                                |   8 +-
 .travis.yml                                   |  23 --
 python/qemu/console_socket.py                 | 110 ++++++
 python/qemu/machine.py                        |  23 +-
 tests/Makefile.include                        |  19 +-
 tests/acceptance/boot_linux.py                |   2 +
 tests/acceptance/linux_initrd.py              |   3 +
 tests/acceptance/machine_mips_malta.py        |   3 +
 tests/acceptance/machine_rx_gdbsim.py         |   2 +-
 tests/docker/Makefile.include                 |  17 +-
 tests/docker/common.rc                        |   2 +-
 tests/docker/docker.py                        |  46 ++-
 .../dockerfiles/debian-all-test-cross.docker  |  53 +++
 .../dockerfiles/debian-alpha-cross.docker     |   2 +-
 .../dockerfiles/debian-amd64-cross.docker     |   2 +-
 tests/docker/dockerfiles/debian-amd64.docker  |   2 +-
 .../dockerfiles/debian-arm64-cross.docker     |   2 +-
 .../debian-arm64-test-cross.docker            |   2 +-
 .../dockerfiles/debian-armel-cross.docker     |   2 +-
 .../dockerfiles/debian-armhf-cross.docker     |   2 +-
 .../dockerfiles/debian-hppa-cross.docker      |   2 +-
 .../dockerfiles/debian-m68k-cross.docker      |   2 +-
 .../dockerfiles/debian-mips-cross.docker      |   2 +-
 .../dockerfiles/debian-mips64-cross.docker    |   2 +-
 .../dockerfiles/debian-mips64el-cross.docker  |   2 +-
 .../dockerfiles/debian-mipsel-cross.docker    |   2 +-
 .../dockerfiles/debian-powerpc-cross.docker   |   2 +-
 .../dockerfiles/debian-ppc64-cross.docker     |   2 +-
 .../dockerfiles/debian-ppc64el-cross.docker   |   2 +-
 .../dockerfiles/debian-riscv64-cross.docker   |   2 +-
 .../dockerfiles/debian-s390x-cross.docker     |   2 +-
 .../dockerfiles/debian-sh4-cross.docker       |   2 +-
 .../dockerfiles/debian-sparc64-cross.docker   |   2 +-
 .../dockerfiles/debian-tricore-cross.docker   |   2 +-
 .../dockerfiles/debian-win32-cross.docker     |   2 +-
 .../dockerfiles/debian-win64-cross.docker     |   2 +-
 tests/docker/dockerfiles/debian9-mxe.docker   |   2 +-
 tests/docker/dockerfiles/fedora.docker        |   7 +
 tests/docker/dockerfiles/ubuntu2004.docker    |  10 +-
 tests/qemu-iotests/051.pc.out                 |   4 +-
 tests/tcg/Makefile.qemu                       |   4 +-
 tests/tcg/configure.sh                        |  19 +-
 tests/vm/Makefile.include                     |  22 ++
 tests/vm/aarch64vm.py                         | 106 ++++++
 tests/vm/basevm.py                            | 344 +++++++++++++-----
 tests/vm/centos-8-aarch64.ks                  |  51 +++
 tests/vm/centos.aarch64                       | 227 ++++++++++++
 tests/vm/conf_example_aarch64.yml             |  51 +++
 tests/vm/conf_example_x86.yml                 |  50 +++
 tests/vm/fedora                               |  17 +-
 tests/vm/freebsd                              |  16 +-
 tests/vm/netbsd                               |  19 +-
 tests/vm/openbsd                              |  17 +-
 tests/vm/ubuntu.aarch64                       |  68 ++++
 tests/vm/ubuntu.i386                          |  46 +--
 tests/vm/ubuntuvm.py                          |  60 +++
 65 files changed, 1771 insertions(+), 376 deletions(-)
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


