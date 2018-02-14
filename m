Received: from eggs.gnu.org ([2001:4830:134:3::10]:43496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elv7N-0006JC-6B
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:20:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elv7L-0007Aa-Px
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:20:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58256 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1elv7L-0007AI-Ib
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:20:51 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 14 Feb 2018 12:20:16 +0100
Message-Id: <1518607234-17739-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/18] qtest patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

The following changes since commit bec9c64ef7be8063f1192608b83877bc5c9ea2=
17:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2018-02-13 18:24:08 +0000)

are available in the git repository at:

  https://github.com/huth/qemu.git tags/pull-request-2018-02-14

for you to fetch changes up to 02f4fbecb93da2125d22d3f0b62c6ee44aea84d4:

  tests/m48t59: Use the m48t59 test on ppc, too (2018-02-14 11:43:42 +010=
0)

----------------------------------------------------------------
Various improvements to the qtest checks:
- Clean-ups by Eric Blake with regards to the global_qtest variable
- Some more test cases for the boot-serial tester
- Re-activation of the m48t59-test
----------------------------------------------------------------

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

Thomas Huth (6):
      tests/boot-serial: Enable the boot-serial test on SPARC machines, t=
oo
      tests/boot-serial: Add tests for PowerPC Mac machines
      tests/m48t59: Fix and re-enable the test for sparc
      tests/m48t59: Make the test independent of global_qtest
      tests/Makefile: Derive check-qtest-ppc64-y from check-qtest-ppc-y
      tests/m48t59: Use the m48t59 test on ppc, too

Wei Huang (1):
      tests/boot-serial-test: Add support for the aarch64 virt machine

 tests/Makefile.include      |  22 ++++----
 tests/ahci-test.c           |   3 +-
 tests/bios-tables-test.c    |   2 +-
 tests/boot-order-test.c     |   8 +--
 tests/boot-sector.c         |   8 +--
 tests/boot-sector.h         |   6 ++-
 tests/boot-serial-test.c    |  16 ++++++
 tests/ds1338-test.c         |   6 +--
 tests/e1000e-test.c         |   8 +--
 tests/fw_cfg-test.c         |  13 ++---
 tests/i440fx-test.c         |   2 +-
 tests/ide-test.c            |   4 +-
 tests/ivshmem-test.c        |   1 +
 tests/libqos/ahci.c         |  49 +++++++++---------
 tests/libqos/ahci.h         |   2 +-
 tests/libqos/fw_cfg.c       |  14 ++---
 tests/libqos/fw_cfg.h       |  10 ++--
 tests/libqos/i2c-imx.c      |  67 ++++++++++++------------
 tests/libqos/i2c-omap.c     |  45 ++++++++--------
 tests/libqos/i2c.h          |   7 ++-
 tests/libqos/libqos-pc.c    |   2 +-
 tests/libqos/libqos.c       |  40 +++++---------
 tests/libqos/libqos.h       |   4 +-
 tests/libqos/malloc-pc.c    |   8 +--
 tests/libqos/malloc-pc.h    |   4 +-
 tests/libqos/malloc-spapr.c |   4 +-
 tests/libqos/malloc-spapr.h |   2 +-
 tests/libqos/malloc.h       |   1 +
 tests/libqos/pci-pc.c       |  13 ++---
 tests/libqos/pci-pc.h       |   2 +-
 tests/libqos/pci-spapr.c    |  25 +++++----
 tests/libqos/pci-spapr.h    |   2 +-
 tests/libqos/pci.h          |   1 +
 tests/libqos/rtas.c         |  36 +++++++------
 tests/libqos/rtas.h         |  12 +++--
 tests/libqtest.c            |  19 ++++---
 tests/m48t59-test.c         | 123 ++++++++++++++++++++++++--------------=
------
 tests/megasas-test.c        |   5 +-
 tests/pxe-test.c            |   2 +-
 tests/q35-test.c            |   4 +-
 tests/qmp-test.c            |  35 +++++++------
 tests/rtas-test.c           |   3 +-
 tests/rtl8139-test.c        |   5 +-
 tests/sdhci-test.c          |   2 +-
 tests/tco-test.c            |   5 +-
 tests/tmp105-test.c         |   6 +--
 tests/usb-hcd-ehci-test.c   |   2 +-
 tests/usb-hcd-uhci-test.c   |   1 +
 tests/vhost-user-test.c     |   4 +-
 tests/virtio-9p-test.c      |   1 +
 tests/virtio-blk-test.c     |   1 +
 tests/virtio-net-test.c     |  15 +++---
 tests/virtio-scsi-test.c    |  16 +++---
 tests/vmgenid-test.c        |   2 +-
 tests/wdt_ib700-test.c      |  90 ++++++++++++++------------------
 55 files changed, 416 insertions(+), 374 deletions(-)
