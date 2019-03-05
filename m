Received: from eggs.gnu.org ([209.51.188.92]:38848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1h1CHH-0003kt-P5
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:46:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1h1CHG-0008P9-TU
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:46:47 -0500
From: Niels de Vos <ndevos@redhat.com>
Date: Tue,  5 Mar 2019 16:46:32 +0100
Message-Id: <20190305154634.4609-1-ndevos@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] block: Gluster 6 compatibility
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

This v2 post contains changes suggested by Daniel P. Berrang=C3=A9 and Ke=
vin
Wolf. Thanks!

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
