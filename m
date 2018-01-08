Received: from eggs.gnu.org ([2001:4830:134:3::10]:33411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eYYQ5-0002r7-Gl
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:29:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eYYQ2-00067S-Nw
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:28:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51026
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eYYQ2-00066o-JE
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:28:54 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.21) with SMTP id
	w08ESnKK192073
	for <qemu-devel@nongnu.org>; Mon, 8 Jan 2018 09:28:53 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fc8cfpr5j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 09:28:52 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 8 Jan 2018 14:28:48 -0000
From: Greg Kurz <groug@kaod.org>
Date: Mon,  8 Jan 2018 15:28:22 +0100
In-Reply-To: <20180108142831.6638-1-groug@kaod.org>
References: <20180108142831.6638-1-groug@kaod.org>
Message-Id: <20180108142831.6638-6-groug@kaod.org>
Subject: [Qemu-devel] [PULL 05/14] 9pfs: handle: fix type definition
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
 hw/9pfs/9p-handle.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/hw/9pfs/9p-handle.c b/hw/9pfs/9p-handle.c
index 9875f1894cc5..65b12de230c1 100644
--- a/hw/9pfs/9p-handle.c
+++ b/hw/9pfs/9p-handle.c
@@ -41,10 +41,10 @@
 #define BTRFS_SUPER_MAGIC 0x9123683E
 #endif
 
-struct handle_data {
+typedef struct HandleData {
     int mountfd;
     int handle_bytes;
-};
+} HandleData;
 
 static inline int name_to_handle(int dirfd, const char *name,
                                  struct file_handle *fh, int *mnt_id, int flags)
