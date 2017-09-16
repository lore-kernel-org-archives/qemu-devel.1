Received: from eggs.gnu.org ([2001:4830:134:3::10]:47644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dt1WE-0005Ac-6G
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 21:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dt1WB-000673-2b
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 21:03:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dt1WA-00065w-Sb
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 21:03:34 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 15 Sep 2017 21:03:19 -0400
Message-Id: <20170916010330.10435-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/11] Ide patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com

The following changes since commit 5faf2d376af3cb4eb92da44c2580e08d39832c=
aa:

  Merge remote-tracking branch 'remotes/huth/tags/check-20170915' into st=
aging (2017-09-15 20:29:44 +0100)

are available in the git repository at:

  https://github.com/jnsnow/qemu.git tags/ide-pull-request

for you to fetch changes up to 2a94e34d3ecef91727f467cc012587c632099d40:

  AHCI: remove DPRINTF macro (2017-09-15 20:36:18 -0400)

----------------------------------------------------------------

----------------------------------------------------------------

Igor Mammedov (1):
  ide: ahci: unparent children buses before freeing their memory

John Snow (9):
  IDE: replace DEBUG_IDE with tracing system
  IDE: Add register hints to tracing
  IDE: add tracing for data ports
  ATAPI: Replace DEBUG_IDE_ATAPI with tracing events
  IDE: replace DEBUG_AIO with trace events
  AHCI: Replace DPRINTF with trace-events
  AHCI: Rework IRQ constants
  AHCI: pretty-print FIS to buffer instead of stderr
  AHCI: remove DPRINTF macro

Thomas Huth (1):
  hw/ide/microdrive: Mark the dscm1xxxx device with user_creatable =3D
    false

 Makefile.objs             |   1 +
 hw/ide/ahci.c             | 244 ++++++++++++++++++++++++----------------=
------
 hw/ide/ahci_internal.h    |  44 +++++++--
 hw/ide/atapi.c            |  69 +++++--------
 hw/ide/cmd646.c           |  10 +-
 hw/ide/core.c             | 185 +++++++++++++++++++++++------------
 hw/ide/microdrive.c       |   3 +
 hw/ide/pci.c              |  17 +---
 hw/ide/piix.c             |  11 +--
 hw/ide/trace-events       | 111 +++++++++++++++++++++
 hw/ide/via.c              |  10 +-
 include/hw/ide/internal.h |   8 +-
 12 files changed, 441 insertions(+), 272 deletions(-)
 create mode 100644 hw/ide/trace-events

--=20
2.9.5
