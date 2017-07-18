Received: from eggs.gnu.org ([2001:4830:134:3::10]:60024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLsJ-0001UD-4G
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:20:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLsI-0000ZX-Bj
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:20:51 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 03:09:42 -0300
Message-Id: <20170718061005.29518-7-f4bug@amsat.org>
In-Reply-To: <20170718061005.29518-1-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 06/29] migration/block: use QEMU_IS_ALIGNED
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>

Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.cocci

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 migration/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/block.c b/migration/block.c
index 9171f60028..498c72ad59 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -933,7 +933,7 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
                 ret = bdrv_get_info(blk_bs(blk), &bdi);
                 if (ret == 0 && bdi.cluster_size > 0 &&
                     bdi.cluster_size <= BLOCK_SIZE &&
-                    BLOCK_SIZE % bdi.cluster_size == 0) {
+                    QEMU_IS_ALIGNED(BLOCK_SIZE, bdi.cluster_size)) {
                     cluster_size = bdi.cluster_size;
                 } else {
                     cluster_size = BLOCK_SIZE;
-- 
2.13.2
