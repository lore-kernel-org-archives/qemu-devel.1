Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42301C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12542216C4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12542216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50258 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOeIx-0004HI-3B
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 04:21:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hOeHC-0001Wz-Ry
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hOeHB-0000Af-KC
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:19:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hOeHB-00009O-A5
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:19:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9DA40308793F;
	Thu,  9 May 2019 08:19:36 +0000 (UTC)
Received: from thuth.com (ovpn-116-115.ams2.redhat.com [10.36.116.115])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2FBFA5B680;
	Thu,  9 May 2019 08:19:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Thu,  9 May 2019 10:19:16 +0200
Message-Id: <20190509081930.19081-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Thu, 09 May 2019 08:19:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/14] qtests,
 copyright statement clarifications and misc patches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi Peter,

the following changes since commit 629d166994725773dea9cef843fcb0ae5f3585=
fe:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
90507' into staging (2019-05-08 00:06:43 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2019-05-09

for you to fetch changes up to 2c8fcd8f9ef2394b9933a52c157df4ef67ca1eba:

  include/exec/poison: Mark TARGET_FMT_lu as poisoned, too (2019-05-09 09=
:37:09 +0200)

----------------------------------------------------------------
- Fix "make check" problem that occurred with LANG=3DC and Python 3.5 / 3=
.6
- Get rid of some more dependencies on the global_qtest variable in the q=
tests
- Some other small test clean-ups
- Some copyright statement clarifications
- Mark TARGET_FMT_lu as poisoned
----------------------------------------------------------------

Eduardo Habkost (1):
      tests: Force Python I/O encoding for check-qapi-schema

Thomas Huth (13):
      tests/tco: Make test independent of global_qtest
      tests/megasas: Make test independent of global_qtest
      tests/qmp-cmd-test: Use qtest_init() instead of qtest_start()
      tests/test-hmp: Use qtest_init() instead of qtest_start()
      tests/ide-test: Make test independent of global_qtest
      tests/tpm-tests: Use g_test_skip() to mark skipped tests
      tests/Makefile: Remove unused test-obj-y variable
      tests/drive_del-test: Use qtest_init() instead of qtest_start()
      tests: qpci_unplug_acpi_device_test() should not rely on global_qte=
st
      hw/i2c/smbus_ich9: Fix the confusing contributions-after-2012 state=
ment
      target/openrisc: Fix LGPL information in the file headers
      target/sh4: Fix LGPL information in the file headers
      include/exec/poison: Mark TARGET_FMT_lu as poisoned, too

 hw/i2c/smbus_ich9.c                  |  21 +--
 hw/openrisc/cputimer.c               |   2 +-
 hw/openrisc/openrisc_sim.c           |   2 +-
 hw/openrisc/pic_cpu.c                |   2 +-
 include/exec/poison.h                |   1 +
 linux-user/openrisc/target_cpu.h     |   2 +-
 linux-user/openrisc/target_structs.h |   2 +-
 linux-user/sh4/target_cpu.h          |   2 +-
 linux-user/sh4/target_structs.h      |   2 +-
 target/openrisc/cpu.h                |   2 +-
 target/openrisc/exception.c          |   2 +-
 target/openrisc/exception_helper.c   |   2 +-
 target/openrisc/fpu_helper.c         |   2 +-
 target/openrisc/insns.decode         |   2 +-
 target/openrisc/interrupt.c          |   2 +-
 target/openrisc/machine.c            |   2 +-
 target/openrisc/mmu.c                |   2 +-
 target/sh4/cpu.h                     |   2 +-
 target/sh4/gdbstub.c                 |   2 +-
 target/sh4/helper.c                  |   2 +-
 target/sh4/op_helper.c               |   2 +-
 target/sh4/translate.c               |   2 +-
 tests/Makefile.include               |  21 +--
 tests/drive_del-test.c               |  63 ++++----
 tests/e1000e-test.c                  |   4 +-
 tests/ide-test.c                     | 284 ++++++++++++++++++++---------=
------
 tests/ivshmem-test.c                 |   9 +-
 tests/libqos/pci-pc.c                |  10 +-
 tests/libqos/pci.h                   |   2 +-
 tests/megasas-test.c                 |   2 +-
 tests/qmp-cmd-test.c                 |  15 +-
 tests/tco-test.c                     |  63 ++++----
 tests/test-hmp.c                     |  19 +--
 tests/tpm-tests.c                    |   2 +-
 tests/virtio-blk-test.c              |   3 +-
 tests/virtio-net-test.c              |   4 +-
 tests/virtio-rng-test.c              |   5 +-
 37 files changed, 298 insertions(+), 270 deletions(-)

