Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903FBC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:01:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 670382083B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670382083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyK3x-0001Lo-Qn
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 14:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1hyK2A-00087Q-KV
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hyK27-00018J-Tp
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52378)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hyK27-00014t-Om
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1716A2A09B9;
 Thu, 15 Aug 2019 17:59:30 +0000 (UTC)
Received: from thuth.com (ovpn-116-65.ams2.redhat.com [10.36.116.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35E9917CF8;
 Thu, 15 Aug 2019 17:59:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 19:59:13 +0200
Message-Id: <20190815175922.3475-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 15 Aug 2019 17:59:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/9] qtest patches
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi Peter,

the following changes since commit 9e06029aea3b2eca1d5261352e695edc1e7d7b8b:

  Update version for v4.1.0 release (2019-08-15 13:03:37 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2019-08-15

for you to fetch changes up to 6fc9f3d347aee337421f8afc4d0984294f8ea6c3:

  tests/libqtest: Make qmp_assert_success() independent from global_qtest (2019-08-15 19:24:10 +0200)

----------------------------------------------------------------
- Fix for ctrl queue in the virtio-net QOS driver
- Improve Valgrind reports in the tests that use the null-co driver
- Get rid of global_qtest related code in libqtest and libqos
----------------------------------------------------------------

Andrey Shinkevich (1):
      tests: Set read-zeroes on for null-co driver

Oleinik, Alexander (2):
      qtest: Rename qtest.c:qtest_init()
      libqos: Account for the ctrl queue in virtio-net

Thomas Huth (6):
      tests/libqos: Make generic virtio code independent from global_qtest
      tests/libqos: Make virtio-pci code independent from global_qtest
      tests/libqtest: Remove unused function hmp()
      tests/libqtest: Clean up qtest_cb_for_every_machine() wrt global_qtest
      tests/libqtest: Make qtest_qmp_device_add/del independent from global_qtest
      tests/libqtest: Make qmp_assert_success() independent from global_qtest

 include/sysemu/qtest.h     |   2 +-
 qtest.c                    |   3 +-
 tests/cpu-plug-test.c      |  15 +++--
 tests/drive_del-test.c     |   3 +-
 tests/e1000e-test.c        |   2 +-
 tests/ivshmem-test.c       |   2 +-
 tests/libqos/usb.c         |   6 +-
 tests/libqos/usb.h         |   2 +-
 tests/libqos/virtio-net.c  |   1 +
 tests/libqos/virtio-net.h  |   2 +-
 tests/libqos/virtio-pci.c  |   8 +--
 tests/libqos/virtio-scsi.c |   3 +-
 tests/libqos/virtio.c      |  81 ++++++++++++-----------
 tests/libqos/virtio.h      |  30 +++++----
 tests/libqtest.c           |  37 ++++-------
 tests/libqtest.h           |  24 +++----
 tests/megasas-test.c       |   3 +-
 tests/nvme-test.c          |   3 +-
 tests/qmp-test.c           |   2 +-
 tests/test-blockjob-txn.c  |   5 +-
 tests/test-blockjob.c      |   5 +-
 tests/usb-hcd-ohci-test.c  |   2 +-
 tests/usb-hcd-uhci-test.c  |  11 ++--
 tests/usb-hcd-xhci-test.c  |  25 ++++---
 tests/virtio-9p-test.c     |  16 +++--
 tests/virtio-blk-test.c    | 159 ++++++++++++++++++++++++---------------------
 tests/virtio-ccw-test.c    |  25 ++++---
 tests/virtio-net-test.c    |  35 ++++++----
 tests/virtio-rng-test.c    |   2 +-
 tests/virtio-scsi-test.c   |  35 ++++++----
 tests/virtio-serial-test.c |   4 +-
 vl.c                       |   2 +-
 32 files changed, 300 insertions(+), 255 deletions(-)

