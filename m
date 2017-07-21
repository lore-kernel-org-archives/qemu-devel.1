Received: from eggs.gnu.org ([2001:4830:134:3::10]:48323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYYN2-0007g5-Uj
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYYN0-000456-5m
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:53:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dYYMz-00044L-Vp
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:53:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC952C05681A
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 13:53:28 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 21 Jul 2017 15:53:17 +0200
Message-Id: <1500645206-13559-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 0/9] tests: Clean up around qmp() and hmp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Eric Blake (2):
  qtest: Avoid passing raw strings through hmp()
  qtest: Document calling conventions

Markus Armbruster (7):
  tests: Pass literal format strings directly to qmp_FOO()
  tests: Clean up string interpolation into QMP input (simple cases)
  tests/libqos/usb: Clean up string interpolation into QMP input
  tests/libqos/pci: Clean up string interpolation into QMP input
  tests: Clean up wait for event
  tests/libqtest: Clean up how we read the QMP greeting
  tests/libqtest: Enable compile-time format string checking

 tests/ahci-test.c         |   4 +-
 tests/boot-order-test.c   |   2 +-
 tests/ide-test.c          |   4 +-
 tests/ivshmem-test.c      |  10 +--
 tests/libqos/libqos.c     |  16 +----
 tests/libqos/pci-pc.c     |  15 +----
 tests/libqos/pci.c        |  33 +++++-----
 tests/libqos/pci.h        |   2 +-
 tests/libqos/usb.c        |  30 ++++-----
 tests/libqtest.c          |   4 +-
 tests/libqtest.h          |  62 +++++++++++-------
 tests/postcopy-test.c     |   8 +--
 tests/tco-test.c          |   3 +-
 tests/test-hmp.c          |   4 +-
 tests/test-qga.c          | 160 ++++++++++++++++++++--------------------------
 tests/usb-hcd-uhci-test.c |   6 +-
 tests/usb-hcd-xhci-test.c |  12 +---
 tests/vhost-user-test.c   |   6 +-
 tests/virtio-blk-test.c   |   5 +-
 tests/wdt_ib700-test.c    |  35 +++-------
 20 files changed, 180 insertions(+), 241 deletions(-)

-- 
2.7.5
