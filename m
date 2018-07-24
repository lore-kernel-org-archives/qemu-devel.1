Received: from eggs.gnu.org ([2001:4830:134:3::10]:46154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fi3Xk-0006yY-8N
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 16:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fi3Xh-0007oO-5h
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 16:04:24 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Tue, 24 Jul 2018 23:03:43 +0300
Message-Id: <20180724200343.13733-6-lbloch@janustech.com>
In-Reply-To: <20180724200343.13733-1-lbloch@janustech.com>
References: <20180724200343.13733-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 5/5] docs: Document the l2-cache-full option
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

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
---
 docs/qcow2-cache.txt | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
index 9d261b7da9..ea61585a4b 100644
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
 
@@ -130,6 +131,12 @@ There are a few things that need to be taken into account:
    memory as possible to the L2 cache before increasing the refcount
    cache size.
 
+- If "l2-cache-full" is specified, QEMU will assign enough memory
+  to the L2 cache to cover the entire size of the image.
+
+- "l2-cache-size" and "l2-cache-full" can not be set simultaneously, as
+  setting "l2-cache-full" already implies a specific size for the L2 cache.
+
 - All three "l2-cache-size", "refcount-cache-size", and "cache-size" options
   can not be set simultaneously.
 
-- 
2.14.1
