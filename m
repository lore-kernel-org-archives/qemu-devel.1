Received: from eggs.gnu.org ([2001:4830:134:3::10]:43501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gX1En-00063q-BY
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:55:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gX1Ei-00069W-S2
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:55:28 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 12 Dec 2018 10:55:13 +0100
Message-Id: <20181212095519.6390-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/6] s390x: first batch of 4.0 changes
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

The following changes since commit bb9bf94b3e8926553290bc9a7cb84315af4220=
86:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-r=
equest' into staging (2018-12-11 19:18:58 +0000)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20181212

for you to fetch changes up to c9aacaadeb42076c01b07e59dd94dcf73f751e05:

  hw/s390x/virtio-ccw.c: Don't take address of fields in packed structs (=
2018-12-12 10:39:28 +0100)

----------------------------------------------------------------
s390x patches for 4.0:
- add 4.0 machine type
- various fixes and small changes

----------------------------------------------------------------

Christian Borntraeger (1):
  s390/MAINTAINERS: Add Halil as kvm and machine maintainer

Cornelia Huck (2):
  s390x: introduce 4.0 compat machine
  vfio-ap: flag as compatible with balloon

David Hildenbrand (2):
  s390x/zpci: drop msix.available
  s390x/tod: Properly stop the KVM TOD while the guest is not running

Peter Maydell (1):
  hw/s390x/virtio-ccw.c: Don't take address of fields in packed structs

 MAINTAINERS                |   4 +-
 hw/s390x/s390-pci-bus.c    |   2 -
 hw/s390x/s390-pci-bus.h    |   1 -
 hw/s390x/s390-virtio-ccw.c |  17 ++++++-
 hw/s390x/tod-kvm.c         | 102 ++++++++++++++++++++++++++++++++++++-
 hw/s390x/virtio-ccw.c      |  42 +++++++--------
 hw/vfio/ap.c               |   8 +++
 include/hw/s390x/tod.h     |   8 ++-
 8 files changed, 156 insertions(+), 28 deletions(-)

--=20
2.17.2
