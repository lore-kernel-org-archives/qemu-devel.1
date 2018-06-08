Received: from eggs.gnu.org ([2001:4830:134:3::10]:47776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUE-0002RO-G9
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUA-0001Vc-3s
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49370 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fRLU9-0001V8-To
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:38 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Jun 2018 13:47:03 -0400
Message-Id: <20180608174733.4936-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/30] Ide patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org

The following changes since commit 0d2fa03dae4fbe185a082f361342b1e30aed45=
82:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
80608' into staging (2018-06-08 16:26:51 +0100)

are available in the Git repository at:

  https://github.com/jnsnow/qemu.git tags/ide-pull-request

for you to fetch changes up to c173723f247c69974a83af1395020d0f01a0d334:

  ide: introduce ide_transfer_start_norecurse (2018-06-08 13:36:31 -0400)

----------------------------------------------------------------

AHCI Pull request

----------------------------------------------------------------

John Snow (21):
  ahci: trim signatures on raise/lower
  ahci: fix PxCI register race
  ahci: don't schedule unnecessary BH
  ahci: add port register enumeration
  ahci: modify ahci_port_read to use register numbers
  ahci: make port read traces more descriptive
  ahci: fix spacing damage on ahci_port_write
  ahci: combine identical clauses in port write
  ahci: modify ahci_port_write to use register numbers
  ahci: make port write traces more descriptive
  ahci: delete old port register address definitions
  ahci: add host register enumeration
  ahci: fix host register max address
  ahci: modify ahci_mem_read_32 to work on register numbers
  ahci: make mem_read_32 traces more descriptive
  ahci: fix spacing damage on ahci_mem_write
  ahci: adjust ahci_mem_write to work on registers
  ahci: delete old host register address definitions
  ahci: make ahci_mem_write traces more descriptive
  libqos/ahci: track sector size
  ahci: move PIO Setup FIS before transfer, fix it for ATAPI commands

Paolo Bonzini (5):
  ide: push end_transfer_func out of start_transfer callback, rename
    callback
  ide: call ide_cmd_done from ide_transfer_stop
  ide: make ide_transfer_stop idempotent
  atapi: call ide_set_irq before ide_transfer_start
  ide: introduce ide_transfer_start_norecurse

Thomas Huth (4):
  tests/boot-sector: Add magic bytes to s390x boot code header
  tests/cdrom-test: Test booting from CD-ROM ISO image file
  tests/cdrom-test: Test that -cdrom parameter is working
  MAINTAINERS: Add the cdrom-test to John's section

 MAINTAINERS               |   1 +
 hw/ide/ahci.c             | 371 +++++++++++++++++++++++++++-------------=
------
 hw/ide/ahci_internal.h    |  63 +++++---
 hw/ide/atapi.c            |  44 +++---
 hw/ide/core.c             |  39 ++---
 hw/ide/trace-events       |  15 +-
 include/hw/ide/internal.h |   4 +-
 tests/Makefile.include    |   2 +
 tests/boot-sector.c       |   9 +-
 tests/cdrom-test.c        | 222 +++++++++++++++++++++++++++
 tests/libqos/ahci.c       |  45 +++---
 tests/libqos/ahci.h       |   3 +-
 12 files changed, 573 insertions(+), 245 deletions(-)
 create mode 100644 tests/cdrom-test.c

--=20
2.14.3
