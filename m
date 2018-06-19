Received: from eggs.gnu.org ([2001:4830:134:3::10]:45215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hQ-00010X-TY
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hP-000844-Ti
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:44:48 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:41:27 -0500
Message-Id: <20180619014319.28272-2-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 001/113] block/ssh: fix possible segmentation
 fault when .desc is not null-terminated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>

From: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>

This patch prevents a possible segmentation fault when .desc members are checked
against NULL.

The ssh_runtime_opts was added by commit
8a6a80896d6af03b8ee0c17cdf37219eca2588a7 ("block/ssh: Use QemuOpts for runtime
options").

This fix was inspired by
http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg00883.html.

Fixes: 8a6a80896d6af03b8ee0c17cdf37219eca2588a7 ("block/ssh: Use QemuOpts for runtime options")
Cc: Max Reitz <mreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
(cherry picked from commit fbd5c4c0db47e578e3fdd88a0ebc4314a1ed3d42)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/ssh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/ssh.c b/block/ssh.c
index b049a16eb9..8890a0c4ba 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -556,6 +556,7 @@ static QemuOptsList ssh_runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "Defines how and what to check the host key against",
         },
+        { /* end of list */ }
     },
 };
 
-- 
2.11.0
