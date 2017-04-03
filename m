Received: from eggs.gnu.org ([2001:4830:134:3::10]:39177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cv7ti-0005Gp-Ve
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cv7tg-00039j-BL
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:44:19 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:32812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cv7tg-00039E-5Q
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:44:16 -0400
Received: by mail-wr0-x242.google.com with SMTP id u18so36374395wrc.0
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 12:44:16 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Apr 2017 21:44:04 +0200
Message-Id: <20170403194409.21276-2-pbonzini@redhat.com>
In-Reply-To: <20170403194409.21276-1-pbonzini@redhat.com>
References: <20170403194409.21276-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 1/6] iscsi: drop unused IscsiAIOCB.qiov field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>

From: Stefan Hajnoczi <stefanha@redhat.com>

The IscsiAIOCB.qiov field has been unused since commit
063c3378a9e3c25cc0afac3c72e4823d0621e352 ("block/iscsi: introduce
bdrv_co_{readv, writev, flush_to_disk}") back in 2013.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20170327165005.22038-1-stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
1.8.3.1
