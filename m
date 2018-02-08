Received: from eggs.gnu.org ([2001:4830:134:3::10]:45298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ejsVy-0002HJ-Bz
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:09:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ejsVx-0002J4-Af
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:09:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53826 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ejsVx-0002Ij-5C
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:09:49 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E0AF404084A
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 20:09:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  8 Feb 2018 21:09:28 +0100
Message-Id: <1518120582-26647-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/14] qtest patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Here's a set of qtest patches that have been posted to the list before
and are IMHO ready for inclusion. I've included the patches from Eric's
"Preliminary libqtest cleanups" series that do not need major reworks
(the rest needs some more love later), and some additional entries for
the boot-serial tester. If there are no objections, I'll sent a PULL
request for these patches next week.

Eric Blake (10):
  libqtest: Use qemu_strtoul()
  libqos: Track QTestState with QPCIBus
  libqos: Use explicit QTestState for fw_cfg operations
  libqos: Use explicit QTestState for rtas operations
  libqos: Use explicit QTestState for i2c operations
  libqos: Use explicit QTestState for ahci operations
  libqos: Use explicit QTestState for remaining libqos operations
  qmp-test: Drop dependence on global_qtest
  tests/boot-sector: Drop dependence on global_qtest
  wdt_ib700-test: Drop dependence on global_qtest

Markus Armbruster (1):
  tests: Clean up wait for event

Thomas Huth (2):
  tests/boot-serial: Enable the boot-serial test on SPARC machines, too
  tests/boot-serial: Add tests for PowerPC Mac machines

Wei Huang (1):
  tests/boot-serial-test: Add support for the aarch64 virt machine

 tests/Makefile.include      |  3 ++
 tests/ahci-test.c           |  3 +-
 tests/bios-tables-test.c    |  2 +-
 tests/boot-order-test.c     |  8 ++--
 tests/boot-sector.c         |  8 ++--
 tests/boot-sector.h         |  6 ++-
 tests/boot-serial-test.c    | 16 ++++++++
 tests/ds1338-test.c         |  6 +--
 tests/e1000e-test.c         |  8 ++--
 tests/fw_cfg-test.c         | 13 ++-----
 tests/i440fx-test.c         |  2 +-
 tests/ide-test.c            |  4 +-
 tests/ivshmem-test.c        |  1 +
 tests/libqos/ahci.c         | 49 ++++++++++++------------
 tests/libqos/ahci.h         |  2 +-
 tests/libqos/fw_cfg.c       | 14 ++++---
 tests/libqos/fw_cfg.h       | 10 +++--
 tests/libqos/i2c-imx.c      | 67 ++++++++++++++++-----------------
 tests/libqos/i2c-omap.c     | 45 ++++++++++++-----------
 tests/libqos/i2c.h          |  7 +++-
 tests/libqos/libqos-pc.c    |  2 +-
 tests/libqos/libqos.c       | 40 +++++++-------------
 tests/libqos/libqos.h       |  4 +-
 tests/libqos/malloc-pc.c    |  8 ++--
 tests/libqos/malloc-pc.h    |  4 +-
 tests/libqos/malloc-spapr.c |  4 +-
 tests/libqos/malloc-spapr.h |  2 +-
 tests/libqos/malloc.h       |  1 +
 tests/libqos/pci-pc.c       | 13 +++----
 tests/libqos/pci-pc.h       |  2 +-
 tests/libqos/pci-spapr.c    | 25 ++++++++-----
 tests/libqos/pci-spapr.h    |  2 +-
 tests/libqos/pci.h          |  1 +
 tests/libqos/rtas.c         | 36 ++++++++++--------
 tests/libqos/rtas.h         | 12 +++---
 tests/libqtest.c            | 19 +++++++---
 tests/megasas-test.c        |  5 ++-
 tests/pxe-test.c            |  2 +-
 tests/q35-test.c            |  4 +-
 tests/qmp-test.c            | 35 +++++++++---------
 tests/rtas-test.c           |  3 +-
 tests/rtl8139-test.c        |  5 ++-
 tests/tco-test.c            |  5 +--
 tests/tmp105-test.c         |  6 +--
 tests/usb-hcd-ehci-test.c   |  2 +-
 tests/usb-hcd-uhci-test.c   |  1 +
 tests/vhost-user-test.c     |  4 +-
 tests/virtio-9p-test.c      |  1 +
 tests/virtio-blk-test.c     |  1 +
 tests/virtio-net-test.c     | 15 +++++---
 tests/virtio-scsi-test.c    | 16 ++++----
 tests/vmgenid-test.c        |  2 +-
 tests/wdt_ib700-test.c      | 90 ++++++++++++++++++++-------------------=
------
 53 files changed, 339 insertions(+), 307 deletions(-)

--=20
1.8.3.1
