Received: from eggs.gnu.org ([2001:4830:134:3::10]:59012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Pgs-0006K7-DQ
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 23:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Pgr-00042b-Jw
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 23:57:02 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 21 Apr 2017 11:56:01 +0800
Message-Id: <20170421035606.448-16-famz@redhat.com>
In-Reply-To: <20170421035606.448-1-famz@redhat.com>
References: <20170421035606.448-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v14 15/20] file-posix: Add 'locking' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Making this option available even before implementing it will let
converting tests easier: in coming patches they can specify the option
already when necessary, before we actually write code to lock the
images.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/file-posix.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index ade71db..2114720 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -392,6 +392,11 @@ static QemuOptsList raw_runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "host AIO implementation (threads, native)",
         },
+        {
+            .name = "locking",
+            .type = QEMU_OPT_BOOL,
+            .help = "lock the file",
+        },
         { /* end of list */ }
     },
 };
-- 
2.9.3
