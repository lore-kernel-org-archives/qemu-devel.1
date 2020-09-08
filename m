Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A53BC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C23512076C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBW6GQPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23512076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFaBA-0007OO-NG
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 05:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kFaAb-0006pe-Lr
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 05:44:09 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b]:42739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kFaAZ-0003Iv-8h
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 05:44:09 -0400
Received: by mail-ed1-x52b.google.com with SMTP id l63so15303316edl.9
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 02:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Iew5QQrmPu3N74dshfcSIH1r3lLDsEFiPrYfsB4hmjs=;
 b=GBW6GQPDiPDXpIQAfst2XJuKqCmWUk/bqmoLR/KdM07KLq8mhOjQK7Gyru8K9JlqLa
 fY5bnawJPWrYrBLaJDZ9fD1vm5PbgR7ArDLA1/+1i86uQaT/0trKx0YaZ/Gz8wrbh38k
 UZjE0IQ+QNtjUOMRqRAJr6Z7sg2/O9ISzJmmzX6DuzsMvkL5W4WJbnl4SCJkyGPBZekQ
 6uBjreW5Ai9oxCgIxpyqZDhYXvPOUWfuXwsgyWzZuNvH+AIjrJHdIxzbxvKCsiDcLHl+
 HSfHfvlS9+e1U87l2PXDp2gtACueH0gm6Wj7i6RqVzIsEZcZ3PhlpSfp+7LokqC8L4+P
 010g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Iew5QQrmPu3N74dshfcSIH1r3lLDsEFiPrYfsB4hmjs=;
 b=d0lN7pm8G5r0hPMnj5z8owQI5LekqBDbj7uyBS6Ny8FjdpDQDeET4I9vHgqrAO8Q5k
 8BHheh9HZzNufcbv4XzBPPo4ZPosLDs/v1SZmyk7jA/dWUh/YtuNL5ObzegywmZ5Jw3w
 lWQRh3U6CR1UYzfv4c2y8BKPt0EMG9Kt0JaHt03C6Ek0kHhxnerQPcaMNHXTC15vilIV
 AmZjhNMyVMNLaG+sIavBOyOMr7DIbpyZK2v7R09VQpeBwknWLljPB8eZ652c69pFlis4
 Kn5OVXVOnJLAAkCkmJcKemiCAaXZBb1t6ObdqDecvoZabqo/greWiaZTW2H5a0JkbJit
 bTkg==
X-Gm-Message-State: AOAM530xp7be8u3N1VbOMzfF9e/Wtc2Yaq8MJHx/RfCQr8T0uUq4XB6P
 pHNo8KPKnV8ZVOhhQx9qnw+8lqGHN0s=
X-Google-Smtp-Source: ABdhPJxSn7Tqhw0l80mozcbCRE+qfsr3pN8zn0rwUnma9P2foB4DIHU7YnTa2nJH9wPD+zKntypOCQ==
X-Received: by 2002:a50:e685:: with SMTP id z5mr25345491edm.305.1599558245327; 
 Tue, 08 Sep 2020 02:44:05 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:6c4a:4cae:bef0:843f])
 by smtp.gmail.com with ESMTPSA id q10sm17064133eja.107.2020.09.08.02.44.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 02:44:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v5 00/46] Next round of Meson bugfixes and cleanups
Date: Tue,  8 Sep 2020 11:44:08 +0200
Message-Id: <20200908094408.27091-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-ed1-x52b.google.com
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

The following changes since commit e11bd71f89649da3cff439c030d2ccac0cc914e3:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-09-07' into staging (2020-09-07 16:51:00 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to ef6a0d6e3927464de67f70cb13abbfe67361e0c9:

  docs: update build system documentation (2020-09-08 07:21:55 +0200)

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

Paolo Bonzini (26):
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
      docs: update build system documentation

Thomas Huth (1):
      meson: convert the unit tests

Yonggang Luo (2):
      configure: update dtc submodule
      meson: Convert undefsym.sh to undefsym.py

 .gitignore                       |   2 -
 Makefile                         |  63 +++---
 Makefile.objs                    |  34 ----
 accel/tcg/meson.build            |   2 +-
 chardev/meson.build              |   4 +-
 configure                        | 304 ++++------------------------
 disas/meson.build                |   4 +-
 docs/devel/build-system.rst      | 115 ++---------
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
 tests/Makefile.include           | 416 ++-------------------------------------
 tests/benchmark-crypto-cipher.c  |   8 +-
 tests/benchmark-crypto-hash.c    |   2 +-
 tests/benchmark-crypto-hmac.c    |   8 +-
 tests/docker/Makefile.include    |   4 +
 tests/include/meson.build        |  16 ++
 tests/meson.build                | 253 ++++++++++++++++++++++++
 tests/migration/initrd-stress.sh |  10 +
 tests/migration/meson.build      |  14 ++
 tests/migration/stress.c         |  15 +-
 tests/qemu-iotests/meson.build   |   4 -
 tests/qtest/fuzz/meson.build     |   7 +-
 tests/qtest/libqos/meson.build   |   9 +-
 tests/tcg/Makefile.qemu          |   2 -
 tests/test-crypto-secret.c       |  10 +-
 tests/test-qga.c                 |   2 +-
 ui/meson.build                   |   3 +-
 38 files changed, 667 insertions(+), 1154 deletions(-)
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

