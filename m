Received: from eggs.gnu.org ([2001:4830:134:3::10]:44684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eNGCr-0002oA-By
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:48:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eNGCn-0005pL-GH
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:48:37 -0500
Received: from 6.mo173.mail-out.ovh.net ([46.105.43.93]:34268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eNGCn-0005ob-9M
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:48:33 -0500
Received: from player739.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 7DE51924DE
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 11:48:31 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 08 Dec 2017 11:48:28 +0100
Message-ID: <151273010895.18940.16168709206818260818.stgit@bahia.lan>
In-Reply-To: <151273008711.18940.15284049324681529367.stgit@bahia.lan>
References: <151273008711.18940.15284049324681529367.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2/5] 9pfs: fix XattrOperations typedef
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Greg Kurz <groug@kaod.org>

To comply with the QEMU coding style.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fsdev/file-op-9p.h |    5 +++--
 hw/9pfs/9p-xattr.h |    5 ++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index 474c79d003f6..05b3ef357462 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -30,7 +30,6 @@ typedef struct FsCred
     dev_t   fc_rdev;
 } FsCred;
 
-struct xattr_operations;
 struct FsContext;
 struct V9fsPath;
 
@@ -67,6 +66,8 @@ typedef struct extended_ops {
 
 
 typedef struct FileOperations FileOperations;
+typedef struct XattrOperations XattrOperations;
+
 /*
  * Structure to store the various fsdev's passed through command line.
  */
@@ -85,7 +86,7 @@ typedef struct FsContext
     uid_t uid;
     char *fs_root;
     int export_flags;
-    struct xattr_operations **xops;
+    XattrOperations **xops;
     struct extended_ops exops;
     FsThrottle *fst;
     /* fs driver specific data */
diff --git a/hw/9pfs/9p-xattr.h b/hw/9pfs/9p-xattr.h
index 0d83996575e1..35bcd24f77b1 100644
--- a/hw/9pfs/9p-xattr.h
+++ b/hw/9pfs/9p-xattr.h
@@ -16,8 +16,7 @@
 
 #include "qemu/xattr.h"
 
-typedef struct xattr_operations
-{
+struct XattrOperations {
     const char *name;
     ssize_t (*getxattr)(FsContext *ctx, const char *path,
                         const char *name, void *value, size_t size);
@@ -27,7 +26,7 @@ typedef struct xattr_operations
                     void *value, size_t size, int flags);
     int (*removexattr)(FsContext *ctx,
                        const char *path, const char *name);
-} XattrOperations;
+};
 
 ssize_t local_getxattr_nofollow(FsContext *ctx, const char *path,
                                 const char *name, void *value, size_t size);
