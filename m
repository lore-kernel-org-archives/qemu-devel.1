Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FEDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8166A20781
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jy4etx+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8166A20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo62J-0006PR-85
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 10:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo61E-0004ls-Fl
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:04:52 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55380)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo61C-0003Tu-52
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:04:52 -0400
Received: by mail-wm1-x341.google.com with SMTP id g75so2435036wme.5
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 07:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xBwYsX4gZ0dAQBwodESlnIFaKnt72aLoTgwWNaqkZCM=;
 b=Jy4etx+1VZXao65URNYDi8ukZWGjuw1XoTe/bqOPA++plqNZCLdYGvelK3VABShoL7
 a3zzc80bQPvafYoyTXdycwuiT7rexco9DZS53eSLsWF0pf42c37LQ4Mi4sQ+Gwry7JKp
 p4W0Ii4amf5rz1baY0le4OUR/PD37jA90G2DOsj02VdipVRtMbsijcDM+VDH/88cbV7M
 7I/Ydz4gSYlde4dIz6PiGi5PMPCQSjrY+lQN5SMjCJfUvxBvzKjFfScBhD/dbvgfyCwq
 R/RSocNZ8M1Q1KUkHLXvcNd+bS9yNA1lBzoyo2SnZh39P5ZFhaOobk7MGXU+dEkq9UDy
 WfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xBwYsX4gZ0dAQBwodESlnIFaKnt72aLoTgwWNaqkZCM=;
 b=rqab6C9TB5wn2qzkqTNFsC0+J/V5y+HPhWhCRcVqikrVA8fO93YpmcHXyBAEaQFp7E
 ljMr4kcpFUy86+ThIqM+LJr5C+key3lvnH8SHOtTLV8Pr0VZaGq0hwIq+cLc4e+BUVJ+
 Q8174sPNAojld3UrEicvNDeAZKwLRQ1srwstkbkJNAS9tTnKylKIAXsnr5n5d0FOxNDG
 22HogmklexFeEHjMCIrZrpsWIOoEyaqq5YmcODais4AAItZwPgLvfQvv4069GIPG1bj8
 4EkuNZnWMjek+go3vMXYCXIKXNeDp0deWTcw571AHIRrUh01uCwIbs9k1sBkLeyRSulZ
 MEhg==
X-Gm-Message-State: AOAM533Ppa0XE6nAIYIPq6YvJbj6jHbozTTPQC9UFKbjbk2UeYHaV+h0
 aSqCTEQaN1ist/4RiKRvruV7Rg==
X-Google-Smtp-Source: ABdhPJwqHYasLqL+vsyco8Wnm4B8jeoopDT0tAxUywc6h18hiewsdSJKLeUTWvDplY9Wl5v0tELosw==
X-Received: by 2002:a1c:32c4:: with SMTP id y187mr30537329wmy.79.1593007488078; 
 Wed, 24 Jun 2020 07:04:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g144sm8793520wme.2.2020.06.24.07.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 07:04:46 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 378B01FF7E;
 Wed, 24 Jun 2020 15:04:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 00/25] testing/next (vm, gitlab, docker)
Date: Wed, 24 Jun 2020 15:04:21 +0100
Message-Id: <20200624140446.15380-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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

This is the current state of my testing/next queue. The main changes
from the last post:

  https://patchew.org/QEMU/20200622143204.12921-1-alex.bennee@linaro.org/

are the inclusion of Danial's excellent work to generate containers
which are stored in the gitlab registry and used as a basis for
the builds in gitlab (saving the manual apt/yum steps we used to do).

On top of those changes I've tried to tweak the tooling so a local
build can pull cached images from a REGISTRY. So far it doesn't seem
to be working although it does attempt to do it. I've included the
patches for review and in the hopes someone else can help debug what
else we need to do.

The following need review:

 - gitlab: split build-disabled into two phases
 - gitlab: enable check-tcg for linux-user tests
 - gitlab: add acceptance testing to system builds
 - tests/docker: add --registry support to tooling
 - gitlab: build containers with buildkit and metadata
 - .gitignore: un-ignore .gitlab-ci.d
 - tests/docker: change tag naming scheme of our images

Alex Bennée (11):
  tests/vm: switch from optsparse to argparse
  tests/vm: allow us to take advantage of MTTCG
  tests/docker: check for an parameters not empty string
  tests/docker: change tag naming scheme of our images
  .gitignore: un-ignore .gitlab-ci.d
  gitlab: build containers with buildkit and metadata
  tests/docker: add --registry support to tooling
  gitlab: add acceptance testing to system builds
  gitlab: enable check-tcg for linux-user tests
  gitlab: add avocado asset caching
  gitlab: split build-disabled into two phases

Daniel P. Berrangé (3):
  gitlab: introduce explicit "container" and "build" stages
  gitlab: build all container images during CI
  gitlab: convert jobs to use custom built containers

David Edmondson (1):
  crypto/linux_keyring: fix 'secret_keyring' configure test

Philippe Mathieu-Daudé (1):
  iotests: Fix 051 output after qdev_init_nofail() removal

Robert Foley (9):
  tests/vm: pass args through to BaseVM's __init__
  tests/vm: Add configuration to basevm.py
  tests/vm: Added configuration file support
  tests/vm: Add common Ubuntu python module
  tests/vm: Added a new script for ubuntu.aarch64.
  tests/vm: Added a new script for centos.aarch64.
  tests/vm: change scripts to use self._config
  python/qemu: Add ConsoleSocket for optional use in QEMUMachine
  tests/vm: Add workaround to consume console

 configure                                     |  31 +-
 .gitignore                                    |   1 +
 .gitlab-ci.d/containers.yml                   | 250 +++++++++++++
 .gitlab-ci.d/edk2.yml                         |   3 +-
 .gitlab-ci.d/opensbi.yml                      |   3 +-
 .gitlab-ci.yml                                | 275 +++++++++------
 .travis.yml                                   |  23 --
 python/qemu/console_socket.py                 | 110 ++++++
 python/qemu/machine.py                        |  23 +-
 tests/docker/Makefile.include                 |   5 +-
 tests/docker/common.rc                        |   2 +-
 tests/docker/docker.py                        |  27 +-
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
 tests/qemu-iotests/051.pc.out                 |   4 +-
 tests/vm/Makefile.include                     |  22 ++
 tests/vm/aarch64vm.py                         | 106 ++++++
 tests/vm/basevm.py                            | 332 +++++++++++++-----
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
 tests/vm/ubuntuvm.py                          |  60 ++++
 51 files changed, 1565 insertions(+), 322 deletions(-)
 create mode 100644 .gitlab-ci.d/containers.yml
 create mode 100644 python/qemu/console_socket.py
 create mode 100644 tests/vm/aarch64vm.py
 create mode 100644 tests/vm/centos-8-aarch64.ks
 create mode 100755 tests/vm/centos.aarch64
 create mode 100644 tests/vm/conf_example_aarch64.yml
 create mode 100644 tests/vm/conf_example_x86.yml
 create mode 100755 tests/vm/ubuntu.aarch64
 create mode 100644 tests/vm/ubuntuvm.py

-- 
2.20.1


