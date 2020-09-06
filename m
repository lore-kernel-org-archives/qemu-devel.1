Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206FDC433E2
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 20:21:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 759812145D
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 20:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RN3SePH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 759812145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF19x-0003SO-FJ
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 16:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kF187-0001MH-1D
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 16:19:15 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a]:33587)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kF185-0006Ec-3g
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 16:19:14 -0400
Received: by mail-ej1-x62a.google.com with SMTP id j11so15402596ejk.0
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2020 13:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fI1Yzx8tkES1ywSA873ok4tICaeQKSPVBXe78dr1nbY=;
 b=RN3SePH17ILuEXh4KHQIxfnTHSct72Kx80psFCBM4t0PeW9APaujTPyi0pkyULUdOB
 04LGH7JTq+yhSzE998VfVQz8LNUgZffiLCB9XpsErY1wI/wTSiCSz02Z6hne21dSYrQz
 qOptTzNtBtGvBvO6xqr1LP+1wlEQdsbQfr6s+lPx/Ugtp3CESocT3nZGPnML3ZzyZSc/
 4jPxwm/wWBn3q6oQK7+E4eJBbSuihUMS8vfSXsKlXyo18dmHlQFOKrnP8Ii+csd+oXhO
 0klX7OGiA67PfvE5ObR5NksuuP9lfVMhURjJ/qWOtYiWPekILaQohRe6rtmKNOAn36Ye
 hWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=fI1Yzx8tkES1ywSA873ok4tICaeQKSPVBXe78dr1nbY=;
 b=K6cyyjLAfdnf6MQNCvs8QMcZ/vEBYKtYuwTJyEQ51fUhdZ/qzfTtP4qHjAoZAuL5Gv
 MsklNg6+astemc0LW09+4nbPSL8gn3ARb7fpKboFtSqWExWEv6pSdY1nIbmQdomO6Lpv
 QVgWwg1samJj8V+ZT/nWfU1YIIH+wSHdWTheCH6XY9q4lAV12kpoQ4PfIx2W3ZlnQQab
 vzD11kevTIWHujUQXUcsIQAi3xSB08Bc1dODIa4eYGqEPsdRgEx7IVjQ9mzZUKoboZcy
 t8IEEzdpeivWQZpAeI8YsOdJ/EAQEmJvewc2h0SwYPw8ax+VWWQhVPaksCFTn12XvFhh
 ocuQ==
X-Gm-Message-State: AOAM532UG9NcwhsQDHYrytlObg+CIcoWd3suC1ns9zxQg8z7ukddf94d
 B/GowW9FJsElIDzEGLJlYl8O2HP+yVQ=
X-Google-Smtp-Source: ABdhPJziYYQIdfQv+v3FFhjqouB0EVb7RvfoDfCQAJA5RTZUaWTnxPUhvq8GoyplX3r3t3nRVrm0qg==
X-Received: by 2002:a17:906:e103:: with SMTP id
 gj3mr17600425ejb.153.1599423550952; 
 Sun, 06 Sep 2020 13:19:10 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:79e5:61d2:1641:7362])
 by smtp.gmail.com with ESMTPSA id v2sm1399435ejh.57.2020.09.06.13.19.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2020 13:19:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/45] Next round of Meson bugfixes and cleanups
Date: Sun,  6 Sep 2020 22:19:09 +0200
Message-Id: <20200906201911.11814-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-ej1-x62a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 227de21ed0759e275a469394af72c999d0134bb5:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20200903' into staging (2020-09-05 15:30:41 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 17701f5a5d5ca20e9af8034b219c9b11c66f325a:

  meson: remove linkage of sdl to baum (2020-09-06 22:07:58 +0200)

----------------------------------------------------------------
meson related:
* convert unit tests
* bugfixes for mtest2make
* miscellaneous bugfixes
* dead code removal and configure cleanups
* oss-fuzz fixes
* msys fixes

----------------------------------------------------------------
Alexander Bulekov (3):
      oss-fuzz: fix rpath
      meson: specify fuzz linker script as a project arg
      fuzz: Add support for custom fuzzing library

Bruce Rogers (1):
      meson: remove linkage of sdl to baum

