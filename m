Received: from eggs.gnu.org ([2001:4830:134:3::10]:53771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOV3t-0000i8-69
	for qemu-devel@nongnu.org; Thu, 31 May 2018 17:24:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOV3s-0005tn-AD
	for qemu-devel@nongnu.org; Thu, 31 May 2018 17:24:45 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 31 May 2018 16:24:35 -0500
Message-Id: <20180531212435.165261-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] block: Ignore generated job QAPI files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

Commit bf42508f introduced new generated files; make sure they
don't get accidentally committed from an in-tree build.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 .gitignore | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitignore b/.gitignore
index 81e1f2fb0f1..9da3b3e6267 100644
--- a/.gitignore
+++ b/.gitignore
@@ -36,6 +36,7 @@
 /qapi/qapi-commands-common.[ch]
 /qapi/qapi-commands-crypto.[ch]
 /qapi/qapi-commands-introspect.[ch]
+/qapi/qapi-commands-job.[ch]
 /qapi/qapi-commands-migration.[ch]
 /qapi/qapi-commands-misc.[ch]
 /qapi/qapi-commands-net.[ch]
@@ -53,6 +54,7 @@
 /qapi/qapi-events-common.[ch]
 /qapi/qapi-events-crypto.[ch]
 /qapi/qapi-events-introspect.[ch]
+/qapi/qapi-events-job.[ch]
 /qapi/qapi-events-migration.[ch]
 /qapi/qapi-events-misc.[ch]
 /qapi/qapi-events-net.[ch]
@@ -71,6 +73,7 @@
 /qapi/qapi-types-common.[ch]
 /qapi/qapi-types-crypto.[ch]
 /qapi/qapi-types-introspect.[ch]
+/qapi/qapi-types-job.[ch]
 /qapi/qapi-types-migration.[ch]
 /qapi/qapi-types-misc.[ch]
 /qapi/qapi-types-net.[ch]
@@ -88,6 +91,7 @@
 /qapi/qapi-visit-common.[ch]
 /qapi/qapi-visit-crypto.[ch]
 /qapi/qapi-visit-introspect.[ch]
+/qapi/qapi-visit-job.[ch]
 /qapi/qapi-visit-migration.[ch]
 /qapi/qapi-visit-misc.[ch]
 /qapi/qapi-visit-net.[ch]
-- 
2.14.3
