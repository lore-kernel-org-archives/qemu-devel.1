Received: from eggs.gnu.org ([2001:4830:134:3::10]:49620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOQSD-00010w-AQ
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 09:52:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOQS9-0004Pq-Cz
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 09:52:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cOQS9-0004PY-6a
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 09:52:41 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 304618123A
	for <qemu-devel@nongnu.org>; Tue,  3 Jan 2017 14:52:41 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  3 Jan 2017 15:52:29 +0100
Message-Id: <1483455154-8106-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] virtio-gpu: misc bugfixes.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

  Hi,

New year, new pull request.  Here comes the vga patch queue with
a collection of virtio-gpu fixes.

please pull,
  Gerd

The following changes since commit 6a928d25b6d8bc3729c3d28326c6db13b94810=
59:

  Update version for v2.8.0-rc4 release (2016-12-15 07:36:03 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/pull-vga-20170103-1

for you to fetch changes up to 204f01b30975923c64006f8067f0937b91eea68b:

  virtio-gpu: fix memory leak in resource attach backing (2017-01-03 15:4=
7:21 +0100)

----------------------------------------------------------------
virtio-gpu: misc bugfixes.

----------------------------------------------------------------
Gerd Hoffmann (1):
      virtio-gpu: track and limit host memory allocations

Li Qiang (3):
      virtio-gpu: call cleanup mapping function in resource destroy
      virtio-gpu-3d: fix memory leak in resource attach backing
      virtio-gpu: fix memory leak in resource attach backing

Prasad J Pandit (1):
      display: virtio-gpu-3d: check virgl capabilities max_size

 hw/display/virtio-gpu-3d.c     | 13 ++++++++++---
 hw/display/virtio-gpu.c        | 24 ++++++++++++++++++++----
 include/hw/virtio/virtio-gpu.h |  3 +++
 3 files changed, 33 insertions(+), 7 deletions(-)
