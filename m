Received: from eggs.gnu.org ([2001:4830:134:3::10]:56650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eXcy2-0007BP-DY
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 20:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eXcxz-0006EM-1z
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 20:08:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eXcxy-0006Cw-GO
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 20:08:06 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w0614eTN115939
	for <qemu-devel@nongnu.org>; Fri, 5 Jan 2018 20:08:04 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fam3y8qkh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 20:08:04 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Sat, 6 Jan 2018 01:08:02 -0000
From: Greg Kurz <groug@kaod.org>
Date: Sat,  6 Jan 2018 02:07:30 +0100
In-Reply-To: <20180106010739.18201-1-groug@kaod.org>
References: <20180106010739.18201-1-groug@kaod.org>
Message-Id: <20180106010739.18201-4-groug@kaod.org>
Subject: [Qemu-devel] [PULL 03/12] fsdev: fix some type definitions
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
 fsdev/file-op-9p.h | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index 05b3ef357462..63d19a6dcd0e 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -22,21 +22,19 @@
 #define SM_LOCAL_MODE_BITS    0600
 #define SM_LOCAL_DIR_MODE_BITS    0700
 
-typedef struct FsCred
-{
+typedef struct FsCred {
     uid_t   fc_uid;
     gid_t   fc_gid;
     mode_t  fc_mode;
     dev_t   fc_rdev;
 } FsCred;
 
-struct FsContext;
-struct V9fsPath;
+typedef struct FsContext FsContext;
+typedef struct V9fsPath V9fsPath;
 
-typedef struct extended_ops {
-    int (*get_st_gen)(struct FsContext *, struct V9fsPath *,
-                      mode_t, uint64_t *);
-} extended_ops;
+typedef struct ExtendedOps {
+    int (*get_st_gen)(FsContext *, V9fsPath *, mode_t, uint64_t *);
+} ExtendedOps;
 
 /* export flags */
 #define V9FS_IMMEDIATE_WRITEOUT     0x00000001
@@ -81,19 +79,18 @@ typedef struct FsDriverEntry {
     mode_t dmode;
 } FsDriverEntry;
 
-typedef struct FsContext
-{
+struct FsContext {
     uid_t uid;
     char *fs_root;
     int export_flags;
     XattrOperations **xops;
-    struct extended_ops exops;
+    ExtendedOps exops;
     FsThrottle *fst;
     /* fs driver specific data */
     void *private;
     mode_t fmode;
     mode_t dmode;
-} FsContext;
+};
 
 typedef struct V9fsPath {
     uint16_t size;
@@ -106,9 +103,9 @@ void cred_init(FsCred *);
 
 struct FileOperations
 {
-    int (*parse_opts)(QemuOpts *, struct FsDriverEntry *);
-    int (*init)(struct FsContext *);
-    void (*cleanup)(struct FsContext *);
+    int (*parse_opts)(QemuOpts *, FsDriverEntry *);
+    int (*init)(FsContext *);
+    void (*cleanup)(FsContext *);
     int (*lstat)(FsContext *, V9fsPath *, struct stat *);
     ssize_t (*readlink)(FsContext *, V9fsPath *, char *, size_t);
     int (*chmod)(FsContext *, V9fsPath *, FsCred *);
-- 
2.13.6
