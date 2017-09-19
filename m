Received: from eggs.gnu.org ([2001:4830:134:3::10]:37014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1du68r-0005bQ-Mv
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1du68n-0004Re-TD
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:11:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1du68n-0004RC-NT
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:11:53 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 18 Sep 2017 20:11:34 -0400
Message-Id: <20170919001147.23182-2-jsnow@redhat.com>
In-Reply-To: <20170919001147.23182-1-jsnow@redhat.com>
References: <20170919001147.23182-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/13] Ide patches
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

The following changes since commit a9158a5cba955b79d580a252cc58ff44d154e3=
70:

  Merge remote-tracking branch 'remotes/kraxel/tags/audio-20170918-pull-r=
equest' into staging (2017-09-18 12:40:54 +0100)

are available in the git repository at:

  https://github.com/jnsnow/qemu.git tags/ide-pull-request

for you to fetch changes up to ae34fce5f94e93a68c879fe6179d4bcd9ee915d7:

  hw/block/fdc: Convert to realize (2017-09-18 19:43:38 -0400)

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

Mao Zhongyi (2):
  hw/ide: Convert DeviceClass init to realize
  hw/block/fdc: Convert to realize

Thomas Huth (1):
  hw/ide/microdrive: Mark the dscm1xxxx device with user_creatable =3D
    false

 Makefile.objs                 |   1 +
 hw/block/fdc.c                |  33 +++---
 hw/ide/ahci.c                 | 244 ++++++++++++++++++++++--------------=
------
 hw/ide/ahci_internal.h        |  44 ++++++--
 hw/ide/atapi.c                |  69 +++++-------
 hw/ide/cmd646.c               |  10 +-
 hw/ide/core.c                 | 192 +++++++++++++++++++++------------
 hw/ide/microdrive.c           |   3 +
 hw/ide/pci.c                  |  17 +--
 hw/ide/piix.c                 |  11 +-
 hw/ide/qdev.c                 |  86 ++++++++-------
 hw/ide/trace-events           | 111 +++++++++++++++++++
 hw/ide/via.c                  |  10 +-
 include/hw/ide/internal.h     |  14 +--
 tests/qemu-iotests/051.pc.out |  10 +-
 tests/qemu-iotests/172.out    |   8 --
 16 files changed, 509 insertions(+), 354 deletions(-)
 create mode 100644 hw/ide/trace-events

--=20
2.9.5
