Received: from eggs.gnu.org ([209.51.188.92]:54505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h12Mh-0001Cg-Ds
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 00:11:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h12Mg-0005pk-Sa
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 00:11:43 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  5 Mar 2019 16:11:32 +1100
Message-Id: <20190305051134.27930-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 0/2] virtio-balloon: Some further fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, david@redhat.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Commits f6deb6d..ee1cd00 made some reworks to the balloon device to
fix behaviour on systems (both host and guest) which don't have 4kiB
pages.  However it introduced a couple of problems, which this series
addresses.

David Gibson (2):
  virtio-balloon: Fix possible guest memory corruption with inflates &
    deflates
  virtio-balloon: Restore MADV_WILLNEED hint on balloon deflate

 hw/virtio/virtio-balloon.c         | 63 +++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-balloon.h |  1 +
 2 files changed, 62 insertions(+), 2 deletions(-)

--=20
2.20.1
