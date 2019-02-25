Received: from eggs.gnu.org ([209.51.188.92]:38383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyLcG-0002yL-8q
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 14:08:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyLcF-0001dI-KF
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 14:08:40 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 25 Feb 2019 20:08:26 +0100
Message-Id: <20190225190828.17726-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/2] block/ssh: Implement
 .bdrv_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This series implements .bdrv_refresh_filename() for the ssh block
driver, along with an appropriate .bdrv_dirname() so we don't chop off
query strings for backing files with relative filenames.


v3:
- Keep iotests 104 and 207 working


Max Reitz (2):
  block/ssh: Implement .bdrv_refresh_filename()
  block/ssh: Implement .bdrv_dirname()

 block/ssh.c                   | 73 ++++++++++++++++++++++++++++++++---
 tests/qemu-iotests/207        | 10 ++---
 tests/qemu-iotests/207.out    | 10 ++---
 tests/qemu-iotests/common.rc  |  2 +-
 tests/qemu-iotests/iotests.py |  2 +-
 5 files changed, 80 insertions(+), 17 deletions(-)

--=20
2.20.1
