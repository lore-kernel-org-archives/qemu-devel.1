Received: from eggs.gnu.org ([2001:4830:134:3::10]:42941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gX1Cc-000489-Aj
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:53:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gX1Ca-0003Wl-Dp
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:53:14 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 12 Dec 2018 09:52:50 +0000
Message-Id: <20181212095252.20349-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

The following changes since commit bb9bf94b3e8926553290bc9a7cb84315af4220=
86:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-r=
equest' into staging (2018-12-11 19:18:58 +0000)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to e61809ed8ac3a2f68eb1cc231244f84eb06adacf:

  virtio-blk: fix comment for virtio_blk_rw_complete as nalloc is initial=
ly -1 (2018-12-12 09:16:55 +0000)

----------------------------------------------------------------
Pull request

Minor virtio-blk fixes.

----------------------------------------------------------------

Dongli Zhang (2):
  virtio-blk: rename iov to out_iov in virtio_blk_handle_request()
  virtio-blk: fix comment for virtio_blk_rw_complete as nalloc is
    initially -1

 hw/block/virtio-blk.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--=20
2.19.2
