Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB38C433E2
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 17:55:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A625320639
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 17:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbljFSU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A625320639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEyt6-0001dl-LQ
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 13:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kEyrM-0008SO-Oc
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 13:53:48 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a]:46090)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kEyrK-00006R-Tn
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 13:53:48 -0400
Received: by mail-ed1-x52a.google.com with SMTP id a12so10432421eds.13
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2020 10:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7AS8KhYdrnDBR9hWgRBcDx2cZFXGSdP3aDhKp5qip0g=;
 b=TbljFSU5C0kKm5AKTY5vFQ6UFCGbb54o8OFD4pNCeHFpD6przaehkME2cI7drheXe0
 p78POYeWykdek/2+XLElW6g96bcBRxW4ijnPhU2hlDIbg47IIAi797uS5JtwTQfIIonf
 wiXjQTsGPwPLi0OGKAVkulHFVpWOy6gVSRZBVE5pPEZDlkc2vmZD+Fspzu5BNTXq3en9
 4mDA8klONuEtkb0SGuuVj6JekFkZOf9eTFrRVFlLHOeUeaXQG3+DZ5I0NIZiLxYuOTHr
 Rjv8b1SB5VSDtIXxkBs40KGQz6Ab7sAm72F21oXXa4tpTqqEShYdVpc4XKWWDu8iw42q
 QIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=7AS8KhYdrnDBR9hWgRBcDx2cZFXGSdP3aDhKp5qip0g=;
 b=E2KRkM5nnK8lnUOTS5xfJWqwm8Brry5H3FHfPY4O/hFt8WAMdZMaqt38SdqypJkWuM
 jptXGX+x+kQx+Qtk+i429u6uqBqaOHF3P18VGD1U7Ue54QKM1wBDs+TUs6EuWyeKRcpF
 jm7ufZT3SDxdIjiDdombXyJIuUojEZjOpQoAJ4i1hQqm6eyVoDkv5a7ehUPkjyV8k8i8
 rg5pCORCcSv2tAvmYcyz3BCpH/jRuW6QZ83MAqK6V3WDIateSleqGvGE6mfgg4nu2fYy
 xu8yUE2jZQoxAnl1SXSpqR0tlzA2i+Z4ImGum94i6nIXoOoMqO1Ur7ps3NuoA5Nb4cWB
 EDRg==
X-Gm-Message-State: AOAM532V32kdey4HrDE0zoGWbfC91koeehAxIRnvXqiB2SlPSO2yI/x3
 bUDBk6YAzWIU6p2DzmchQ7R9reFC4aY=
X-Google-Smtp-Source: ABdhPJz3ZPtPZTpuhOFd5hfZ3VylcALx6/Z7uU5IshVkuol5M0x3Vd65jrjIbecjg0pLH+/5+OFmyg==
X-Received: by 2002:aa7:dcc6:: with SMTP id w6mr5938057edu.10.1599414824361;
 Sun, 06 Sep 2020 10:53:44 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:b2e3:b609:246c:e7e8])
 by smtp.gmail.com with ESMTPSA id m4sm13680390ejn.31.2020.09.06.10.53.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2020 10:53:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/46] Next round of Meson bugfixes and cleanups
Date: Sun,  6 Sep 2020 19:53:43 +0200
Message-Id: <20200906175344.5042-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-ed1-x52a.google.com
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

for you to fetch changes up to 6264b35324d3766d3c2ff369c4e8ecba8bd5b571:

  meson: remove linkage of sdl to baum (2020-09-06 19:50:57 +0200)

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
      configure: move C++ compiler handling to meson
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
 configure                        | 353 ++++-----------------------------
 disas/meson.build                |   4 +-
 docs/devel/build-system.rst      |  18 +-
 hw/arm/meson.build               |   2 +-
 hw/mips/meson.build              |   2 +-
 hw/riscv/meson.build             |   2 +-
 meson.build                      | 152 ++++++++++----
 monitor/meson.build              |   2 +-
 rules.mak                        | 158 ---------------
 scripts/empty.c                  |   6 +
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
 tests/meson.build                | 257 ++++++++++++++++++++++++
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
 39 files changed, 686 insertions(+), 1121 deletions(-)
 delete mode 100644 Makefile.objs
 delete mode 100644 rules.mak
 create mode 100644 scripts/empty.c
 delete mode 100755 scripts/grepy.sh
 create mode 100644 scripts/test-driver.py
 create mode 100644 scripts/undefsym.py
 delete mode 100755 scripts/undefsym.sh
 create mode 100644 tests/include/meson.build
 create mode 100755 tests/migration/initrd-stress.sh
 create mode 100644 tests/migration/meson.build
-- 
2.26.2


