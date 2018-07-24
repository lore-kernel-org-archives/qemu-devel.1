Received: from eggs.gnu.org ([2001:4830:134:3::10]:43192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fi0iQ-00019T-0y
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fi0iM-0004w5-O3
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:03:14 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Tue, 24 Jul 2018 20:02:17 +0300
Message-Id: <20180724170217.10247-3-lbloch@janustech.com>
In-Reply-To: <20180724170217.10247-1-lbloch@janustech.com>
References: <20180724170217.10247-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 2/2] docs: Document the l2-cache-full option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Leonid Bloch <lbloch@janustech.com>

This documents the new "l2-cache-full" option, and sharpens the
documentation of the related options.

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
---
 docs/qcow2-cache.txt | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
index 8a09a5cc5f..ea61585a4b 100644
--- a/docs/qcow2-cache.txt
+++ b/docs/qcow2-cache.txt
@@ -110,11 +110,12 @@ How to configure the cache sizes
 Cache sizes can be configured using the -drive option in the
 command-line, or the 'blockdev-add' QMP command.
 
-There are three options available, and all of them take bytes:
+There are four options available:
 
-"l2-cache-size":         maximum size of the L2 table cache
-"refcount-cache-size":   maximum size of the refcount block cache
-"cache-size":            maximum size of both caches combined
+"l2-cache-size":         maximum size of the L2 table cache (bytes, K, M)
+"refcount-cache-size":   maximum size of the refcount block cache (bytes, K, M)
+"cache-size":            maximum size of both caches combined (bytes, K, M)
+"l2-cache-full":         make the L2 cache cover the full image (boolean)
 
 There are a few things that need to be taken into account:
 
@@ -130,6 +131,15 @@ There are a few things that need to be taken into account:
    memory as possible to the L2 cache before increasing the refcount
    cache size.
 
+- If "l2-cache-full" is specified, QEMU will assign enough memory
+  to the L2 cache to cover the entire size of the image.
+
+- "l2-cache-size" and "l2-cache-full" can not be set simultaneously, as
+  setting "l2-cache-full" already implies a specific size for the L2 cache.
+
+- All three "l2-cache-size", "refcount-cache-size", and "cache-size" options
+  can not be set simultaneously.
+
 Unlike L2 tables, refcount blocks are not used during normal I/O but
 only during allocations and internal snapshots. In most cases they are
 accessed sequentially (even during random guest I/O) so increasing the
-- 
2.14.1
