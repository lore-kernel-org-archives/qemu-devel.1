Received: from eggs.gnu.org ([209.51.188.92]:37343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gmisJ-0000OL-R5
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:33:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gmisH-0006IP-S0
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:33:11 -0500
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 24 Jan 2019 18:23:21 +0100
Message-Id: <20190124172323.230296-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH RFC 0/2] virtio-blk: add DISCARD and WRITE
 ZEROES features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This series adds the support of DISCARD and WRITE ZEROES commands
and extends the virtio-blk-test to test WRITE_ZEROES command when
the feature is enabled.

RFC because I'm not sure if the "case" conditions that I used in
virtio-blk.c is clean enough.

This series requires the new virtio headers from linux v5.0-rc1
already imported by Paolo:

Based-on: <20190104082731.24967-1-pbonzini@redhat.com>

Thanks,
Stefano

Stefano Garzarella (2):
  virtio-blk: add DISCARD and WRITE ZEROES features
  tests/virtio-blk: add test for WRITE_ZEROES command

 hw/block/virtio-blk.c   | 79 +++++++++++++++++++++++++++++++++++++++++
 tests/virtio-blk-test.c | 63 ++++++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+)

--=20
2.20.1
