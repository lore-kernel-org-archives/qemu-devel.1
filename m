Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3566DC5ACD6
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 028DF20735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KfGCU4e5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028DF20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGO7-0002CS-3w
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 13:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGMl-0000FD-5I
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGMj-0001Tr-2N
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:50:58 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:37619)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jEGMi-0001K1-Q5
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:50:57 -0400
Received: by mail-wr1-x42b.google.com with SMTP id 6so26871150wre.4
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 10:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qSLczt+gDAdBi4LDjw24bYcBV5MQ/AraFikb8wO4XTY=;
 b=KfGCU4e51O3k5UpAnIZkaWDPh94/1tXUaKVL2nE12YGKLV4+3YgWI0YlFZ22QUbgKy
 4tlxvXHvsHtPM6E/hb8Mlux9sf2DrQwgT+bETq/gV5WVU7IUCqiIM8XzhuwaLtBFfoX7
 jvdxVFDa0L88AZ2wiB7YGAy1FsijIVUVgU5tmmAuQEO2a4Vr3z0YowuIzQ7qTwirAzxz
 pZ/zgEvx8tr0L1B6RiBSjFkFLFtnPtMuX9rUAChU7aVM6q+fYVko6FiJf5j3VKIrevtO
 aShCQiOidqQudOH/YWXSeigzaFeiUzYW6KCfldqsE/b5Gc5hcLS4O1DVtUcgSAHHyakm
 tw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qSLczt+gDAdBi4LDjw24bYcBV5MQ/AraFikb8wO4XTY=;
 b=KLqvAbuXBz6pPcbqtXsFMREs6vEE0j1E1kDF6ceSQI9exJVei2g8k6Rb+ZUCICRSiM
 0JnCJRF+ZUsu184ZWtAZvxoZcCV6ITTtfoB+esxw+wxH5A7Z7QPUveXyOabfJSb0XQQo
 K/F0rhgYdI4Wcu3VhtmhYX700V3sB/pFfUe71TGffOXlMqoXDSEmwocib/N/WHNX61vh
 RPDL/zCtBTLRz1TK4WMFMElWWBvJJswvmtuJEajgLr/MpFrCIPTULyptuMPRQt37VoQw
 iEXNqLNWnWLMKWbnsrrCNlgMfqukIGGxT3gcBH5fxKdWf3o6/MLEp3vV/A+JXqGRgZIm
 pr6g==
X-Gm-Message-State: ANhLgQ2nACbHLXo9MZG/HwF+/iyZFhO8prPG9C2RZe9Evvp3iDFRRCxg
 RtPFi073nhSCKmkOGRAv6LNpDg==
X-Google-Smtp-Source: ADFU+vvYSbDTq4rOnJqXzWxDohl4D6hbNzie3S3020geYhTaHpgaObCrjRUdJQ/4tlTfD3OgtV1pZQ==
X-Received: by 2002:adf:8023:: with SMTP id 32mr143293wrk.189.1584467455416;
 Tue, 17 Mar 2020 10:50:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c85sm173188wmd.48.2020.03.17.10.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 10:50:54 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 406271FF7E;
 Tue, 17 Mar 2020 17:50:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 00/28 for 5.0] testing and gdbstub updates
Date: Tue, 17 Mar 2020 17:50:25 +0000
Message-Id: <20200317175053.5278-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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

The following changes since commit 6fb1603aa24d9212493e4819d7b685be9c9aad7a:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200317' into staging (2020-03-17 14:44:50 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-and-gdbstub-170320-1

for you to fetch changes up to 3bc2609d478779be600fd66744eb4e3730ec5e33:

  gdbstub: Fix single-step issue by confirming 'vContSupported+' feature to gdb (2020-03-17 17:38:52 +0000)

----------------------------------------------------------------
Testing and gdbstub updates:

  - docker updates for VirGL
  - re-factor gdbstub for static GDBState
  - re-factor gdbstub for dynamic arrays
  - add SVE support to arm gdbstub
  - add some guest debug tests to check-tcg
  - add aarch64 userspace register tests
  - remove packet size limit to gdbstub
  - simplify gdbstub monitor code
  - report vContSupported in gdbstub to use proper single-step

