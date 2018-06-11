Received: from eggs.gnu.org ([2001:4830:134:3::10]:52235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fSUXJ-0003Fd-Sg
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fSUXJ-0000hz-4V
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:39:37 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Jun 2018 16:39:25 -0500
Message-Id: <20180611213927.141894-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Fix qemu-img map on unaligned image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, danken@redhat.com, nsoffer@redhat.com, mlipchuk@redhat.com

See https://bugzilla.redhat.com/1589738; thanks to Nir, Maor, and Dan
for figuring out that it was a qemu-img regression and coming up with
a test case; and for Kevin for then bisecting it to point to my
byte-based conversion code being at fault.

Eric Blake (2):
  qemu-img: Fix assert when mapping unaligned raw file
  iotests: Add test 221 to catch qemu-img map regression

 qemu-img.c                 |  2 +-
 tests/qemu-iotests/221     | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/221.out | 16 +++++++++++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 78 insertions(+), 1 deletion(-)
 create mode 100755 tests/qemu-iotests/221
 create mode 100644 tests/qemu-iotests/221.out

-- 
2.14.4
