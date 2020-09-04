Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DABC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 531222074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531222074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEA9D-00058L-B8
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 07:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA65-0008Bz-J5
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:41:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49168
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA5v-0005Ae-DB
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:41:37 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-QClWKxk0P5iizaAJXktIjg-1; Fri, 04 Sep 2020 07:41:24 -0400
X-MC-Unique: QClWKxk0P5iizaAJXktIjg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20E3F8712F5
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 11:41:23 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D947D5DD6E
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 11:41:22 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/46] Next round of Meson bugfixes and cleanups
Date: Fri,  4 Sep 2020 07:40:36 -0400
Message-Id: <20200904114122.31307-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:58:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit 67a7bfe560a1bba59efab085cb3430f45176d382:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-09-03' into staging (2020-09-03 16:58:25 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 4be1987db8b361f17c50bea582c6056cd54c4752:

  meson: remove linkage of sdl to baum (2020-09-04 07:33:28 -0400)

Finally a favorable diffstat appears...

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
 meson.build                      | 153 +++++++++++----
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
 39 files changed, 686 insertions(+), 1122 deletions(-)
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


