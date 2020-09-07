Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33FDC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:45:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08389207DE
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDM8rM0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08389207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFKGR-0005lF-2n
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 12:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kFKFk-0004vb-Da
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 12:44:24 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634]:37656)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kFKFi-0000Z3-I9
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 12:44:24 -0400
Received: by mail-ej1-x634.google.com with SMTP id nw23so18962210ejb.4
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 09:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UaDGbL3i7ikwtLIsat0e9nCTw2lQMjWiBe+goatyRsQ=;
 b=bDM8rM0JoBITdBaCT4tSqW7r7sywHSRn0hjnUa9pjzEGaL0WJIj2ejtRRI0n1RUZf6
 zZMZkmfnVip3tibFS46YO50nHaGvx8iT/TrlIMPAq5aIoOkB2u2qyXTF/gXrOHMO9LJ0
 yysR0yn3YWtemPgQBKU+NI5ccnr4HhRS52ziug7ahYLoahLSALuMGM2oH6nTdhA5ePGi
 JqmUcnFKj7VqUlud6S5tb72+M01zse8qNAb71h3pOxzerHF3biQmoWg10+3rpcE2a4Sx
 3AmUQ6vsdG/llj+OLs+4xnOW1w1+WK7AHWQo6U8COFlPDqSzQyRPOPBF4yhYrz5OBaEq
 0/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=UaDGbL3i7ikwtLIsat0e9nCTw2lQMjWiBe+goatyRsQ=;
 b=fdviwzqpJ8+Eeueb4yvnVZ34SeuSCtMQKzVdaVj/cTTzIgJ3lh8aEk2SbJ3Z41qqgJ
 0/xiUzUbyY66OeLIsjDFqsqEIS+ipqjkfnIiZwdJlV0xsjuo+rNys9nZv+LyUJx52n3S
 S4YSY0BmQFUAvkKjSyiUZrXE+OAdfsjFeWmTbpfbwi2VmYfKUA43c9dbAeUTt4PFgcxO
 m7klz+c8QxG9IWWTAXnA7xhaVM1W62IFYjjHHSJQaPWpRwGkaGVGGF0+1xDTLGmzlUsS
 /WlXMjo8PWepfVdWQBBs+lhX9zdq7GWzZ687K17z9h8ubUNNxD24bZqRT5h7p+pMBX7b
 8JFA==
X-Gm-Message-State: AOAM530/CBbmAurKQmHayKzmi01nbgASpLcBhphd6GbLt8z3I471EiRx
 uLtUYPM++TD+biQlACCqGseSS8u7db8=
X-Google-Smtp-Source: ABdhPJz3hnYPURFzK6QvMlZwt6EkmF0nR+Lkm528uEfQ+qpfz7RmdIBYLMrKOhv0t4ynQWsY4R+NqQ==
X-Received: by 2002:a17:906:1542:: with SMTP id
 c2mr23114425ejd.533.1599497060579; 
 Mon, 07 Sep 2020 09:44:20 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:6891:d6db:f6ec:d1df])
 by smtp.gmail.com with ESMTPSA id n20sm15760391ejg.65.2020.09.07.09.44.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 09:44:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/46] Next round of Meson bugfixes and cleanups
Date: Mon,  7 Sep 2020 18:44:19 +0200
Message-Id: <20200907164421.19886-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-ej1-x634.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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

The following changes since commit 62f9256052df85194faa33137bbe0afb1c95b6e6:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200904-pull-request' into staging (2020-09-07 13:27:20 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to cfdedc114244adf488242f547af899bc2fe9f3c0:

  meson: remove linkage of sdl to baum (2020-09-07 18:43:20 +0200)

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

Paolo Bonzini (25):
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
      meson: get opengl compilation flags from OPENGL_CFLAGS
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
 configure                        | 304 ++++------------------------
 disas/meson.build                |   4 +-
 docs/devel/build-system.rst      |  18 +-
 hw/arm/meson.build               |   2 +-
 hw/mips/meson.build              |   2 +-
 hw/riscv/meson.build             |   2 +-
 meson.build                      | 127 ++++++++----
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
 tests/meson.build                | 255 ++++++++++++++++++++++++
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
 ui/meson.build                   |   3 +-
 39 files changed, 662 insertions(+), 1066 deletions(-)
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


