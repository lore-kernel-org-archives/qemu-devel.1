Received: from eggs.gnu.org ([2001:4830:134:3::10]:40996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fY1b3-0002sV-G0
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 23:58:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fY1b2-00063g-M5
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 23:58:21 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 27 Jun 2018 11:57:51 +0800
Message-Id: <20180627035752.1425-2-famz@redhat.com>
In-Reply-To: <20180627035752.1425-1-famz@redhat.com>
References: <20180627035752.1425-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] qcow2: Remove dead check on !ret
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

In the beginning of the function, we initialize the local variable to 0,
and in the body of the function, we check the assigned values and exit
the loop immediately. So here it can never be non-zero.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/qcow2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index a3a3aa2a97..ff23063616 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1772,7 +1772,7 @@ static coroutine_fn int qcow2_handle_l2meta(BlockDriverState *bs,
     while (l2meta != NULL) {
         QCowL2Meta *next;
 
-        if (!ret && link_l2) {
+        if (link_l2) {
             ret = qcow2_alloc_cluster_link_l2(bs, l2meta);
             if (ret) {
                 goto out;
-- 
2.17.1
