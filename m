Received: from eggs.gnu.org ([2001:4830:134:3::10]:51773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfXkA-0006lz-FD
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:38:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfXk9-0008Jt-1b
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:38:18 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  9 Aug 2017 15:38:03 -0500
Message-Id: <20170809203808.31725-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.10 v2 0/5] More bdrv_getlength() fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jcody@redhat.com

We already have a lot of bdrv_getlength() fixes in -rc2; so I think
this is still okay for -rc3.

v1 was here (with a typo'd subject line):
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01226.html

Since v1:
- patch 1: fix error message capitalization (Kevin, R-b kept)
- fix locking bug in original patch 2 (Kevin)
- split original patch 2 into two parts: signature update, and
added error checking (Kevin)
- check for unlikely integer overflow before bdrv_truncate (Jeff)

001/5:[0002] [FC] 'vpc: Check failure of bdrv_getlength()'
002/5:[down] 'qcow: Change signature of get_cluster_offset()'
003/5:[0048] [FC] 'qcow: Check failure of bdrv_getlength() and bdrv_trunc=
ate()'
004/5:[----] [--] 'qcow2: Drop debugging dump_refcounts()'
005/5:[----] [--] 'qcow2: Check failure of bdrv_getlength()'

Eric Blake (5):
  vpc: Check failure of bdrv_getlength()
  qcow: Change signature of get_cluster_offset()
  qcow: Check failure of bdrv_getlength() and bdrv_truncate()
  qcow2: Drop debugging dump_refcounts()
  qcow2: Check failure of bdrv_getlength()

 block/qcow.c  | 165 ++++++++++++++++++++++++++++++++++------------------=
------
 block/qcow2.c |  26 ++-------
 block/vpc.c   |   9 +++-
 3 files changed, 110 insertions(+), 90 deletions(-)

--=20
2.13.4
