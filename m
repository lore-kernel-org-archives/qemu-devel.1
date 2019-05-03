Received: from eggs.gnu.org ([209.51.188.92]:45306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu_oss@crudebyte.com>) id 1hMavV-0003Pq-UB
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:20:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <qemu_oss@crudebyte.com>) id 1hMavU-000544-Lw
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:20:45 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:53547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
	id 1hMavU-0004zB-2V
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:20:44 -0400
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 03 May 2019 18:20:39 +0200
Message-ID: <1926077.q6xKvCkoZ9@silver>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: [Qemu-devel] [PATCH v2 0/4] 9p: Fix file ID collisions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Antonios Motakis <antonios.motakis@huawei.com>

Hi!

This is v2 of a proposed patch set for fixing file ID collisions with 9pfs.

Patch 1 to 3 are identical to the previous version. New in this v2 is patch 4
which introduces variable length suffixes for inode mapping instead of fixed
length prefixes.

Also: patch 4 disables file ID persistency at compile time by default for now,
since I am yet unresolved about details of that persistency.

Christian Schoenebeck (4):
  9p: mitigates most QID path collisions
  9P: trivial cleanup of QID path collision mitigation
  9p: persistency of QID path beyond reboots / suspensions
  9p: use variable length suffixes for inode mapping

 fsdev/9p-marshal.h   |    6 +-
 hw/9pfs/9p.c         | 1145 ++++++++++++++++++++++++++++++++++++++++++++++++--
 hw/9pfs/9p.h         |  167 ++++++++
 hw/9pfs/trace-events |   14 +-
 4 files changed, 1296 insertions(+), 36 deletions(-)

-- 
2.11.0
