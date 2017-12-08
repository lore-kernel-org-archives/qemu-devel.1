Received: from eggs.gnu.org ([2001:4830:134:3::10]:44721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eNGCy-0002tf-Rf
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:48:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eNGCu-0005y0-RU
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:48:44 -0500
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:56777)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eNGCu-0005w8-Lu
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:48:40 -0500
Received: from player739.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 0643B924FD
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 11:48:38 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 08 Dec 2017 11:48:36 +0100
Message-ID: <151273011641.18940.11537202217846631376.stgit@bahia.lan>
In-Reply-To: <151273008711.18940.15284049324681529367.stgit@bahia.lan>
References: <151273008711.18940.15284049324681529367.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 3/5] fsdev: fix some type definitions
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
 fsdev/file-op-9p.h |   27 ++++++++++++---------------
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
