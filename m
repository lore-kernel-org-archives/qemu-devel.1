Received: from eggs.gnu.org ([2001:4830:134:3::10]:44107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fxab2-0005eV-Cw
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 12:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fxaQ2-0008H1-Qb
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 12:12:42 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fxaQ2-0008Ei-KA
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 12:12:38 -0400
Received: by mail-pf1-x442.google.com with SMTP id i26-v6so3709806pfo.12
	for <qemu-devel@nongnu.org>; Wed, 05 Sep 2018 09:12:37 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed,  5 Sep 2018 16:12:00 +0000
Message-Id: <1536163920-2443-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH] docs/block-replication.txt: Add more detail
 about replication_do_checkpoint_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Wen Congyang <wencongyang2@huawei.com>, xie Changlong <xiechanglong.d@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Add more detail description for COLO checkpoint use case.
Suggested by Dr. David Alan Gilbert <dgilbert@redhat.com>

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 docs/block-replication.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/docs/block-replication.txt b/docs/block-replication.txt
index 6bde6737fb..b6c5e94764 100644
--- a/docs/block-replication.txt
+++ b/docs/block-replication.txt
@@ -131,9 +131,10 @@ a. replication_start_all()
    thread.
 b. replication_do_checkpoint_all()
    This interface is called after all VM state is transferred to
-   Secondary QEMU. The Disk buffer will be dropped in this interface.
-   The caller must hold the I/O mutex lock if it is in migration/checkpoint
-   thread.
+   secondary node, and in primary node this interface no need to
+   called after synchronizing all the states. The Disk buffer will be dropped
+   in this interface. The caller must hold the I/O mutex lock if it is
+   in migration/checkpoint thread.
 c. replication_get_error_all()
    This interface is called to check if error happened in replication.
    The caller must hold the I/O mutex lock if it is in migration/checkpoint
-- 
2.17.GIT
