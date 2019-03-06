Received: from eggs.gnu.org ([209.51.188.92]:51032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1Msm-0005Kt-3D
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 22:06:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1Msl-0003rt-D6
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 22:06:12 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  6 Mar 2019 14:05:58 +1100
Message-Id: <20190306030601.21986-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] virtio-balloon: Several fixes to recent
 rework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tsirkin <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

A rework to the virtio-balloon driver was recently merged as
f6deb6d..ee1cd00.  This series addresses several minor issues in the
new code.

Changes since RFC:
 * Add a fix for the g_malloc/free mismatch reported by Coverity
 * Remove the not-really-useful hint-on-deflate flag

David Gibson (3):
  virtio-balloon: Don't mismatch g_malloc()/free (CID 1399146)
  virtio-balloon: Fix possible guest memory corruption with inflates &
    deflates
  virtio-balloon: Restore MADV_WILLNEED hint on balloon deflate

 hw/virtio/virtio-balloon.c | 65 +++++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 4 deletions(-)

--=20
2.20.1
