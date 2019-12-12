Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0C9C2D0CA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF0A22527
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwwpGOXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF0A22527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifRdi-00061Y-Gh
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 11:48:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRUv-0004wH-6E
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRUj-0000j2-QC
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:28 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27324
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRUj-0000ht-AP
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CMB36U/SwxQAKATWcsMr06x2qAsIoApgCf9PCzijbkg=;
 b=GwwpGOXZrkrVEUItCsE+wM/YKyrWx90qAz3UIqW6Rg79MPIstRHk1TXmd8QWIZlwztx7PS
 6dwSjFhc9surqsaqE847FKuWjPtda/mMo25jcVrN3L2ZfHJ7KDlHZ7T6b2nTxoPd0r9xoh
 Zc2NQwQXorpWrDVKQcPuHAbiT6+T2h0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-Pk_bVIxVMAqklUjCfMV05A-1; Thu, 12 Dec 2019 11:39:13 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED4071005516
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:39:12 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5BD4A60BE1;
 Thu, 12 Dec 2019 16:39:11 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 001/104] virtiofsd: Pull in upstream headers
Date: Thu, 12 Dec 2019 16:37:21 +0000
Message-Id: <20191212163904.159893-2-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Pk_bVIxVMAqklUjCfMV05A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Pull in headers fromlibfuse's upstream fuse-3.8.0

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse.h                | 1275 +++++++++++++++
 tools/virtiofsd/fuse_common.h         |  823 ++++++++++
 tools/virtiofsd/fuse_i.h              |  139 ++
 tools/virtiofsd/fuse_log.h            |   82 +
 tools/virtiofsd/fuse_lowlevel.h       | 2089 +++++++++++++++++++++++++
 tools/virtiofsd/fuse_misc.h           |   59 +
 tools/virtiofsd/fuse_opt.h            |  271 ++++
 tools/virtiofsd/passthrough_helpers.h |   76 +
 8 files changed, 4814 insertions(+)
 create mode 100644 tools/virtiofsd/fuse.h
 create mode 100644 tools/virtiofsd/fuse_common.h
 create mode 100644 tools/virtiofsd/fuse_i.h
 create mode 100644 tools/virtiofsd/fuse_log.h
 create mode 100644 tools/virtiofsd/fuse_lowlevel.h
 create mode 100644 tools/virtiofsd/fuse_misc.h
 create mode 100644 tools/virtiofsd/fuse_opt.h
 create mode 100644 tools/virtiofsd/passthrough_helpers.h

