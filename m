Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9809AC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:36:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1349A20828
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1349A20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5to4-0006P7-4t
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 11:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i5tiE-0001Xg-MJ
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:30:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i5tiD-0001Zg-6D
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:30:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36322)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1i5tiC-0001Yz-ST
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:30:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 151563082E57;
 Thu,  5 Sep 2019 15:30:16 +0000 (UTC)
Received: from thuth.com (ovpn-116-96.ams2.redhat.com [10.36.116.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3AAC560619;
 Thu,  5 Sep 2019 15:30:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  5 Sep 2019 17:30:09 +0200
Message-Id: <20190905153011.24010-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 05 Sep 2019 15:30:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 0/9] qtests and misc patches
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

the following changes since commit 500efcfcf0fe2e0dae1d25637a13435ce7b6e421:

  Merge remote-tracking branch 'remotes/rth/tags/pull-or1k-20190904' into staging (2019-09-05 09:33:01 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2019-09-05-v2

for you to fetch changes up to e7dc804ef0d7cac9ac8b4a1324ab7dbfafb55704:

  gitlab-ci.yml: Install libattr-devel and libcap-devel to test virtio-9p (2019-09-05 16:00:01 +0200)

----------------------------------------------------------------
- Make the core libqtest library independent from global_qtest
- Clean up docs from hard-coded qemu-system-* names
- Install libattr-dev and libcap-dev in gitlab-ci to test virtio-9p
----------------------------------------------------------------

Thomas Huth (9):
      tests/migration: Do not use functions anymore that rely on global_qtest
      tests/libqos/e1000e: Make e1000e libqos functions independent from global_qtest
      tests/libqos: Replace clock_step with qtest_clock_step in virtio code
      tests: Remove unnecessary global_qtest references
      tests/libqtest: Move global_test wrapper function into a separate header
      tests/libqtest: Use libqtest-single.h in tests that require global_qtest
      tests/vm: Take the J=x setting into account for the vm-boot-ssh targets, too
      qemu-doc: Do not hard-code the name of the QEMU binary
      gitlab-ci.yml: Install libattr-devel and libcap-devel to test virtio-9p

 .gitlab-ci.yml                |   2 +-
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
 tests/virtio-9p-test.c        |   2 +-
 tests/virtio-blk-test.c       |   5 +-
 tests/virtio-ccw-test.c       |   2 +-
 tests/virtio-net-test.c       |   2 +-
 tests/virtio-scsi-test.c      |   2 +-
 tests/virtio-serial-test.c    |   2 +-
 tests/vm/Makefile.include     |   1 +
 50 files changed, 548 insertions(+), 511 deletions(-)
 create mode 100644 tests/libqtest-single.h

