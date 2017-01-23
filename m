Received: from eggs.gnu.org ([2001:4830:134:3::10]:41207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cVdn7-00049K-PD
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:32:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cVdn6-0005ux-SV
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:32:09 -0500
From: Fam Zheng <famz@redhat.com>
Date: Mon, 23 Jan 2017 20:30:43 +0800
Message-Id: <20170123123056.30383-4-famz@redhat.com>
In-Reply-To: <20170123123056.30383-1-famz@redhat.com>
References: <20170123123056.30383-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v12 03/16] qemu-io: Set "share-rw" flag
 together with read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com, Max Reitz <mreitz@redhat.com>

qemu-io is a low level tool to read or modify guest visible data, which
implies the user knows very well what is being done. Allowing reading
from a locked image is harmless in most cases, so do it.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qemu-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/qemu-io.c b/qemu-io.c
index 23a229f..f000504 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -585,6 +585,8 @@ int main(int argc, char **argv)
     /* open the device */
     if (!readonly) {
         flags |= BDRV_O_RDWR;
+    } else {
+        flags |= BDRV_O_SHARE_RW;
     }
 
     if ((argc - optind) == 1) {
-- 
2.9.3