diff --git a/tools/virtiofsd/fuse.h b/tools/virtiofsd/fuse.h
new file mode 100644
index 0000000000..883f6e59fb
--- /dev/null
+++ b/tools/virtiofsd/fuse.h
@@ -0,0 +1,1275 @@
+/*
+  FUSE: Filesystem in Userspace
+  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+
+  This program can be distributed under the terms of the GNU LGPLv2.
+  See the file COPYING.LIB.
+*/
+
+#ifndef FUSE_H_
+#define FUSE_H_
+
+/** @file
+ *
+ * This file defines the library interface of FUSE
+ *
+ * IMPORTANT: you should define FUSE_USE_VERSION before including this hea=
der.
+ */
+
+#include "fuse_common.h"
+
+#include <fcntl.h>
+#include <time.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/statvfs.h>
+#include <sys/uio.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/* ----------------------------------------------------------- *
+ * Basic FUSE API=09=09=09=09=09       *
+ * ----------------------------------------------------------- */
+
+/** Handle for a FUSE filesystem */
+struct fuse;
+
+/**
+ * Readdir flags, passed to ->readdir()
+ */
+enum fuse_readdir_flags {
+=09/**
+=09 * "Plus" mode.
+=09 *
+=09 * The kernel wants to prefill the inode cache during readdir.  The
+=09 * filesystem may honour this by filling in the attributes and setting
+=09 * FUSE_FILL_DIR_FLAGS for the filler function.  The filesystem may als=
o
+=09 * just ignore this flag completely.
+=09 */
+=09FUSE_READDIR_PLUS =3D (1 << 0),
+};
+
+enum fuse_fill_dir_flags {
+=09/**
+=09 * "Plus" mode: all file attributes are valid
+=09 *
+=09 * The attributes are used by the kernel to prefill the inode cache
+=09 * during a readdir.
+=09 *
+=09 * It is okay to set FUSE_FILL_DIR_PLUS if FUSE_READDIR_PLUS is not set
+=09 * and vice versa.
+=09 */
+=09FUSE_FILL_DIR_PLUS =3D (1 << 1),
+};
+
+/** Function to add an entry in a readdir() operation
+ *
+ * The *off* parameter can be any non-zero value that enables the
+ * filesystem to identify the current point in the directory
+ * stream. It does not need to be the actual physical position. A
+ * value of zero is reserved to indicate that seeking in directories
+ * is not supported.
+ *=20
+ * @param buf the buffer passed to the readdir() operation
+ * @param name the file name of the directory entry
+ * @param stat file attributes, can be NULL
+ * @param off offset of the next entry or zero
+ * @param flags fill flags
+ * @return 1 if buffer is full, zero otherwise
+ */
+typedef int (*fuse_fill_dir_t) (void *buf, const char *name,
+=09=09=09=09const struct stat *stbuf, off_t off,
+=09=09=09=09enum fuse_fill_dir_flags flags);
+/**
+ * Configuration of the high-level API
+ *
+ * This structure is initialized from the arguments passed to
+ * fuse_new(), and then passed to the file system's init() handler
+ * which should ensure that the configuration is compatible with the
+ * file system implementation.
+ */
+struct fuse_config {
+=09/**
+=09 * If `set_gid` is non-zero, the st_gid attribute of each file
+=09 * is overwritten with the value of `gid`.
+=09 */
+=09int set_gid;
+=09unsigned int gid;
+
+=09/**
+=09 * If `set_uid` is non-zero, the st_uid attribute of each file
+=09 * is overwritten with the value of `uid`.
+=09 */
+=09int set_uid;
+=09unsigned int uid;
+
+=09/**
+=09 * If `set_mode` is non-zero, the any permissions bits set in
+=09 * `umask` are unset in the st_mode attribute of each file.
+=09 */
+=09int set_mode;
+=09unsigned int umask;
+
+=09/**
+=09 * The timeout in seconds for which name lookups will be
+=09 * cached.
+=09 */
+=09double entry_timeout;
+
+=09/**
+=09 * The timeout in seconds for which a negative lookup will be
+=09 * cached. This means, that if file did not exist (lookup
+=09 * retuned ENOENT), the lookup will only be redone after the
+=09 * timeout, and the file/directory will be assumed to not
+=09 * exist until then. A value of zero means that negative
+=09 * lookups are not cached.
+=09 */
+=09double negative_timeout;
+
+=09/**
+=09 * The timeout in seconds for which file/directory attributes
+=09 * (as returned by e.g. the `getattr` handler) are cached.
+=09 */
+=09double attr_timeout;
+
+=09/**
+=09 * Allow requests to be interrupted
+=09 */
+=09int intr;
+
+=09/**
+=09 * Specify which signal number to send to the filesystem when
+=09 * a request is interrupted.  The default is hardcoded to
+=09 * USR1.
+=09 */
+=09int intr_signal;
+
+=09/**
+=09 * Normally, FUSE assigns inodes to paths only for as long as
+=09 * the kernel is aware of them. With this option inodes are
+=09 * instead remembered for at least this many seconds.  This
+=09 * will require more memory, but may be necessary when using
+=09 * applications that make use of inode numbers.
+=09 *
+=09 * A number of -1 means that inodes will be remembered for the
+=09 * entire life-time of the file-system process.
+=09 */
+=09int remember;
+
+=09/**
+=09 * The default behavior is that if an open file is deleted,
+=09 * the file is renamed to a hidden file (.fuse_hiddenXXX), and
+=09 * only removed when the file is finally released.  This
+=09 * relieves the filesystem implementation of having to deal
+=09 * with this problem. This option disables the hiding
+=09 * behavior, and files are removed immediately in an unlink
+=09 * operation (or in a rename operation which overwrites an
+=09 * existing file).
+=09 *
+=09 * It is recommended that you not use the hard_remove
+=09 * option. When hard_remove is set, the following libc
+=09 * functions fail on unlinked files (returning errno of
+=09 * ENOENT): read(2), write(2), fsync(2), close(2), f*xattr(2),
+=09 * ftruncate(2), fstat(2), fchmod(2), fchown(2)
+=09 */
+=09int hard_remove;
+
+=09/**
+=09 * Honor the st_ino field in the functions getattr() and
+=09 * fill_dir(). This value is used to fill in the st_ino field
+=09 * in the stat(2), lstat(2), fstat(2) functions and the d_ino
+=09 * field in the readdir(2) function. The filesystem does not
+=09 * have to guarantee uniqueness, however some applications
+=09 * rely on this value being unique for the whole filesystem.
+=09 *
+=09 * Note that this does *not* affect the inode that libfuse=20
+=09 * and the kernel use internally (also called the "nodeid").
+=09 */
+=09int use_ino;
+
+=09/**
+=09 * If use_ino option is not given, still try to fill in the
+=09 * d_ino field in readdir(2). If the name was previously
+=09 * looked up, and is still in the cache, the inode number
+=09 * found there will be used.  Otherwise it will be set to -1.
+=09 * If use_ino option is given, this option is ignored.
+=09 */
+=09int readdir_ino;
+
+=09/**
+=09 * This option disables the use of page cache (file content cache)
+=09 * in the kernel for this filesystem. This has several affects:
+=09 *
+=09 * 1. Each read(2) or write(2) system call will initiate one
+=09 *    or more read or write operations, data will not be
+=09 *    cached in the kernel.
+=09 *
+=09 * 2. The return value of the read() and write() system calls
+=09 *    will correspond to the return values of the read and
+=09 *    write operations. This is useful for example if the
+=09 *    file size is not known in advance (before reading it).
+=09 *
+=09 * Internally, enabling this option causes fuse to set the
+=09 * `direct_io` field of `struct fuse_file_info` - overwriting
+=09 * any value that was put there by the file system.
+=09 */
+=09int direct_io;
+
+=09/**
+=09 * This option disables flushing the cache of the file
+=09 * contents on every open(2).  This should only be enabled on
+=09 * filesystems where the file data is never changed
+=09 * externally (not through the mounted FUSE filesystem).  Thus
+=09 * it is not suitable for network filesystems and other
+=09 * intermediate filesystems.
+=09 *
+=09 * NOTE: if this option is not specified (and neither
+=09 * direct_io) data is still cached after the open(2), so a
+=09 * read(2) system call will not always initiate a read
+=09 * operation.
+=09 *
+=09 * Internally, enabling this option causes fuse to set the
+=09 * `keep_cache` field of `struct fuse_file_info` - overwriting
+=09 * any value that was put there by the file system.
+=09 */
+=09int kernel_cache;
+
+=09/**
+=09 * This option is an alternative to `kernel_cache`. Instead of
+=09 * unconditionally keeping cached data, the cached data is
+=09 * invalidated on open(2) if if the modification time or the
+=09 * size of the file has changed since it was last opened.
+=09 */
+=09int auto_cache;
+
+=09/**
+=09 * The timeout in seconds for which file attributes are cached
+=09 * for the purpose of checking if auto_cache should flush the
+=09 * file data on open.
+=09 */
+=09int ac_attr_timeout_set;
+=09double ac_attr_timeout;
+
+=09/**
+=09 * If this option is given the file-system handlers for the
+=09 * following operations will not receive path information:
+=09 * read, write, flush, release, fsync, readdir, releasedir,
+=09 * fsyncdir, lock, ioctl and poll.
+=09 *
+=09 * For the truncate, getattr, chmod, chown and utimens
+=09 * operations the path will be provided only if the struct
+=09 * fuse_file_info argument is NULL.
+=09 */
+=09int nullpath_ok;
+
+=09/**
+=09 * The remaining options are used by libfuse internally and
+=09 * should not be touched.
+=09 */
+=09int show_help;
+=09char *modules;
+=09int debug;
+};
+
+
+/**
+ * The file system operations:
+ *
+ * Most of these should work very similarly to the well known UNIX
+ * file system operations.  A major exception is that instead of
+ * returning an error in 'errno', the operation should return the
+ * negated error value (-errno) directly.
+ *
+ * All methods are optional, but some are essential for a useful
+ * filesystem (e.g. getattr).  Open, flush, release, fsync, opendir,
+ * releasedir, fsyncdir, access, create, truncate, lock, init and
+ * destroy are special purpose methods, without which a full featured
+ * filesystem can still be implemented.
+ *
+ * In general, all methods are expected to perform any necessary
+ * permission checking. However, a filesystem may delegate this task
+ * to the kernel by passing the `default_permissions` mount option to
+ * `fuse_new()`. In this case, methods will only be called if
+ * the kernel's permission check has succeeded.
+ *
+ * Almost all operations take a path which can be of any length.
+ */
+struct fuse_operations {
+=09/** Get file attributes.
+=09 *
+=09 * Similar to stat().  The 'st_dev' and 'st_blksize' fields are
+=09 * ignored. The 'st_ino' field is ignored except if the 'use_ino'
+=09 * mount option is given. In that case it is passed to userspace,
+=09 * but libfuse and the kernel will still assign a different
+=09 * inode for internal use (called the "nodeid").
+=09 *
+=09 * `fi` will always be NULL if the file is not currently open, but
+=09 * may also be NULL if the file is open.
+=09 */
+=09int (*getattr) (const char *, struct stat *, struct fuse_file_info *fi)=
;
+
+=09/** Read the target of a symbolic link
+=09 *
+=09 * The buffer should be filled with a null terminated string.  The
+=09 * buffer size argument includes the space for the terminating
+=09 * null character.=09If the linkname is too long to fit in the
+=09 * buffer, it should be truncated.=09The return value should be 0
+=09 * for success.
+=09 */
+=09int (*readlink) (const char *, char *, size_t);
+
+=09/** Create a file node
+=09 *
+=09 * This is called for creation of all non-directory, non-symlink
+=09 * nodes.  If the filesystem defines a create() method, then for
+=09 * regular files that will be called instead.
+=09 */
+=09int (*mknod) (const char *, mode_t, dev_t);
+
+=09/** Create a directory
+=09 *
+=09 * Note that the mode argument may not have the type specification
+=09 * bits set, i.e. S_ISDIR(mode) can be false.  To obtain the
+=09 * correct directory type bits use  mode|S_IFDIR
+=09 * */
+=09int (*mkdir) (const char *, mode_t);
+
+=09/** Remove a file */
+=09int (*unlink) (const char *);
+
+=09/** Remove a directory */
+=09int (*rmdir) (const char *);
+
+=09/** Create a symbolic link */
+=09int (*symlink) (const char *, const char *);
+
+=09/** Rename a file
+=09 *
+=09 * *flags* may be `RENAME_EXCHANGE` or `RENAME_NOREPLACE`. If
+=09 * RENAME_NOREPLACE is specified, the filesystem must not
+=09 * overwrite *newname* if it exists and return an error
+=09 * instead. If `RENAME_EXCHANGE` is specified, the filesystem
+=09 * must atomically exchange the two files, i.e. both must
+=09 * exist and neither may be deleted.
+=09 */
+=09int (*rename) (const char *, const char *, unsigned int flags);
+
+=09/** Create a hard link to a file */
+=09int (*link) (const char *, const char *);
+
+=09/** Change the permission bits of a file
+=09 *
+=09 * `fi` will always be NULL if the file is not currenlty open, but
+=09 * may also be NULL if the file is open.
+=09 */
+=09int (*chmod) (const char *, mode_t, struct fuse_file_info *fi);
+
+=09/** Change the owner and group of a file
+=09 *
+=09 * `fi` will always be NULL if the file is not currenlty open, but
+=09 * may also be NULL if the file is open.
+=09 *
+=09 * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled, this method is
+=09 * expected to reset the setuid and setgid bits.
+=09 */
+=09int (*chown) (const char *, uid_t, gid_t, struct fuse_file_info *fi);
+
+=09/** Change the size of a file
+=09 *
+=09 * `fi` will always be NULL if the file is not currenlty open, but
+=09 * may also be NULL if the file is open.
+=09 *
+=09 * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled, this method is
+=09 * expected to reset the setuid and setgid bits.
+=09 */
+=09int (*truncate) (const char *, off_t, struct fuse_file_info *fi);
+
+=09/** Open a file
+=09 *
+=09 * Open flags are available in fi->flags. The following rules
+=09 * apply.
+=09 *
+=09 *  - Creation (O_CREAT, O_EXCL, O_NOCTTY) flags will be
+=09 *    filtered out / handled by the kernel.
+=09 *
+=09 *  - Access modes (O_RDONLY, O_WRONLY, O_RDWR, O_EXEC, O_SEARCH)
+=09 *    should be used by the filesystem to check if the operation is
+=09 *    permitted.  If the ``-o default_permissions`` mount option is
+=09 *    given, this check is already done by the kernel before calling
+=09 *    open() and may thus be omitted by the filesystem.
+=09 *
+=09 *  - When writeback caching is enabled, the kernel may send
+=09 *    read requests even for files opened with O_WRONLY. The
+=09 *    filesystem should be prepared to handle this.
+=09 *
+=09 *  - When writeback caching is disabled, the filesystem is
+=09 *    expected to properly handle the O_APPEND flag and ensure
+=09 *    that each write is appending to the end of the file.
+=09 *=20
+         *  - When writeback caching is enabled, the kernel will
+=09 *    handle O_APPEND. However, unless all changes to the file
+=09 *    come through the kernel this will not work reliably. The
+=09 *    filesystem should thus either ignore the O_APPEND flag
+=09 *    (and let the kernel handle it), or return an error
+=09 *    (indicating that reliably O_APPEND is not available).
+=09 *
+=09 * Filesystem may store an arbitrary file handle (pointer,
+=09 * index, etc) in fi->fh, and use this in other all other file
+=09 * operations (read, write, flush, release, fsync).
+=09 *
+=09 * Filesystem may also implement stateless file I/O and not store
+=09 * anything in fi->fh.
+=09 *
+=09 * There are also some flags (direct_io, keep_cache) which the
+=09 * filesystem may set in fi, to change the way the file is opened.
+=09 * See fuse_file_info structure in <fuse_common.h> for more details.
+=09 *
+=09 * If this request is answered with an error code of ENOSYS
+=09 * and FUSE_CAP_NO_OPEN_SUPPORT is set in
+=09 * `fuse_conn_info.capable`, this is treated as success and
+=09 * future calls to open will also succeed without being send
+=09 * to the filesystem process.
+=09 *
+=09 */
+=09int (*open) (const char *, struct fuse_file_info *);
+
+=09/** Read data from an open file
+=09 *
+=09 * Read should return exactly the number of bytes requested except
+=09 * on EOF or error, otherwise the rest of the data will be
+=09 * substituted with zeroes.=09 An exception to this is when the
+=09 * 'direct_io' mount option is specified, in which case the return
+=09 * value of the read system call will reflect the return value of
+=09 * this operation.
+=09 */
+=09int (*read) (const char *, char *, size_t, off_t,
+=09=09     struct fuse_file_info *);
+
+=09/** Write data to an open file
+=09 *
+=09 * Write should return exactly the number of bytes requested
+=09 * except on error.=09 An exception to this is when the 'direct_io'
+=09 * mount option is specified (see read operation).
+=09 *
+=09 * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled, this method is
+=09 * expected to reset the setuid and setgid bits.
+=09 */
+=09int (*write) (const char *, const char *, size_t, off_t,
+=09=09      struct fuse_file_info *);
+
+=09/** Get file system statistics
+=09 *
+=09 * The 'f_favail', 'f_fsid' and 'f_flag' fields are ignored
+=09 */
+=09int (*statfs) (const char *, struct statvfs *);
+
+=09/** Possibly flush cached data
+=09 *
+=09 * BIG NOTE: This is not equivalent to fsync().  It's not a
+=09 * request to sync dirty data.
+=09 *
+=09 * Flush is called on each close() of a file descriptor, as opposed to
+=09 * release which is called on the close of the last file descriptor for
+=09 * a file.  Under Linux, errors returned by flush() will be passed to=
=20
+=09 * userspace as errors from close(), so flush() is a good place to writ=
e
+=09 * back any cached dirty data. However, many applications ignore errors=
=20
+=09 * on close(), and on non-Linux systems, close() may succeed even if fl=
ush()
+=09 * returns an error. For these reasons, filesystems should not assume
+=09 * that errors returned by flush will ever be noticed or even
+=09 * delivered.
+=09 *
+=09 * NOTE: The flush() method may be called more than once for each
+=09 * open().  This happens if more than one file descriptor refers to an
+=09 * open file handle, e.g. due to dup(), dup2() or fork() calls.  It is
+=09 * not possible to determine if a flush is final, so each flush should
+=09 * be treated equally.  Multiple write-flush sequences are relatively
+=09 * rare, so this shouldn't be a problem.
+=09 *
+=09 * Filesystems shouldn't assume that flush will be called at any
+=09 * particular point.  It may be called more times than expected, or not
+=09 * at all.
+=09 *
+=09 * [close]: http://pubs.opengroup.org/onlinepubs/9699919799/functions/c=
lose.html
+=09 */
+=09int (*flush) (const char *, struct fuse_file_info *);
+
+=09/** Release an open file
+=09 *
+=09 * Release is called when there are no more references to an open
+=09 * file: all file descriptors are closed and all memory mappings
+=09 * are unmapped.
+=09 *
+=09 * For every open() call there will be exactly one release() call
+=09 * with the same flags and file handle.  It is possible to
+=09 * have a file opened more than once, in which case only the last
+=09 * release will mean, that no more reads/writes will happen on the
+=09 * file.  The return value of release is ignored.
+=09 */
+=09int (*release) (const char *, struct fuse_file_info *);
+
+=09/** Synchronize file contents
+=09 *
+=09 * If the datasync parameter is non-zero, then only the user data
+=09 * should be flushed, not the meta data.
+=09 */
+=09int (*fsync) (const char *, int, struct fuse_file_info *);
+
+=09/** Set extended attributes */
+=09int (*setxattr) (const char *, const char *, const char *, size_t, int)=
;
+
+=09/** Get extended attributes */
+=09int (*getxattr) (const char *, const char *, char *, size_t);
+
+=09/** List extended attributes */
+=09int (*listxattr) (const char *, char *, size_t);
+
+=09/** Remove extended attributes */
+=09int (*removexattr) (const char *, const char *);
+
+=09/** Open directory
+=09 *
+=09 * Unless the 'default_permissions' mount option is given,
+=09 * this method should check if opendir is permitted for this
+=09 * directory. Optionally opendir may also return an arbitrary
+=09 * filehandle in the fuse_file_info structure, which will be
+=09 * passed to readdir, releasedir and fsyncdir.
+=09 */
+=09int (*opendir) (const char *, struct fuse_file_info *);
+
+=09/** Read directory
+=09 *
+=09 * The filesystem may choose between two modes of operation:
+=09 *
+=09 * 1) The readdir implementation ignores the offset parameter, and
+=09 * passes zero to the filler function's offset.  The filler
+=09 * function will not return '1' (unless an error happens), so the
+=09 * whole directory is read in a single readdir operation.
+=09 *
+=09 * 2) The readdir implementation keeps track of the offsets of the
+=09 * directory entries.  It uses the offset parameter and always
+=09 * passes non-zero offset to the filler function.  When the buffer
+=09 * is full (or an error happens) the filler function will return
+=09 * '1'.
+=09 */
+=09int (*readdir) (const char *, void *, fuse_fill_dir_t, off_t,
+=09=09=09struct fuse_file_info *, enum fuse_readdir_flags);
+
+=09/** Release directory
+=09 */
+=09int (*releasedir) (const char *, struct fuse_file_info *);
+
+=09/** Synchronize directory contents
+=09 *
+=09 * If the datasync parameter is non-zero, then only the user data
+=09 * should be flushed, not the meta data
+=09 */
+=09int (*fsyncdir) (const char *, int, struct fuse_file_info *);
+
+=09/**
+=09 * Initialize filesystem
+=09 *
+=09 * The return value will passed in the `private_data` field of
+=09 * `struct fuse_context` to all file operations, and as a
+=09 * parameter to the destroy() method. It overrides the initial
+=09 * value provided to fuse_main() / fuse_new().
+=09 */
+=09void *(*init) (struct fuse_conn_info *conn,
+=09=09       struct fuse_config *cfg);
+
+=09/**
+=09 * Clean up filesystem
+=09 *
+=09 * Called on filesystem exit.
+=09 */
+=09void (*destroy) (void *private_data);
+
+=09/**
+=09 * Check file access permissions
+=09 *
+=09 * This will be called for the access() system call.  If the
+=09 * 'default_permissions' mount option is given, this method is not
+=09 * called.
+=09 *
+=09 * This method is not called under Linux kernel versions 2.4.x
+=09 */
+=09int (*access) (const char *, int);
+
+=09/**
+=09 * Create and open a file
+=09 *
+=09 * If the file does not exist, first create it with the specified
+=09 * mode, and then open it.
+=09 *
+=09 * If this method is not implemented or under Linux kernel
+=09 * versions earlier than 2.6.15, the mknod() and open() methods
+=09 * will be called instead.
+=09 */
+=09int (*create) (const char *, mode_t, struct fuse_file_info *);
+
+=09/**
+=09 * Perform POSIX file locking operation
+=09 *
+=09 * The cmd argument will be either F_GETLK, F_SETLK or F_SETLKW.
+=09 *
+=09 * For the meaning of fields in 'struct flock' see the man page
+=09 * for fcntl(2).  The l_whence field will always be set to
+=09 * SEEK_SET.
+=09 *
+=09 * For checking lock ownership, the 'fuse_file_info->owner'
+=09 * argument must be used.
+=09 *
+=09 * For F_GETLK operation, the library will first check currently
+=09 * held locks, and if a conflicting lock is found it will return
+=09 * information without calling this method.=09 This ensures, that
+=09 * for local locks the l_pid field is correctly filled in.=09The
+=09 * results may not be accurate in case of race conditions and in
+=09 * the presence of hard links, but it's unlikely that an
+=09 * application would rely on accurate GETLK results in these
+=09 * cases.  If a conflicting lock is not found, this method will be
+=09 * called, and the filesystem may fill out l_pid by a meaningful
+=09 * value, or it may leave this field zero.
+=09 *
+=09 * For F_SETLK and F_SETLKW the l_pid field will be set to the pid
+=09 * of the process performing the locking operation.
+=09 *
+=09 * Note: if this method is not implemented, the kernel will still
+=09 * allow file locking to work locally.  Hence it is only
+=09 * interesting for network filesystems and similar.
+=09 */
+=09int (*lock) (const char *, struct fuse_file_info *, int cmd,
+=09=09     struct flock *);
+
+=09/**
+=09 * Change the access and modification times of a file with
+=09 * nanosecond resolution
+=09 *
+=09 * This supersedes the old utime() interface.  New applications
+=09 * should use this.
+=09 *
+=09 * `fi` will always be NULL if the file is not currenlty open, but
+=09 * may also be NULL if the file is open.
+=09 *
+=09 * See the utimensat(2) man page for details.
+=09 */
+=09 int (*utimens) (const char *, const struct timespec tv[2],
+=09=09=09 struct fuse_file_info *fi);
+
+=09/**
+=09 * Map block index within file to block index within device
+=09 *
+=09 * Note: This makes sense only for block device backed filesystems
+=09 * mounted with the 'blkdev' option
+=09 */
+=09int (*bmap) (const char *, size_t blocksize, uint64_t *idx);
+
+=09/**
+=09 * Ioctl
+=09 *
+=09 * flags will have FUSE_IOCTL_COMPAT set for 32bit ioctls in
+=09 * 64bit environment.  The size and direction of data is
+=09 * determined by _IOC_*() decoding of cmd.  For _IOC_NONE,
+=09 * data will be NULL, for _IOC_WRITE data is out area, for
+=09 * _IOC_READ in area and if both are set in/out area.  In all
+=09 * non-NULL cases, the area is of _IOC_SIZE(cmd) bytes.
+=09 *
+=09 * If flags has FUSE_IOCTL_DIR then the fuse_file_info refers to a
+=09 * directory file handle.
+=09 *
+=09 * Note : the unsigned long request submitted by the application
+=09 * is truncated to 32 bits.
+=09 */
+=09int (*ioctl) (const char *, unsigned int cmd, void *arg,
+=09=09      struct fuse_file_info *, unsigned int flags, void *data);
+
+=09/**
+=09 * Poll for IO readiness events
+=09 *
+=09 * Note: If ph is non-NULL, the client should notify
+=09 * when IO readiness events occur by calling
+=09 * fuse_notify_poll() with the specified ph.
+=09 *
+=09 * Regardless of the number of times poll with a non-NULL ph
+=09 * is received, single notification is enough to clear all.
+=09 * Notifying more times incurs overhead but doesn't harm
+=09 * correctness.
+=09 *
+=09 * The callee is responsible for destroying ph with
+=09 * fuse_pollhandle_destroy() when no longer in use.
+=09 */
+=09int (*poll) (const char *, struct fuse_file_info *,
+=09=09     struct fuse_pollhandle *ph, unsigned *reventsp);
+
+=09/** Write contents of buffer to an open file
+=09 *
+=09 * Similar to the write() method, but data is supplied in a
+=09 * generic buffer.  Use fuse_buf_copy() to transfer data to
+=09 * the destination.
+=09 *
+=09 * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled, this method is
+=09 * expected to reset the setuid and setgid bits.
+=09 */
+=09int (*write_buf) (const char *, struct fuse_bufvec *buf, off_t off,
+=09=09=09  struct fuse_file_info *);
+
+=09/** Store data from an open file in a buffer
+=09 *
+=09 * Similar to the read() method, but data is stored and
+=09 * returned in a generic buffer.
+=09 *
+=09 * No actual copying of data has to take place, the source
+=09 * file descriptor may simply be stored in the buffer for
+=09 * later data transfer.
+=09 *
+=09 * The buffer must be allocated dynamically and stored at the
+=09 * location pointed to by bufp.  If the buffer contains memory
+=09 * regions, they too must be allocated using malloc().  The
+=09 * allocated memory will be freed by the caller.
+=09 */
+=09int (*read_buf) (const char *, struct fuse_bufvec **bufp,
+=09=09=09 size_t size, off_t off, struct fuse_file_info *);
+=09/**
+=09 * Perform BSD file locking operation
+=09 *
+=09 * The op argument will be either LOCK_SH, LOCK_EX or LOCK_UN
+=09 *
+=09 * Nonblocking requests will be indicated by ORing LOCK_NB to
+=09 * the above operations
+=09 *
+=09 * For more information see the flock(2) manual page.
+=09 *
+=09 * Additionally fi->owner will be set to a value unique to
+=09 * this open file.  This same value will be supplied to
+=09 * ->release() when the file is released.
+=09 *
+=09 * Note: if this method is not implemented, the kernel will still
+=09 * allow file locking to work locally.  Hence it is only
+=09 * interesting for network filesystems and similar.
+=09 */
+=09int (*flock) (const char *, struct fuse_file_info *, int op);
+
+=09/**
+=09 * Allocates space for an open file
+=09 *
+=09 * This function ensures that required space is allocated for specified
+=09 * file.  If this function returns success then any subsequent write
+=09 * request to specified range is guaranteed not to fail because of lack
+=09 * of space on the file system media.
+=09 */
+=09int (*fallocate) (const char *, int, off_t, off_t,
+=09=09=09  struct fuse_file_info *);
+
+=09/**
+=09 * Copy a range of data from one file to another
+=09 *
+=09 * Performs an optimized copy between two file descriptors without the
+=09 * additional cost of transferring data through the FUSE kernel module
+=09 * to user space (glibc) and then back into the FUSE filesystem again.
+=09 *
+=09 * In case this method is not implemented, glibc falls back to reading
+=09 * data from the source and writing to the destination. Effectively
+=09 * doing an inefficient copy of the data.
+=09 */
+=09ssize_t (*copy_file_range) (const char *path_in,
+=09=09=09=09    struct fuse_file_info *fi_in,
+=09=09=09=09    off_t offset_in, const char *path_out,
+=09=09=09=09    struct fuse_file_info *fi_out,
+=09=09=09=09    off_t offset_out, size_t size, int flags);
+
+=09/**
+=09 * Find next data or hole after the specified offset
+=09 */
+=09off_t (*lseek) (const char *, off_t off, int whence, struct fuse_file_i=
nfo *);
+};
+
+/** Extra context that may be needed by some filesystems
+ *
+ * The uid, gid and pid fields are not filled in case of a writepage
+ * operation.
+ */
+struct fuse_context {
+=09/** Pointer to the fuse object */
+=09struct fuse *fuse;
+
+=09/** User ID of the calling process */
+=09uid_t uid;
+
+=09/** Group ID of the calling process */
+=09gid_t gid;
+
+=09/** Process ID of the calling thread */
+=09pid_t pid;
+
+=09/** Private filesystem data */
+=09void *private_data;
+
+=09/** Umask of the calling process */
+=09mode_t umask;
+};
+
+/**
+ * Main function of FUSE.
+ *
+ * This is for the lazy.  This is all that has to be called from the
+ * main() function.
+ *
+ * This function does the following:
+ *   - parses command line options, and handles --help and
+ *     --version
+ *   - installs signal handlers for INT, HUP, TERM and PIPE
+ *   - registers an exit handler to unmount the filesystem on program exit
+ *   - creates a fuse handle
+ *   - registers the operations
+ *   - calls either the single-threaded or the multi-threaded event loop
+ *
+ * Most file systems will have to parse some file-system specific
+ * arguments before calling this function. It is recommended to do
+ * this with fuse_opt_parse() and a processing function that passes
+ * through any unknown options (this can also be achieved by just
+ * passing NULL as the processing function). That way, the remaining
+ * options can be passed directly to fuse_main().
+ *
+ * fuse_main() accepts all options that can be passed to
+ * fuse_parse_cmdline(), fuse_new(), or fuse_session_new().
+ *
+ * Option parsing skips argv[0], which is assumed to contain the
+ * program name. This element must always be present and is used to
+ * construct a basic ``usage: `` message for the --help
+ * output. argv[0] may also be set to the empty string. In this case
+ * the usage message is suppressed. This can be used by file systems
+ * to print their own usage line first. See hello.c for an example of
+ * how to do this.
+ *
+ * Note: this is currently implemented as a macro.
+ *
+ * The following error codes may be returned from fuse_main():
+ *   1: Invalid option arguments
+ *   2: No mount point specified
+ *   3: FUSE setup failed
+ *   4: Mounting failed
+ *   5: Failed to daemonize (detach from session)
+ *   6: Failed to set up signal handlers
+ *   7: An error occured during the life of the file system
+ *
+ * @param argc the argument counter passed to the main() function
+ * @param argv the argument vector passed to the main() function
+ * @param op the file system operation
+ * @param private_data Initial value for the `private_data`
+ *            field of `struct fuse_context`. May be overridden by the
+ *            `struct fuse_operations.init` handler.
+ * @return 0 on success, nonzero on failure
+ *
+ * Example usage, see hello.c
+ */
+/*
+  int fuse_main(int argc, char *argv[], const struct fuse_operations *op,
+  void *private_data);
+*/
+#define fuse_main(argc, argv, op, private_data)=09=09=09=09\
+=09fuse_main_real(argc, argv, op, sizeof(*(op)), private_data)
+
+/* ----------------------------------------------------------- *
+ * More detailed API=09=09=09=09=09       *
+ * ----------------------------------------------------------- */
+
+/**
+ * Print available options (high- and low-level) to stdout.  This is
+ * not an exhaustive list, but includes only those options that may be
+ * of interest to an end-user of a file system.
+ *
+ * The function looks at the argument vector only to determine if
+ * there are additional modules to be loaded (module=3Dfoo option),
+ * and attempts to call their help functions as well.
+ *
+ * @param args the argument vector.
+ */
+void fuse_lib_help(struct fuse_args *args);
+
+/**
+ * Create a new FUSE filesystem.
+ *
+ * This function accepts most file-system independent mount options
+ * (like context, nodev, ro - see mount(8)), as well as the
+ * FUSE-specific mount options from mount.fuse(8).
+ *
+ * If the --help option is specified, the function writes a help text
+ * to stdout and returns NULL.
+ *
+ * Option parsing skips argv[0], which is assumed to contain the
+ * program name. This element must always be present and is used to
+ * construct a basic ``usage: `` message for the --help output. If
+ * argv[0] is set to the empty string, no usage message is included in
+ * the --help output.
+ *
+ * If an unknown option is passed in, an error message is written to
+ * stderr and the function returns NULL.
+ *
+ * @param args argument vector
+ * @param op the filesystem operations
+ * @param op_size the size of the fuse_operations structure
+ * @param private_data Initial value for the `private_data`
+ *            field of `struct fuse_context`. May be overridden by the
+ *            `struct fuse_operations.init` handler.
+ * @return the created FUSE handle
+ */
+#if FUSE_USE_VERSION =3D=3D 30
+struct fuse *fuse_new_30(struct fuse_args *args, const struct fuse_operati=
ons *op,
+=09=09=09 size_t op_size, void *private_data);
+#define fuse_new(args, op, size, data) fuse_new_30(args, op, size, data)
+#else
+struct fuse *fuse_new(struct fuse_args *args, const struct fuse_operations=
 *op,
+=09=09      size_t op_size, void *private_data);
+#endif
+
+/**
+ * Mount a FUSE file system.
+ *
+ * @param mountpoint the mount point path
+ * @param f the FUSE handle
+ *
+ * @return 0 on success, -1 on failure.
+ **/
+int fuse_mount(struct fuse *f, const char *mountpoint);
+
+/**
+ * Unmount a FUSE file system.
+ *
+ * See fuse_session_unmount() for additional information.
+ *
+ * @param f the FUSE handle
+ **/
+void fuse_unmount(struct fuse *f);
+
+/**
+ * Destroy the FUSE handle.
+ *
+ * NOTE: This function does not unmount the filesystem.=09 If this is
+ * needed, call fuse_unmount() before calling this function.
+ *
+ * @param f the FUSE handle
+ */
+void fuse_destroy(struct fuse *f);
+
+/**
+ * FUSE event loop.
+ *
+ * Requests from the kernel are processed, and the appropriate
+ * operations are called.
+ *
+ * For a description of the return value and the conditions when the
+ * event loop exits, refer to the documentation of
+ * fuse_session_loop().
+ *
+ * @param f the FUSE handle
+ * @return see fuse_session_loop()
+ *
+ * See also: fuse_loop_mt()
+ */
+int fuse_loop(struct fuse *f);
+
+/**
+ * Flag session as terminated
+ *
+ * This function will cause any running event loops to exit on
+ * the next opportunity.
+ *
+ * @param f the FUSE handle
+ */
+void fuse_exit(struct fuse *f);
+
+/**
+ * FUSE event loop with multiple threads
+ *
+ * Requests from the kernel are processed, and the appropriate
+ * operations are called.  Request are processed in parallel by
+ * distributing them between multiple threads.
+ *
+ * For a description of the return value and the conditions when the
+ * event loop exits, refer to the documentation of
+ * fuse_session_loop().
+ *
+ * Note: using fuse_loop() instead of fuse_loop_mt() means you are running=
 in
+ * single-threaded mode, and that you will not have to worry about reentra=
ncy,
+ * though you will have to worry about recursive lookups. In single-thread=
ed
+ * mode, FUSE will wait for one callback to return before calling another.
+ *
+ * Enabling multiple threads, by using fuse_loop_mt(), will cause FUSE to =
make
+ * multiple simultaneous calls into the various callback functions given b=
y your
+ * fuse_operations record.
+ *
+ * If you are using multiple threads, you can enjoy all the parallel execu=
tion
+ * and interactive response benefits of threads, and you get to enjoy all =
the
+ * benefits of race conditions and locking bugs, too. Ensure that any code=
 used
+ * in the callback function of fuse_operations is also thread-safe.
+ *
+ * @param f the FUSE handle
+ * @param config loop configuration
+ * @return see fuse_session_loop()
+ *
+ * See also: fuse_loop()
+ */
+#if FUSE_USE_VERSION < 32
+int fuse_loop_mt_31(struct fuse *f, int clone_fd);
+#define fuse_loop_mt(f, clone_fd) fuse_loop_mt_31(f, clone_fd)
+#else
+int fuse_loop_mt(struct fuse *f, struct fuse_loop_config *config);
+#endif
+
+/**
+ * Get the current context
+ *
+ * The context is only valid for the duration of a filesystem
+ * operation, and thus must not be stored and used later.
+ *
+ * @return the context
+ */
+struct fuse_context *fuse_get_context(void);
+
+/**
+ * Get the current supplementary group IDs for the current request
+ *
+ * Similar to the getgroups(2) system call, except the return value is
+ * always the total number of group IDs, even if it is larger than the
+ * specified size.
+ *
+ * The current fuse kernel module in linux (as of 2.6.30) doesn't pass
+ * the group list to userspace, hence this function needs to parse
+ * "/proc/$TID/task/$TID/status" to get the group IDs.
+ *
+ * This feature may not be supported on all operating systems.  In
+ * such a case this function will return -ENOSYS.
+ *
+ * @param size size of given array
+ * @param list array of group IDs to be filled in
+ * @return the total number of supplementary group IDs or -errno on failur=
e
+ */
+int fuse_getgroups(int size, gid_t list[]);
+
+/**
+ * Check if the current request has already been interrupted
+ *
+ * @return 1 if the request has been interrupted, 0 otherwise
+ */
+int fuse_interrupted(void);
+
+/**
+ * Invalidates cache for the given path.
+ *
+ * This calls fuse_lowlevel_notify_inval_inode internally.
+ *
+ * @return 0 on successful invalidation, negative error value otherwise.
+ *         This routine may return -ENOENT to indicate that there was
+ *         no entry to be invalidated, e.g., because the path has not
+ *         been seen before or has been forgotten; this should not be
+ *         considered to be an error.
+ */
+int fuse_invalidate_path(struct fuse *f, const char *path);
+
+/**
+ * The real main function
+ *
+ * Do not call this directly, use fuse_main()
+ */
+int fuse_main_real(int argc, char *argv[], const struct fuse_operations *o=
p,
+=09=09   size_t op_size, void *private_data);
+
+/**
+ * Start the cleanup thread when using option "remember".
+ *
+ * This is done automatically by fuse_loop_mt()
+ * @param fuse struct fuse pointer for fuse instance
+ * @return 0 on success and -1 on error
+ */
+int fuse_start_cleanup_thread(struct fuse *fuse);
+
+/**
+ * Stop the cleanup thread when using option "remember".
+ *
+ * This is done automatically by fuse_loop_mt()
+ * @param fuse struct fuse pointer for fuse instance
+ */
+void fuse_stop_cleanup_thread(struct fuse *fuse);
+
+/**
+ * Iterate over cache removing stale entries
+ * use in conjunction with "-oremember"
+ *
+ * NOTE: This is already done for the standard sessions
+ *
+ * @param fuse struct fuse pointer for fuse instance
+ * @return the number of seconds until the next cleanup
+ */
+int fuse_clean_cache(struct fuse *fuse);
+
+/*
+ * Stacking API
+ */
+
+/**
+ * Fuse filesystem object
+ *
+ * This is opaque object represents a filesystem layer
+ */
+struct fuse_fs;
+
+/*
+ * These functions call the relevant filesystem operation, and return
+ * the result.
+ *
+ * If the operation is not defined, they return -ENOSYS, with the
+ * exception of fuse_fs_open, fuse_fs_release, fuse_fs_opendir,
+ * fuse_fs_releasedir and fuse_fs_statfs, which return 0.
+ */
+
+int fuse_fs_getattr(struct fuse_fs *fs, const char *path, struct stat *buf=
,
+=09=09    struct fuse_file_info *fi);
+int fuse_fs_rename(struct fuse_fs *fs, const char *oldpath,
+=09=09   const char *newpath, unsigned int flags);
+int fuse_fs_unlink(struct fuse_fs *fs, const char *path);
+int fuse_fs_rmdir(struct fuse_fs *fs, const char *path);
+int fuse_fs_symlink(struct fuse_fs *fs, const char *linkname,
+=09=09    const char *path);
+int fuse_fs_link(struct fuse_fs *fs, const char *oldpath, const char *newp=
ath);
+int fuse_fs_release(struct fuse_fs *fs,=09 const char *path,
+=09=09    struct fuse_file_info *fi);
+int fuse_fs_open(struct fuse_fs *fs, const char *path,
+=09=09 struct fuse_file_info *fi);
+int fuse_fs_read(struct fuse_fs *fs, const char *path, char *buf, size_t s=
ize,
+=09=09 off_t off, struct fuse_file_info *fi);
+int fuse_fs_read_buf(struct fuse_fs *fs, const char *path,
+=09=09     struct fuse_bufvec **bufp, size_t size, off_t off,
+=09=09     struct fuse_file_info *fi);
+int fuse_fs_write(struct fuse_fs *fs, const char *path, const char *buf,
+=09=09  size_t size, off_t off, struct fuse_file_info *fi);
+int fuse_fs_write_buf(struct fuse_fs *fs, const char *path,
+=09=09      struct fuse_bufvec *buf, off_t off,
+=09=09      struct fuse_file_info *fi);
+int fuse_fs_fsync(struct fuse_fs *fs, const char *path, int datasync,
+=09=09  struct fuse_file_info *fi);
+int fuse_fs_flush(struct fuse_fs *fs, const char *path,
+=09=09  struct fuse_file_info *fi);
+int fuse_fs_statfs(struct fuse_fs *fs, const char *path, struct statvfs *b=
uf);
+int fuse_fs_opendir(struct fuse_fs *fs, const char *path,
+=09=09    struct fuse_file_info *fi);
+int fuse_fs_readdir(struct fuse_fs *fs, const char *path, void *buf,
+=09=09    fuse_fill_dir_t filler, off_t off,
+=09=09    struct fuse_file_info *fi, enum fuse_readdir_flags flags);
+int fuse_fs_fsyncdir(struct fuse_fs *fs, const char *path, int datasync,
+=09=09     struct fuse_file_info *fi);
+int fuse_fs_releasedir(struct fuse_fs *fs, const char *path,
+=09=09       struct fuse_file_info *fi);
+int fuse_fs_create(struct fuse_fs *fs, const char *path, mode_t mode,
+=09=09   struct fuse_file_info *fi);
+int fuse_fs_lock(struct fuse_fs *fs, const char *path,
+=09=09 struct fuse_file_info *fi, int cmd, struct flock *lock);
+int fuse_fs_flock(struct fuse_fs *fs, const char *path,
+=09=09  struct fuse_file_info *fi, int op);
+int fuse_fs_chmod(struct fuse_fs *fs, const char *path, mode_t mode,
+=09=09  struct fuse_file_info *fi);
+int fuse_fs_chown(struct fuse_fs *fs, const char *path, uid_t uid, gid_t g=
id,
+=09=09  struct fuse_file_info *fi);
+int fuse_fs_truncate(struct fuse_fs *fs, const char *path, off_t size,
+=09=09     struct fuse_file_info *fi);
+int fuse_fs_utimens(struct fuse_fs *fs, const char *path,
+=09=09    const struct timespec tv[2], struct fuse_file_info *fi);
+int fuse_fs_access(struct fuse_fs *fs, const char *path, int mask);
+int fuse_fs_readlink(struct fuse_fs *fs, const char *path, char *buf,
+=09=09     size_t len);
+int fuse_fs_mknod(struct fuse_fs *fs, const char *path, mode_t mode,
+=09=09  dev_t rdev);
+int fuse_fs_mkdir(struct fuse_fs *fs, const char *path, mode_t mode);
+int fuse_fs_setxattr(struct fuse_fs *fs, const char *path, const char *nam=
e,
+=09=09     const char *value, size_t size, int flags);
+int fuse_fs_getxattr(struct fuse_fs *fs, const char *path, const char *nam=
e,
+=09=09     char *value, size_t size);
+int fuse_fs_listxattr(struct fuse_fs *fs, const char *path, char *list,
+=09=09      size_t size);
+int fuse_fs_removexattr(struct fuse_fs *fs, const char *path,
+=09=09=09const char *name);
+int fuse_fs_bmap(struct fuse_fs *fs, const char *path, size_t blocksize,
+=09=09 uint64_t *idx);
+int fuse_fs_ioctl(struct fuse_fs *fs, const char *path, unsigned int cmd,
+=09=09  void *arg, struct fuse_file_info *fi, unsigned int flags,
+=09=09  void *data);
+int fuse_fs_poll(struct fuse_fs *fs, const char *path,
+=09=09 struct fuse_file_info *fi, struct fuse_pollhandle *ph,
+=09=09 unsigned *reventsp);
+int fuse_fs_fallocate(struct fuse_fs *fs, const char *path, int mode,
+=09=09 off_t offset, off_t length, struct fuse_file_info *fi);
+ssize_t fuse_fs_copy_file_range(struct fuse_fs *fs, const char *path_in,
+=09=09=09=09struct fuse_file_info *fi_in, off_t off_in,
+=09=09=09=09const char *path_out,
+=09=09=09=09struct fuse_file_info *fi_out, off_t off_out,
+=09=09=09=09size_t len, int flags);
+off_t fuse_fs_lseek(struct fuse_fs *fs, const char *path, off_t off, int w=
hence,
+=09=09    struct fuse_file_info *fi);
+void fuse_fs_init(struct fuse_fs *fs, struct fuse_conn_info *conn,
+=09=09struct fuse_config *cfg);
+void fuse_fs_destroy(struct fuse_fs *fs);
+
+int fuse_notify_poll(struct fuse_pollhandle *ph);
+
+/**
+ * Create a new fuse filesystem object
+ *
+ * This is usually called from the factory of a fuse module to create
+ * a new instance of a filesystem.
+ *
+ * @param op the filesystem operations
+ * @param op_size the size of the fuse_operations structure
+ * @param private_data Initial value for the `private_data`
+ *            field of `struct fuse_context`. May be overridden by the
+ *            `struct fuse_operations.init` handler.
+ * @return a new filesystem object
+ */
+struct fuse_fs *fuse_fs_new(const struct fuse_operations *op, size_t op_si=
ze,
+=09=09=09    void *private_data);
+
+/**
+ * Factory for creating filesystem objects
+ *
+ * The function may use and remove options from 'args' that belong
+ * to this module.
+ *
+ * For now the 'fs' vector always contains exactly one filesystem.
+ * This is the filesystem which will be below the newly created
+ * filesystem in the stack.
+ *
+ * @param args the command line arguments
+ * @param fs NULL terminated filesystem object vector
+ * @return the new filesystem object
+ */
+typedef struct fuse_fs *(*fuse_module_factory_t)(struct fuse_args *args,
+=09=09=09=09=09=09 struct fuse_fs *fs[]);
+/**
+ * Register filesystem module
+ *
+ * If the "-omodules=3D*name*_:..." option is present, filesystem
+ * objects are created and pushed onto the stack with the *factory_*
+ * function.
+ *
+ * @param name_ the name of this filesystem module
+ * @param factory_ the factory function for this filesystem module
+ */
+#define FUSE_REGISTER_MODULE(name_, factory_) \
+=09fuse_module_factory_t fuse_module_ ## name_ ## _factory =3D factory_
+
+/** Get session from fuse object */
+struct fuse_session *fuse_get_session(struct fuse *f);
+
+/**
+ * Open a FUSE file descriptor and set up the mount for the given
+ * mountpoint and flags.
+ *
+ * @param mountpoint reference to the mount in the file system
+ * @param options mount options
+ * @return the FUSE file descriptor or -1 upon error
+ */
+int fuse_open_channel(const char *mountpoint, const char *options);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* FUSE_H_ */
diff --git a/tools/virtiofsd/fuse_common.h b/tools/virtiofsd/fuse_common.h
new file mode 100644
index 0000000000..2d686b2ac4
--- /dev/null
+++ b/tools/virtiofsd/fuse_common.h
@@ -0,0 +1,823 @@
+/*  FUSE: Filesystem in Userspace
+  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+
+  This program can be distributed under the terms of the GNU LGPLv2.
+  See the file COPYING.LIB.
+*/
+
+/** @file */
+
+#if !defined(FUSE_H_) && !defined(FUSE_LOWLEVEL_H_)
+#error "Never include <fuse_common.h> directly; use <fuse.h> or <fuse_lowl=
evel.h> instead."
+#endif
+
+#ifndef FUSE_COMMON_H_
+#define FUSE_COMMON_H_
+
+#include "fuse_opt.h"
+#include "fuse_log.h"
+#include <stdint.h>
+#include <sys/types.h>
+
+/** Major version of FUSE library interface */
+#define FUSE_MAJOR_VERSION 3
+
+/** Minor version of FUSE library interface */
+#define FUSE_MINOR_VERSION 2
+
+#define FUSE_MAKE_VERSION(maj, min)  ((maj) * 10 + (min))
+#define FUSE_VERSION FUSE_MAKE_VERSION(FUSE_MAJOR_VERSION, FUSE_MINOR_VERS=
ION)
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * Information about an open file.
+ *
+ * File Handles are created by the open, opendir, and create methods and c=
losed
+ * by the release and releasedir methods.  Multiple file handles may be
+ * concurrently open for the same file.  Generally, a client will create o=
ne
+ * file handle per file descriptor, though in some cases multiple file
+ * descriptors can share a single file handle.
+ */
+struct fuse_file_info {
+=09/** Open flags.=09 Available in open() and release() */
+=09int flags;
+
+=09/** In case of a write operation indicates if this was caused
+=09    by a delayed write from the page cache. If so, then the
+=09    context's pid, uid, and gid fields will not be valid, and
+=09    the *fh* value may not match the *fh* value that would
+=09    have been sent with the corresponding individual write
+=09    requests if write caching had been disabled. */
+=09unsigned int writepage : 1;
+
+=09/** Can be filled in by open, to use direct I/O on this file. */
+=09unsigned int direct_io : 1;
+
+=09/** Can be filled in by open. It signals the kernel that any
+=09    currently cached file data (ie., data that the filesystem
+=09    provided the last time the file was open) need not be
+=09    invalidated. Has no effect when set in other contexts (in
+=09    particular it does nothing when set by opendir()). */
+=09unsigned int keep_cache : 1;
+
+=09/** Indicates a flush operation.  Set in flush operation, also
+=09    maybe set in highlevel lock operation and lowlevel release
+=09    operation. */
+=09unsigned int flush : 1;
+
+=09/** Can be filled in by open, to indicate that the file is not
+=09    seekable. */
+=09unsigned int nonseekable : 1;
+
+=09/* Indicates that flock locks for this file should be
+=09   released.  If set, lock_owner shall contain a valid value.
+=09   May only be set in ->release(). */
+=09unsigned int flock_release : 1;
+
+=09/** Can be filled in by opendir. It signals the kernel to
+=09    enable caching of entries returned by readdir().  Has no
+=09    effect when set in other contexts (in particular it does
+=09    nothing when set by open()). */
+=09unsigned int cache_readdir : 1;
+
+=09/** Padding.  Reserved for future use*/
+=09unsigned int padding : 25;
+=09unsigned int padding2 : 32;
+
+=09/** File handle id.  May be filled in by filesystem in create,
+=09 * open, and opendir().  Available in most other file operations on the
+=09 * same file handle. */
+=09uint64_t fh;
+
+=09/** Lock owner id.  Available in locking operations and flush */
+=09uint64_t lock_owner;
+
+=09/** Requested poll events.  Available in ->poll.  Only set on kernels
+=09    which support it.  If unsupported, this field is set to zero. */
+=09uint32_t poll_events;
+};
+
+/**
+ * Configuration parameters passed to fuse_session_loop_mt() and
+ * fuse_loop_mt().
+ */
+struct fuse_loop_config {
+=09/**
+=09 * whether to use separate device fds for each thread
+=09 * (may increase performance)
+=09 */
+=09int clone_fd;
+
+=09/**
+=09 * The maximum number of available worker threads before they
+=09 * start to get deleted when they become idle. If not
+=09 * specified, the default is 10.
+=09 *
+=09 * Adjusting this has performance implications; a very small number
+=09 * of threads in the pool will cause a lot of thread creation and
+=09 * deletion overhead and performance may suffer. When set to 0, a new
+=09 * thread will be created to service every operation.
+=09 */
+=09unsigned int max_idle_threads;
+};
+
+/*************************************************************************=
*
+ * Capability bits for 'fuse_conn_info.capable' and 'fuse_conn_info.want' =
*
+ *************************************************************************=
*/
+
+/**
+ * Indicates that the filesystem supports asynchronous read requests.
+ *
+ * If this capability is not requested/available, the kernel will
+ * ensure that there is at most one pending read request per
+ * file-handle at any time, and will attempt to order read requests by
+ * increasing offset.
+ *
+ * This feature is enabled by default when supported by the kernel.
+ */
+#define FUSE_CAP_ASYNC_READ=09=09(1 << 0)
+
+/**
+ * Indicates that the filesystem supports "remote" locking.
+ *
+ * This feature is enabled by default when supported by the kernel,
+ * and if getlk() and setlk() handlers are implemented.
+ */
+#define FUSE_CAP_POSIX_LOCKS=09=09(1 << 1)
+
+/**
+ * Indicates that the filesystem supports the O_TRUNC open flag.  If
+ * disabled, and an application specifies O_TRUNC, fuse first calls
+ * truncate() and then open() with O_TRUNC filtered out.
+ *
+ * This feature is enabled by default when supported by the kernel.
+ */
+#define FUSE_CAP_ATOMIC_O_TRUNC=09=09(1 << 3)
+
+/**
+ * Indicates that the filesystem supports lookups of "." and "..".
+ *
+ * This feature is disabled by default.
+ */
+#define FUSE_CAP_EXPORT_SUPPORT=09=09(1 << 4)
+
+/**
+ * Indicates that the kernel should not apply the umask to the
+ * file mode on create operations.
+ *
+ * This feature is disabled by default.
+ */
+#define FUSE_CAP_DONT_MASK=09=09(1 << 6)
+
+/**
+ * Indicates that libfuse should try to use splice() when writing to
+ * the fuse device. This may improve performance.
+ *
+ * This feature is disabled by default.
+ */
+#define FUSE_CAP_SPLICE_WRITE=09=09(1 << 7)
+
+/**
+ * Indicates that libfuse should try to move pages instead of copying when
+ * writing to / reading from the fuse device. This may improve performance=
.
+ *
+ * This feature is disabled by default.
+ */
+#define FUSE_CAP_SPLICE_MOVE=09=09(1 << 8)
+
+/**
+ * Indicates that libfuse should try to use splice() when reading from
+ * the fuse device. This may improve performance.
+ *
+ * This feature is enabled by default when supported by the kernel and
+ * if the filesystem implements a write_buf() handler.
+ */
+#define FUSE_CAP_SPLICE_READ=09=09(1 << 9)
+
+/**
+ * If set, the calls to flock(2) will be emulated using POSIX locks and mu=
st
+ * then be handled by the filesystem's setlock() handler.
+ *
+ * If not set, flock(2) calls will be handled by the FUSE kernel module
+ * internally (so any access that does not go through the kernel cannot be=
 taken
+ * into account).
+ *
+ * This feature is enabled by default when supported by the kernel and
+ * if the filesystem implements a flock() handler.
+ */
+#define FUSE_CAP_FLOCK_LOCKS=09=09(1 << 10)
+
+/**
+ * Indicates that the filesystem supports ioctl's on directories.
+ *
+ * This feature is enabled by default when supported by the kernel.
+ */
+#define FUSE_CAP_IOCTL_DIR=09=09(1 << 11)
+
+/**
+ * Traditionally, while a file is open the FUSE kernel module only
+ * asks the filesystem for an update of the file's attributes when a
+ * client attempts to read beyond EOF. This is unsuitable for
+ * e.g. network filesystems, where the file contents may change
+ * without the kernel knowing about it.
+ *
+ * If this flag is set, FUSE will check the validity of the attributes
+ * on every read. If the attributes are no longer valid (i.e., if the
+ * *attr_timeout* passed to fuse_reply_attr() or set in `struct
+ * fuse_entry_param` has passed), it will first issue a `getattr`
+ * request. If the new mtime differs from the previous value, any
+ * cached file *contents* will be invalidated as well.
+ *
+ * This flag should always be set when available. If all file changes
+ * go through the kernel, *attr_timeout* should be set to a very large
+ * number to avoid unnecessary getattr() calls.
+ *
+ * This feature is enabled by default when supported by the kernel.
+ */
+#define FUSE_CAP_AUTO_INVAL_DATA=09(1 << 12)
+
+/**
+ * Indicates that the filesystem supports readdirplus.
+ *
+ * This feature is enabled by default when supported by the kernel and if =
the
+ * filesystem implements a readdirplus() handler.
+ */
+#define FUSE_CAP_READDIRPLUS=09=09(1 << 13)
+
+/**
+ * Indicates that the filesystem supports adaptive readdirplus.
+ *
+ * If FUSE_CAP_READDIRPLUS is not set, this flag has no effect.
+ *
+ * If FUSE_CAP_READDIRPLUS is set and this flag is not set, the kernel
+ * will always issue readdirplus() requests to retrieve directory
+ * contents.
+ *
+ * If FUSE_CAP_READDIRPLUS is set and this flag is set, the kernel
+ * will issue both readdir() and readdirplus() requests, depending on
+ * how much information is expected to be required.
+ *
+ * As of Linux 4.20, the algorithm is as follows: when userspace
+ * starts to read directory entries, issue a READDIRPLUS request to
+ * the filesystem. If any entry attributes have been looked up by the
+ * time userspace requests the next batch of entries continue with
+ * READDIRPLUS, otherwise switch to plain READDIR.  This will reasult
+ * in eg plain "ls" triggering READDIRPLUS first then READDIR after
+ * that because it doesn't do lookups.  "ls -l" should result in all
+ * READDIRPLUS, except if dentries are already cached.
+ *
+ * This feature is enabled by default when supported by the kernel and
+ * if the filesystem implements both a readdirplus() and a readdir()
+ * handler.
+ */
+#define FUSE_CAP_READDIRPLUS_AUTO=09(1 << 14)
+
+/**
+ * Indicates that the filesystem supports asynchronous direct I/O submissi=
on.
+ *
+ * If this capability is not requested/available, the kernel will ensure t=
hat
+ * there is at most one pending read and one pending write request per dir=
ect
+ * I/O file-handle at any time.
+ *
+ * This feature is enabled by default when supported by the kernel.
+ */
+#define FUSE_CAP_ASYNC_DIO=09=09(1 << 15)
+
+/**
+ * Indicates that writeback caching should be enabled. This means that
+ * individual write request may be buffered and merged in the kernel
+ * before they are send to the filesystem.
+ *
+ * This feature is disabled by default.
+ */
+#define FUSE_CAP_WRITEBACK_CACHE=09(1 << 16)
+
+/**
+ * Indicates support for zero-message opens. If this flag is set in
+ * the `capable` field of the `fuse_conn_info` structure, then the
+ * filesystem may return `ENOSYS` from the open() handler to indicate
+ * success. Further attempts to open files will be handled in the
+ * kernel. (If this flag is not set, returning ENOSYS will be treated
+ * as an error and signaled to the caller).
+ *
+ * Setting (or unsetting) this flag in the `want` field has *no
+ * effect*.
+ */
+#define FUSE_CAP_NO_OPEN_SUPPORT=09(1 << 17)
+
+/**
+ * Indicates support for parallel directory operations. If this flag
+ * is unset, the FUSE kernel module will ensure that lookup() and
+ * readdir() requests are never issued concurrently for the same
+ * directory.
+ *
+ * This feature is enabled by default when supported by the kernel.
+ */
+#define FUSE_CAP_PARALLEL_DIROPS        (1 << 18)
+
+/**
+ * Indicates support for POSIX ACLs.
+ *
+ * If this feature is enabled, the kernel will cache and have
+ * responsibility for enforcing ACLs. ACL will be stored as xattrs and
+ * passed to userspace, which is responsible for updating the ACLs in
+ * the filesystem, keeping the file mode in sync with the ACL, and
+ * ensuring inheritance of default ACLs when new filesystem nodes are
+ * created. Note that this requires that the file system is able to
+ * parse and interpret the xattr representation of ACLs.
+ *
+ * Enabling this feature implicitly turns on the
+ * ``default_permissions`` mount option (even if it was not passed to
+ * mount(2)).
+ *
+ * This feature is disabled by default.
+ */
+#define FUSE_CAP_POSIX_ACL              (1 << 19)
+
+/**
+ * Indicates that the filesystem is responsible for unsetting
+ * setuid and setgid bits when a file is written, truncated, or
+ * its owner is changed.
+ *
+ * This feature is enabled by default when supported by the kernel.
+ */
+#define FUSE_CAP_HANDLE_KILLPRIV         (1 << 20)
+
+/**
+ * Indicates support for zero-message opendirs. If this flag is set in
+ * the `capable` field of the `fuse_conn_info` structure, then the filesys=
tem
+ * may return `ENOSYS` from the opendir() handler to indicate success. Fur=
ther
+ * opendir and releasedir messages will be handled in the kernel. (If this
+ * flag is not set, returning ENOSYS will be treated as an error and signa=
lled
+ * to the caller.)
+ *
+ * Setting (or unsetting) this flag in the `want` field has *no effect*.
+ */
+#define FUSE_CAP_NO_OPENDIR_SUPPORT    (1 << 24)
+
+/**
+ * Ioctl flags
+ *
+ * FUSE_IOCTL_COMPAT: 32bit compat ioctl on 64bit machine
+ * FUSE_IOCTL_UNRESTRICTED: not restricted to well-formed ioctls, retry al=
lowed
+ * FUSE_IOCTL_RETRY: retry with new iovecs
+ * FUSE_IOCTL_DIR: is a directory
+ *
+ * FUSE_IOCTL_MAX_IOV: maximum of in_iovecs + out_iovecs
+ */
+#define FUSE_IOCTL_COMPAT=09(1 << 0)
+#define FUSE_IOCTL_UNRESTRICTED=09(1 << 1)
+#define FUSE_IOCTL_RETRY=09(1 << 2)
+#define FUSE_IOCTL_DIR=09=09(1 << 4)
+
+#define FUSE_IOCTL_MAX_IOV=09256
+
+/**
+ * Connection information, passed to the ->init() method
+ *
+ * Some of the elements are read-write, these can be changed to
+ * indicate the value requested by the filesystem.  The requested
+ * value must usually be smaller than the indicated value.
+ */
+struct fuse_conn_info {
+=09/**
+=09 * Major version of the protocol (read-only)
+=09 */
+=09unsigned proto_major;
+
+=09/**
+=09 * Minor version of the protocol (read-only)
+=09 */
+=09unsigned proto_minor;
+
+=09/**
+=09 * Maximum size of the write buffer
+=09 */
+=09unsigned max_write;
+
+=09/**
+=09 * Maximum size of read requests. A value of zero indicates no
+=09 * limit. However, even if the filesystem does not specify a
+=09 * limit, the maximum size of read requests will still be
+=09 * limited by the kernel.
+=09 *
+=09 * NOTE: For the time being, the maximum size of read requests
+=09 * must be set both here *and* passed to fuse_session_new()
+=09 * using the ``-o max_read=3D<n>`` mount option. At some point
+=09 * in the future, specifying the mount option will no longer
+=09 * be necessary.
+=09 */
+=09unsigned max_read;
+
+=09/**
+=09 * Maximum readahead
+=09 */
+=09unsigned max_readahead;
+
+=09/**
+=09 * Capability flags that the kernel supports (read-only)
+=09 */
+=09unsigned capable;
+
+=09/**
+=09 * Capability flags that the filesystem wants to enable.
+=09 *
+=09 * libfuse attempts to initialize this field with
+=09 * reasonable default values before calling the init() handler.
+=09 */
+=09unsigned want;
+
+=09/**
+=09 * Maximum number of pending "background" requests. A
+=09 * background request is any type of request for which the
+=09 * total number is not limited by other means. As of kernel
+=09 * 4.8, only two types of requests fall into this category:
+=09 *
+=09 *   1. Read-ahead requests
+=09 *   2. Asynchronous direct I/O requests
+=09 *
+=09 * Read-ahead requests are generated (if max_readahead is
+=09 * non-zero) by the kernel to preemptively fill its caches
+=09 * when it anticipates that userspace will soon read more
+=09 * data.
+=09 *
+=09 * Asynchronous direct I/O requests are generated if
+=09 * FUSE_CAP_ASYNC_DIO is enabled and userspace submits a large
+=09 * direct I/O request. In this case the kernel will internally
+=09 * split it up into multiple smaller requests and submit them
+=09 * to the filesystem concurrently.
+=09 *
+=09 * Note that the following requests are *not* background
+=09 * requests: writeback requests (limited by the kernel's
+=09 * flusher algorithm), regular (i.e., synchronous and
+=09 * buffered) userspace read/write requests (limited to one per
+=09 * thread), asynchronous read requests (Linux's io_submit(2)
+=09 * call actually blocks, so these are also limited to one per
+=09 * thread).
+=09 */
+=09unsigned max_background;
+
+=09/**
+=09 * Kernel congestion threshold parameter. If the number of pending
+=09 * background requests exceeds this number, the FUSE kernel module will
+=09 * mark the filesystem as "congested". This instructs the kernel to
+=09 * expect that queued requests will take some time to complete, and to
+=09 * adjust its algorithms accordingly (e.g. by putting a waiting thread
+=09 * to sleep instead of using a busy-loop).
+=09 */
+=09unsigned congestion_threshold;
+
+=09/**
+=09 * When FUSE_CAP_WRITEBACK_CACHE is enabled, the kernel is responsible
+=09 * for updating mtime and ctime when write requests are received. The
+=09 * updated values are passed to the filesystem with setattr() requests.
+=09 * However, if the filesystem does not support the full resolution of
+=09 * the kernel timestamps (nanoseconds), the mtime and ctime values used
+=09 * by kernel and filesystem will differ (and result in an apparent
+=09 * change of times after a cache flush).
+=09 *
+=09 * To prevent this problem, this variable can be used to inform the
+=09 * kernel about the timestamp granularity supported by the file-system.
+=09 * The value should be power of 10.  The default is 1, i.e. full
+=09 * nano-second resolution. Filesystems supporting only second resolutio=
n
+=09 * should set this to 1000000000.
+=09 */
+=09unsigned time_gran;
+
+=09/**
+=09 * For future use.
+=09 */
+=09unsigned reserved[22];
+};
+
+struct fuse_session;
+struct fuse_pollhandle;
+struct fuse_conn_info_opts;
+
+/**
+ * This function parses several command-line options that can be used
+ * to override elements of struct fuse_conn_info. The pointer returned
+ * by this function should be passed to the
+ * fuse_apply_conn_info_opts() method by the file system's init()
+ * handler.
+ *
+ * Before using this function, think twice if you really want these
+ * parameters to be adjustable from the command line. In most cases,
+ * they should be determined by the file system internally.
+ *
+ * The following options are recognized:
+ *
+ *   -o max_write=3DN         sets conn->max_write
+ *   -o max_readahead=3DN     sets conn->max_readahead
+ *   -o max_background=3DN    sets conn->max_background
+ *   -o congestion_threshold=3DN  sets conn->congestion_threshold
+ *   -o async_read          sets FUSE_CAP_ASYNC_READ in conn->want
+ *   -o sync_read           unsets FUSE_CAP_ASYNC_READ in conn->want
+ *   -o atomic_o_trunc      sets FUSE_CAP_ATOMIC_O_TRUNC in conn->want
+ *   -o no_remote_lock      Equivalent to -o no_remote_flock,no_remote_pos=
ix_lock
+ *   -o no_remote_flock     Unsets FUSE_CAP_FLOCK_LOCKS in conn->want
+ *   -o no_remote_posix_lock  Unsets FUSE_CAP_POSIX_LOCKS in conn->want
+ *   -o [no_]splice_write     (un-)sets FUSE_CAP_SPLICE_WRITE in conn->wan=
t
+ *   -o [no_]splice_move      (un-)sets FUSE_CAP_SPLICE_MOVE in conn->want
+ *   -o [no_]splice_read      (un-)sets FUSE_CAP_SPLICE_READ in conn->want
+ *   -o [no_]auto_inval_data  (un-)sets FUSE_CAP_AUTO_INVAL_DATA in conn->=
want
+ *   -o readdirplus=3Dno        unsets FUSE_CAP_READDIRPLUS in conn->want
+ *   -o readdirplus=3Dyes       sets FUSE_CAP_READDIRPLUS and unsets
+ *                            FUSE_CAP_READDIRPLUS_AUTO in conn->want
+ *   -o readdirplus=3Dauto      sets FUSE_CAP_READDIRPLUS and
+ *                            FUSE_CAP_READDIRPLUS_AUTO in conn->want
+ *   -o [no_]async_dio        (un-)sets FUSE_CAP_ASYNC_DIO in conn->want
+ *   -o [no_]writeback_cache  (un-)sets FUSE_CAP_WRITEBACK_CACHE in conn->=
want
+ *   -o time_gran=3DN           sets conn->time_gran
+ *
+ * Known options will be removed from *args*, unknown options will be
+ * passed through unchanged.
+ *
+ * @param args argument vector (input+output)
+ * @return parsed options
+ **/
+struct fuse_conn_info_opts* fuse_parse_conn_info_opts(struct fuse_args *ar=
gs);
+
+/**
+ * This function applies the (parsed) parameters in *opts* to the
+ * *conn* pointer. It may modify the following fields: wants,
+ * max_write, max_readahead, congestion_threshold, max_background,
+ * time_gran. A field is only set (or unset) if the corresponding
+ * option has been explicitly set.
+ */
+void fuse_apply_conn_info_opts(struct fuse_conn_info_opts *opts,
+=09=09=09  struct fuse_conn_info *conn);
+
+/**
+ * Go into the background
+ *
+ * @param foreground if true, stay in the foreground
+ * @return 0 on success, -1 on failure
+ */
+int fuse_daemonize(int foreground);
+
+/**
+ * Get the version of the library
+ *
+ * @return the version
+ */
+int fuse_version(void);
+
+/**
+ * Get the full package version string of the library
+ *
+ * @return the package version
+ */
+const char *fuse_pkgversion(void);
+
+/**
+ * Destroy poll handle
+ *
+ * @param ph the poll handle
+ */
+void fuse_pollhandle_destroy(struct fuse_pollhandle *ph);
+
+/* ----------------------------------------------------------- *
+ * Data buffer=09=09=09=09=09=09       *
+ * ----------------------------------------------------------- */
+
+/**
+ * Buffer flags
+ */
+enum fuse_buf_flags {
+=09/**
+=09 * Buffer contains a file descriptor
+=09 *
+=09 * If this flag is set, the .fd field is valid, otherwise the
+=09 * .mem fields is valid.
+=09 */
+=09FUSE_BUF_IS_FD=09=09=3D (1 << 1),
+
+=09/**
+=09 * Seek on the file descriptor
+=09 *
+=09 * If this flag is set then the .pos field is valid and is
+=09 * used to seek to the given offset before performing
+=09 * operation on file descriptor.
+=09 */
+=09FUSE_BUF_FD_SEEK=09=3D (1 << 2),
+
+=09/**
+=09 * Retry operation on file descriptor
+=09 *
+=09 * If this flag is set then retry operation on file descriptor
+=09 * until .size bytes have been copied or an error or EOF is
+=09 * detected.
+=09 */
+=09FUSE_BUF_FD_RETRY=09=3D (1 << 3),
+};
+
+/**
+ * Buffer copy flags
+ */
+enum fuse_buf_copy_flags {
+=09/**
+=09 * Don't use splice(2)
+=09 *
+=09 * Always fall back to using read and write instead of
+=09 * splice(2) to copy data from one file descriptor to another.
+=09 *
+=09 * If this flag is not set, then only fall back if splice is
+=09 * unavailable.
+=09 */
+=09FUSE_BUF_NO_SPLICE=09=3D (1 << 1),
+
+=09/**
+=09 * Force splice
+=09 *
+=09 * Always use splice(2) to copy data from one file descriptor
+=09 * to another.  If splice is not available, return -EINVAL.
+=09 */
+=09FUSE_BUF_FORCE_SPLICE=09=3D (1 << 2),
+
+=09/**
+=09 * Try to move data with splice.
+=09 *
+=09 * If splice is used, try to move pages from the source to the
+=09 * destination instead of copying.  See documentation of
+=09 * SPLICE_F_MOVE in splice(2) man page.
+=09 */
+=09FUSE_BUF_SPLICE_MOVE=09=3D (1 << 3),
+
+=09/**
+=09 * Don't block on the pipe when copying data with splice
+=09 *
+=09 * Makes the operations on the pipe non-blocking (if the pipe
+=09 * is full or empty).  See SPLICE_F_NONBLOCK in the splice(2)
+=09 * man page.
+=09 */
+=09FUSE_BUF_SPLICE_NONBLOCK=3D (1 << 4),
+};
+
+/**
+ * Single data buffer
+ *
+ * Generic data buffer for I/O, extended attributes, etc...  Data may
+ * be supplied as a memory pointer or as a file descriptor
+ */
+struct fuse_buf {
+=09/**
+=09 * Size of data in bytes
+=09 */
+=09size_t size;
+
+=09/**
+=09 * Buffer flags
+=09 */
+=09enum fuse_buf_flags flags;
+
+=09/**
+=09 * Memory pointer
+=09 *
+=09 * Used unless FUSE_BUF_IS_FD flag is set.
+=09 */
+=09void *mem;
+
+=09/**
+=09 * File descriptor
+=09 *
+=09 * Used if FUSE_BUF_IS_FD flag is set.
+=09 */
+=09int fd;
+
+=09/**
+=09 * File position
+=09 *
+=09 * Used if FUSE_BUF_FD_SEEK flag is set.
+=09 */
+=09off_t pos;
+};
+
+/**
+ * Data buffer vector
+ *
+ * An array of data buffers, each containing a memory pointer or a
+ * file descriptor.
+ *
+ * Allocate dynamically to add more than one buffer.
+ */
+struct fuse_bufvec {
+=09/**
+=09 * Number of buffers in the array
+=09 */
+=09size_t count;
+
+=09/**
+=09 * Index of current buffer within the array
+=09 */
+=09size_t idx;
+
+=09/**
+=09 * Current offset within the current buffer
+=09 */
+=09size_t off;
+
+=09/**
+=09 * Array of buffers
+=09 */
+=09struct fuse_buf buf[1];
+};
+
+/* Initialize bufvec with a single buffer of given size */
+#define FUSE_BUFVEC_INIT(size__)=09=09=09=09\
+=09((struct fuse_bufvec) {=09=09=09=09=09\
+=09=09/* .count=3D */ 1,=09=09=09=09\
+=09=09/* .idx =3D  */ 0,=09=09=09=09\
+=09=09/* .off =3D  */ 0,=09=09=09=09\
+=09=09/* .buf =3D  */ { /* [0] =3D */ {=09=09=09\
+=09=09=09/* .size =3D  */ (size__),=09=09\
+=09=09=09/* .flags =3D */ (enum fuse_buf_flags) 0,=09\
+=09=09=09/* .mem =3D   */ NULL,=09=09=09\
+=09=09=09/* .fd =3D    */ -1,=09=09=09\
+=09=09=09/* .pos =3D   */ 0,=09=09=09\
+=09=09} }=09=09=09=09=09=09\
+=09} )
+
+/**
+ * Get total size of data in a fuse buffer vector
+ *
+ * @param bufv buffer vector
+ * @return size of data
+ */
+size_t fuse_buf_size(const struct fuse_bufvec *bufv);
+
+/**
+ * Copy data from one buffer vector to another
+ *
+ * @param dst destination buffer vector
+ * @param src source buffer vector
+ * @param flags flags controlling the copy
+ * @return actual number of bytes copied or -errno on error
+ */
+ssize_t fuse_buf_copy(struct fuse_bufvec *dst, struct fuse_bufvec *src,
+=09=09      enum fuse_buf_copy_flags flags);
+
+/* ----------------------------------------------------------- *
+ * Signal handling=09=09=09=09=09       *
+ * ----------------------------------------------------------- */
+
+/**
+ * Exit session on HUP, TERM and INT signals and ignore PIPE signal
+ *
+ * Stores session in a global variable.=09 May only be called once per
+ * process until fuse_remove_signal_handlers() is called.
+ *
+ * Once either of the POSIX signals arrives, the signal handler calls
+ * fuse_session_exit().
+ *
+ * @param se the session to exit
+ * @return 0 on success, -1 on failure
+ *
+ * See also:
+ * fuse_remove_signal_handlers()
+ */
+int fuse_set_signal_handlers(struct fuse_session *se);
+
+/**
+ * Restore default signal handlers
+ *
+ * Resets global session.  After this fuse_set_signal_handlers() may
+ * be called again.
+ *
+ * @param se the same session as given in fuse_set_signal_handlers()
+ *
+ * See also:
+ * fuse_set_signal_handlers()
+ */
+void fuse_remove_signal_handlers(struct fuse_session *se);
+
+/* ----------------------------------------------------------- *
+ * Compatibility stuff=09=09=09=09=09       *
+ * ----------------------------------------------------------- */
+
+#if !defined(FUSE_USE_VERSION) || FUSE_USE_VERSION < 30
+#  error only API version 30 or greater is supported
+#endif
+
+#ifdef __cplusplus
+}
+#endif
+
+
+/*
+ * This interface uses 64 bit off_t.
+ *
+ * On 32bit systems please add -D_FILE_OFFSET_BITS=3D64 to your compile fl=
ags!
+ */
+
+#if defined(__GNUC__) && (__GNUC__ > 4 || __GNUC__ =3D=3D 4 && __GNUC_MINO=
R__ >=3D 6) && !defined __cplusplus
+_Static_assert(sizeof(off_t) =3D=3D 8, "fuse: off_t must be 64bit");
+#else
+struct _fuse_off_t_must_be_64bit_dummy_struct \
+=09{ unsigned _fuse_off_t_must_be_64bit:((sizeof(off_t) =3D=3D 8) ? 1 : -1=
); };
+#endif
+
+#endif /* FUSE_COMMON_H_ */
diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
new file mode 100644
index 0000000000..d38b630ac5
--- /dev/null
+++ b/tools/virtiofsd/fuse_i.h
@@ -0,0 +1,139 @@
+/*
+  FUSE: Filesystem in Userspace
+  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+
+  This program can be distributed under the terms of the GNU LGPLv2.
+  See the file COPYING.LIB
+*/
+
+#include "fuse.h"
+#include "fuse_lowlevel.h"
+
+struct mount_opts;
+
+struct fuse_req {
+=09struct fuse_session *se;
+=09uint64_t unique;
+=09int ctr;
+=09pthread_mutex_t lock;
+=09struct fuse_ctx ctx;
+=09struct fuse_chan *ch;
+=09int interrupted;
+=09unsigned int ioctl_64bit : 1;
+=09union {
+=09=09struct {
+=09=09=09uint64_t unique;
+=09=09} i;
+=09=09struct {
+=09=09=09fuse_interrupt_func_t func;
+=09=09=09void *data;
+=09=09} ni;
+=09} u;
+=09struct fuse_req *next;
+=09struct fuse_req *prev;
+};
+
+struct fuse_notify_req {
+=09uint64_t unique;
+=09void (*reply)(struct fuse_notify_req *, fuse_req_t, fuse_ino_t,
+=09=09      const void *, const struct fuse_buf *);
+=09struct fuse_notify_req *next;
+=09struct fuse_notify_req *prev;
+};
+
+struct fuse_session {
+=09char *mountpoint;
+=09volatile int exited;
+=09int fd;
+=09struct mount_opts *mo;
+=09int debug;
+=09int deny_others;
+=09struct fuse_lowlevel_ops op;
+=09int got_init;
+=09struct cuse_data *cuse_data;
+=09void *userdata;
+=09uid_t owner;
+=09struct fuse_conn_info conn;
+=09struct fuse_req list;
+=09struct fuse_req interrupts;
+=09pthread_mutex_t lock;
+=09int got_destroy;
+=09pthread_key_t pipe_key;
+=09int broken_splice_nonblock;
+=09uint64_t notify_ctr;
+=09struct fuse_notify_req notify_list;
+=09size_t bufsize;
+=09int error;
+};
+
+struct fuse_chan {
+=09pthread_mutex_t lock;
+=09int ctr;
+=09int fd;
+};
+
+/**
+ * Filesystem module
+ *
+ * Filesystem modules are registered with the FUSE_REGISTER_MODULE()
+ * macro.
+ *
+ */
+struct fuse_module {
+=09char *name;
+=09fuse_module_factory_t factory;
+=09struct fuse_module *next;
+=09struct fusemod_so *so;
+=09int ctr;
+};
+
+/* ----------------------------------------------------------- *
+ * Channel interface (when using -o clone_fd)=09=09       *
+ * ----------------------------------------------------------- */
+
+/**
+ * Obtain counted reference to the channel
+ *
+ * @param ch the channel
+ * @return the channel
+ */
+struct fuse_chan *fuse_chan_get(struct fuse_chan *ch);
+
+/**
+ * Drop counted reference to a channel
+ *
+ * @param ch the channel
+ */
+void fuse_chan_put(struct fuse_chan *ch);
+
+struct mount_opts *parse_mount_opts(struct fuse_args *args);
+void destroy_mount_opts(struct mount_opts *mo);
+void fuse_mount_version(void);
+unsigned get_max_read(struct mount_opts *o);
+void fuse_kern_unmount(const char *mountpoint, int fd);
+int fuse_kern_mount(const char *mountpoint, struct mount_opts *mo);
+
+int fuse_send_reply_iov_nofree(fuse_req_t req, int error, struct iovec *io=
v,
+=09=09=09       int count);
+void fuse_free_req(fuse_req_t req);
+
+void cuse_lowlevel_init(fuse_req_t req, fuse_ino_t nodeide, const void *in=
arg);
+
+int fuse_start_thread(pthread_t *thread_id, void *(*func)(void *), void *a=
rg);
+
+int fuse_session_receive_buf_int(struct fuse_session *se, struct fuse_buf =
*buf,
+=09=09=09=09 struct fuse_chan *ch);
+void fuse_session_process_buf_int(struct fuse_session *se,
+=09=09=09=09  const struct fuse_buf *buf, struct fuse_chan *ch);
+
+struct fuse *fuse_new_31(struct fuse_args *args, const struct fuse_operati=
ons *op,
+=09=09      size_t op_size, void *private_data);
+int fuse_loop_mt_32(struct fuse *f, struct fuse_loop_config *config);
+int fuse_session_loop_mt_32(struct fuse_session *se, struct fuse_loop_conf=
ig *config);
+
+#define FUSE_MAX_MAX_PAGES 256
+#define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
+
+/* room needed in buffer to accommodate header */
+#define FUSE_BUFFER_HEADER_SIZE 0x1000
+
diff --git a/tools/virtiofsd/fuse_log.h b/tools/virtiofsd/fuse_log.h
new file mode 100644
index 0000000000..5e112e0f53
--- /dev/null
+++ b/tools/virtiofsd/fuse_log.h
@@ -0,0 +1,82 @@
+/*
+  FUSE: Filesystem in Userspace
+  Copyright (C) 2019  Red Hat, Inc.
+
+  This program can be distributed under the terms of the GNU LGPLv2.
+  See the file COPYING.LIB.
+*/
+
+#ifndef FUSE_LOG_H_
+#define FUSE_LOG_H_
+
+/** @file
+ *
+ * This file defines the logging interface of FUSE
+ */
+
+#include <stdarg.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * Log severity level
+ *
+ * These levels correspond to syslog(2) log levels since they are widely u=
sed.
+ */
+enum fuse_log_level {
+=09FUSE_LOG_EMERG,
+=09FUSE_LOG_ALERT,
+=09FUSE_LOG_CRIT,
+=09FUSE_LOG_ERR,
+=09FUSE_LOG_WARNING,
+=09FUSE_LOG_NOTICE,
+=09FUSE_LOG_INFO,
+=09FUSE_LOG_DEBUG
+};
+
+/**
+ * Log message handler function.
+ *
+ * This function must be thread-safe.  It may be called from any libfuse
+ * function, including fuse_parse_cmdline() and other functions invoked be=
fore
+ * a FUSE filesystem is created.
+ *
+ * Install a custom log message handler function using fuse_set_log_func()=
.
+ *
+ * @param level log severity level
+ * @param fmt sprintf-style format string including newline
+ * @param ap format string arguments
+ */
+typedef void (*fuse_log_func_t)(enum fuse_log_level level,
+=09=09=09=09const char *fmt, va_list ap);
+
+/**
+ * Install a custom log handler function.
+ *
+ * Log messages are emitted by libfuse functions to report errors and debu=
g
+ * information.  Messages are printed to stderr by default but this can be
+ * overridden by installing a custom log message handler function.
+ *
+ * The log message handler function is global and affects all FUSE filesys=
tems
+ * created within this process.
+ *
+ * @param func a custom log message handler function or NULL to revert to
+ *             the default
+ */
+void fuse_set_log_func(fuse_log_func_t func);
+
+/**
+ * Emit a log message
+ *
+ * @param level severity level (FUSE_LOG_ERR, FUSE_LOG_DEBUG, etc)
+ * @param fmt sprintf-style format string including newline
+ */
+void fuse_log(enum fuse_log_level level, const char *fmt, ...);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* FUSE_LOG_H_ */
diff --git a/tools/virtiofsd/fuse_lowlevel.h b/tools/virtiofsd/fuse_lowleve=
l.h
new file mode 100644
index 0000000000..18c6363f07
--- /dev/null
+++ b/tools/virtiofsd/fuse_lowlevel.h
@@ -0,0 +1,2089 @@
+/*
+  FUSE: Filesystem in Userspace
+  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+
+  This program can be distributed under the terms of the GNU LGPLv2.
+  See the file COPYING.LIB.
+*/
+
+#ifndef FUSE_LOWLEVEL_H_
+#define FUSE_LOWLEVEL_H_
+
+/** @file
+ *
+ * Low level API
+ *
+ * IMPORTANT: you should define FUSE_USE_VERSION before including this
+ * header.  To use the newest API define it to 31 (recommended for any
+ * new application).
+ */
+
+#ifndef FUSE_USE_VERSION
+#error FUSE_USE_VERSION not defined
+#endif
+
+#include "fuse_common.h"
+
+#include <utime.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/statvfs.h>
+#include <sys/uio.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/* ----------------------------------------------------------- *
+ * Miscellaneous definitions=09=09=09=09       *
+ * ----------------------------------------------------------- */
+
+/** The node ID of the root inode */
+#define FUSE_ROOT_ID 1
+
+/** Inode number type */
+typedef uint64_t fuse_ino_t;
+
+/** Request pointer type */
+typedef struct fuse_req *fuse_req_t;
+
+/**
+ * Session
+ *
+ * This provides hooks for processing requests, and exiting
+ */
+struct fuse_session;
+
+/** Directory entry parameters supplied to fuse_reply_entry() */
+struct fuse_entry_param {
+=09/** Unique inode number
+=09 *
+=09 * In lookup, zero means negative entry (from version 2.5)
+=09 * Returning ENOENT also means negative entry, but by setting zero
+=09 * ino the kernel may cache negative entries for entry_timeout
+=09 * seconds.
+=09 */
+=09fuse_ino_t ino;
+
+=09/** Generation number for this entry.
+=09 *
+=09 * If the file system will be exported over NFS, the
+=09 * ino/generation pairs need to be unique over the file
+=09 * system's lifetime (rather than just the mount time). So if
+=09 * the file system reuses an inode after it has been deleted,
+=09 * it must assign a new, previously unused generation number
+=09 * to the inode at the same time.
+=09 *
+=09 */
+=09uint64_t generation;
+
+=09/** Inode attributes.
+=09 *
+=09 * Even if attr_timeout =3D=3D 0, attr must be correct. For example,
+=09 * for open(), FUSE uses attr.st_size from lookup() to determine
+=09 * how many bytes to request. If this value is not correct,
+=09 * incorrect data will be returned.
+=09 */
+=09struct stat attr;
+
+=09/** Validity timeout (in seconds) for inode attributes. If
+=09    attributes only change as a result of requests that come
+=09    through the kernel, this should be set to a very large
+=09    value. */
+=09double attr_timeout;
+
+=09/** Validity timeout (in seconds) for the name. If directory
+=09    entries are changed/deleted only as a result of requests
+=09    that come through the kernel, this should be set to a very
+=09    large value. */
+=09double entry_timeout;
+};
+
+/**
+ * Additional context associated with requests.
+ *
+ * Note that the reported client uid, gid and pid may be zero in some
+ * situations. For example, if the FUSE file system is running in a
+ * PID or user namespace but then accessed from outside the namespace,
+ * there is no valid uid/pid/gid that could be reported.
+ */
+struct fuse_ctx {
+=09/** User ID of the calling process */
+=09uid_t uid;
+
+=09/** Group ID of the calling process */
+=09gid_t gid;
+
+=09/** Thread ID of the calling process */
+=09pid_t pid;
+
+=09/** Umask of the calling process */
+=09mode_t umask;
+};
+
+struct fuse_forget_data {
+=09fuse_ino_t ino;
+=09uint64_t nlookup;
+};
+
+/* 'to_set' flags in setattr */
+#define FUSE_SET_ATTR_MODE=09(1 << 0)
+#define FUSE_SET_ATTR_UID=09(1 << 1)
+#define FUSE_SET_ATTR_GID=09(1 << 2)
+#define FUSE_SET_ATTR_SIZE=09(1 << 3)
+#define FUSE_SET_ATTR_ATIME=09(1 << 4)
+#define FUSE_SET_ATTR_MTIME=09(1 << 5)
+#define FUSE_SET_ATTR_ATIME_NOW=09(1 << 7)
+#define FUSE_SET_ATTR_MTIME_NOW=09(1 << 8)
+#define FUSE_SET_ATTR_CTIME=09(1 << 10)
+
+/* ----------------------------------------------------------- *
+ * Request methods and replies=09=09=09=09       *
+ * ----------------------------------------------------------- */
+
+/**
+ * Low level filesystem operations
+ *
+ * Most of the methods (with the exception of init and destroy)
+ * receive a request handle (fuse_req_t) as their first argument.
+ * This handle must be passed to one of the specified reply functions.
+ *
+ * This may be done inside the method invocation, or after the call
+ * has returned.  The request handle is valid until one of the reply
+ * functions is called.
+ *
+ * Other pointer arguments (name, fuse_file_info, etc) are not valid
+ * after the call has returned, so if they are needed later, their
+ * contents have to be copied.
+ *
+ * In general, all methods are expected to perform any necessary
+ * permission checking. However, a filesystem may delegate this task
+ * to the kernel by passing the `default_permissions` mount option to
+ * `fuse_session_new()`. In this case, methods will only be called if
+ * the kernel's permission check has succeeded.
+ *
+ * The filesystem sometimes needs to handle a return value of -ENOENT
+ * from the reply function, which means, that the request was
+ * interrupted, and the reply discarded.  For example if
+ * fuse_reply_open() return -ENOENT means, that the release method for
+ * this file will not be called.
+ */
+struct fuse_lowlevel_ops {
+=09/**
+=09 * Initialize filesystem
+=09 *
+=09 * This function is called when libfuse establishes
+=09 * communication with the FUSE kernel module. The file system
+=09 * should use this module to inspect and/or modify the
+=09 * connection parameters provided in the `conn` structure.
+=09 *
+=09 * Note that some parameters may be overwritten by options
+=09 * passed to fuse_session_new() which take precedence over the
+=09 * values set in this handler.
+=09 *
+=09 * There's no reply to this function
+=09 *
+=09 * @param userdata the user data passed to fuse_session_new()
+=09 */
+=09void (*init) (void *userdata, struct fuse_conn_info *conn);
+
+=09/**
+=09 * Clean up filesystem.
+=09 *
+=09 * Called on filesystem exit. When this method is called, the
+=09 * connection to the kernel may be gone already, so that eg. calls
+=09 * to fuse_lowlevel_notify_* will fail.
+=09 *
+=09 * There's no reply to this function
+=09 *
+=09 * @param userdata the user data passed to fuse_session_new()
+=09 */
+=09void (*destroy) (void *userdata);
+
+=09/**
+=09 * Look up a directory entry by name and get its attributes.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_entry
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param parent inode number of the parent directory
+=09 * @param name the name to look up
+=09 */
+=09void (*lookup) (fuse_req_t req, fuse_ino_t parent, const char *name);
+
+=09/**
+=09 * Forget about an inode
+=09 *
+=09 * This function is called when the kernel removes an inode
+=09 * from its internal caches.
+=09 *
+=09 * The inode's lookup count increases by one for every call to
+=09 * fuse_reply_entry and fuse_reply_create. The nlookup parameter
+=09 * indicates by how much the lookup count should be decreased.
+=09 *
+=09 * Inodes with a non-zero lookup count may receive request from
+=09 * the kernel even after calls to unlink, rmdir or (when
+=09 * overwriting an existing file) rename. Filesystems must handle
+=09 * such requests properly and it is recommended to defer removal
+=09 * of the inode until the lookup count reaches zero. Calls to
+=09 * unlink, rmdir or rename will be followed closely by forget
+=09 * unless the file or directory is open, in which case the
+=09 * kernel issues forget only after the release or releasedir
+=09 * calls.
+=09 *
+=09 * Note that if a file system will be exported over NFS the
+=09 * inodes lifetime must extend even beyond forget. See the
+=09 * generation field in struct fuse_entry_param above.
+=09 *
+=09 * On unmount the lookup count for all inodes implicitly drops
+=09 * to zero. It is not guaranteed that the file system will
+=09 * receive corresponding forget messages for the affected
+=09 * inodes.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_none
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param nlookup the number of lookups to forget
+=09 */
+=09void (*forget) (fuse_req_t req, fuse_ino_t ino, uint64_t nlookup);
+
+=09/**
+=09 * Get file attributes.
+=09 *
+=09 * If writeback caching is enabled, the kernel may have a
+=09 * better idea of a file's length than the FUSE file system
+=09 * (eg if there has been a write that extended the file size,
+=09 * but that has not yet been passed to the filesystem.n
+=09 *
+=09 * In this case, the st_size value provided by the file system
+=09 * will be ignored.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_attr
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param fi for future use, currently always NULL
+=09 */
+=09void (*getattr) (fuse_req_t req, fuse_ino_t ino,
+=09=09=09 struct fuse_file_info *fi);
+
+=09/**
+=09 * Set file attributes
+=09 *
+=09 * In the 'attr' argument only members indicated by the 'to_set'
+=09 * bitmask contain valid values.  Other members contain undefined
+=09 * values.
+=09 *
+=09 * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled, this method is
+=09 * expected to reset the setuid and setgid bits if the file
+=09 * size or owner is being changed.
+=09 *
+=09 * If the setattr was invoked from the ftruncate() system call
+=09 * under Linux kernel versions 2.6.15 or later, the fi->fh will
+=09 * contain the value set by the open method or will be undefined
+=09 * if the open method didn't set any value.  Otherwise (not
+=09 * ftruncate call, or kernel version earlier than 2.6.15) the fi
+=09 * parameter will be NULL.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_attr
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param attr the attributes
+=09 * @param to_set bit mask of attributes which should be set
+=09 * @param fi file information, or NULL
+=09 */
+=09void (*setattr) (fuse_req_t req, fuse_ino_t ino, struct stat *attr,
+=09=09=09 int to_set, struct fuse_file_info *fi);
+
+=09/**
+=09 * Read symbolic link
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_readlink
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 */
+=09void (*readlink) (fuse_req_t req, fuse_ino_t ino);
+
+=09/**
+=09 * Create file node
+=09 *
+=09 * Create a regular file, character device, block device, fifo or
+=09 * socket node.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_entry
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param parent inode number of the parent directory
+=09 * @param name to create
+=09 * @param mode file type and mode with which to create the new file
+=09 * @param rdev the device number (only valid if created file is a devic=
e)
+=09 */
+=09void (*mknod) (fuse_req_t req, fuse_ino_t parent, const char *name,
+=09=09       mode_t mode, dev_t rdev);
+
+=09/**
+=09 * Create a directory
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_entry
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param parent inode number of the parent directory
+=09 * @param name to create
+=09 * @param mode with which to create the new file
+=09 */
+=09void (*mkdir) (fuse_req_t req, fuse_ino_t parent, const char *name,
+=09=09       mode_t mode);
+
+=09/**
+=09 * Remove a file
+=09 *
+=09 * If the file's inode's lookup count is non-zero, the file
+=09 * system is expected to postpone any removal of the inode
+=09 * until the lookup count reaches zero (see description of the
+=09 * forget function).
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param parent inode number of the parent directory
+=09 * @param name to remove
+=09 */
+=09void (*unlink) (fuse_req_t req, fuse_ino_t parent, const char *name);
+
+=09/**
+=09 * Remove a directory
+=09 *
+=09 * If the directory's inode's lookup count is non-zero, the
+=09 * file system is expected to postpone any removal of the
+=09 * inode until the lookup count reaches zero (see description
+=09 * of the forget function).
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param parent inode number of the parent directory
+=09 * @param name to remove
+=09 */
+=09void (*rmdir) (fuse_req_t req, fuse_ino_t parent, const char *name);
+
+=09/**
+=09 * Create a symbolic link
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_entry
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param link the contents of the symbolic link
+=09 * @param parent inode number of the parent directory
+=09 * @param name to create
+=09 */
+=09void (*symlink) (fuse_req_t req, const char *link, fuse_ino_t parent,
+=09=09=09 const char *name);
+
+=09/** Rename a file
+=09 *
+=09 * If the target exists it should be atomically replaced. If
+=09 * the target's inode's lookup count is non-zero, the file
+=09 * system is expected to postpone any removal of the inode
+=09 * until the lookup count reaches zero (see description of the
+=09 * forget function).
+=09 *
+=09 * If this request is answered with an error code of ENOSYS, this is
+=09 * treated as a permanent failure with error code EINVAL, i.e. all
+=09 * future bmap requests will fail with EINVAL without being
+=09 * send to the filesystem process.
+=09 *
+=09 * *flags* may be `RENAME_EXCHANGE` or `RENAME_NOREPLACE`. If
+=09 * RENAME_NOREPLACE is specified, the filesystem must not
+=09 * overwrite *newname* if it exists and return an error
+=09 * instead. If `RENAME_EXCHANGE` is specified, the filesystem
+=09 * must atomically exchange the two files, i.e. both must
+=09 * exist and neither may be deleted.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param parent inode number of the old parent directory
+=09 * @param name old name
+=09 * @param newparent inode number of the new parent directory
+=09 * @param newname new name
+=09 */
+=09void (*rename) (fuse_req_t req, fuse_ino_t parent, const char *name,
+=09=09=09fuse_ino_t newparent, const char *newname,
+=09=09=09unsigned int flags);
+
+=09/**
+=09 * Create a hard link
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_entry
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the old inode number
+=09 * @param newparent inode number of the new parent directory
+=09 * @param newname new name to create
+=09 */
+=09void (*link) (fuse_req_t req, fuse_ino_t ino, fuse_ino_t newparent,
+=09=09      const char *newname);
+
+=09/**
+=09 * Open a file
+=09 *
+=09 * Open flags are available in fi->flags. The following rules
+=09 * apply.
+=09 *
+=09 *  - Creation (O_CREAT, O_EXCL, O_NOCTTY) flags will be
+=09 *    filtered out / handled by the kernel.
+=09 *
+=09 *  - Access modes (O_RDONLY, O_WRONLY, O_RDWR) should be used
+=09 *    by the filesystem to check if the operation is
+=09 *    permitted.  If the ``-o default_permissions`` mount
+=09 *    option is given, this check is already done by the
+=09 *    kernel before calling open() and may thus be omitted by
+=09 *    the filesystem.
+=09 *
+=09 *  - When writeback caching is enabled, the kernel may send
+=09 *    read requests even for files opened with O_WRONLY. The
+=09 *    filesystem should be prepared to handle this.
+=09 *
+=09 *  - When writeback caching is disabled, the filesystem is
+=09 *    expected to properly handle the O_APPEND flag and ensure
+=09 *    that each write is appending to the end of the file.
+=09 *=20
+         *  - When writeback caching is enabled, the kernel will
+=09 *    handle O_APPEND. However, unless all changes to the file
+=09 *    come through the kernel this will not work reliably. The
+=09 *    filesystem should thus either ignore the O_APPEND flag
+=09 *    (and let the kernel handle it), or return an error
+=09 *    (indicating that reliably O_APPEND is not available).
+=09 *
+=09 * Filesystem may store an arbitrary file handle (pointer,
+=09 * index, etc) in fi->fh, and use this in other all other file
+=09 * operations (read, write, flush, release, fsync).
+=09 *
+=09 * Filesystem may also implement stateless file I/O and not store
+=09 * anything in fi->fh.
+=09 *
+=09 * There are also some flags (direct_io, keep_cache) which the
+=09 * filesystem may set in fi, to change the way the file is opened.
+=09 * See fuse_file_info structure in <fuse_common.h> for more details.
+=09 *
+=09 * If this request is answered with an error code of ENOSYS
+=09 * and FUSE_CAP_NO_OPEN_SUPPORT is set in
+=09 * `fuse_conn_info.capable`, this is treated as success and
+=09 * future calls to open and release will also succeed without being
+=09 * sent to the filesystem process.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_open
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param fi file information
+=09 */
+=09void (*open) (fuse_req_t req, fuse_ino_t ino,
+=09=09      struct fuse_file_info *fi);
+
+=09/**
+=09 * Read data
+=09 *
+=09 * Read should send exactly the number of bytes requested except
+=09 * on EOF or error, otherwise the rest of the data will be
+=09 * substituted with zeroes.  An exception to this is when the file
+=09 * has been opened in 'direct_io' mode, in which case the return
+=09 * value of the read system call will reflect the return value of
+=09 * this operation.
+=09 *
+=09 * fi->fh will contain the value set by the open method, or will
+=09 * be undefined if the open method didn't set any value.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_buf
+=09 *   fuse_reply_iov
+=09 *   fuse_reply_data
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param size number of bytes to read
+=09 * @param off offset to read from
+=09 * @param fi file information
+=09 */
+=09void (*read) (fuse_req_t req, fuse_ino_t ino, size_t size, off_t off,
+=09=09      struct fuse_file_info *fi);
+
+=09/**
+=09 * Write data
+=09 *
+=09 * Write should return exactly the number of bytes requested
+=09 * except on error.  An exception to this is when the file has
+=09 * been opened in 'direct_io' mode, in which case the return value
+=09 * of the write system call will reflect the return value of this
+=09 * operation.
+=09 *
+=09 * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled, this method is
+=09 * expected to reset the setuid and setgid bits.
+=09 *
+=09 * fi->fh will contain the value set by the open method, or will
+=09 * be undefined if the open method didn't set any value.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_write
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param buf data to write
+=09 * @param size number of bytes to write
+=09 * @param off offset to write to
+=09 * @param fi file information
+=09 */
+=09void (*write) (fuse_req_t req, fuse_ino_t ino, const char *buf,
+=09=09       size_t size, off_t off, struct fuse_file_info *fi);
+
+=09/**
+=09 * Flush method
+=09 *
+=09 * This is called on each close() of the opened file.
+=09 *
+=09 * Since file descriptors can be duplicated (dup, dup2, fork), for
+=09 * one open call there may be many flush calls.
+=09 *
+=09 * Filesystems shouldn't assume that flush will always be called
+=09 * after some writes, or that if will be called at all.
+=09 *
+=09 * fi->fh will contain the value set by the open method, or will
+=09 * be undefined if the open method didn't set any value.
+=09 *
+=09 * NOTE: the name of the method is misleading, since (unlike
+=09 * fsync) the filesystem is not forced to flush pending writes.
+=09 * One reason to flush data is if the filesystem wants to return
+=09 * write errors during close.  However, such use is non-portable
+=09 * because POSIX does not require [close] to wait for delayed I/O to
+=09 * complete.
+=09 *
+=09 * If the filesystem supports file locking operations (setlk,
+=09 * getlk) it should remove all locks belonging to 'fi->owner'.
+=09 *
+=09 * If this request is answered with an error code of ENOSYS,
+=09 * this is treated as success and future calls to flush() will
+=09 * succeed automatically without being send to the filesystem
+=09 * process.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param fi file information
+=09 *
+=09 * [close]: http://pubs.opengroup.org/onlinepubs/9699919799/functions/c=
lose.html
+=09 */
+=09void (*flush) (fuse_req_t req, fuse_ino_t ino,
+=09=09       struct fuse_file_info *fi);
+
+=09/**
+=09 * Release an open file
+=09 *
+=09 * Release is called when there are no more references to an open
+=09 * file: all file descriptors are closed and all memory mappings
+=09 * are unmapped.
+=09 *
+=09 * For every open call there will be exactly one release call (unless
+=09 * the filesystem is force-unmounted).
+=09 *
+=09 * The filesystem may reply with an error, but error values are
+=09 * not returned to close() or munmap() which triggered the
+=09 * release.
+=09 *
+=09 * fi->fh will contain the value set by the open method, or will
+=09 * be undefined if the open method didn't set any value.
+=09 * fi->flags will contain the same flags as for open.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param fi file information
+=09 */
+=09void (*release) (fuse_req_t req, fuse_ino_t ino,
+=09=09=09 struct fuse_file_info *fi);
+
+=09/**
+=09 * Synchronize file contents
+=09 *
+=09 * If the datasync parameter is non-zero, then only the user data
+=09 * should be flushed, not the meta data.
+=09 *
+=09 * If this request is answered with an error code of ENOSYS,
+=09 * this is treated as success and future calls to fsync() will
+=09 * succeed automatically without being send to the filesystem
+=09 * process.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param datasync flag indicating if only data should be flushed
+=09 * @param fi file information
+=09 */
+=09void (*fsync) (fuse_req_t req, fuse_ino_t ino, int datasync,
+=09=09       struct fuse_file_info *fi);
+
+=09/**
+=09 * Open a directory
+=09 *
+=09 * Filesystem may store an arbitrary file handle (pointer, index,
+=09 * etc) in fi->fh, and use this in other all other directory
+=09 * stream operations (readdir, releasedir, fsyncdir).
+=09 *
+=09 * If this request is answered with an error code of ENOSYS and
+=09 * FUSE_CAP_NO_OPENDIR_SUPPORT is set in `fuse_conn_info.capable`,
+=09 * this is treated as success and future calls to opendir and
+=09 * releasedir will also succeed without being sent to the filesystem
+=09 * process. In addition, the kernel will cache readdir results
+=09 * as if opendir returned FOPEN_KEEP_CACHE | FOPEN_CACHE_DIR.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_open
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param fi file information
+=09 */
+=09void (*opendir) (fuse_req_t req, fuse_ino_t ino,
+=09=09=09 struct fuse_file_info *fi);
+
+=09/**
+=09 * Read directory
+=09 *
+=09 * Send a buffer filled using fuse_add_direntry(), with size not
+=09 * exceeding the requested size.  Send an empty buffer on end of
+=09 * stream.
+=09 *
+=09 * fi->fh will contain the value set by the opendir method, or
+=09 * will be undefined if the opendir method didn't set any value.
+=09 *
+=09 * Returning a directory entry from readdir() does not affect
+=09 * its lookup count.
+=09 *
+         * If off_t is non-zero, then it will correspond to one of the off=
_t
+=09 * values that was previously returned by readdir() for the same
+=09 * directory handle. In this case, readdir() should skip over entries
+=09 * coming before the position defined by the off_t value. If entries
+=09 * are added or removed while the directory handle is open, they filesy=
stem
+=09 * may still include the entries that have been removed, and may not
+=09 * report the entries that have been created. However, addition or
+=09 * removal of entries must never cause readdir() to skip over unrelated
+=09 * entries or to report them more than once. This means
+=09 * that off_t can not be a simple index that enumerates the entries
+=09 * that have been returned but must contain sufficient information to
+=09 * uniquely determine the next directory entry to return even when the
+=09 * set of entries is changing.
+=09 *
+=09 * The function does not have to report the '.' and '..'
+=09 * entries, but is allowed to do so. Note that, if readdir does
+=09 * not return '.' or '..', they will not be implicitly returned,
+=09 * and this behavior is observable by the caller.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_buf
+=09 *   fuse_reply_data
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param size maximum number of bytes to send
+=09 * @param off offset to continue reading the directory stream
+=09 * @param fi file information
+=09 */
+=09void (*readdir) (fuse_req_t req, fuse_ino_t ino, size_t size, off_t off=
,
+=09=09=09 struct fuse_file_info *fi);
+
+=09/**
+=09 * Release an open directory
+=09 *
+=09 * For every opendir call there will be exactly one releasedir
+=09 * call (unless the filesystem is force-unmounted).
+=09 *
+=09 * fi->fh will contain the value set by the opendir method, or
+=09 * will be undefined if the opendir method didn't set any value.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param fi file information
+=09 */
+=09void (*releasedir) (fuse_req_t req, fuse_ino_t ino,
+=09=09=09    struct fuse_file_info *fi);
+
+=09/**
+=09 * Synchronize directory contents
+=09 *
+=09 * If the datasync parameter is non-zero, then only the directory
+=09 * contents should be flushed, not the meta data.
+=09 *
+=09 * fi->fh will contain the value set by the opendir method, or
+=09 * will be undefined if the opendir method didn't set any value.
+=09 *
+=09 * If this request is answered with an error code of ENOSYS,
+=09 * this is treated as success and future calls to fsyncdir() will
+=09 * succeed automatically without being send to the filesystem
+=09 * process.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param datasync flag indicating if only data should be flushed
+=09 * @param fi file information
+=09 */
+=09void (*fsyncdir) (fuse_req_t req, fuse_ino_t ino, int datasync,
+=09=09=09  struct fuse_file_info *fi);
+
+=09/**
+=09 * Get file system statistics
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_statfs
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number, zero means "undefined"
+=09 */
+=09void (*statfs) (fuse_req_t req, fuse_ino_t ino);
+
+=09/**
+=09 * Set an extended attribute
+=09 *
+=09 * If this request is answered with an error code of ENOSYS, this is
+=09 * treated as a permanent failure with error code EOPNOTSUPP, i.e. all
+=09 * future setxattr() requests will fail with EOPNOTSUPP without being
+=09 * send to the filesystem process.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_err
+=09 */
+=09void (*setxattr) (fuse_req_t req, fuse_ino_t ino, const char *name,
+=09=09=09  const char *value, size_t size, int flags);
+
+=09/**
+=09 * Get an extended attribute
+=09 *
+=09 * If size is zero, the size of the value should be sent with
+=09 * fuse_reply_xattr.
+=09 *
+=09 * If the size is non-zero, and the value fits in the buffer, the
+=09 * value should be sent with fuse_reply_buf.
+=09 *
+=09 * If the size is too small for the value, the ERANGE error should
+=09 * be sent.
+=09 *
+=09 * If this request is answered with an error code of ENOSYS, this is
+=09 * treated as a permanent failure with error code EOPNOTSUPP, i.e. all
+=09 * future getxattr() requests will fail with EOPNOTSUPP without being
+=09 * send to the filesystem process.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_buf
+=09 *   fuse_reply_data
+=09 *   fuse_reply_xattr
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param name of the extended attribute
+=09 * @param size maximum size of the value to send
+=09 */
+=09void (*getxattr) (fuse_req_t req, fuse_ino_t ino, const char *name,
+=09=09=09  size_t size);
+
+=09/**
+=09 * List extended attribute names
+=09 *
+=09 * If size is zero, the total size of the attribute list should be
+=09 * sent with fuse_reply_xattr.
+=09 *
+=09 * If the size is non-zero, and the null character separated
+=09 * attribute list fits in the buffer, the list should be sent with
+=09 * fuse_reply_buf.
+=09 *
+=09 * If the size is too small for the list, the ERANGE error should
+=09 * be sent.
+=09 *
+=09 * If this request is answered with an error code of ENOSYS, this is
+=09 * treated as a permanent failure with error code EOPNOTSUPP, i.e. all
+=09 * future listxattr() requests will fail with EOPNOTSUPP without being
+=09 * send to the filesystem process.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_buf
+=09 *   fuse_reply_data
+=09 *   fuse_reply_xattr
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param size maximum size of the list to send
+=09 */
+=09void (*listxattr) (fuse_req_t req, fuse_ino_t ino, size_t size);
+
+=09/**
+=09 * Remove an extended attribute
+=09 *
+=09 * If this request is answered with an error code of ENOSYS, this is
+=09 * treated as a permanent failure with error code EOPNOTSUPP, i.e. all
+=09 * future removexattr() requests will fail with EOPNOTSUPP without bein=
g
+=09 * send to the filesystem process.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param name of the extended attribute
+=09 */
+=09void (*removexattr) (fuse_req_t req, fuse_ino_t ino, const char *name);
+
+=09/**
+=09 * Check file access permissions
+=09 *
+=09 * This will be called for the access() and chdir() system
+=09 * calls.  If the 'default_permissions' mount option is given,
+=09 * this method is not called.
+=09 *
+=09 * This method is not called under Linux kernel versions 2.4.x
+=09 *
+=09 * If this request is answered with an error code of ENOSYS, this is
+=09 * treated as a permanent success, i.e. this and all future access()
+=09 * requests will succeed without being send to the filesystem process.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param mask requested access mode
+=09 */
+=09void (*access) (fuse_req_t req, fuse_ino_t ino, int mask);
+
+=09/**
+=09 * Create and open a file
+=09 *
+=09 * If the file does not exist, first create it with the specified
+=09 * mode, and then open it.
+=09 *
+=09 * See the description of the open handler for more
+=09 * information.
+=09 *
+=09 * If this method is not implemented or under Linux kernel
+=09 * versions earlier than 2.6.15, the mknod() and open() methods
+=09 * will be called instead.
+=09 *
+=09 * If this request is answered with an error code of ENOSYS, the handle=
r
+=09 * is treated as not implemented (i.e., for this and future requests th=
e
+=09 * mknod() and open() handlers will be called instead).
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_create
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param parent inode number of the parent directory
+=09 * @param name to create
+=09 * @param mode file type and mode with which to create the new file
+=09 * @param fi file information
+=09 */
+=09void (*create) (fuse_req_t req, fuse_ino_t parent, const char *name,
+=09=09=09mode_t mode, struct fuse_file_info *fi);
+
+=09/**
+=09 * Test for a POSIX file lock
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_lock
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param fi file information
+=09 * @param lock the region/type to test
+=09 */
+=09void (*getlk) (fuse_req_t req, fuse_ino_t ino,
+=09=09       struct fuse_file_info *fi, struct flock *lock);
+
+=09/**
+=09 * Acquire, modify or release a POSIX file lock
+=09 *
+=09 * For POSIX threads (NPTL) there's a 1-1 relation between pid and
+=09 * owner, but otherwise this is not always the case.  For checking
+=09 * lock ownership, 'fi->owner' must be used.  The l_pid field in
+=09 * 'struct flock' should only be used to fill in this field in
+=09 * getlk().
+=09 *
+=09 * Note: if the locking methods are not implemented, the kernel
+=09 * will still allow file locking to work locally.  Hence these are
+=09 * only interesting for network filesystems and similar.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param fi file information
+=09 * @param lock the region/type to set
+=09 * @param sleep locking operation may sleep
+=09 */
+=09void (*setlk) (fuse_req_t req, fuse_ino_t ino,
+=09=09       struct fuse_file_info *fi,
+=09=09       struct flock *lock, int sleep);
+
+=09/**
+=09 * Map block index within file to block index within device
+=09 *
+=09 * Note: This makes sense only for block device backed filesystems
+=09 * mounted with the 'blkdev' option
+=09 *
+=09 * If this request is answered with an error code of ENOSYS, this is
+=09 * treated as a permanent failure, i.e. all future bmap() requests will
+=09 * fail with the same error code without being send to the filesystem
+=09 * process.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_bmap
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param blocksize unit of block index
+=09 * @param idx block index within file
+=09 */
+=09void (*bmap) (fuse_req_t req, fuse_ino_t ino, size_t blocksize,
+=09=09      uint64_t idx);
+
+=09/**
+=09 * Ioctl
+=09 *
+=09 * Note: For unrestricted ioctls (not allowed for FUSE
+=09 * servers), data in and out areas can be discovered by giving
+=09 * iovs and setting FUSE_IOCTL_RETRY in *flags*.  For
+=09 * restricted ioctls, kernel prepares in/out data area
+=09 * according to the information encoded in cmd.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_ioctl_retry
+=09 *   fuse_reply_ioctl
+=09 *   fuse_reply_ioctl_iov
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param cmd ioctl command
+=09 * @param arg ioctl argument
+=09 * @param fi file information
+=09 * @param flags for FUSE_IOCTL_* flags
+=09 * @param in_buf data fetched from the caller
+=09 * @param in_bufsz number of fetched bytes
+=09 * @param out_bufsz maximum size of output data
+=09 *
+=09 * Note : the unsigned long request submitted by the application
+=09 * is truncated to 32 bits.
+=09 */
+=09void (*ioctl) (fuse_req_t req, fuse_ino_t ino, unsigned int cmd,
+=09=09       void *arg, struct fuse_file_info *fi, unsigned flags,
+=09=09       const void *in_buf, size_t in_bufsz, size_t out_bufsz);
+
+=09/**
+=09 * Poll for IO readiness
+=09 *
+=09 * Note: If ph is non-NULL, the client should notify
+=09 * when IO readiness events occur by calling
+=09 * fuse_lowlevel_notify_poll() with the specified ph.
+=09 *
+=09 * Regardless of the number of times poll with a non-NULL ph
+=09 * is received, single notification is enough to clear all.
+=09 * Notifying more times incurs overhead but doesn't harm
+=09 * correctness.
+=09 *
+=09 * The callee is responsible for destroying ph with
+=09 * fuse_pollhandle_destroy() when no longer in use.
+=09 *
+=09 * If this request is answered with an error code of ENOSYS, this is
+=09 * treated as success (with a kernel-defined default poll-mask) and
+=09 * future calls to pull() will succeed the same way without being send
+=09 * to the filesystem process.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_poll
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param fi file information
+=09 * @param ph poll handle to be used for notification
+=09 */
+=09void (*poll) (fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi=
,
+=09=09      struct fuse_pollhandle *ph);
+
+=09/**
+=09 * Write data made available in a buffer
+=09 *
+=09 * This is a more generic version of the ->write() method.  If
+=09 * FUSE_CAP_SPLICE_READ is set in fuse_conn_info.want and the
+=09 * kernel supports splicing from the fuse device, then the
+=09 * data will be made available in pipe for supporting zero
+=09 * copy data transfer.
+=09 *
+=09 * buf->count is guaranteed to be one (and thus buf->idx is
+=09 * always zero). The write_buf handler must ensure that
+=09 * bufv->off is correctly updated (reflecting the number of
+=09 * bytes read from bufv->buf[0]).
+=09 *
+=09 * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled, this method is
+=09 * expected to reset the setuid and setgid bits.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_write
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param bufv buffer containing the data
+=09 * @param off offset to write to
+=09 * @param fi file information
+=09 */
+=09void (*write_buf) (fuse_req_t req, fuse_ino_t ino,
+=09=09=09   struct fuse_bufvec *bufv, off_t off,
+=09=09=09   struct fuse_file_info *fi);
+
+=09/**
+=09 * Callback function for the retrieve request
+=09 *
+=09 * Valid replies:
+=09 *=09fuse_reply_none
+=09 *
+=09 * @param req request handle
+=09 * @param cookie user data supplied to fuse_lowlevel_notify_retrieve()
+=09 * @param ino the inode number supplied to fuse_lowlevel_notify_retriev=
e()
+=09 * @param offset the offset supplied to fuse_lowlevel_notify_retrieve()
+=09 * @param bufv the buffer containing the returned data
+=09 */
+=09void (*retrieve_reply) (fuse_req_t req, void *cookie, fuse_ino_t ino,
+=09=09=09=09off_t offset, struct fuse_bufvec *bufv);
+
+=09/**
+=09 * Forget about multiple inodes
+=09 *
+=09 * See description of the forget function for more
+=09 * information.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_none
+=09 *
+=09 * @param req request handle
+=09 */
+=09void (*forget_multi) (fuse_req_t req, size_t count,
+=09=09=09      struct fuse_forget_data *forgets);
+
+=09/**
+=09 * Acquire, modify or release a BSD file lock
+=09 *
+=09 * Note: if the locking methods are not implemented, the kernel
+=09 * will still allow file locking to work locally.  Hence these are
+=09 * only interesting for network filesystems and similar.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param fi file information
+=09 * @param op the locking operation, see flock(2)
+=09 */
+=09void (*flock) (fuse_req_t req, fuse_ino_t ino,
+=09=09       struct fuse_file_info *fi, int op);
+
+=09/**
+=09 * Allocate requested space. If this function returns success then
+=09 * subsequent writes to the specified range shall not fail due to the l=
ack
+=09 * of free space on the file system storage media.
+=09 *
+=09 * If this request is answered with an error code of ENOSYS, this is
+=09 * treated as a permanent failure with error code EOPNOTSUPP, i.e. all
+=09 * future fallocate() requests will fail with EOPNOTSUPP without being
+=09 * send to the filesystem process.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param offset starting point for allocated region
+=09 * @param length size of allocated region
+=09 * @param mode determines the operation to be performed on the given ra=
nge,
+=09 *             see fallocate(2)
+=09 */
+=09void (*fallocate) (fuse_req_t req, fuse_ino_t ino, int mode,
+=09=09       off_t offset, off_t length, struct fuse_file_info *fi);
+
+=09/**
+=09 * Read directory with attributes
+=09 *
+=09 * Send a buffer filled using fuse_add_direntry_plus(), with size not
+=09 * exceeding the requested size.  Send an empty buffer on end of
+=09 * stream.
+=09 *
+=09 * fi->fh will contain the value set by the opendir method, or
+=09 * will be undefined if the opendir method didn't set any value.
+=09 *
+=09 * In contrast to readdir() (which does not affect the lookup counts),
+=09 * the lookup count of every entry returned by readdirplus(), except ".=
"
+=09 * and "..", is incremented by one.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_buf
+=09 *   fuse_reply_data
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param size maximum number of bytes to send
+=09 * @param off offset to continue reading the directory stream
+=09 * @param fi file information
+=09 */
+=09void (*readdirplus) (fuse_req_t req, fuse_ino_t ino, size_t size, off_t=
 off,
+=09=09=09 struct fuse_file_info *fi);
+
+=09/**
+=09 * Copy a range of data from one file to another
+=09 *
+=09 * Performs an optimized copy between two file descriptors without the
+=09 * additional cost of transferring data through the FUSE kernel module
+=09 * to user space (glibc) and then back into the FUSE filesystem again.
+=09 *
+=09 * In case this method is not implemented, glibc falls back to reading
+=09 * data from the source and writing to the destination. Effectively
+=09 * doing an inefficient copy of the data.
+=09 *
+=09 * If this request is answered with an error code of ENOSYS, this is
+=09 * treated as a permanent failure with error code EOPNOTSUPP, i.e. all
+=09 * future copy_file_range() requests will fail with EOPNOTSUPP without
+=09 * being send to the filesystem process.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_write
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino_in the inode number or the source file
+=09 * @param off_in starting point from were the data should be read
+=09 * @param fi_in file information of the source file
+=09 * @param ino_out the inode number or the destination file
+=09 * @param off_out starting point where the data should be written
+=09 * @param fi_out file information of the destination file
+=09 * @param len maximum size of the data to copy
+=09 * @param flags passed along with the copy_file_range() syscall
+=09 */
+=09void (*copy_file_range) (fuse_req_t req, fuse_ino_t ino_in,
+=09=09=09=09 off_t off_in, struct fuse_file_info *fi_in,
+=09=09=09=09 fuse_ino_t ino_out, off_t off_out,
+=09=09=09=09 struct fuse_file_info *fi_out, size_t len,
+=09=09=09=09 int flags);
+
+=09/**
+=09 * Find next data or hole after the specified offset
+=09 *
+=09 * If this request is answered with an error code of ENOSYS, this is
+=09 * treated as a permanent failure, i.e. all future lseek() requests wil=
l
+=09 * fail with the same error code without being send to the filesystem
+=09 * process.
+=09 *
+=09 * Valid replies:
+=09 *   fuse_reply_lseek
+=09 *   fuse_reply_err
+=09 *
+=09 * @param req request handle
+=09 * @param ino the inode number
+=09 * @param off offset to start search from
+=09 * @param whence either SEEK_DATA or SEEK_HOLE
+=09 * @param fi file information
+=09 */
+=09void (*lseek) (fuse_req_t req, fuse_ino_t ino, off_t off, int whence,
+=09=09       struct fuse_file_info *fi);
+};
+
+/**
+ * Reply with an error code or success.
+ *
+ * Possible requests:
+ *   all except forget
+ *
+ * Whereever possible, error codes should be chosen from the list of
+ * documented error conditions in the corresponding system calls
+ * manpage.
+ *
+ * An error code of ENOSYS is sometimes treated specially. This is
+ * indicated in the documentation of the affected handler functions.
+ *
+ * The following requests may be answered with a zero error code:
+ * unlink, rmdir, rename, flush, release, fsync, fsyncdir, setxattr,
+ * removexattr, setlk.
+ *
+ * @param req request handle
+ * @param err the positive error value, or zero for success
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_err(fuse_req_t req, int err);
+
+/**
+ * Don't send reply
+ *
+ * Possible requests:
+ *   forget
+ *   forget_multi
+ *   retrieve_reply
+ *
+ * @param req request handle
+ */
+void fuse_reply_none(fuse_req_t req);
+
+/**
+ * Reply with a directory entry
+ *
+ * Possible requests:
+ *   lookup, mknod, mkdir, symlink, link
+ *
+ * Side effects:
+ *   increments the lookup count on success
+ *
+ * @param req request handle
+ * @param e the entry parameters
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_entry(fuse_req_t req, const struct fuse_entry_param *e);
+
+/**
+ * Reply with a directory entry and open parameters
+ *
+ * currently the following members of 'fi' are used:
+ *   fh, direct_io, keep_cache
+ *
+ * Possible requests:
+ *   create
+ *
+ * Side effects:
+ *   increments the lookup count on success
+ *
+ * @param req request handle
+ * @param e the entry parameters
+ * @param fi file information
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
+=09=09      const struct fuse_file_info *fi);
+
+/**
+ * Reply with attributes
+ *
+ * Possible requests:
+ *   getattr, setattr
+ *
+ * @param req request handle
+ * @param attr the attributes
+ * @param attr_timeout=09validity timeout (in seconds) for the attributes
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
+=09=09    double attr_timeout);
+
+/**
+ * Reply with the contents of a symbolic link
+ *
+ * Possible requests:
+ *   readlink
+ *
+ * @param req request handle
+ * @param link symbolic link contents
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_readlink(fuse_req_t req, const char *link);
+
+/**
+ * Reply with open parameters
+ *
+ * currently the following members of 'fi' are used:
+ *   fh, direct_io, keep_cache
+ *
+ * Possible requests:
+ *   open, opendir
+ *
+ * @param req request handle
+ * @param fi file information
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_open(fuse_req_t req, const struct fuse_file_info *fi);
+
+/**
+ * Reply with number of bytes written
+ *
+ * Possible requests:
+ *   write
+ *
+ * @param req request handle
+ * @param count the number of bytes written
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_write(fuse_req_t req, size_t count);
+
+/**
+ * Reply with data
+ *
+ * Possible requests:
+ *   read, readdir, getxattr, listxattr
+ *
+ * @param req request handle
+ * @param buf buffer containing data
+ * @param size the size of data in bytes
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_buf(fuse_req_t req, const char *buf, size_t size);
+
+/**
+ * Reply with data copied/moved from buffer(s)
+ *
+ * Zero copy data transfer ("splicing") will be used under
+ * the following circumstances:
+ *
+ * 1. FUSE_CAP_SPLICE_WRITE is set in fuse_conn_info.want, and
+ * 2. the kernel supports splicing from the fuse device
+ *    (FUSE_CAP_SPLICE_WRITE is set in fuse_conn_info.capable), and
+ * 3. *flags* does not contain FUSE_BUF_NO_SPLICE
+ * 4. The amount of data that is provided in file-descriptor backed
+ *    buffers (i.e., buffers for which bufv[n].flags =3D=3D FUSE_BUF_FD)
+ *    is at least twice the page size.
+ *
+ * In order for SPLICE_F_MOVE to be used, the following additional
+ * conditions have to be fulfilled:
+ *
+ * 1. FUSE_CAP_SPLICE_MOVE is set in fuse_conn_info.want, and
+ * 2. the kernel supports it (i.e, FUSE_CAP_SPLICE_MOVE is set in
+      fuse_conn_info.capable), and
+ * 3. *flags* contains FUSE_BUF_SPLICE_MOVE
+ *
+ * Note that, if splice is used, the data is actually spliced twice:
+ * once into a temporary pipe (to prepend header data), and then again
+ * into the kernel. If some of the provided buffers are memory-backed,
+ * the data in them is copied in step one and spliced in step two.
+ *
+ * The FUSE_BUF_SPLICE_FORCE_SPLICE and FUSE_BUF_SPLICE_NONBLOCK flags
+ * are silently ignored.
+ *
+ * Possible requests:
+ *   read, readdir, getxattr, listxattr
+ *
+ * Side effects:
+ *   when used to return data from a readdirplus() (but not readdir())
+ *   call, increments the lookup count of each returned entry by one
+ *   on success.
+ *
+ * @param req request handle
+ * @param bufv buffer vector
+ * @param flags flags controlling the copy
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_data(fuse_req_t req, struct fuse_bufvec *bufv,
+=09=09    enum fuse_buf_copy_flags flags);
+
+/**
+ * Reply with data vector
+ *
+ * Possible requests:
+ *   read, readdir, getxattr, listxattr
+ *
+ * @param req request handle
+ * @param iov the vector containing the data
+ * @param count the size of vector
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_iov(fuse_req_t req, const struct iovec *iov, int count);
+
+/**
+ * Reply with filesystem statistics
+ *
+ * Possible requests:
+ *   statfs
+ *
+ * @param req request handle
+ * @param stbuf filesystem statistics
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_statfs(fuse_req_t req, const struct statvfs *stbuf);
+
+/**
+ * Reply with needed buffer size
+ *
+ * Possible requests:
+ *   getxattr, listxattr
+ *
+ * @param req request handle
+ * @param count the buffer size needed in bytes
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_xattr(fuse_req_t req, size_t count);
+
+/**
+ * Reply with file lock information
+ *
+ * Possible requests:
+ *   getlk
+ *
+ * @param req request handle
+ * @param lock the lock information
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_lock(fuse_req_t req, const struct flock *lock);
+
+/**
+ * Reply with block index
+ *
+ * Possible requests:
+ *   bmap
+ *
+ * @param req request handle
+ * @param idx block index within device
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_bmap(fuse_req_t req, uint64_t idx);
+
+/* ----------------------------------------------------------- *
+ * Filling a buffer in readdir=09=09=09=09       *
+ * ----------------------------------------------------------- */
+
+/**
+ * Add a directory entry to the buffer
+ *
+ * Buffer needs to be large enough to hold the entry.  If it's not,
+ * then the entry is not filled in but the size of the entry is still
+ * returned.  The caller can check this by comparing the bufsize
+ * parameter with the returned entry size.  If the entry size is
+ * larger than the buffer size, the operation failed.
+ *
+ * From the 'stbuf' argument the st_ino field and bits 12-15 of the
+ * st_mode field are used.  The other fields are ignored.
+ *
+ * *off* should be any non-zero value that the filesystem can use to
+ * identify the current point in the directory stream. It does not
+ * need to be the actual physical position. A value of zero is
+ * reserved to mean "from the beginning", and should therefore never
+ * be used (the first call to fuse_add_direntry should be passed the
+ * offset of the second directory entry).
+ *
+ * @param req request handle
+ * @param buf the point where the new entry will be added to the buffer
+ * @param bufsize remaining size of the buffer
+ * @param name the name of the entry
+ * @param stbuf the file attributes
+ * @param off the offset of the next entry
+ * @return the space needed for the entry
+ */
+size_t fuse_add_direntry(fuse_req_t req, char *buf, size_t bufsize,
+=09=09=09 const char *name, const struct stat *stbuf,
+=09=09=09 off_t off);
+
+/**
+ * Add a directory entry to the buffer with the attributes
+ *
+ * See documentation of `fuse_add_direntry()` for more details.
+ *
+ * @param req request handle
+ * @param buf the point where the new entry will be added to the buffer
+ * @param bufsize remaining size of the buffer
+ * @param name the name of the entry
+ * @param e the directory entry
+ * @param off the offset of the next entry
+ * @return the space needed for the entry
+ */
+size_t fuse_add_direntry_plus(fuse_req_t req, char *buf, size_t bufsize,
+=09=09=09      const char *name,
+=09=09=09      const struct fuse_entry_param *e, off_t off);
+
+/**
+ * Reply to ask for data fetch and output buffer preparation.  ioctl
+ * will be retried with the specified input data fetched and output
+ * buffer prepared.
+ *
+ * Possible requests:
+ *   ioctl
+ *
+ * @param req request handle
+ * @param in_iov iovec specifying data to fetch from the caller
+ * @param in_count number of entries in in_iov
+ * @param out_iov iovec specifying addresses to write output to
+ * @param out_count number of entries in out_iov
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_ioctl_retry(fuse_req_t req,
+=09=09=09   const struct iovec *in_iov, size_t in_count,
+=09=09=09   const struct iovec *out_iov, size_t out_count);
+
+/**
+ * Reply to finish ioctl
+ *
+ * Possible requests:
+ *   ioctl
+ *
+ * @param req request handle
+ * @param result result to be passed to the caller
+ * @param buf buffer containing output data
+ * @param size length of output data
+ */
+int fuse_reply_ioctl(fuse_req_t req, int result, const void *buf, size_t s=
ize);
+
+/**
+ * Reply to finish ioctl with iov buffer
+ *
+ * Possible requests:
+ *   ioctl
+ *
+ * @param req request handle
+ * @param result result to be passed to the caller
+ * @param iov the vector containing the data
+ * @param count the size of vector
+ */
+int fuse_reply_ioctl_iov(fuse_req_t req, int result, const struct iovec *i=
ov,
+=09=09=09 int count);
+
+/**
+ * Reply with poll result event mask
+ *
+ * @param req request handle
+ * @param revents poll result event mask
+ */
+int fuse_reply_poll(fuse_req_t req, unsigned revents);
+
+/**
+ * Reply with offset
+ *
+ * Possible requests:
+ *   lseek
+ *
+ * @param req request handle
+ * @param off offset of next data or hole
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_lseek(fuse_req_t req, off_t off);
+
+/* ----------------------------------------------------------- *
+ * Notification=09=09=09=09=09=09       *
+ * ----------------------------------------------------------- */
+
+/**
+ * Notify IO readiness event
+ *
+ * For more information, please read comment for poll operation.
+ *
+ * @param ph poll handle to notify IO readiness event for
+ */
+int fuse_lowlevel_notify_poll(struct fuse_pollhandle *ph);
+
+/**
+ * Notify to invalidate cache for an inode.
+ *
+ * Added in FUSE protocol version 7.12. If the kernel does not support
+ * this (or a newer) version, the function will return -ENOSYS and do
+ * nothing.
+ *
+ * If the filesystem has writeback caching enabled, invalidating an
+ * inode will first trigger a writeback of all dirty pages. The call
+ * will block until all writeback requests have completed and the
+ * inode has been invalidated. It will, however, not wait for
+ * completion of pending writeback requests that have been issued
+ * before.
+ *
+ * If there are no dirty pages, this function will never block.
+ *
+ * @param se the session object
+ * @param ino the inode number
+ * @param off the offset in the inode where to start invalidating
+ *            or negative to invalidate attributes only
+ * @param len the amount of cache to invalidate or 0 for all
+ * @return zero for success, -errno for failure
+ */
+int fuse_lowlevel_notify_inval_inode(struct fuse_session *se, fuse_ino_t i=
no,
+=09=09=09=09     off_t off, off_t len);
+
+/**
+ * Notify to invalidate parent attributes and the dentry matching
+ * parent/name
+ *
+ * To avoid a deadlock this function must not be called in the
+ * execution path of a related filesytem operation or within any code
+ * that could hold a lock that could be needed to execute such an
+ * operation. As of kernel 4.18, a "related operation" is a lookup(),
+ * symlink(), mknod(), mkdir(), unlink(), rename(), link() or create()
+ * request for the parent, and a setattr(), unlink(), rmdir(),
+ * rename(), setxattr(), removexattr(), readdir() or readdirplus()
+ * request for the inode itself.
+ *
+ * When called correctly, this function will never block.
+ *
+ * Added in FUSE protocol version 7.12. If the kernel does not support
+ * this (or a newer) version, the function will return -ENOSYS and do
+ * nothing.
+ *
+ * @param se the session object
+ * @param parent inode number
+ * @param name file name
+ * @param namelen strlen() of file name
+ * @return zero for success, -errno for failure
+ */
+int fuse_lowlevel_notify_inval_entry(struct fuse_session *se, fuse_ino_t p=
arent,
+=09=09=09=09     const char *name, size_t namelen);
+
+/**
+ * This function behaves like fuse_lowlevel_notify_inval_entry() with
+ * the following additional effect (at least as of Linux kernel 4.8):
+ *
+ * If the provided *child* inode matches the inode that is currently
+ * associated with the cached dentry, and if there are any inotify
+ * watches registered for the dentry, then the watchers are informed
+ * that the dentry has been deleted.
+ *
+ * To avoid a deadlock this function must not be called while
+ * executing a related filesytem operation or while holding a lock
+ * that could be needed to execute such an operation (see the
+ * description of fuse_lowlevel_notify_inval_entry() for more
+ * details).
+ *
+ * When called correctly, this function will never block.
+ *
+ * Added in FUSE protocol version 7.18. If the kernel does not support
+ * this (or a newer) version, the function will return -ENOSYS and do
+ * nothing.
+ *
+ * @param se the session object
+ * @param parent inode number
+ * @param child inode number
+ * @param name file name
+ * @param namelen strlen() of file name
+ * @return zero for success, -errno for failure
+ */
+int fuse_lowlevel_notify_delete(struct fuse_session *se,
+=09=09=09=09fuse_ino_t parent, fuse_ino_t child,
+=09=09=09=09const char *name, size_t namelen);
+
+/**
+ * Store data to the kernel buffers
+ *
+ * Synchronously store data in the kernel buffers belonging to the
+ * given inode.  The stored data is marked up-to-date (no read will be
+ * performed against it, unless it's invalidated or evicted from the
+ * cache).
+ *
+ * If the stored data overflows the current file size, then the size
+ * is extended, similarly to a write(2) on the filesystem.
+ *
+ * If this function returns an error, then the store wasn't fully
+ * completed, but it may have been partially completed.
+ *
+ * Added in FUSE protocol version 7.15. If the kernel does not support
+ * this (or a newer) version, the function will return -ENOSYS and do
+ * nothing.
+ *
+ * @param se the session object
+ * @param ino the inode number
+ * @param offset the starting offset into the file to store to
+ * @param bufv buffer vector
+ * @param flags flags controlling the copy
+ * @return zero for success, -errno for failure
+ */
+int fuse_lowlevel_notify_store(struct fuse_session *se, fuse_ino_t ino,
+=09=09=09       off_t offset, struct fuse_bufvec *bufv,
+=09=09=09       enum fuse_buf_copy_flags flags);
+/**
+ * Retrieve data from the kernel buffers
+ *
+ * Retrieve data in the kernel buffers belonging to the given inode.
+ * If successful then the retrieve_reply() method will be called with
+ * the returned data.
+ *
+ * Only present pages are returned in the retrieve reply.  Retrieving
+ * stops when it finds a non-present page and only data prior to that
+ * is returned.
+ *
+ * If this function returns an error, then the retrieve will not be
+ * completed and no reply will be sent.
+ *
+ * This function doesn't change the dirty state of pages in the kernel
+ * buffer.  For dirty pages the write() method will be called
+ * regardless of having been retrieved previously.
+ *
+ * Added in FUSE protocol version 7.15. If the kernel does not support
+ * this (or a newer) version, the function will return -ENOSYS and do
+ * nothing.
+ *
+ * @param se the session object
+ * @param ino the inode number
+ * @param size the number of bytes to retrieve
+ * @param offset the starting offset into the file to retrieve from
+ * @param cookie user data to supply to the reply callback
+ * @return zero for success, -errno for failure
+ */
+int fuse_lowlevel_notify_retrieve(struct fuse_session *se, fuse_ino_t ino,
+=09=09=09=09  size_t size, off_t offset, void *cookie);
+
+
+/* ----------------------------------------------------------- *
+ * Utility functions=09=09=09=09=09       *
+ * ----------------------------------------------------------- */
+
+/**
+ * Get the userdata from the request
+ *
+ * @param req request handle
+ * @return the user data passed to fuse_session_new()
+ */
+void *fuse_req_userdata(fuse_req_t req);
+
+/**
+ * Get the context from the request
+ *
+ * The pointer returned by this function will only be valid for the
+ * request's lifetime
+ *
+ * @param req request handle
+ * @return the context structure
+ */
+const struct fuse_ctx *fuse_req_ctx(fuse_req_t req);
+
+/**
+ * Get the current supplementary group IDs for the specified request
+ *
+ * Similar to the getgroups(2) system call, except the return value is
+ * always the total number of group IDs, even if it is larger than the
+ * specified size.
+ *
+ * The current fuse kernel module in linux (as of 2.6.30) doesn't pass
+ * the group list to userspace, hence this function needs to parse
+ * "/proc/$TID/task/$TID/status" to get the group IDs.
+ *
+ * This feature may not be supported on all operating systems.  In
+ * such a case this function will return -ENOSYS.
+ *
+ * @param req request handle
+ * @param size size of given array
+ * @param list array of group IDs to be filled in
+ * @return the total number of supplementary group IDs or -errno on failur=
e
+ */
+int fuse_req_getgroups(fuse_req_t req, int size, gid_t list[]);
+
+/**
+ * Callback function for an interrupt
+ *
+ * @param req interrupted request
+ * @param data user data
+ */
+typedef void (*fuse_interrupt_func_t)(fuse_req_t req, void *data);
+
+/**
+ * Register/unregister callback for an interrupt
+ *
+ * If an interrupt has already happened, then the callback function is
+ * called from within this function, hence it's not possible for
+ * interrupts to be lost.
+ *
+ * @param req request handle
+ * @param func the callback function or NULL for unregister
+ * @param data user data passed to the callback function
+ */
+void fuse_req_interrupt_func(fuse_req_t req, fuse_interrupt_func_t func,
+=09=09=09     void *data);
+
+/**
+ * Check if a request has already been interrupted
+ *
+ * @param req request handle
+ * @return 1 if the request has been interrupted, 0 otherwise
+ */
+int fuse_req_interrupted(fuse_req_t req);
+
+
+/* ----------------------------------------------------------- *
+ * Inquiry functions                                           *
+ * ----------------------------------------------------------- */
+
+/**
+ * Print low-level version information to stdout.
+ */
+void fuse_lowlevel_version(void);
+
+/**
+ * Print available low-level options to stdout. This is not an
+ * exhaustive list, but includes only those options that may be of
+ * interest to an end-user of a file system.
+ */
+void fuse_lowlevel_help(void);
+
+/**
+ * Print available options for `fuse_parse_cmdline()`.
+ */
+void fuse_cmdline_help(void);
+
+/* ----------------------------------------------------------- *
+ * Filesystem setup & teardown                                 *
+ * ----------------------------------------------------------- */
+
+struct fuse_cmdline_opts {
+=09int singlethread;
+=09int foreground;
+=09int debug;
+=09int nodefault_subtype;
+=09char *mountpoint;
+=09int show_version;
+=09int show_help;
+=09int clone_fd;
+=09unsigned int max_idle_threads;
+};
+
+/**
+ * Utility function to parse common options for simple file systems
+ * using the low-level API. A help text that describes the available
+ * options can be printed with `fuse_cmdline_help`. A single
+ * non-option argument is treated as the mountpoint. Multiple
+ * non-option arguments will result in an error.
+ *
+ * If neither -o subtype=3D or -o fsname=3D options are given, a new
+ * subtype option will be added and set to the basename of the program
+ * (the fsname will remain unset, and then defaults to "fuse").
+ *
+ * Known options will be removed from *args*, unknown options will
+ * remain.
+ *
+ * @param args argument vector (input+output)
+ * @param opts output argument for parsed options
+ * @return 0 on success, -1 on failure
+ */
+int fuse_parse_cmdline(struct fuse_args *args,
+=09=09       struct fuse_cmdline_opts *opts);
+
+/**
+ * Create a low level session.
+ *
+ * Returns a session structure suitable for passing to
+ * fuse_session_mount() and fuse_session_loop().
+ *
+ * This function accepts most file-system independent mount options
+ * (like context, nodev, ro - see mount(8)), as well as the general
+ * fuse mount options listed in mount.fuse(8) (e.g. -o allow_root and
+ * -o default_permissions, but not ``-o use_ino``).  Instead of `-o
+ * debug`, debugging may also enabled with `-d` or `--debug`.
+ *
+ * If not all options are known, an error message is written to stderr
+ * and the function returns NULL.
+ *
+ * Option parsing skips argv[0], which is assumed to contain the
+ * program name. To prevent accidentally passing an option in
+ * argv[0], this element must always be present (even if no options
+ * are specified). It may be set to the empty string ('\0') if no
+ * reasonable value can be provided.
+ *
+ * @param args argument vector
+ * @param op the (low-level) filesystem operations
+ * @param op_size sizeof(struct fuse_lowlevel_ops)
+ * @param userdata user data
+ *
+ * @return the fuse session on success, NULL on failure
+ **/
+struct fuse_session *fuse_session_new(struct fuse_args *args,
+=09=09=09=09      const struct fuse_lowlevel_ops *op,
+=09=09=09=09      size_t op_size, void *userdata);
+
+/**
+ * Mount a FUSE file system.
+ *
+ * @param mountpoint the mount point path
+ * @param se session object
+ *
+ * @return 0 on success, -1 on failure.
+ **/
+int fuse_session_mount(struct fuse_session *se, const char *mountpoint);
+
+/**
+ * Enter a single threaded, blocking event loop.
+ *
+ * When the event loop terminates because the connection to the FUSE
+ * kernel module has been closed, this function returns zero. This
+ * happens when the filesystem is unmounted regularly (by the
+ * filesystem owner or root running the umount(8) or fusermount(1)
+ * command), or if connection is explicitly severed by writing ``1``
+ * to the``abort`` file in ``/sys/fs/fuse/connections/NNN``. The only
+ * way to distinguish between these two conditions is to check if the
+ * filesystem is still mounted after the session loop returns.
+ *
+ * When some error occurs during request processing, the function
+ * returns a negated errno(3) value.
+ *
+ * If the loop has been terminated because of a signal handler
+ * installed by fuse_set_signal_handlers(), this function returns the
+ * (positive) signal value that triggered the exit.
+ *
+ * @param se the session
+ * @return 0, -errno, or a signal value
+ */
+int fuse_session_loop(struct fuse_session *se);
+
+/**
+ * Enter a multi-threaded event loop.
+ *
+ * For a description of the return value and the conditions when the
+ * event loop exits, refer to the documentation of
+ * fuse_session_loop().
+ *
+ * @param se the session
+ * @param config session loop configuration=20
+ * @return see fuse_session_loop()
+ */
+#if FUSE_USE_VERSION < 32
+int fuse_session_loop_mt_31(struct fuse_session *se, int clone_fd);
+#define fuse_session_loop_mt(se, clone_fd) fuse_session_loop_mt_31(se, clo=
ne_fd)
+#else
+int fuse_session_loop_mt(struct fuse_session *se, struct fuse_loop_config =
*config);
+#endif
+
+/**
+ * Flag a session as terminated.
+ *
+ * This function is invoked by the POSIX signal handlers, when
+ * registered using fuse_set_signal_handlers(). It will cause any
+ * running event loops to terminate on the next opportunity.
+ *
+ * @param se the session
+ */
+void fuse_session_exit(struct fuse_session *se);
+
+/**
+ * Reset the terminated flag of a session
+ *
+ * @param se the session
+ */
+void fuse_session_reset(struct fuse_session *se);
+
+/**
+ * Query the terminated flag of a session
+ *
+ * @param se the session
+ * @return 1 if exited, 0 if not exited
+ */
+int fuse_session_exited(struct fuse_session *se);
+
+/**
+ * Ensure that file system is unmounted.
+ *
+ * In regular operation, the file system is typically unmounted by the
+ * user calling umount(8) or fusermount(1), which then terminates the
+ * FUSE session loop. However, the session loop may also terminate as
+ * a result of an explicit call to fuse_session_exit() (e.g. by a
+ * signal handler installed by fuse_set_signal_handler()). In this
+ * case the filesystem remains mounted, but any attempt to access it
+ * will block (while the filesystem process is still running) or give
+ * an ESHUTDOWN error (after the filesystem process has terminated).
+ *
+ * If the communication channel with the FUSE kernel module is still
+ * open (i.e., if the session loop was terminated by an explicit call
+ * to fuse_session_exit()), this function will close it and unmount
+ * the filesystem. If the communication channel has been closed by the
+ * kernel, this method will do (almost) nothing.
+ *
+ * NOTE: The above semantics mean that if the connection to the kernel
+ * is terminated via the ``/sys/fs/fuse/connections/NNN/abort`` file,
+ * this method will *not* unmount the filesystem.
+ *
+ * @param se the session
+ */
+void fuse_session_unmount(struct fuse_session *se);
+
+/**
+ * Destroy a session
+ *
+ * @param se the session
+ */
+void fuse_session_destroy(struct fuse_session *se);
+
+/* ----------------------------------------------------------- *
+ * Custom event loop support                                   *
+ * ----------------------------------------------------------- */
+
+/**
+ * Return file descriptor for communication with kernel.
+ *
+ * The file selector can be used to integrate FUSE with a custom event
+ * loop. Whenever data is available for reading on the provided fd,
+ * the event loop should call `fuse_session_receive_buf` followed by
+ * `fuse_session_process_buf` to process the request.
+ *
+ * The returned file descriptor is valid until `fuse_session_unmount`
+ * is called.
+ *
+ * @param se the session
+ * @return a file descriptor
+ */
+int fuse_session_fd(struct fuse_session *se);
+
+/**
+ * Process a raw request supplied in a generic buffer
+ *
+ * The fuse_buf may contain a memory buffer or a pipe file descriptor.
+ *
+ * @param se the session
+ * @param buf the fuse_buf containing the request
+ */
+void fuse_session_process_buf(struct fuse_session *se,
+=09=09=09      const struct fuse_buf *buf);
+
+/**
+ * Read a raw request from the kernel into the supplied buffer.
+ *
+ * Depending on file system options, system capabilities, and request
+ * size the request is either read into a memory buffer or spliced
+ * into a temporary pipe.
+ *
+ * @param se the session
+ * @param buf the fuse_buf to store the request in
+ * @return the actual size of the raw request, or -errno on error
+ */
+int fuse_session_receive_buf(struct fuse_session *se, struct fuse_buf *buf=
);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* FUSE_LOWLEVEL_H_ */
diff --git a/tools/virtiofsd/fuse_misc.h b/tools/virtiofsd/fuse_misc.h
new file mode 100644
index 0000000000..2f6663ed7d
--- /dev/null
+++ b/tools/virtiofsd/fuse_misc.h
@@ -0,0 +1,59 @@
+/*
+  FUSE: Filesystem in Userspace
+  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+
+  This program can be distributed under the terms of the GNU LGPLv2.
+  See the file COPYING.LIB
+*/
+
+#include <pthread.h>
+
+/*
+  Versioned symbols cannot be used in some cases because it
+    - confuse the dynamic linker in uClibc
+    - not supported on MacOSX (in MachO binary format)
+*/
+#if (!defined(__UCLIBC__) && !defined(__APPLE__))
+#define FUSE_SYMVER(x) __asm__(x)
+#else
+#define FUSE_SYMVER(x)
+#endif
+
+#ifndef USE_UCLIBC
+#define fuse_mutex_init(mut) pthread_mutex_init(mut, NULL)
+#else
+/* Is this hack still needed? */
+static inline void fuse_mutex_init(pthread_mutex_t *mut)
+{
+=09pthread_mutexattr_t attr;
+=09pthread_mutexattr_init(&attr);
+=09pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_ADAPTIVE_NP);
+=09pthread_mutex_init(mut, &attr);
+=09pthread_mutexattr_destroy(&attr);
+}
+#endif
+
+#ifdef HAVE_STRUCT_STAT_ST_ATIM
+/* Linux */
+#define ST_ATIM_NSEC(stbuf) ((stbuf)->st_atim.tv_nsec)
+#define ST_CTIM_NSEC(stbuf) ((stbuf)->st_ctim.tv_nsec)
+#define ST_MTIM_NSEC(stbuf) ((stbuf)->st_mtim.tv_nsec)
+#define ST_ATIM_NSEC_SET(stbuf, val) (stbuf)->st_atim.tv_nsec =3D (val)
+#define ST_CTIM_NSEC_SET(stbuf, val) (stbuf)->st_ctim.tv_nsec =3D (val)
+#define ST_MTIM_NSEC_SET(stbuf, val) (stbuf)->st_mtim.tv_nsec =3D (val)
+#elif defined(HAVE_STRUCT_STAT_ST_ATIMESPEC)
+/* FreeBSD */
+#define ST_ATIM_NSEC(stbuf) ((stbuf)->st_atimespec.tv_nsec)
+#define ST_CTIM_NSEC(stbuf) ((stbuf)->st_ctimespec.tv_nsec)
+#define ST_MTIM_NSEC(stbuf) ((stbuf)->st_mtimespec.tv_nsec)
+#define ST_ATIM_NSEC_SET(stbuf, val) (stbuf)->st_atimespec.tv_nsec =3D (va=
l)
+#define ST_CTIM_NSEC_SET(stbuf, val) (stbuf)->st_ctimespec.tv_nsec =3D (va=
l)
+#define ST_MTIM_NSEC_SET(stbuf, val) (stbuf)->st_mtimespec.tv_nsec =3D (va=
l)
+#else
+#define ST_ATIM_NSEC(stbuf) 0
+#define ST_CTIM_NSEC(stbuf) 0
+#define ST_MTIM_NSEC(stbuf) 0
+#define ST_ATIM_NSEC_SET(stbuf, val) do { } while (0)
+#define ST_CTIM_NSEC_SET(stbuf, val) do { } while (0)
+#define ST_MTIM_NSEC_SET(stbuf, val) do { } while (0)
+#endif
diff --git a/tools/virtiofsd/fuse_opt.h b/tools/virtiofsd/fuse_opt.h
new file mode 100644
index 0000000000..d8573e74fd
--- /dev/null
+++ b/tools/virtiofsd/fuse_opt.h
@@ -0,0 +1,271 @@
+/*
+  FUSE: Filesystem in Userspace
+  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+
+  This program can be distributed under the terms of the GNU LGPLv2.
+  See the file COPYING.LIB.
+*/
+
+#ifndef FUSE_OPT_H_
+#define FUSE_OPT_H_
+
+/** @file
+ *
+ * This file defines the option parsing interface of FUSE
+ */
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * Option description
+ *
+ * This structure describes a single option, and action associated
+ * with it, in case it matches.
+ *
+ * More than one such match may occur, in which case the action for
+ * each match is executed.
+ *
+ * There are three possible actions in case of a match:
+ *
+ * i) An integer (int or unsigned) variable determined by 'offset' is
+ *    set to 'value'
+ *
+ * ii) The processing function is called, with 'value' as the key
+ *
+ * iii) An integer (any) or string (char *) variable determined by
+ *    'offset' is set to the value of an option parameter
+ *
+ * 'offset' should normally be either set to
+ *
+ *  - 'offsetof(struct foo, member)'  actions i) and iii)
+ *
+ *  - -1=09=09=09      action ii)
+ *
+ * The 'offsetof()' macro is defined in the <stddef.h> header.
+ *
+ * The template determines which options match, and also have an
+ * effect on the action.  Normally the action is either i) or ii), but
+ * if a format is present in the template, then action iii) is
+ * performed.
+ *
+ * The types of templates are:
+ *
+ * 1) "-x", "-foo", "--foo", "--foo-bar", etc.=09These match only
+ *   themselves.  Invalid values are "--" and anything beginning
+ *   with "-o"
+ *
+ * 2) "foo", "foo-bar", etc.  These match "-ofoo", "-ofoo-bar" or
+ *    the relevant option in a comma separated option list
+ *
+ * 3) "bar=3D", "--foo=3D", etc.  These are variations of 1) and 2)
+ *    which have a parameter
+ *
+ * 4) "bar=3D%s", "--foo=3D%lu", etc.  Same matching as above but perform
+ *    action iii).
+ *
+ * 5) "-x ", etc.  Matches either "-xparam" or "-x param" as
+ *    two separate arguments
+ *
+ * 6) "-x %s", etc.  Combination of 4) and 5)
+ *
+ * If the format is "%s", memory is allocated for the string unlike with
+ * scanf().  The previous value (if non-NULL) stored at the this location =
is
+ * freed.
+ */
+struct fuse_opt {
+=09/** Matching template and optional parameter formatting */
+=09const char *templ;
+
+=09/**
+=09 * Offset of variable within 'data' parameter of fuse_opt_parse()
+=09 * or -1
+=09 */
+=09unsigned long offset;
+
+=09/**
+=09 * Value to set the variable to, or to be passed as 'key' to the
+=09 * processing function.=09 Ignored if template has a format
+=09 */
+=09int value;
+};
+
+/**
+ * Key option.=09In case of a match, the processing function will be
+ * called with the specified key.
+ */
+#define FUSE_OPT_KEY(templ, key) { templ, -1U, key }
+
+/**
+ * Last option.=09 An array of 'struct fuse_opt' must end with a NULL
+ * template value
+ */
+#define FUSE_OPT_END { NULL, 0, 0 }
+
+/**
+ * Argument list
+ */
+struct fuse_args {
+=09/** Argument count */
+=09int argc;
+
+=09/** Argument vector.  NULL terminated */
+=09char **argv;
+
+=09/** Is 'argv' allocated? */
+=09int allocated;
+};
+
+/**
+ * Initializer for 'struct fuse_args'
+ */
+#define FUSE_ARGS_INIT(argc, argv) { argc, argv, 0 }
+
+/**
+ * Key value passed to the processing function if an option did not
+ * match any template
+ */
+#define FUSE_OPT_KEY_OPT     -1
+
+/**
+ * Key value passed to the processing function for all non-options
+ *
+ * Non-options are the arguments beginning with a character other than
+ * '-' or all arguments after the special '--' option
+ */
+#define FUSE_OPT_KEY_NONOPT  -2
+
+/**
+ * Special key value for options to keep
+ *
+ * Argument is not passed to processing function, but behave as if the
+ * processing function returned 1
+ */
+#define FUSE_OPT_KEY_KEEP -3
+
+/**
+ * Special key value for options to discard
+ *
+ * Argument is not passed to processing function, but behave as if the
+ * processing function returned zero
+ */
+#define FUSE_OPT_KEY_DISCARD -4
+
+/**
+ * Processing function
+ *
+ * This function is called if
+ *    - option did not match any 'struct fuse_opt'
+ *    - argument is a non-option
+ *    - option did match and offset was set to -1
+ *
+ * The 'arg' parameter will always contain the whole argument or
+ * option including the parameter if exists.  A two-argument option
+ * ("-x foo") is always converted to single argument option of the
+ * form "-xfoo" before this function is called.
+ *
+ * Options of the form '-ofoo' are passed to this function without the
+ * '-o' prefix.
+ *
+ * The return value of this function determines whether this argument
+ * is to be inserted into the output argument vector, or discarded.
+ *
+ * @param data is the user data passed to the fuse_opt_parse() function
+ * @param arg is the whole argument or option
+ * @param key determines why the processing function was called
+ * @param outargs the current output argument list
+ * @return -1 on error, 0 if arg is to be discarded, 1 if arg should be ke=
pt
+ */
+typedef int (*fuse_opt_proc_t)(void *data, const char *arg, int key,
+=09=09=09       struct fuse_args *outargs);
+
+/**
+ * Option parsing function
+ *
+ * If 'args' was returned from a previous call to fuse_opt_parse() or
+ * it was constructed from
+ *
+ * A NULL 'args' is equivalent to an empty argument vector
+ *
+ * A NULL 'opts' is equivalent to an 'opts' array containing a single
+ * end marker
+ *
+ * A NULL 'proc' is equivalent to a processing function always
+ * returning '1'
+ *
+ * @param args is the input and output argument list
+ * @param data is the user data
+ * @param opts is the option description array
+ * @param proc is the processing function
+ * @return -1 on error, 0 on success
+ */
+int fuse_opt_parse(struct fuse_args *args, void *data,
+=09=09   const struct fuse_opt opts[], fuse_opt_proc_t proc);
+
+/**
+ * Add an option to a comma separated option list
+ *
+ * @param opts is a pointer to an option list, may point to a NULL value
+ * @param opt is the option to add
+ * @return -1 on allocation error, 0 on success
+ */
+int fuse_opt_add_opt(char **opts, const char *opt);
+
+/**
+ * Add an option, escaping commas, to a comma separated option list
+ *
+ * @param opts is a pointer to an option list, may point to a NULL value
+ * @param opt is the option to add
+ * @return -1 on allocation error, 0 on success
+ */
+int fuse_opt_add_opt_escaped(char **opts, const char *opt);
+
+/**
+ * Add an argument to a NULL terminated argument vector
+ *
+ * @param args is the structure containing the current argument list
+ * @param arg is the new argument to add
+ * @return -1 on allocation error, 0 on success
+ */
+int fuse_opt_add_arg(struct fuse_args *args, const char *arg);
+
+/**
+ * Add an argument at the specified position in a NULL terminated
+ * argument vector
+ *
+ * Adds the argument to the N-th position.  This is useful for adding
+ * options at the beginning of the array which must not come after the
+ * special '--' option.
+ *
+ * @param args is the structure containing the current argument list
+ * @param pos is the position at which to add the argument
+ * @param arg is the new argument to add
+ * @return -1 on allocation error, 0 on success
+ */
+int fuse_opt_insert_arg(struct fuse_args *args, int pos, const char *arg);
+
+/**
+ * Free the contents of argument list
+ *
+ * The structure itself is not freed
+ *
+ * @param args is the structure containing the argument list
+ */
+void fuse_opt_free_args(struct fuse_args *args);
+
+
+/**
+ * Check if an option matches
+ *
+ * @param opts is the option description array
+ * @param opt is the option to match
+ * @return 1 if a match is found, 0 if not
+ */
+int fuse_opt_match(const struct fuse_opt opts[], const char *opt);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* FUSE_OPT_H_ */
diff --git a/tools/virtiofsd/passthrough_helpers.h b/tools/virtiofsd/passth=
rough_helpers.h
new file mode 100644
index 0000000000..6b77c33600
--- /dev/null
+++ b/tools/virtiofsd/passthrough_helpers.h
@@ -0,0 +1,76 @@
+/*
+ * FUSE: Filesystem in Userspace
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURP=
OSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENT=
IAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STR=
ICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY W=
AY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE
+ */
+
+/*
+ * Creates files on the underlying file system in response to a FUSE_MKNOD
+ * operation
+ */
+static int mknod_wrapper(int dirfd, const char *path, const char *link,
+=09int mode, dev_t rdev)
+{
+=09int res;
+
+=09if (S_ISREG(mode)) {
+=09=09res =3D openat(dirfd, path, O_CREAT | O_EXCL | O_WRONLY, mode);
+=09=09if (res >=3D 0)
+=09=09=09res =3D close(res);
+=09} else if (S_ISDIR(mode)) {
+=09=09res =3D mkdirat(dirfd, path, mode);
+=09} else if (S_ISLNK(mode) && link !=3D NULL) {
+=09=09res =3D symlinkat(link, dirfd, path);
+=09} else if (S_ISFIFO(mode)) {
+=09=09res =3D mkfifoat(dirfd, path, mode);
+#ifdef __FreeBSD__
+=09} else if (S_ISSOCK(mode)) {
+=09=09struct sockaddr_un su;
+=09=09int fd;
+
+=09=09if (strlen(path) >=3D sizeof(su.sun_path)) {
+=09=09=09errno =3D ENAMETOOLONG;
+=09=09=09return -1;
+=09=09}
+=09=09fd =3D socket(AF_UNIX, SOCK_STREAM, 0);
+=09=09if (fd >=3D 0) {
+=09=09=09/*
+=09=09=09 * We must bind the socket to the underlying file
+=09=09=09 * system to create the socket file, even though
+=09=09=09 * we'll never listen on this socket.
+=09=09=09 */
+=09=09=09su.sun_family =3D AF_UNIX;
+=09=09=09strncpy(su.sun_path, path, sizeof(su.sun_path));
+=09=09=09res =3D bindat(dirfd, fd, (struct sockaddr*)&su,
+=09=09=09=09sizeof(su));
+=09=09=09if (res =3D=3D 0)
+=09=09=09=09close(fd);
+=09=09} else {
+=09=09=09res =3D -1;
+=09=09}
+#endif
+=09} else {
+=09=09res =3D mknodat(dirfd, path, mode, rdev);
+=09}
+
+=09return res;
+}
--=20
2.23.0