----------------------------------------------------------------
Alex Bennée (20):
      gdbstub: make GDBState static and have common init function
      gdbstub: stop passing GDBState * around and use global
      gdbstub: move str_buf to GDBState and use GString
      gdbstub: move mem_buf to GDBState and use GByteArray
      gdbstub: add helper for 128 bit registers
      target/arm: use gdb_get_reg helpers
      target/m68k: use gdb_get_reg helpers
      target/i386: use gdb_get_reg helpers
      gdbstub: extend GByteArray to read register helpers
      target/arm: prepare for multiple dynamic XMLs
      target/arm: explicitly encode regnum in our XML
      target/arm: default SVE length to 64 bytes for linux-user
      target/arm: generate xml description of our SVE registers
      target/arm: don't bother with id_aa64pfr0_read for USER_ONLY
      tests/tcg/aarch64: userspace system register test
      configure: allow user to specify what gdb to use
      tests/guest-debug: add a simple test runner
      tests/tcg/aarch64: add a gdbstub testcase for SVE registers
      tests/tcg/aarch64: add SVE iotcl test
      tests/tcg/aarch64: add test-sve-ioctl guest-debug test

Changbin Du (1):
      gdbstub: Fix single-step issue by confirming 'vContSupported+' feature to gdb

Damien Hedde (2):
      gdbstub: change GDBState.last_packet to GByteArray
      gdbstub: do not split gdb_monitor_write payload

Philippe Mathieu-Daudé (5):
      tests/docker: Install tools to cross-debug and build Linux kernels
      tests/docker: Update VirGL git repository URL
      tests/docker: Remove obsolete VirGL --with-glx configure option
      tests/docker: Update VirGL to v0.8.0
      travis.yml: Set G_MESSAGES_DEBUG do report GLib errors

 configure                                    |   9 +
 include/exec/gdbstub.h                       |  62 +-
 include/hw/core/cpu.h                        |   2 +-
 target/alpha/cpu.h                           |   2 +-
 target/arm/cpu.h                             |  31 +-
 target/cris/cpu.h                            |   4 +-
 target/hppa/cpu.h                            |   2 +-
 target/i386/cpu.h                            |   2 +-
 target/lm32/cpu.h                            |   2 +-
 target/m68k/cpu.h                            |   2 +-
 target/microblaze/cpu.h                      |   2 +-
 target/mips/internal.h                       |   2 +-
 target/openrisc/cpu.h                        |   2 +-
 target/ppc/cpu.h                             |   4 +-
 target/riscv/cpu.h                           |   2 +-
 target/s390x/internal.h                      |   2 +-
 target/sh4/cpu.h                             |   2 +-
 target/sparc/cpu.h                           |   2 +-
 target/xtensa/cpu.h                          |   2 +-
 gdbstub.c                                    | 936 +++++++++++++--------------
 hw/core/cpu.c                                |   2 +-
 target/alpha/gdbstub.c                       |   2 +-
 target/arm/cpu.c                             |   7 +-
 target/arm/gdbstub.c                         | 173 ++++-
 target/arm/gdbstub64.c                       |   2 +-
 target/arm/helper.c                          | 186 +++++-
 target/cris/gdbstub.c                        |   4 +-
 target/hppa/gdbstub.c                        |   2 +-
 target/i386/gdbstub.c                        |  29 +-
 target/lm32/gdbstub.c                        |   2 +-
 target/m68k/gdbstub.c                        |   2 +-
 target/m68k/helper.c                         |  33 +-
 target/microblaze/gdbstub.c                  |   2 +-
 target/mips/gdbstub.c                        |   2 +-
 target/nios2/cpu.c                           |   2 +-
 target/openrisc/gdbstub.c                    |   2 +-
 target/ppc/gdbstub.c                         |  48 +-
 target/ppc/translate_init.inc.c              |  54 +-
 target/riscv/gdbstub.c                       |  20 +-
 target/s390x/gdbstub.c                       |  30 +-
 target/sh4/gdbstub.c                         |   2 +-
 target/sparc/gdbstub.c                       |   2 +-
 target/xtensa/gdbstub.c                      |   2 +-
 tests/tcg/aarch64/sve-ioctls.c               |  70 ++
 tests/tcg/aarch64/sysregs.c                  | 172 +++++
 .travis.yml                                  |   1 +
 tests/.gitignore                             |   1 +
 tests/docker/dockerfiles/debian-amd64.docker |   6 +-
 tests/docker/dockerfiles/debian10.docker     |   3 +
 tests/docker/dockerfiles/debian9.docker      |   3 +
 tests/guest-debug/run-test.py                |  57 ++
 tests/tcg/aarch64/Makefile.target            |  32 +
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py  |  85 +++
 tests/tcg/aarch64/gdbstub/test-sve.py        |  84 +++
 54 files changed, 1497 insertions(+), 701 deletions(-)
 create mode 100644 tests/tcg/aarch64/sve-ioctls.c
 create mode 100644 tests/tcg/aarch64/sysregs.c
 create mode 100755 tests/guest-debug/run-test.py
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sve.py

-- 
2.20.1


