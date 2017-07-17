Received: from eggs.gnu.org ([2001:4830:134:3::10]:51024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dX88R-0006m5-CM
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:40:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dX88O-0007gz-9H
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:40:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dX88O-0007gN-2y
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:40:32 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 17 Jul 2017 16:40:24 +0100
Message-Id: <20170717154026.32697-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit 4871b51b9241b10f4fd8e04bbb21577886795e=
25:

  vmgenid-test: use boot-sector infrastructure (2017-07-14 17:03:03 +0100=
)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 593ed6f0a3c827a13a274e47f6fa980344234f9c:

  block: fix shadowed variable in bdrv_co_pdiscard (2017-07-17 15:58:37 +=
0100)

----------------------------------------------------------------

----------------------------------------------------------------

Alistair Francis (1):
  util/aio-win32: Only select on what we are actually waiting for

Denis V. Lunev (1):
  block: fix shadowed variable in bdrv_co_pdiscard

 block/io.c       |  1 -
 util/aio-win32.c | 13 ++++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

--=20
2.9.4
