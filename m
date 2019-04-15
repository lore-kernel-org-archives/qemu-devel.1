Received: from eggs.gnu.org ([209.51.188.92]:47610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hG3wz-0007as-6f
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hG3wx-0003OP-BQ
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:55:16 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 15 Apr 2019 17:54:48 +0200
Message-Id: <20190415155452.5115-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] qcow2: Preallocation fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Kevin Wolf (4):
  qcow2: Avoid COW during metadata preallocation
  qcow2: Fix preallocation bdrv_pwrite to wrong file
  qcow2: Add errp to preallocate_co()
  qcow2: Fix full preallocation with external data file

 block/qcow2.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

--=20
2.20.1
