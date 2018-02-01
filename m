Received: from eggs.gnu.org ([2001:4830:134:3::10]:40635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eh696-0000WS-0X
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 23:06:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eh695-0008O9-2T
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 23:06:44 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 31 Jan 2018 23:06:34 -0500
Message-Id: <20180201040635.5749-2-jcody@redhat.com>
In-Reply-To: <20180201040635.5749-1-jcody@redhat.com>
References: <20180201040635.5749-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] block/ssh: fix possible segmentation fault
 when .desc is not null-terminated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

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
---
 block/ssh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/ssh.c b/block/ssh.c
index b049a16..8890a0c 100644
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
2.9.5
