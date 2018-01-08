Received: from eggs.gnu.org ([2001:4830:134:3::10]:33426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eYYQ7-0002sd-Ip
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:29:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eYYQ4-00068u-RS
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:28:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eYYQ4-00068S-IU
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:28:56 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.21) with SMTP id
	w08ESmpo071591
	for <qemu-devel@nongnu.org>; Mon, 8 Jan 2018 09:28:55 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fc7juga8g-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 09:28:54 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 8 Jan 2018 14:28:49 -0000
From: Greg Kurz <groug@kaod.org>
Date: Mon,  8 Jan 2018 15:28:19 +0100
In-Reply-To: <20180108142831.6638-1-groug@kaod.org>
References: <20180108142831.6638-1-groug@kaod.org>
Message-Id: <20180108142831.6638-3-groug@kaod.org>
Subject: [Qemu-devel] [PULL 02/14] 9pfs: fix XattrOperations typedef
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

To comply with the QEMU coding style.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fsdev/file-op-9p.h | 5 +++--
 hw/9pfs/9p-xattr.h | 5 ++---
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
-- 
2.13.6
