Received: from eggs.gnu.org ([209.51.188.92]:47883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1h0qUq-00029c-0s
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:31:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1h0qUo-0003nA-6B
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:31:19 -0500
From: Niels de Vos <ndevos@redhat.com>
Date: Mon,  4 Mar 2019 17:21:01 +0100
Message-Id: <20190304162103.18912-1-ndevos@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] block: Gluster 6 compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: Cole Robinson <crobinso@redhat.com>, integration@gluster.org, qemu-devel@nongnu.org, Niels de Vos <ndevos@redhat.com>

Gluster 6 is currently available as release candidate. There have been a
few changes to libgfapi.so that need to be adapted by consuming projects
like QEMU. Fedora Rawhide already contains glusterfs-6.0-RC0, and this
prevents rebuilds of QEMU there (https://bugzilla.redhat.com/1684298).

The following two changes should be sufficient to consume Gluster 6 once
it is released. These have been tested on CentOS-7 with Gluster 5 and
Gluster 6 (minimal manual qemu-img tests only).

Cheers,
Niels


Niels de Vos (2):
  block/gluster: Handle changed glfs_ftruncate signature
  gluster: the glfs_io_cbk callback function pointer adds pre/post stat
    args

 block/gluster.c | 17 ++++++++++++++---
 configure       | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 3 deletions(-)

--=20
2.20.1
