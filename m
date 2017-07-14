Received: from eggs.gnu.org ([2001:4830:134:3::10]:53464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dW1hS-0003ss-8w
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dW1hQ-0003N5-5D
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:36:10 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:16566)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dW1hP-0003MD-PZ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:36:08 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Fri, 14 Jul 2017 17:35:46 +0300
Message-Id: <20170714143548.32559-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v3 0/2] fix leaks in bdrv_open_driver()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>

v3:
 new commit: block: fix dangling bs->explicit_options in block.c
 rework error paths in bdrv_open_driver()
v2:
 move bdrv_unref_child(bs, bs->file) to bdrv_open_driver
 do not set bs->drv to NULL if open succeeds

Manos Pitsidianakis (2):
  block: fix dangling bs->explicit_options in block.c
  block: fix leaks in bdrv_open_driver()

 block.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

-- 
2.11.0
