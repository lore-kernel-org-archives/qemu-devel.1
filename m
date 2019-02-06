Received: from eggs.gnu.org ([209.51.188.92]:57681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grPDz-0004z1-9R
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:34:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grPDy-0007Tb-KG
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:34:55 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  6 Feb 2019 16:29:17 +0100
Message-Id: <20190206152919.5532-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] block/ssh: Implement
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

This series depends on my "block: Fix some filename generation issues"
series.

Based-on: 20190201192935.18394-1-mreitz@redhat.com


v2:
- No longer based on the libssh2 -> libssh patches
- Put /* and */ on their own lines to make checkpatch happy


Max Reitz (2):
  block/ssh: Implement .bdrv_refresh_filename()
  block/ssh: Implement .bdrv_dirname()

 block/ssh.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 5 deletions(-)

--=20
2.20.1
