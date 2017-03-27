Received: from eggs.gnu.org ([2001:4830:134:3::10]:41323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1csXqT-00069t-GN
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:50:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1csXqS-0007RF-KV
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:50:17 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 27 Mar 2017 17:50:05 +0100
Message-Id: <20170327165005.22038-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] iscsi: drop unused IscsiAIOCB.qiov field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>, Stefan Hajnoczi <stefanha@redhat.com>

The IscsiAIOCB.qiov field has been unused since commit
063c3378a9e3c25cc0afac3c72e4823d0621e352 ("block/iscsi: introduce
bdrv_co_{readv, writev, flush_to_disk}") back in 2013.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/iscsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 75d8905..716e74a 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -103,7 +103,6 @@ typedef struct IscsiTask {
 
 typedef struct IscsiAIOCB {
     BlockAIOCB common;
-    QEMUIOVector *qiov;
     QEMUBH *bh;
     IscsiLun *iscsilun;
     struct scsi_task *task;
-- 
2.9.3
