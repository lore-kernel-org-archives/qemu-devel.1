Received: from eggs.gnu.org ([209.51.188.92]:54506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gr3me-0000zR-5b
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:41:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gr3md-0007ri-8P
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:41:16 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue,  5 Feb 2019 17:40:59 +0100
Message-Id: <20190205164109.25413-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/10] s390x update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

The following changes since commit a61faa3d02159d24d4fa984733dbc0c9055087=
52:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.0-20190204=
' into staging (2019-02-04 10:33:40 +0000)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20190205

for you to fetch changes up to 2313a88fe68cb970532ba1641ffc35c848daae86:

  s390x/pci: Unplug remaining requested devices on pcihost reset (2019-02=
-05 10:34:06 +0100)

----------------------------------------------------------------
Fixes and improvements in tcg and the zPCI code.

----------------------------------------------------------------

Alex Benn=C3=A9e (1):
  target/s390x: define TCG_GUEST_DEFAULT_MO for MTTCG

Cornelia Huck (1):
  s390x/pci: mark zpci devices as unmigratable

David Hildenbrand (7):
  s390x/pci: Introduce unplug requests and split unplug handler
  s390x/pci: Drop release timer and replace it with a flag
  s390x/tcg: Don't model FP registers as globals
  s390x/pci: Fix primary bus number for PCI bridges
  s390x/pci: Fix hotplugging of PCI bridges
  s390x/pci: Warn when adding PCI devices without the 'zpci' feature
  s390x/pci: Unplug remaining requested devices on pcihost reset

Igor Mammedov (1):
  s390x: remove direct reference to mem_path global from s390x code

 hw/s390x/s390-pci-bus.c    | 244 ++++++++++++++++++++++++-------------
 hw/s390x/s390-pci-bus.h    |   4 +-
 target/s390x/cpu.h         |   4 +
 target/s390x/insn-data.def | 150 +++++++++++------------
 target/s390x/kvm.c         |   5 +-
 target/s390x/translate.c   | 135 ++++++++++++--------
 6 files changed, 330 insertions(+), 212 deletions(-)

--=20
2.17.2
