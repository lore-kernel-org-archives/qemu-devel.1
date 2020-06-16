Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2917CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:54:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E900C20B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PNro4S+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E900C20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlB6y-0005I0-5O
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 08:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlB5p-0003hM-Fm
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:53:33 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:46654)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlB5n-00005G-GA
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:53:33 -0400
Received: by mail-wr1-x42a.google.com with SMTP id x6so20612613wrm.13
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 05:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sZyRuWat06D3xG0H55RrQhbE1KyrtVpUifQMuvnHSdo=;
 b=PNro4S+Gp2Ru/HE+Vyrf6iTagLMANWwrro71adF1P/r4Q5/l4X3aX1m0pkmhY+Oult
 bnMm4/aaB1AP0zanNFVSxd5xV8IZ9FfaKRQuPLfgpB1jSJfDUbYS14u9dCfdalWLH0i0
 VhbK4nrjBG9FleZPBnp+RoYKrm1LatRdzFAiIt2VWaoc11mSqL3Azu6OUEkcWE2D1jnI
 6JiMtFIKS7S56WmD8VoCCYhMccrBxxhFpxT7apTq3heOoBYPHz5LrdiVVhO5S9Bii+9J
 dS5GfIDjx7AO3EFjdjfaAI7N3jfNsrgK7/UTHo1Vw6LX1u7Lnxp+NLMrXln5cAgCd60Y
 rC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sZyRuWat06D3xG0H55RrQhbE1KyrtVpUifQMuvnHSdo=;
 b=rW6t6XmgAmq2PFV31pBqYa2/yUWn69JsZSuuzZYcU2TY/OLp7+fPpbW4rvUHgzyvzg
 u/XvYr2kpDeKPJIhDqq2YWajHymoJPc7kiE9v31DKk9/aSjqnobZHZHLcjico+zWkEIZ
 DHfr0E9HqIz8MCrFdOy++GzXP455yyyfOYvgSVqiLgLHJlxjiQVOasQey87mR0epHdWL
 4oPje0Tu6kyrmkVbqzoCbQzrQt4gTqszvpxn+EaE/d2Fy8GVA9NnZnJJv/J50MozzkYW
 vsVYyCbkZ6L4oGoylso9+mIo6s6AbLsZbQjupoLAq549Ryw+FuEiXQvz8dPGZYN7w0xp
 NO2g==
X-Gm-Message-State: AOAM530t/L0MMD6pRwKm9KIC/FJYPZ9diKYT0ZdR9bYluZ5EQLa32gFU
 Dy1v5hk3z2ftAne/BaV6zzF8EA==
X-Google-Smtp-Source: ABdhPJyuZAm77D8vo1LTx1U7kiNkqGTk83Kd74u1RQHvgJ80IbsVfC7iod5QuM1FrSv+AiAVwY8eOA==
X-Received: by 2002:adf:ed4f:: with SMTP id u15mr2891034wro.126.1592312005861; 
 Tue, 16 Jun 2020 05:53:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c70sm3778631wme.32.2020.06.16.05.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 05:53:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4673E1FF7E;
 Tue, 16 Jun 2020 13:53:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 00/21] testing and plugin updates (tsan, plugins, cross-builds)
Date: Tue, 16 Jun 2020 13:53:03 +0100
Message-Id: <20200616125324.19045-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

  https://github.com/stsquad/qemu.git tags/pull-testing-and-plugin-160620-1

for you to fetch changes up to 99c5f1ccb9ad9fe42466df292a9e4c9b863eafe6:

  plugins: new lockstep plugin for debugging TCG changes (2020-06-16 13:25:00 +0100)

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


