Received: from eggs.gnu.org ([2001:4830:134:3::10]:39559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqAIS-0001aI-6v
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqAIR-0000TF-I1
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:17:20 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 21 Mar 2017 11:16:22 +0800
Message-Id: <20170321031635.22123-4-famz@redhat.com>
In-Reply-To: <20170321031635.22123-1-famz@redhat.com>
References: <20170321031635.22123-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 03/16] blockjob: Add
 BLK_PERM_AIO_CONTEXT_CHANGE shared perm on bs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 blockjob.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/blockjob.c b/blockjob.c
index 69126af..3fd84b7 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -197,6 +197,9 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
         }
     }
 
+    /* The notifier we'll register on @blk takes care of following context
+     * change, so permit it. */
+    shared_perm |= BLK_PERM_AIO_CONTEXT_CHANGE;
     blk = blk_new(perm, shared_perm);
     ret = blk_insert_bs(blk, bs, errp);
     if (ret < 0) {
-- 
2.9.3
