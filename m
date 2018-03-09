Received: from eggs.gnu.org ([2001:4830:134:3::10]:33387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKks-0000zk-9e
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKkp-0006ir-7e
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:26 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:18:54 +0100
Message-Id: <20180309161933.8168-18-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 17/56] qcow2: Rename qcow2_co_create2() to
 qcow2_co_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

The functions originally known as qcow2_create() and qcow2_create2()
are now called qcow2_co_create_opts() and qcow2_co_create(), which
matches the names of the BlockDriver callbacks that they will implement
at the end of this patch series.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 369e374a9b..b7354a27a1 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2761,11 +2761,11 @@ static uint64_t qcow2_opt_get_refcount_bits_del(QemuOpts *opts, int version,
 }
 
 static int coroutine_fn
-qcow2_co_create2(const char *filename, int64_t total_size,
-                 const char *backing_file, const char *backing_format,
-                 int flags, size_t cluster_size, PreallocMode prealloc,
-                 QemuOpts *opts, int version, int refcount_order,
-                 const char *encryptfmt, Error **errp)
+qcow2_co_create(const char *filename, int64_t total_size,
+                const char *backing_file, const char *backing_format,
+                int flags, size_t cluster_size, PreallocMode prealloc,
+                QemuOpts *opts, int version, int refcount_order,
+                const char *encryptfmt, Error **errp)
 {
     QDict *options;
 
@@ -3034,9 +3034,9 @@ static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpts *opt
 
     refcount_order = ctz32(refcount_bits);
 
-    ret = qcow2_co_create2(filename, size, backing_file, backing_fmt, flags,
-                           cluster_size, prealloc, opts, version, refcount_order,
-                           encryptfmt, &local_err);
+    ret = qcow2_co_create(filename, size, backing_file, backing_fmt, flags,
+                          cluster_size, prealloc, opts, version, refcount_order,
+                          encryptfmt, &local_err);
     error_propagate(errp, local_err);
 
 finish:
-- 
2.13.6
