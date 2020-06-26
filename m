Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76689C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:15:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A3820836
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QaKyg2zX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A3820836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jostI-00019p-Gw
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 14:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1josrU-0007I0-DA
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:14:04 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53197)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1josrS-0001Eq-1W
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:14:03 -0400
Received: by mail-wm1-x341.google.com with SMTP id q15so9643326wmj.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 11:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OJduraLw5HOt6QT+IFvbH9oeQ9mW8FGVGn3RmJ2MOpc=;
 b=QaKyg2zX+58OfXSq3+RNZtLwfEruaoz+jF2k5I9BRO2vMwX9ZJWfYHO6/ey8+jNUzv
 B/PoVjC8dLYXkSzARX/Po3VBYSEfFMLeZMyU24O/dkmuCb5j4FdwYbIKfK1PcH+Y22ZQ
 v+HGlck6ibFbG0Hg5yiO6ejapmEG2ZrcbHrim3DXm7tv89vufNsZTF8d29jkdSbzUSoM
 OnArNxixs+9hdRa0dv4stPX3lVouf5r5mxLK7Z3epq3g84sE/yN0NqTaidNGWTeFEpmX
 /eXBeTxpi1BXIRr7/SrEw5zm2+zejBgx1OnDAyJdUDXyM/kE5QUyfv2X56EjLPNU++AF
 AxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OJduraLw5HOt6QT+IFvbH9oeQ9mW8FGVGn3RmJ2MOpc=;
 b=ZZdvmTte8EW193hHXVWYgns7SJ8mdLZYcQVccEuv9lhybcRRsoKJYKnQDH/+FrKEnr
 cuJCTYafi8lsVQ0GYfHMWG1jK2OFak/FtJSukoOe6d31Bimnw2xXD4GggZ9WpsC5Aei3
 mu1mAFx0eDSmVv3hlZ7FvqvrUNunR3UBv/h/axKSQiUmYfW2GRJTV/rC4J7FbYyHoPve
 ZTyg4FBK6QkZxCq8A/9buhnXnfjSrLcm3UQBv18eNfDkzo79V+SWJ7JO4wv0W0/g8IJp
 FV52RA5PuKTnZId2u4gImiR0LDrFpzAI8Sq0OQd3YqRS8D82nVy/xTzJTvqTsMAkMWW1
 p4nA==
X-Gm-Message-State: AOAM530YcJYFVb5Ft5nTAirtVQaXHkJwp144pdSEFZPSa8H0/8/87BUz
 010TFsgcAfohRKAWnHPhYgciuw==
X-Google-Smtp-Source: ABdhPJyxkNnjMZTwRi6gJusbe5/a7BJyyMta0VJj5C+tih1h6kVs4kVKFpdAXpXoT7xlntzZX5Q5Uw==
X-Received: by 2002:a1c:a90d:: with SMTP id s13mr4470036wme.184.1593195239814; 
 Fri, 26 Jun 2020 11:13:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q188sm15687919wma.46.2020.06.26.11.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 11:13:58 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B2F5F1FF7E;
 Fri, 26 Jun 2020 19:13:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 00/30] testing/next (gitlab, vm, docker)
Date: Fri, 26 Jun 2020 19:13:27 +0100
Message-Id: <20200626181357.26211-1-alex.bennee@linaro.org>
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

This is the next iteration of my testing/next queue. The main changes
from the last post:

  https://patchew.org/QEMU/20200624140446.15380-1-alex.bennee@linaro.org/

The GitLab docker patches are almost ready although there are a couple
of problems running on GitLab's infrastructure which need to be ironed
out. I finally got the caching working so a local build is seeded from
the REGISTRY.

There is also a minor fix to optparse/argparse change for tests/vm.

There are two build fixes that I thought were going in via other trees
but I'll include them in the PR I plan to cut on Tuesday if their
respective sources haven't been merged by then.

The following need review:

  - containers.yml: build with docker.py tooling
  - gitlab: limit re-builds of the containers
  - gitlab: split build-disabled into two phases
  - gitlab: enable check-tcg for linux-user tests
  - tests/docker: add a linux-user testing focused image
  - gitlab: add acceptance testing to system builds
  - tests/docker: add packages needed for check-acceptance
  - tests/docker: add --registry support to tooling
  - gitlab: build containers with buildkit and metadata
  - .gitignore: un-ignore .gitlab-ci.d
  - tests/docker: change tag naming scheme of our images

Alex Bennée (15):
  tests/vm: switch from optsparse to argparse
  tests/vm: allow us to take advantage of MTTCG
  tests/docker: check for an parameters not empty string
  tests/docker: change tag naming scheme of our images
  .gitignore: un-ignore .gitlab-ci.d
  gitlab: build containers with buildkit and metadata
  tests/docker: add --registry support to tooling
  tests/docker: add packages needed for check-acceptance
  gitlab: add acceptance testing to system builds
  tests/docker: add a linux-user testing focused image
  gitlab: enable check-tcg for linux-user tests
  gitlab: add avocado asset caching
  gitlab: split build-disabled into two phases
  gitlab: limit re-builds of the containers
  containers.yml: build with docker.py tooling

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

Thomas Huth (1):
  gitlab-ci: Fix the change rules after moving the YML files

 configure                                     |  31 +-
 .gitignore                                    |   1 +
 .gitlab-ci.d/containers.yml                   | 264 ++++++++++++++
 .gitlab-ci.d/edk2.yml                         |   5 +-
 .gitlab-ci.d/opensbi.yml                      |   5 +-
 .gitlab-ci.yml                                | 275 ++++++++------
 .travis.yml                                   |  23 --
 python/qemu/console_socket.py                 | 110 ++++++
 python/qemu/machine.py                        |  23 +-
 tests/docker/Makefile.include                 |   8 +-
 tests/docker/common.rc                        |   2 +-
 tests/docker/docker.py                        |  39 +-
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
 tests/vm/Makefile.include                     |  22 ++
 tests/vm/aarch64vm.py                         | 106 ++++++
 tests/vm/basevm.py                            | 339 +++++++++++++-----
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
 54 files changed, 1669 insertions(+), 328 deletions(-)
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


