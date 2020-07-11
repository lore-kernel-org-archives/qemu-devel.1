Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4D3C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 17:08:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE5D20786
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 17:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fr9YMsMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE5D20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juIzH-0004xG-Nm
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 13:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juIyQ-0003N8-Rr
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 13:07:38 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:38600)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juIyO-0006h4-FY
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 13:07:38 -0400
Received: by mail-wm1-x331.google.com with SMTP id f18so8938396wml.3
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 10:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+lXl4Szpjg/YT2Ax3s+QJTh2PasxIDSCopx/Q97cD3I=;
 b=Fr9YMsMR0HeJ1JHXAinhTG73biNDt3Kqxjc+16iDdJnCS4/Nn8+m70j0Kgf/2f4CDr
 FFydgDDPkhnB24CrT1AuCf0SgFQVzNuiVMlEvjDTGhV7tQdq1Gr2+/aaGmaNjsGH0mTK
 +vJp/LyUoFRHgrS9qOKPGdkE+Kvi/mtQFhd1yas9EKzhYzWAzLas3ERV2A/MYVmsskTW
 gHoM0MJrXW2cbv63D2wqN7NHI0Gi+Bu9Rcq4/HPYpXkmty6ShJKTlqSeFYenKZxgopkm
 Dn5FlJakP63z5UpBD0hnhDzjnsxnSqTaZeRiw7yivNFmNKSo51gkAStDSNlqd69J2uO+
 rgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+lXl4Szpjg/YT2Ax3s+QJTh2PasxIDSCopx/Q97cD3I=;
 b=eDVXWKX/2VsZjQFFAri+ZsizjD/GqlDn+bbeyBwZ6vq3KsDMHdZCxVehJ+xxLFPAZH
 kcNDxJsLjmfxTN36AhZXi89bINjxD6hE5haYoyHdc4LfJYQI8q2CcBGiRt1yi9bgHj70
 WZMeNGZ+gK0n1j3CcrJUWO73AFrzhofIXcl4lTWyysx92cUcMpFNp7wM6eXJPnfZT4cS
 lBBS6fyJlKJ3ZPcQUMl0kWMHDcbJHqkKLBZ0klaf0KEtG1M3qpj5uibYtUBVlYKd6O+u
 bPXr1AtiXsVsdwiuAqY85LcrjBog6nHWi6JiNXzSiZ8Q7aw9TKcFaKLVAHOuP0Kd1FDi
 znng==
X-Gm-Message-State: AOAM530H9D67VB+CToWEz8ogkOhzHYyQ7iuAuE3dETMoAaF4V3KSoPki
 uhFdBIar5R1SgD5/iTKyZmdVDg==
X-Google-Smtp-Source: ABdhPJxp7TlNu5FhRgKiMAca2b4mFu8uz7wI+cofh35K2Z9oZDbcxIK8mkgyLKAcjedlQuehV4p5mQ==
X-Received: by 2002:a1c:dfd6:: with SMTP id
 w205mr11389704wmg.118.1594487254233; 
 Sat, 11 Jul 2020 10:07:34 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z8sm14903892wmg.39.2020.07.11.10.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 10:07:32 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 23DDE1FF7E;
 Sat, 11 Jul 2020 18:07:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 00/50] testing updates (vm, gitlab, misc build fixes)
Date: Sat, 11 Jul 2020 18:07:22 +0100
Message-Id: <20200711170732.26213-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Fixed a few, dropped a few, added a few

---

The following changes since commit 827937158b72ce2265841ff528bba3c44a1bfbc8:

  Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20200710' into staging (2020-07-11 13:56:03 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-and-misc-110720-2

for you to fetch changes up to 4a40f561d5ebb5050a8c6dcbdcee85621056590a:

  iotests: Set LC_ALL=C for sort (2020-07-11 15:53:29 +0100)

----------------------------------------------------------------
Testing and misc build updates:

  - tests/vm support for aarch64 VMs
  - tests/tcg better cross-compiler detection
  - update docker tooling to support registries
  - update docker support for xtensa
  - gitlab build docker images and store in registry
  - gitlab use docker images for builds
  - a number of skipIf updates to support move
  - linux-user MAP_FIXED_NOREPLACE fix
  - qht-bench compiler tweaks
  - configure fix for secret keyring
  - tsan fiber annotation clean-up
  - doc updates for mttcg/icount/gdbstub
  - fix cirrus to use brew bash for iotests
  - revert virtio-gpu breakage
  - fix LC_ALL to avoid sorting changes in iotests

----------------------------------------------------------------
Alex Bennée (26):
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
      gitlab: limit re-builds of the containers
      containers.yml: build with docker.py tooling
      testing: add check-build target
      shippable: pull images from registry instead of building
      docs/devel: convert and update MTTCG design document
      docs/devel: add some notes on tcg-icount for developers
      tests/docker: fall back more gracefully when pull fails
      .cirrus.yml: add bash to the brew packages

Daniel P. Berrangé (4):
      gitlab: introduce explicit "container" and "build" stages
      gitlab: build all container images during CI
      gitlab: convert jobs to use custom built containers
      tests: improve performance of device-introspect-test

David Edmondson (1):
      crypto/linux_keyring: fix 'secret_keyring' configure test

Gerd Hoffmann (2):
      tests: fix "make check-qtest" for modular builds
      Revert "vga: build virtio-gpu as module"

Jon Doron (1):
      docs: Add to gdbstub documentation the PhyMemMode

Max Filippov (1):
      tests/docker: update toolchain set in debian-xtensa-cross

Max Reitz (1):
      iotests: Set LC_ALL=C for sort

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

 docs/devel/index.rst                               |   2 +
 .../{multi-thread-tcg.txt => multi-thread-tcg.rst} |  52 ++--
 docs/devel/tcg-icount.rst                          |  97 ++++++
 docs/system/gdb.rst                                |  20 ++
 configure                                          |  31 +-
 linux-user/elfload.c                               |  10 +-
 tests/qht-bench.c                                  |  40 ++-
 tests/qtest/device-introspect-test.c               |  60 ++--
 util/coroutine-ucontext.c                          |  52 ++--
 util/module.c                                      |   6 -
 .cirrus.yml                                        |   4 +-
 .gitignore                                         |   1 +
 .gitlab-ci.d/containers.yml                        | 263 ++++++++++++++++
 .gitlab-ci.d/edk2.yml                              |   5 +-
 .gitlab-ci.d/opensbi.yml                           |   5 +-
 .gitlab-ci.yml                                     | 265 ++++++++++------
 .shippable.yml                                     |   8 +-
 .travis.yml                                        |  62 ++--
 hw/display/Makefile.objs                           |  23 +-
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
 tests/docker/docker.py                             |  47 ++-
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
 .../docker/dockerfiles/debian-xtensa-cross.docker  |   6 +-
 tests/docker/dockerfiles/debian9-mxe.docker        |   2 +-
 tests/docker/dockerfiles/fedora.docker             |   7 +
 tests/docker/dockerfiles/ubuntu2004.docker         |  10 +-
 tests/qemu-iotests/common.filter                   |   2 +-
 tests/qtest/Makefile.include                       |   1 +
 tests/tcg/Makefile.qemu                            |   4 +-
 tests/tcg/configure.sh                             |  21 +-
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
 76 files changed, 2034 insertions(+), 448 deletions(-)
 rename docs/devel/{multi-thread-tcg.txt => multi-thread-tcg.rst} (90%)
 create mode 100644 docs/devel/tcg-icount.rst
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


