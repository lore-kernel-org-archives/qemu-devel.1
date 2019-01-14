Received: from eggs.gnu.org ([209.51.188.92]:42667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gj2Sn-0000vj-6X
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:39:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gj2Sm-0005IX-IE
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:39:37 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 14 Jan 2019 13:32:55 +0000
Message-Id: <20190114133257.30299-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] throttle-groups: fix restart coroutine
 iothread race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

v2:
 * Added qemu-iotests test case [Kevin, Alberto]
 * Use atomic operations instead of AioContext lock [Paolo]

This patch series fixes a segfault upon device_del when virtio-scsi is us=
ed
with iothreads.

Stefan Hajnoczi (2):
  throttle-groups: fix restart coroutine iothread race
  iotests: add 238 for throttling tgm unregister iothread segfault

 include/block/throttle-groups.h |  5 ++++
 block/throttle-groups.c         |  9 +++++++
 tests/qemu-iotests/238          | 47 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/238.out      |  6 +++++
 tests/qemu-iotests/group        |  1 +
 5 files changed, 68 insertions(+)
 create mode 100755 tests/qemu-iotests/238
 create mode 100644 tests/qemu-iotests/238.out

--=20
2.20.1