@@ -79,7 +79,7 @@ static int handle_lstat(FsContext *fs_ctx, V9fsPath *fs_path,
                         struct stat *stbuf)
 {
     int fd, ret;
-    struct handle_data *data = (struct handle_data *)fs_ctx->private;
+    HandleData *data = (HandleData *) fs_ctx->private;
 
     fd = open_by_handle(data->mountfd, fs_path->data, O_PATH);
     if (fd < 0) {
@@ -94,7 +94,7 @@ static ssize_t handle_readlink(FsContext *fs_ctx, V9fsPath *fs_path,
                                char *buf, size_t bufsz)
 {
     int fd, ret;
-    struct handle_data *data = (struct handle_data *)fs_ctx->private;
+    HandleData *data = (HandleData *) fs_ctx->private;
 
     fd = open_by_handle(data->mountfd, fs_path->data, O_PATH);
     if (fd < 0) {
@@ -118,7 +118,7 @@ static int handle_closedir(FsContext *ctx, V9fsFidOpenState *fs)
 static int handle_open(FsContext *ctx, V9fsPath *fs_path,
                        int flags, V9fsFidOpenState *fs)
 {
-    struct handle_data *data = (struct handle_data *)ctx->private;
+    HandleData *data = (HandleData *) ctx->private;
 
     fs->fd = open_by_handle(data->mountfd, fs_path->data, flags);
     return fs->fd;
@@ -207,7 +207,7 @@ static ssize_t handle_pwritev(FsContext *ctx, V9fsFidOpenState *fs,
 static int handle_chmod(FsContext *fs_ctx, V9fsPath *fs_path, FsCred *credp)
 {
     int fd, ret;
-    struct handle_data *data = (struct handle_data *)fs_ctx->private;
+    HandleData *data = (HandleData *) fs_ctx->private;
 
     fd = open_by_handle(data->mountfd, fs_path->data, O_NONBLOCK);
     if (fd < 0) {
@@ -222,7 +222,7 @@ static int handle_mknod(FsContext *fs_ctx, V9fsPath *dir_path,
                        const char *name, FsCred *credp)
 {
     int dirfd, ret;
-    struct handle_data *data = (struct handle_data *)fs_ctx->private;
+    HandleData *data = (HandleData *) fs_ctx->private;
 
     dirfd = open_by_handle(data->mountfd, dir_path->data, O_PATH);
     if (dirfd < 0) {
@@ -240,7 +240,7 @@ static int handle_mkdir(FsContext *fs_ctx, V9fsPath *dir_path,
                        const char *name, FsCred *credp)
 {
     int dirfd, ret;
-    struct handle_data *data = (struct handle_data *)fs_ctx->private;
+    HandleData *data = (HandleData *) fs_ctx->private;
 
     dirfd = open_by_handle(data->mountfd, dir_path->data, O_PATH);
     if (dirfd < 0) {
@@ -272,7 +272,7 @@ static int handle_open2(FsContext *fs_ctx, V9fsPath *dir_path, const char *name,
 {
     int ret;
     int dirfd, fd;
-    struct handle_data *data = (struct handle_data *)fs_ctx->private;
+    HandleData *data = (HandleData *) fs_ctx->private;
 
     dirfd = open_by_handle(data->mountfd, dir_path->data, O_PATH);
     if (dirfd < 0) {
@@ -297,7 +297,7 @@ static int handle_symlink(FsContext *fs_ctx, const char *oldpath,
                           V9fsPath *dir_path, const char *name, FsCred *credp)
 {
     int fd, dirfd, ret;
-    struct handle_data *data = (struct handle_data *)fs_ctx->private;
+    HandleData *data = (HandleData *) fs_ctx->private;
 
     dirfd = open_by_handle(data->mountfd, dir_path->data, O_PATH);
     if (dirfd < 0) {
@@ -322,7 +322,7 @@ static int handle_link(FsContext *ctx, V9fsPath *oldpath,
                        V9fsPath *dirpath, const char *name)
 {
     int oldfd, newdirfd, ret;
-    struct handle_data *data = (struct handle_data *)ctx->private;
+    HandleData *data = (HandleData *) ctx->private;
 
     oldfd = open_by_handle(data->mountfd, oldpath->data, O_PATH);
     if (oldfd < 0) {
@@ -342,7 +342,7 @@ static int handle_link(FsContext *ctx, V9fsPath *oldpath,
 static int handle_truncate(FsContext *ctx, V9fsPath *fs_path, off_t size)
 {
     int fd, ret;
-    struct handle_data *data = (struct handle_data *)ctx->private;
+    HandleData *data = (HandleData *) ctx->private;
 
     fd = open_by_handle(data->mountfd, fs_path->data, O_NONBLOCK | O_WRONLY);
     if (fd < 0) {
@@ -363,7 +363,7 @@ static int handle_rename(FsContext *ctx, const char *oldpath,
 static int handle_chown(FsContext *fs_ctx, V9fsPath *fs_path, FsCred *credp)
 {
     int fd, ret;
-    struct handle_data *data = (struct handle_data *)fs_ctx->private;
+    HandleData *data = (HandleData *) fs_ctx->private;
 
     fd = open_by_handle(data->mountfd, fs_path->data, O_PATH);
     if (fd < 0) {
@@ -379,7 +379,7 @@ static int handle_utimensat(FsContext *ctx, V9fsPath *fs_path,
 {
     int ret;
     int fd;
-    struct handle_data *data = (struct handle_data *)ctx->private;
+    HandleData *data = (HandleData *) ctx->private;
 
     fd = open_by_handle(data->mountfd, fs_path->data, O_NONBLOCK);
     if (fd < 0) {
@@ -418,7 +418,7 @@ static int handle_statfs(FsContext *ctx, V9fsPath *fs_path,
                          struct statfs *stbuf)
 {
     int fd, ret;
-    struct handle_data *data = (struct handle_data *)ctx->private;
+    HandleData *data = (HandleData *) ctx->private;
 
     fd = open_by_handle(data->mountfd, fs_path->data, O_NONBLOCK);
     if (fd < 0) {
@@ -433,7 +433,7 @@ static ssize_t handle_lgetxattr(FsContext *ctx, V9fsPath *fs_path,
                                 const char *name, void *value, size_t size)
 {
     int fd, ret;
-    struct handle_data *data = (struct handle_data *)ctx->private;
+    HandleData *data = (HandleData *) ctx->private;
 
     fd = open_by_handle(data->mountfd, fs_path->data, O_NONBLOCK);
     if (fd < 0) {
@@ -448,7 +448,7 @@ static ssize_t handle_llistxattr(FsContext *ctx, V9fsPath *fs_path,
                                  void *value, size_t size)
 {
     int fd, ret;
-    struct handle_data *data = (struct handle_data *)ctx->private;
+    HandleData *data = (HandleData *) ctx->private;
 
     fd = open_by_handle(data->mountfd, fs_path->data, O_NONBLOCK);
     if (fd < 0) {
@@ -463,7 +463,7 @@ static int handle_lsetxattr(FsContext *ctx, V9fsPath *fs_path, const char *name,
                             void *value, size_t size, int flags)
 {
     int fd, ret;
-    struct handle_data *data = (struct handle_data *)ctx->private;
+    HandleData *data = (HandleData *) ctx->private;
 
     fd = open_by_handle(data->mountfd, fs_path->data, O_NONBLOCK);
     if (fd < 0) {
@@ -478,7 +478,7 @@ static int handle_lremovexattr(FsContext *ctx, V9fsPath *fs_path,
                                const char *name)
 {
     int fd, ret;
-    struct handle_data *data = (struct handle_data *)ctx->private;
+    HandleData *data = (HandleData *) ctx->private;
 
     fd = open_by_handle(data->mountfd, fs_path->data, O_NONBLOCK);
     if (fd < 0) {
@@ -495,7 +495,7 @@ static int handle_name_to_path(FsContext *ctx, V9fsPath *dir_path,
     char *buffer;
     struct file_handle *fh;
     int dirfd, ret, mnt_id;
-    struct handle_data *data = (struct handle_data *)ctx->private;
+    HandleData *data = (HandleData *) ctx->private;
 
     /* "." and ".." are not allowed */
     if (!strcmp(name, ".") || !strcmp(name, "..")) {
@@ -536,7 +536,7 @@ static int handle_renameat(FsContext *ctx, V9fsPath *olddir,
                            const char *new_name)
 {
     int olddirfd, newdirfd, ret;
-    struct handle_data *data = (struct handle_data *)ctx->private;
+    HandleData *data = (HandleData *) ctx->private;
 
     olddirfd = open_by_handle(data->mountfd, olddir->data, O_PATH);
     if (olddirfd < 0) {
@@ -557,7 +557,7 @@ static int handle_unlinkat(FsContext *ctx, V9fsPath *dir,
                            const char *name, int flags)
 {
     int dirfd, ret;
-    struct handle_data *data = (struct handle_data *)ctx->private;
+    HandleData *data = (HandleData *) ctx->private;
     int rflags;
 
     dirfd = open_by_handle(data->mountfd, dir->data, O_PATH);
@@ -609,7 +609,7 @@ static int handle_init(FsContext *ctx)
     int ret, mnt_id;
     struct statfs stbuf;
     struct file_handle fh;
-    struct handle_data *data = g_malloc(sizeof(struct handle_data));
+    HandleData *data = g_malloc(sizeof(HandleData));
 
     data->mountfd = open(ctx->fs_root, O_DIRECTORY);
     if (data->mountfd < 0) {
@@ -646,7 +646,7 @@ out:
 
 static void handle_cleanup(FsContext *ctx)
 {
-    struct handle_data *data = ctx->private;
+    HandleData *data = ctx->private;
 
     close(data->mountfd);
     g_free(data);
-- 
2.13.6
