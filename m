Received: from eggs.gnu.org ([2001:4830:134:3::10]:33990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDMPx-0000Kw-Qm
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDMPx-0006pR-2T
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:52:57 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 24 May 2017 10:52:22 +0800
Message-Id: <20170524025235.32190-4-famz@redhat.com>
In-Reply-To: <20170524025235.32190-1-famz@redhat.com>
References: <20170524025235.32190-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 03/16] blockjob: Add
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 blockjob.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/blockjob.c b/blockjob.c
index 6e48932..b20fb86 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -214,6 +214,9 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
         }
     }
 
+    /* The notifier we'll register on @blk takes care of following context
+     * change, so permit it. */
+    shared_perm |= BLK_PERM_AIO_CONTEXT_CHANGE;
     blk = blk_new(perm, shared_perm);
     ret = blk_insert_bs(blk, bs, errp);
     if (ret < 0) {
-- 
2.9.4
