Received: from eggs.gnu.org ([209.51.188.92]:35788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghbLL-0003kU-FC
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:30:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghbLK-0005hD-K8
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:29:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ghbLK-0005gp-E9
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:29:58 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 10 Jan 2019 12:29:45 -0200
Message-Id: <20190110142955.23254-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/10] Machine queue, 2019-01-10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

The following changes since commit 8ae951fbc1068308313b2c57a4fc3c68451641=
f4:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.0-20190109=
' into staging (2019-01-09 16:08:31 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to d769f0dfeeaa1554a38fedb16bb20a4b0ecf793c:

  qom: Don't keep error value between object_property_parse() calls (2019=
-01-10 12:25:15 -0200)

----------------------------------------------------------------
Machine queue, 2019-01-10

* Simplify GlobalProperty array declarations (Eduardo Habkost)
* Deprecate cpu-add commands (Kashyap Chamarthy)
* range/memory-device cleanups (David Hildenbrand)
* Fix -device scsi-hd,help regression (Marc-Andr=C3=A9 Lureau)
* Fix crash when -global generates multiple warnings (Eduardo
  Habkost)

----------------------------------------------------------------

Queue for Machine Core patches


David Hildenbrand (2):
  range: add some more functions
  memory-device: rewrite address assignment using ranges

Eduardo Habkost (4):
  spapr: Eliminate SPAPR_PCI_2_7_MMIO_WIN_SIZE macro
  machine: Eliminate unnecessary stringify() usage
  machine: Use shorter format for GlobalProperty arrays
  qom: Don't keep error value between object_property_parse() calls

Kashyap Chamarthy (3):
  qemu-deprecated.texi: Rename the HMP section
  Update that HMP 'cpu-add' is deprecated in 4.0
  Mention that QMP 'cpu-add' will be deprecated

Marc-Andr=C3=A9 Lureau (1):
  qdev: fix -device scsi-hd,help regression

 include/hw/i386/pc.h        |  18 +-
 include/hw/pci-host/spapr.h |   1 -
 include/qemu/range.h        |  62 ++++
 hw/core/machine.c           | 338 ++++-------------
 hw/core/qdev.c              |   9 +-
 hw/i386/pc.c                | 720 +++++++-----------------------------
 hw/i386/pc_piix.c           | 192 ++--------
 hw/mem/memory-device.c      |  51 +--
 hw/ppc/spapr.c              |  72 +---
 hw/s390x/s390-virtio-ccw.c  |  75 +---
 hw/xen/xen-common.c         |  18 +-
 qom/object.c                |   2 +-
 qemu-deprecated.texi        |  10 +-
 13 files changed, 368 insertions(+), 1200 deletions(-)

--=20
2.18.0.rc1.1.g3f1ff2140
