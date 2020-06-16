Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F81C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:52:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4A35207D3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GTsIpHFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A35207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlC0c-0000Cv-5Q
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 09:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlBzz-0008BI-9N
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:51:35 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:45155)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlBzw-0002H8-Pa
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:51:34 -0400
Received: by mail-wr1-x42f.google.com with SMTP id c3so20824313wru.12
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 06:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gxz/6gm8AkZpa8TmZvFkDqHFPs//OtHrqP6lw1g1oQ0=;
 b=GTsIpHFhifk4Hg3UM4tR/ucs5nAkDoRblcrAIjO2r9vmcx5YDLHDUXOcygTXVs0P2e
 K67uJ5mewltpas79+wJthVntKLqXKlRrXkp9HO//VBqnBFZc1xGWvwDJBX0FOeW+leL+
 DATIH0Uy+V5ioemGrJPkmPmyl7sKsOnQlJ0nFTnl612WC3CVuYWWKwfvTVdtYT5qAOzk
 lFu7EEZKzM+4SnGShBFlcaTeFqg/Ap1SKKt5NvsiRjd2NNEQbivXTOrtBlxK9R4Lpw9g
 hZiE7kZmKEX208m2szLihruZ8wmizVcqj+9f5bY8IdgQVbCvRSL8ESO1BDpbdbG3amY/
 idsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gxz/6gm8AkZpa8TmZvFkDqHFPs//OtHrqP6lw1g1oQ0=;
 b=G1n9dgEaIqI5cLZJg2gctXhy+ORJmz3C3+pKUWqr4L/0IfhBnHWrqg9mJE/nJKuGqO
 RXT/DkfXLGryymX3dHS5Qx6ebPZisKg6BZmuJjHtwoKUw+lPRyRoO2GHSd1VJS/f+IzS
 TjEmKJceCZzLxK/sBVgK1vNqLfsSYYpaj/R9vyipf5KJ0J9DZw/D81lGsp2UFOd+Rm3V
 g7qBH+n8QV9YrW13hWfmmL9esMAuidOygJss40VgRrm0i1lKxPeIW5GeFRnnQ5Sel8b7
 COs/yMhXN/8fhRWBMDg9VNDfy8LTDO0v6nTYwdBZ2wa1arycBDrA9hVVcLPbeHQzEi4N
 HPjA==
X-Gm-Message-State: AOAM533NMy4q+cZgNTTlflNgx5j1XvvUqd7+/oSnwP62nKvYEMhk3kKz
 oTYgWMn4aXjAjKj0yXrV7/3AnQ==
X-Google-Smtp-Source: ABdhPJyc+Ln0KjFHA2kLuT+UndOSUL1VdZev1hdiL+wh2nksPGVo/o1kTYPqqo5WlmiiL8dAPUeGfA==
X-Received: by 2002:a05:6000:1192:: with SMTP id
 g18mr3341990wrx.326.1592315491053; 
 Tue, 16 Jun 2020 06:51:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y14sm3903731wma.25.2020.06.16.06.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 06:51:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4859B1FF7E;
 Tue, 16 Jun 2020 14:51:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 00/21] testing and plugin updates (tsan,
 pluginsm cross-builds)
Date: Tue, 16 Jun 2020 14:51:29 +0100
Message-Id: <20200616135129.5786-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

The following changes since commit f5e34624f28f37ec3c8a93bdee348effee966a78:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-15-2020' into staging (2020-06-16 11:00:28 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-and-plugin-160620-2

for you to fetch changes up to c81950a2f1923dec3f6b952ec6bb9b921be58a70:

  plugins: new lockstep plugin for debugging TCG changes (2020-06-16 14:49:05 +0100)

----------------------------------------------------------------
Testing and plugin updates

  - clear up dtc warnings
  - add support for --enable-tsan builds
  - re-enable shippable cross builds
  - serialise cirrus check steps
  - fix check-tcg plugin issues
  - add lockstep plugin

----------------------------------------------------------------
Alex Bennée (6):
      tests/docker: bump fedora to 32
      Revert ".shippable: temporaily disable some cross builds"
      cirrus.yml: serialise make check
      tests/tcg: build plugin list from contents of src directory
      tests/tcg: ensure -cpu max also used for plugin run
      plugins: new lockstep plugin for debugging TCG changes

Claudio Fontana (2):
      Makefile: dtc: update, build the libfdt target
      Makefile: remove old compatibility gunks

Emilio G. Cota (7):
      cpu: convert queued work to a QSIMPLEQ
      thread: add qemu_spin_destroy
      cputlb: destroy CPUTLB with tlb_destroy
      qht: call qemu_spin_destroy for head buckets
      tcg: call qemu_spin_destroy for tb->jmp_lock
      translate-all: call qemu_spin_destroy for PageDesc
      thread: add tsan annotations to QemuSpin

Lingfeng Yang (1):
      configure: add --enable-tsan flag + fiber annotations for coroutine-ucontext

Robert Foley (5):
      tests/docker: Added docker build support for TSan.
      include/qemu: Added tsan.h for annotations.
      util: Added tsan annotate for thread name.
      docs: Added details on TSan to testing.rst
      tests: Disable select tests under TSan, which hit TSan issue.

 docs/devel/testing.rst                     | 107 +++++++++
 configure                                  |  48 +++-
 Makefile                                   |  16 +-
 include/exec/exec-all.h                    |   8 +
 include/hw/core/cpu.h                      |   6 +-
 include/qemu/thread.h                      |  38 +++-
 include/qemu/tsan.h                        |  71 ++++++
 include/tcg/tcg.h                          |   1 +
 accel/tcg/cputlb.c                         |  15 ++
 accel/tcg/translate-all.c                  |  17 ++
 cpus-common.c                              |  25 +--
 cpus.c                                     |  14 +-
 exec.c                                     |   1 +
 hw/core/cpu.c                              |   1 +
 tcg/tcg.c                                  |   9 +
 tests/plugin/lockstep.c                    | 340 +++++++++++++++++++++++++++++
 util/coroutine-ucontext.c                  |  66 +++++-
 util/qemu-thread-posix.c                   |   2 +
 util/qht.c                                 |   1 +
 .cirrus.yml                                |   6 +-
 .shippable.yml                             |  12 +-
 dtc                                        |   2 +-
 tests/Makefile.include                     |   9 +-
 tests/docker/dockerfiles/fedora.docker     |   2 +-
 tests/docker/dockerfiles/ubuntu2004.docker |  65 ++++++
 tests/docker/test-tsan                     |  44 ++++
 tests/plugin/Makefile                      |   1 +
 tests/qtest/Makefile.include               |   7 +-
 tests/tcg/Makefile.target                  |  12 +-
 tests/tcg/aarch64/Makefile.target          |   5 +-
 tests/tcg/arm/Makefile.target              |   2 +-
 tests/tcg/i386/Makefile.target             |   1 +
 tests/tsan/blacklist.tsan                  |  10 +
 tests/tsan/suppressions.tsan               |  14 ++
 34 files changed, 910 insertions(+), 68 deletions(-)
 create mode 100644 include/qemu/tsan.h
 create mode 100644 tests/plugin/lockstep.c
 create mode 100644 tests/docker/dockerfiles/ubuntu2004.docker
 create mode 100755 tests/docker/test-tsan
 create mode 100644 tests/tsan/blacklist.tsan
 create mode 100644 tests/tsan/suppressions.tsan

-- 
2.20.1


