Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592D0C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 08:33:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3294720870
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 08:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3294720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5nDG-000135-EH
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 04:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i5nAO-0007jA-Mu
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 04:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i5nAN-0005lX-9C
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 04:30:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50888)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1i5nAN-0005kj-1f
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 04:30:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1A8871918641;
 Thu,  5 Sep 2019 08:30:54 +0000 (UTC)
Received: from thuth.com (ovpn-116-96.ams2.redhat.com [10.36.116.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 655E95D704;
 Thu,  5 Sep 2019 08:30:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  5 Sep 2019 10:30:41 +0200
Message-Id: <20190905083049.11645-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Thu, 05 Sep 2019 08:30:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/8] qtests and misc patches
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi Peter,

the following changes since commit a8b5ad8e1faef0d1bb3e550530328e8ec76fe87c:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-09-04 17:22:34 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2019-09-05

for you to fetch changes up to 7bb21c0ac301e423b483dd7fc171b0d7b56de2cf:

  qemu-doc: Do not hard-code the name of the QEMU binary (2019-09-05 09:45:09 +0200)

----------------------------------------------------------------
- Make the core libqtest library independent from global_qtest
- Clean up docs from hard-coded qemu-system-* names
----------------------------------------------------------------

Thomas Huth (8):
      tests/migration: Do not use functions anymore that rely on global_qtest
      tests/libqos/e1000e: Make e1000e libqos functions independent from global_qtest
      tests/libqos: Replace clock_step with qtest_clock_step in virtio code
      tests: Remove unnecessary global_qtest references
      tests/libqtest: Move global_test wrapper function into a separate header
      tests/libqtest: Use libqtest-single.h in tests that require global_qtest
      tests/vm: Take the J=x setting into account for the vm-boot-ssh targets, too
      qemu-doc: Do not hard-code the name of the QEMU binary

 MAINTAINERS                   |   2 +-
 docs/qemu-block-drivers.texi  |  72 +++++-----
 docs/qemu-cpu-models.texi     |  10 +-
 qemu-doc.texi                 |  81 +++++------
 qemu-options.hx               | 128 ++++++++---------
 tests/ahci-test.c             |   1 -
 tests/bios-tables-test.c      |   1 -
 tests/cpu-plug-test.c         |   2 +-
 tests/display-vga-test.c      |   2 +-
 tests/e1000e-test.c           |   2 +-
 tests/fdc-test.c              |   2 +-
 tests/i440fx-test.c           |   2 +-
 tests/i82801b11-test.c        |   2 +-
 tests/intel-hda-test.c        |   2 +-
 tests/ioh3420-test.c          |   2 +-
 tests/ipmi-kcs-test.c         |   3 +-
 tests/ivshmem-test.c          |   3 -
 tests/libqos/e1000e.c         |  16 ++-
 tests/libqos/virtio-mmio.c    |  14 +-
 tests/libqos/virtio-pci.c     |  14 +-
 tests/libqos/virtio.c         |  20 +--
 tests/libqos/virtio.h         |   6 +-
 tests/libqtest-single.h       | 315 ++++++++++++++++++++++++++++++++++++++++++
 tests/libqtest.c              |  13 --
 tests/libqtest.h              | 289 --------------------------------------
 tests/m25p80-test.c           |   2 +-
 tests/migration-test.c        |   6 +-
 tests/qos-test.c              |   2 +-
 tests/rtas-test.c             |   1 -
 tests/rtc-test.c              |   2 +-
 tests/rtl8139-test.c          |   2 +-
 tests/test-arm-mptimer.c      |   2 +-
 tests/test-netfilter.c        |   2 +-
 tests/test-x86-cpuid-compat.c |   2 +-
 tests/tmp105-test.c           |   2 +-
 tests/tpm-crb-test.c          |   2 +-
 tests/tpm-tests.c             |   2 +-
 tests/tpm-tis-test.c          |   2 +-
 tests/usb-hcd-ohci-test.c     |   2 +-
 tests/usb-hcd-uhci-test.c     |   2 +-
 tests/usb-hcd-xhci-test.c     |   2 +-
 tests/vhost-user-test.c       |   2 +-
 tests/virtio-blk-test.c       |   5 +-
 tests/virtio-ccw-test.c       |   2 +-
 tests/virtio-net-test.c       |   2 +-
 tests/virtio-scsi-test.c      |   2 +-
 tests/virtio-serial-test.c    |   2 +-
 tests/vm/Makefile.include     |   1 +
 48 files changed, 546 insertions(+), 509 deletions(-)
 create mode 100644 tests/libqtest-single.h