Marc-André Lureau (12):
      meson: build qapi tests library
      meson: declare tasn1 dependency
      meson: declare keyutils dependency
      meson: convert qht-bench
      meson: move keyutils dependency check
      meson: remove old socket_scm_helper rule
      meson: convert vhost-user-bridge
      meson: convert atomic*-bench
      tests: do not print benchmark output to stdout
      tests/migration/stress: remove unused exit_success
      meson: fix migration/stress compilation with glibc>=2.30
      meson: convert migration/initrd-stress

Paolo Bonzini (24):
      qemu-iotests: move check-block back to Makefiles
      mtest2make: split environment from test command
      mtest2make: split working directory from test command
      mtest2make: hide output of successful tests
      mtest2make: unify tests that appear in multiple suites
      meson: remove b_lundef option
      configure: do not include absolute paths in -I and -L paths
      configure: include cross sdl2-config in meson cross file
      ninjatool: use constant names for stamp files
      meson: fix libqos linking
      meson: convert the speed tests
      configure: remove dead code for in-tree builds
      meson: compute config_all_devices directly
      Makefile: remove dead variables and includes
      Makefile: inline the relevant parts of rules.mak
      configure: move disassembler configuration to meson
      meson: keep all compiler flags detection together
      configure: move -ldl test to meson
      configure: remove unnecessary libm test
      configure: do not look for install(1)
      meson: get glib compilation flags from GLIB_CFLAGS
      configure: do not include dependency flags in QEMU_CFLAGS and LIBS
      configure: drop dead variables and functions
      docs: suggest Meson replacements for various configure functions

Thomas Huth (2):
      tests/Makefile: test-image-locking needs CONFIG_POSIX
      meson: convert the unit tests

Yonggang Luo (3):
      tests: handling signal on win32 properly
      configure: update dtc submodule
      meson: Convert undefsym.sh to undefsym.py

 .gitignore                       |   2 -
 Makefile                         |  63 +++---
 Makefile.objs                    |  34 ----
 accel/tcg/meson.build            |   2 +-
 chardev/meson.build              |   4 +-
 configure                        | 303 ++++------------------------
 disas/meson.build                |   4 +-
 docs/devel/build-system.rst      |  18 +-
 hw/arm/meson.build               |   2 +-
 hw/mips/meson.build              |   2 +-
 hw/riscv/meson.build             |   2 +-
 meson.build                      | 124 +++++++++---
 monitor/meson.build              |   2 +-
 rules.mak                        | 158 ---------------
 scripts/grepy.sh                 |   3 -
 scripts/mtest2make.py            | 100 +++++-----
 scripts/ninjatool.py             |   8 +-
 scripts/oss-fuzz/build.sh        |   2 +-
 scripts/test-driver.py           |  35 ++++
 scripts/undefsym.py              |  49 +++++
 scripts/undefsym.sh              |  20 --
 tests/Makefile.include           | 414 ++-------------------------------------
 tests/benchmark-crypto-cipher.c  |   8 +-
 tests/benchmark-crypto-hash.c    |   2 +-
 tests/benchmark-crypto-hmac.c    |   8 +-
 tests/docker/Makefile.include    |   4 +
 tests/include/meson.build        |  16 ++
 tests/meson.build                | 256 ++++++++++++++++++++++++
 tests/migration/initrd-stress.sh |  10 +
 tests/migration/meson.build      |  14 ++
 tests/migration/stress.c         |  15 +-
 tests/qemu-iotests/meson.build   |   4 -
 tests/qtest/fuzz/meson.build     |   7 +-
 tests/qtest/libqos/meson.build   |   9 +-
 tests/tcg/Makefile.qemu          |   2 -
 tests/test-crypto-secret.c       |  10 +-
 tests/test-qga.c                 |   2 +-
 tests/test-replication.c         |   4 +
 ui/meson.build                   |   1 +
 39 files changed, 659 insertions(+), 1064 deletions(-)
 delete mode 100644 Makefile.objs
 delete mode 100644 rules.mak
 delete mode 100755 scripts/grepy.sh
 create mode 100644 scripts/test-driver.py
 create mode 100644 scripts/undefsym.py
 delete mode 100755 scripts/undefsym.sh
 create mode 100644 tests/include/meson.build
 create mode 100755 tests/migration/initrd-stress.sh
 create mode 100644 tests/migration/meson.build
-- 
2.26.2


