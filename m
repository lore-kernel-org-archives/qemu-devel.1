Received: from eggs.gnu.org ([2001:4830:134:3::10]:56257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGThE-0007Yw-B4
	for qemu-devel@nongnu.org; Wed, 09 May 2018 14:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGThD-0003S7-7t
	for qemu-devel@nongnu.org; Wed, 09 May 2018 14:20:12 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  9 May 2018 20:20:00 +0200
Message-Id: <20180509182002.8044-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] qemu-img: Resolve relative backing
 paths in rebase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

v1 of the cover letter here (no change necessary there):
http://lists.nongnu.org/archive/html/qemu-block/2018-05/msg00243.html

v2: Fixed a leaked buffer in an error path in patch 1 [Eric]


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/2:[0001] [FC] 'qemu-img: Resolve relative backing paths in rebase'
002/2:[----] [--] 'iotests: Add test for rebasing with relative paths'


Max Reitz (2):
  qemu-img: Resolve relative backing paths in rebase
  iotests: Add test for rebasing with relative paths

 qemu-img.c                 | 23 ++++++++++++-
 tests/qemu-iotests/024     | 82 ++++++++++++++++++++++++++++++++++++++++++++--
 tests/qemu-iotests/024.out | 30 +++++++++++++++++
 3 files changed, 131 insertions(+), 4 deletions(-)

-- 
2.14.3
